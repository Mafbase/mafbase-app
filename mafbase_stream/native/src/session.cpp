#include "mafbase_stream/session.h"

#include <chrono>
#include <memory>
#include <mutex>
#include <string>

#include "log.h"
#include "network/bitrate_controller.h"
#include "network/packet_queue.h"
#include "network/writer_thread.h"
#include "rtmp_publisher.h"
#include "session/reconnect_policy.h"
#include "state_machine.h"

namespace ms = mafbase_stream;

namespace {
constexpr const char* kTag = "session";

// Throttle событий, идущих в Dart: не больше 5/сек, кроме критичных
// (RECONNECTING/RECONNECTED/FAILED/STATE — мгновенно).
constexpr int kEventThrottleIntervalMs = 200;

bool is_critical(ms_event_type type) {
    return type == MS_EVENT_RECONNECTING || type == MS_EVENT_RECONNECTED ||
           type == MS_EVENT_FAILED || type == MS_EVENT_STATE ||
           type == MS_EVENT_BITRATE;
}
}  // namespace

struct ms_session {
    mutable std::mutex lifecycle_mu;
    ms::StateMachine sm;
    std::unique_ptr<ms::PacketQueue> queue;
    std::unique_ptr<ms::WriterThread> writer;
    std::unique_ptr<ms::BitrateController> bitrate;
    std::string url;
    ms_session_params params{};
    bool adaptive_bitrate_enabled = true;

    // Накопленное число дропов на момент прошлого queue-depth события. Нужно,
    // чтобы подавать в BitrateController дельту за окно, а не сумму за сессию:
    // иначе после первого же дропа dropped_in_window навсегда > 0 и восстановление
    // битрейта (ветке нужен == 0) выключается до конца стрима. Трогается только
    // из writer-thread'а (set_event_fn), отдельная синхронизация не нужна.
    int abr_last_dropped_total = 0;

    ms_event_callback event_cb = nullptr;
    void* event_user = nullptr;
    ms_request_keyframe_cb request_keyframe_cb = nullptr;
    void* request_keyframe_user = nullptr;
    ms_set_video_bitrate_cb set_bitrate_cb = nullptr;
    void* set_bitrate_user = nullptr;

    // Throttle для не-критичных событий.
    std::chrono::steady_clock::time_point last_event_emit{};

    void emit(const ms_event& ev) {
        if (!event_cb) return;
        if (!is_critical(ev.type)) {
            const auto now = std::chrono::steady_clock::now();
            if (std::chrono::duration_cast<std::chrono::milliseconds>(
                    now - last_event_emit).count() < kEventThrottleIntervalMs) {
                return;
            }
            last_event_emit = now;
        }
        event_cb(&ev, event_user);
    }
};

extern "C" {

ms_session* ms_session_create(void) {
    auto* s = new (std::nothrow) ms_session();
    if (!s) return nullptr;
    return s;
}

void ms_session_set_event_callback(ms_session* session,
                                   ms_event_callback cb,
                                   void* user_data) {
    if (!session) return;
    std::lock_guard lk(session->lifecycle_mu);
    session->event_cb = cb;
    session->event_user = user_data;
}

void ms_session_set_request_keyframe_callback(ms_session* session,
                                              ms_request_keyframe_cb cb,
                                              void* user_data) {
    if (!session) return;
    std::lock_guard lk(session->lifecycle_mu);
    session->request_keyframe_cb = cb;
    session->request_keyframe_user = user_data;
}

void ms_session_set_video_bitrate_callback(ms_session* session,
                                           ms_set_video_bitrate_cb cb,
                                           void* user_data) {
    if (!session) return;
    std::lock_guard lk(session->lifecycle_mu);
    session->set_bitrate_cb = cb;
    session->set_bitrate_user = user_data;
}

ms_result ms_session_start(ms_session* session, const char* rtmp_url, const ms_session_params* params) {
    if (!session || !rtmp_url || !params) return MS_ERR_INVALID_ARG;

    std::lock_guard lk(session->lifecycle_mu);
    if (!session->sm.transition_to(MS_STATE_CONNECTING)) {
        return MS_ERR_INVALID_STATE;
    }
    session->url = rtmp_url;
    session->params = *params;
    session->adaptive_bitrate_enabled = params->adaptive_bitrate_enabled;

    // Listener state-machine передаёт переходы в Dart как ms_event STATE.
    // Сама писать события не должна — это делает WriterThread с полной телеметрией.
    session->sm.set_listener([session](ms_state /*from*/, ms_state to) {
        if (!session->event_cb) return;
        ms_event ev{};
        ev.type = MS_EVENT_STATE;
        ev.state = to;
        ev.bitrate_bps = session->params.video_bitrate_bps;
        session->event_cb(&ev, session->event_user);
    });

    ms::PacketQueue::Config qcfg{};
    qcfg.budget_video_ms = params->queue_budget_video_ms > 0 ? params->queue_budget_video_ms : 500;
    qcfg.budget_audio_ms = params->queue_budget_audio_ms > 0 ? params->queue_budget_audio_ms : 2000;
    qcfg.byte_cap = params->queue_byte_cap > 0 ? params->queue_byte_cap : 4 * 1024 * 1024;
    session->queue = std::make_unique<ms::PacketQueue>(qcfg);

    ms::BitrateController::Config bcfg{};
    bcfg.preset_bps = params->video_bitrate_bps > 0 ? params->video_bitrate_bps : 2'000'000;
    session->bitrate = std::make_unique<ms::BitrateController>(bcfg);
    session->abr_last_dropped_total = 0;  // новая очередь — дропы считаются с нуля

    ms::WriterThread::Config wcfg{};
    wcfg.url = session->url;
    wcfg.params = session->params;
    wcfg.reconnect.max_attempts = params->max_reconnect_attempts > 0 ? params->max_reconnect_attempts : 3;
    wcfg.reconnect.base_delay_ms = params->reconnect_base_delay_ms > 0 ? params->reconnect_base_delay_ms : 1000;
    wcfg.reconnect.cap_delay_ms = params->reconnect_cap_delay_ms > 0 ? params->reconnect_cap_delay_ms : 8000;
    wcfg.io_timeout_us = params->io_timeout_us > 0 ? params->io_timeout_us : 10'000'000;

    session->writer = std::make_unique<ms::WriterThread>(*session->queue, std::move(wcfg));

    // State-change writer'а пробрасываем в state-machine. Listener выше
    // автоматически опубликует STATE event в Dart.
    session->writer->set_state_change_fn(
        [session](ms_state state, ms_io_subcode /*sub*/, int /*attempt*/, const char* /*reason*/) {
            session->sm.transition_to(state);
        });

    session->writer->set_event_fn([session](const ms_event& ev_in) {
        // Обработка адаптивного битрейта: подаём в контроллер и применяем к энкодеру.
        if (session->adaptive_bitrate_enabled && ev_in.type == MS_EVENT_QUEUE_DEPTH &&
            session->bitrate && session->set_bitrate_cb) {
            // dropped_frames_total — накопительный за сессию; контроллеру нужна
            // дельта за окно между queue-depth событиями.
            const int dropped_in_window =
                ev_in.dropped_frames_total - session->abr_last_dropped_total;
            session->abr_last_dropped_total = ev_in.dropped_frames_total;
            const int target = session->bitrate->update(
                ev_in.queue_depth_video_ms, ev_in.queue_depth_audio_ms,
                dropped_in_window, ev_in.backpressure);
            if (target > 0) {
                session->set_bitrate_cb(target, session->set_bitrate_user);
                ms_event ev_br = ev_in;
                ev_br.type = MS_EVENT_BITRATE;
                ev_br.bitrate_bps = target;
                session->params.video_bitrate_bps = target;
                if (session->event_cb) session->event_cb(&ev_br, session->event_user);
            }
        }
        // Forward все события наружу с throttle'ом.
        session->emit(ev_in);
    });

    session->writer->set_request_keyframe_fn([session]() {
        if (session->request_keyframe_cb) {
            session->request_keyframe_cb(session->request_keyframe_user);
        }
    });

    const ms_result r = session->writer->start();
    if (r != MS_OK) {
        session->writer.reset();
        session->queue.reset();
        session->sm.transition_to(MS_STATE_STOPPED);
        return r;
    }
    return MS_OK;
}

ms_result ms_session_push_video(ms_session* session,
                                const uint8_t* nalu,
                                size_t nalu_size,
                                int64_t pts_us,
                                bool is_keyframe) {
    if (!session) return MS_ERR_INVALID_ARG;
    if (!nalu || nalu_size == 0) return MS_ERR_INVALID_ARG;
    // Лёгкая проверка состояния. Не берём session->lifecycle_mu — push на горячем
    // пути и не должен сериализоваться с lifecycle. Очередь сама thread-safe и
    // корректно работает после close() (вернёт false).
    if (!session->queue) return MS_ERR_INVALID_STATE;
    ms::EncodedPacket pkt(ms::StreamKind::Video, pts_us, is_keyframe, nalu, nalu_size);
    if (!session->queue->push(std::move(pkt))) {
        return MS_ERR_INVALID_STATE;
    }
    return MS_OK;
}

ms_result ms_session_push_audio(ms_session* session,
                                const uint8_t* aac_frame,
                                size_t aac_frame_size,
                                int64_t pts_us) {
    if (!session) return MS_ERR_INVALID_ARG;
    if (!aac_frame || aac_frame_size == 0) return MS_ERR_INVALID_ARG;
    if (!session->queue) return MS_ERR_INVALID_STATE;
    ms::EncodedPacket pkt(ms::StreamKind::Audio, pts_us, true, aac_frame, aac_frame_size);
    if (!session->queue->push(std::move(pkt))) {
        return MS_ERR_INVALID_STATE;
    }
    return MS_OK;
}

ms_result ms_session_stop(ms_session* session) {
    if (!session) return MS_ERR_INVALID_ARG;
    std::unique_ptr<ms::WriterThread> writer_to_stop;
    {
        std::lock_guard lk(session->lifecycle_mu);
        const auto current = session->sm.state();
        if (current == MS_STATE_STOPPED) return MS_OK;
        writer_to_stop = std::move(session->writer);
        if (session->queue) session->queue->close();
    }
    // stop() блокирующий — ждёт writer-thread. Делаем без lifecycle_mu, чтобы
    // не блокировать другие вызовы и не превращать это в дедлок с emit_event.
    if (writer_to_stop) writer_to_stop->stop();
    {
        std::lock_guard lk(session->lifecycle_mu);
        session->queue.reset();
        session->bitrate.reset();
        session->sm.transition_to(MS_STATE_STOPPED);
    }
    MS_LOGI(kTag, "session stopped");
    return MS_OK;
}

void ms_session_destroy(ms_session* session) {
    if (!session) return;
    ms_session_stop(session);
    delete session;
}

ms_state ms_session_get_state(const ms_session* session) {
    if (!session) return MS_STATE_STOPPED;
    std::lock_guard lk(session->lifecycle_mu);
    return session->sm.state();
}

const char* ms_result_str(ms_result code) {
    switch (code) {
        case MS_OK: return "OK";
        case MS_ERR_INVALID_ARG: return "INVALID_ARG";
        case MS_ERR_INVALID_STATE: return "INVALID_STATE";
        case MS_ERR_IO: return "IO";
        case MS_ERR_FFMPEG: return "FFMPEG";
        case MS_ERR_NO_MEMORY: return "NO_MEMORY";
        case MS_ERR_TIMEOUT: return "TIMEOUT";
    }
    return "UNKNOWN";
}

const char* ms_state_str(ms_state state) {
    switch (state) {
        case MS_STATE_IDLE: return "idle";
        case MS_STATE_CONNECTING: return "connecting";
        case MS_STATE_STREAMING: return "streaming";
        case MS_STATE_RECONNECTING: return "reconnecting";
        case MS_STATE_STOPPED: return "stopped";
    }
    return "unknown";
}

const char* ms_io_subcode_str(ms_io_subcode code) {
    switch (code) {
        case MS_IO_NONE: return "none";
        case MS_IO_TIMEOUT: return "timeout";
        case MS_IO_EOF: return "eof";
        case MS_IO_CONNRESET: return "connreset";
        case MS_IO_OTHER: return "other";
    }
    return "unknown";
}

const char* ms_event_type_str(ms_event_type type) {
    switch (type) {
        case MS_EVENT_STATE: return "state";
        case MS_EVENT_QUEUE_DEPTH: return "queue_depth";
        case MS_EVENT_BITRATE: return "bitrate";
        case MS_EVENT_RECONNECTING: return "reconnecting";
        case MS_EVENT_RECONNECTED: return "reconnected";
        case MS_EVENT_FAILED: return "failed";
    }
    return "unknown";
}

}  // extern "C"
