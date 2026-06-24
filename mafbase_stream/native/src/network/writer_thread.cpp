#include "writer_thread.h"

#include <chrono>
#include <cstring>

#include "../log.h"
#include "../rtmp_publisher.h"

namespace mafbase_stream {

namespace {
constexpr const char* kTag = "writer";

// Раз в N мс публикуем queue-depth наружу. Важнее, чем кажется: UI-индикатор
// и BitrateController на стороне сессии слушают именно это событие.
constexpr int kQueueDepthEmitIntervalMs = 200;

ms_backpressure backpressure_for(const PacketQueue::Stats& s,
                                 const ms_session_params& params) {
    const int budget = params.queue_budget_video_ms > 0 ? params.queue_budget_video_ms : 500;
    const int worst = std::max(s.video_depth_ms, s.audio_depth_ms);
    if (worst >= (budget * 75) / 100) return MS_BP_HIGH;
    if (worst >= (budget * 40) / 100) return MS_BP_LOW;
    return MS_BP_NONE;
}

ms_network_quality quality_for(ms_backpressure bp, int recent_drops) {
    if (bp == MS_BP_HIGH || recent_drops > 30) return MS_NETQ_BAD;
    if (bp == MS_BP_LOW || recent_drops > 0) return MS_NETQ_DEGRADED;
    return MS_NETQ_GOOD;
}

}  // namespace

WriterThread::WriterThread(PacketQueue& queue, Config cfg)
    : queue_(queue), cfg_(std::move(cfg)) {
    publisher_ = std::make_unique<RtmpPublisher>();
}

WriterThread::~WriterThread() { stop(); }

ms_result WriterThread::start() {
    if (running_.load(std::memory_order_acquire)) return MS_ERR_INVALID_STATE;
    stop_requested_.store(false, std::memory_order_release);

    notify_state(MS_STATE_CONNECTING, MS_IO_NONE, 0, nullptr);

    const int io_timeout_us = cfg_.io_timeout_us > 0 ? cfg_.io_timeout_us : 10'000'000;
    MS_LOGI(kTag, "writer start: io_timeout=" + std::to_string(io_timeout_us / 1000) +
                   "ms, max_attempts=" + std::to_string(cfg_.reconnect.max_attempts) +
                   ", base_delay=" + std::to_string(cfg_.reconnect.base_delay_ms) +
                   "ms, cap_delay=" + std::to_string(cfg_.reconnect.cap_delay_ms) + "ms");
    const auto open_start = std::chrono::steady_clock::now();
    const ms_result r = publisher_->open(cfg_.url, cfg_.params, io_timeout_us);
    const int64_t open_ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                                std::chrono::steady_clock::now() - open_start)
                                .count();
    if (r != MS_OK) {
        MS_LOGE(kTag, "initial open failed in " + std::to_string(open_ms) +
                       "ms (subcode=" +
                       std::to_string(static_cast<int>(publisher_->last_io_subcode())) + ")");
        notify_state(MS_STATE_STOPPED, publisher_->last_io_subcode(), 0, "initial open failed");
        return r;
    }
    MS_LOGI(kTag, "initial open ok in " + std::to_string(open_ms) + "ms");
    notify_state(MS_STATE_STREAMING, MS_IO_NONE, 0, nullptr);

    running_.store(true, std::memory_order_release);
    thread_ = std::thread(&WriterThread::thread_main, this);
    return MS_OK;
}

void WriterThread::stop() {
    if (!running_.exchange(false)) {
        // Никогда не запускался либо уже остановлен.
        if (thread_.joinable()) thread_.join();
        return;
    }
    stop_requested_.store(true, std::memory_order_release);
    if (publisher_) publisher_->request_cancel();
    queue_.close();
    {
        std::lock_guard<std::mutex> lk(sleep_mu_);
    }
    sleep_cv_.notify_all();
    if (thread_.joinable()) thread_.join();

    if (publisher_) publisher_->close();
    notify_state(MS_STATE_STOPPED, MS_IO_NONE, 0, nullptr);
}

void WriterThread::thread_main() {
    while (!stop_requested_.load(std::memory_order_acquire)) {
        const ms_result r = drain_loop();
        if (r == MS_OK) {
            // Очередь закрыта (нормальный stop) — выходим.
            break;
        }
        // IO-ошибка — пробуем реконнект.
        const ms_io_subcode sub = publisher_->last_io_subcode();
        const ms_result rec = reconnect_loop();
        if (rec != MS_OK) {
            // Исчерпали попытки.
            notify_state(MS_STATE_STOPPED, sub, cfg_.reconnect.max_attempts, "reconnect exhausted");
            emit(MS_EVENT_FAILED, sub, cfg_.reconnect.max_attempts, "reconnect exhausted");
            break;
        }
        // После reconnect сбрасываем накопленную за время downtime очередь.
        // Иначе старые audio/video пакеты с PTS из периода reconnect (несколько
        // секунд назад) попадут в новую FLV-сессию: видео-keyframe ляжет на
        // rel_pts=0, а первый audio после keyframe — на rel_pts ≈ длительность
        // reconnect (400ms+). Плеер видит большой initial-gap между AAC seq
        // header и первым audio-tag'ом → audio-master clock уходит в
        // буферизацию и звук «пропадает» до конца сессии.
        //
        // Старый audio всё равно дропается циклом need_keyframe_, а старые
        // video keyframe'ы протухают по budget'у — чистка ничего ценного не
        // теряет, но гарантирует, что новая RTMP-сессия начнётся с пакетов
        // свежей шкалы (encoder уже произведёт keyframe и audio в реальном
        // времени).
        queue_.clear();

        // После reconnect просим энкодер выдать keyframe — без него плеер
        // не сможет отрендерить ни кадра до следующего GOP.
        if (on_request_keyframe_) on_request_keyframe_();
        need_keyframe_.store(true, std::memory_order_release);
    }
}

ms_result WriterThread::drain_loop() {
    using clock = std::chrono::steady_clock;
    auto last_depth_emit = clock::now();

    int dropped_waiting_keyframe = 0;
    auto wait_keyframe_start = clock::now();

    EncodedPacket pkt;
    while (queue_.wait_and_pop(pkt)) {
        if (stop_requested_.load(std::memory_order_acquire)) return MS_OK;

        // После reconnect отбрасываем всё, пока не дождёмся keyframe видеодорожки.
        if (need_keyframe_.load(std::memory_order_acquire)) {
            if (dropped_waiting_keyframe == 0) wait_keyframe_start = clock::now();
            if (pkt.stream == StreamKind::Video && pkt.is_keyframe) {
                const int64_t wait_ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                                            clock::now() - wait_keyframe_start)
                                            .count();
                MS_LOGI(kTag, "got keyframe after reconnect: waited " +
                               std::to_string(wait_ms) + "ms, dropped " +
                               std::to_string(dropped_waiting_keyframe) + " packets");
                dropped_waiting_keyframe = 0;
                need_keyframe_.store(false, std::memory_order_release);
            } else {
                ++dropped_waiting_keyframe;
                continue;
            }
        }

        ms_result r = MS_OK;
        if (pkt.stream == StreamKind::Video) {
            r = publisher_->write_video(pkt.data.data(), pkt.data.size(),
                                        pkt.pts_us, pkt.is_keyframe);
        } else {
            r = publisher_->write_audio(pkt.data.data(), pkt.data.size(), pkt.pts_us);
        }

        if (r != MS_OK) {
            MS_LOGW(kTag, "writer: send failed, will reconnect");
            return MS_ERR_IO;
        }

        // Периодически публикуем queue-depth наружу.
        const auto now = clock::now();
        if (std::chrono::duration_cast<std::chrono::milliseconds>(now - last_depth_emit).count()
            >= kQueueDepthEmitIntervalMs) {
            last_depth_emit = now;
            emit(MS_EVENT_QUEUE_DEPTH);
        }
    }
    return MS_OK;
}

ms_result WriterThread::reconnect_loop() {
    ReconnectPolicy policy(cfg_.reconnect);
    using clock = std::chrono::steady_clock;
    const auto loop_start = clock::now();

    while (policy.advance()) {
        if (stop_requested_.load(std::memory_order_acquire)) return MS_ERR_INVALID_STATE;

        const int attempt = policy.current_attempt();
        const ms_io_subcode prev_sub = publisher_->last_io_subcode();
        MS_LOGI(kTag,
                "reconnect attempt " + std::to_string(attempt) + "/" +
                    std::to_string(cfg_.reconnect.max_attempts) +
                    " (last_io_subcode=" + std::to_string(static_cast<int>(prev_sub)) + ")");
        notify_state(MS_STATE_RECONNECTING, prev_sub, attempt, nullptr);
        emit(MS_EVENT_RECONNECTING, prev_sub, attempt, nullptr);

        // Закрываем старый publisher (request_cancel был выставлен при ошибке —
        // close() ничего не должен висеть).
        publisher_->close();
        publisher_ = std::make_unique<RtmpPublisher>();

        const int delay_ms = policy.next_delay_ms();
        MS_LOGI(kTag, "reconnect attempt " + std::to_string(attempt) + ": sleeping " +
                       std::to_string(delay_ms) + "ms before open");
        {
            std::unique_lock<std::mutex> lk(sleep_mu_);
            sleep_cv_.wait_for(lk, std::chrono::milliseconds(delay_ms),
                               [&]() { return stop_requested_.load(std::memory_order_acquire); });
        }
        if (stop_requested_.load(std::memory_order_acquire)) return MS_ERR_INVALID_STATE;

        const int io_timeout_us = cfg_.io_timeout_us > 0 ? cfg_.io_timeout_us : 10'000'000;
        const auto open_start = clock::now();
        const ms_result r = publisher_->open(cfg_.url, cfg_.params, io_timeout_us);
        const int64_t open_ms =
            std::chrono::duration_cast<std::chrono::milliseconds>(clock::now() - open_start).count();
        if (r == MS_OK) {
            const int64_t total_ms =
                std::chrono::duration_cast<std::chrono::milliseconds>(clock::now() - loop_start).count();
            MS_LOGI(kTag, "reconnect attempt " + std::to_string(attempt) +
                           " ok in " + std::to_string(open_ms) + "ms (total downtime " +
                           std::to_string(total_ms) + "ms)");
            notify_state(MS_STATE_STREAMING, MS_IO_NONE, attempt, nullptr);
            emit(MS_EVENT_RECONNECTED, MS_IO_NONE, attempt, nullptr);
            return MS_OK;
        }
        MS_LOGW(kTag, "reconnect attempt " + std::to_string(attempt) + " failed after " +
                       std::to_string(open_ms) + "ms (subcode=" +
                       std::to_string(static_cast<int>(publisher_->last_io_subcode())) + ")");
    }
    const int64_t total_ms =
        std::chrono::duration_cast<std::chrono::milliseconds>(clock::now() - loop_start).count();
    MS_LOGE(kTag, "reconnect exhausted after " + std::to_string(total_ms) + "ms");
    return MS_ERR_IO;
}

void WriterThread::emit(ms_event_type type, ms_io_subcode subcode, int attempt, const char* reason) {
    if (!on_event_) return;
    const auto stats = queue_.stats();
    ms_event ev{};
    ev.type = type;
    ev.state = MS_STATE_STREAMING;  // в большинстве случаев актуально
    ev.bitrate_bps = cfg_.params.video_bitrate_bps;
    ev.queue_depth_video_ms = stats.video_depth_ms;
    ev.queue_depth_audio_ms = stats.audio_depth_ms;
    ev.dropped_frames_total = stats.dropped_total;
    const ms_backpressure bp = backpressure_for(stats, cfg_.params);
    ev.backpressure = bp;
    const int recent_drops = stats.dropped_total - dropped_at_last_emit_;
    dropped_at_last_emit_ = stats.dropped_total;
    ev.network_quality = quality_for(bp, recent_drops);
    ev.reconnect_attempt = attempt;
    ev.io_subcode = subcode;
    ev.reason = reason;
    on_event_(ev);
}

void WriterThread::emit_state(ms_state state) {
    if (!on_event_) return;
    ms_event ev{};
    ev.type = MS_EVENT_STATE;
    ev.state = state;
    ev.bitrate_bps = cfg_.params.video_bitrate_bps;
    on_event_(ev);
}

void WriterThread::notify_state(ms_state state,
                                ms_io_subcode subcode,
                                int attempt,
                                const char* reason) {
    if (on_state_change_) on_state_change_(state, subcode, attempt, reason);
    emit_state(state);
}

}  // namespace mafbase_stream
