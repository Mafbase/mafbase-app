#ifndef MAFBASE_STREAM_NETWORK_WRITER_THREAD_H
#define MAFBASE_STREAM_NETWORK_WRITER_THREAD_H

#include <atomic>
#include <condition_variable>
#include <functional>
#include <memory>
#include <mutex>
#include <string>
#include <thread>

#include "mafbase_stream/session.h"
#include "../session/reconnect_policy.h"
#include "packet_queue.h"

namespace mafbase_stream {

class RtmpPublisher;

// Поток отправки. Владеет RtmpPublisher'ом и дренажит PacketQueue. При IO-ошибке
// запускает reconnect-цикл (close → backoff → open → ждём keyframe → drain).
//
// Жизненный цикл:
//   start(url, params) — открывает RTMP, поднимает поток.
//   stop()             — request_cancel у publisher'а + закрытие очереди.
//   request_keyframe() — на следующей попытке reconnect просим энкодер выдать IDR
//                        (через колбек платформы — set_request_keyframe_callback).
//
// Для интеграции с сессией: WriterThread сам публикует события через
// EventEmitter (ms_event_callback) и сообщает state-machine о переходах.
class WriterThread {
public:
    using StateChangeFn = std::function<void(ms_state, ms_io_subcode, int attempt, const char* reason)>;
    using EventFn = std::function<void(const ms_event&)>;
    using KeyframeFn = std::function<void()>;

    struct Config {
        std::string url;
        ms_session_params params;
        ReconnectPolicy::Config reconnect;
        int io_timeout_us;
    };

    WriterThread(PacketQueue& queue, Config cfg);
    ~WriterThread();

    WriterThread(const WriterThread&) = delete;
    WriterThread& operator=(const WriterThread&) = delete;

    // Колбеки можно установить только до start().
    void set_state_change_fn(StateChangeFn fn) { on_state_change_ = std::move(fn); }
    void set_event_fn(EventFn fn) { on_event_ = std::move(fn); }
    void set_request_keyframe_fn(KeyframeFn fn) { on_request_keyframe_ = std::move(fn); }

    // Открывает RTMP синхронно (на потоке вызывающего), потом стартует
    // фоновой writer-thread. Возвращает результат первого open.
    ms_result start();

    // Запрашивает остановку, дожидается потока. Идемпотентно.
    void stop();

    // Сообщает текущему publisher'у о неотправленном бизнесе/ошибке. На практике
    // используется только для тестов — production вызывает это автоматически.
    bool is_running() const { return running_.load(std::memory_order_acquire); }

private:
    void thread_main();

    // Один цикл успешной публикации. Возвращает MS_OK при штатном stop()
    // (closed queue), MS_ERR_IO при сетевой ошибке (нужен reconnect).
    ms_result drain_loop();

    // Цикл реконнекта: backoff → open → drain. Возвращает MS_OK при удачном
    // выходе из реконнекта (мы снова в STREAMING) или MS_ERR_IO при исчерпании
    // попыток.
    ms_result reconnect_loop();

    // Публикует событие наружу — упрощённая обёртка.
    void emit(ms_event_type type,
              ms_io_subcode subcode = MS_IO_NONE,
              int attempt = 0,
              const char* reason = nullptr);
    void emit_state(ms_state state);

    void notify_state(ms_state state, ms_io_subcode subcode, int attempt, const char* reason);

    PacketQueue& queue_;
    Config cfg_;
    std::unique_ptr<RtmpPublisher> publisher_;
    std::thread thread_;

    std::atomic<bool> running_{false};
    std::atomic<bool> stop_requested_{false};

    // Реквест на keyframe — выставляется и сбрасывается из писателя.
    std::atomic<bool> need_keyframe_{false};

    StateChangeFn on_state_change_;
    EventFn on_event_;
    KeyframeFn on_request_keyframe_;

    // Для координации спячки backoff'а с stop_requested_.
    std::mutex sleep_mu_;
    std::condition_variable sleep_cv_;

    int dropped_at_last_emit_ = 0;
};

}  // namespace mafbase_stream

#endif
