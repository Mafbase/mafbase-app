#ifndef MAFBASE_STREAM_SESSION_RECONNECT_POLICY_H
#define MAFBASE_STREAM_SESSION_RECONNECT_POLICY_H

namespace mafbase_stream {

// Простой контейнер с состоянием экспоненциального backoff. Не thread-safe —
// используется только из writer-thread, который сам же и владеет.
//
// Параметры по умолчанию: 1с → 2с → 4с (cap 8с), макс. 3 попытки.
class ReconnectPolicy {
public:
    struct Config {
        int max_attempts = 3;
        int base_delay_ms = 1000;
        int cap_delay_ms = 8000;
    };

    explicit ReconnectPolicy(Config cfg);

    // Сбрасывает счётчик попыток. Вызывать после успешного reconnect.
    void reset();

    // Возвращает true и инкрементирует counter, если ещё можно пытаться.
    // false → исчерпали лимит, выходим в FAILED.
    bool advance();

    // Сколько миллисекунд ждать перед следующей попыткой. Базовый exponential:
    // base * 2^(attempt-1), capped at cap.
    int next_delay_ms() const;

    int current_attempt() const { return attempt_; }

private:
    Config cfg_;
    int attempt_ = 0;
};

}  // namespace mafbase_stream

#endif
