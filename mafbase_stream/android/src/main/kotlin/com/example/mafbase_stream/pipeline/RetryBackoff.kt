package com.example.mafbase_stream.pipeline

/** Пауза перед повтором операции, которую заблокировал другой переход пайплайна. */
internal const val TRANSITION_RETRY_MS = 1_000L

/**
 * Экспоненциальный backoff без лимита попыток: `baseMs · 2^attempt`, но не больше [capMs].
 * Чистый JVM-класс — таймеры на стороне вызывающего.
 */
internal class RetryBackoff(private val baseMs: Long, private val capMs: Long) {

    /** Сколько повторов выдано с последнего [reset]. */
    var attempt: Int = 0
        private set

    /** Задержка для очередного повтора; увеличивает [attempt]. */
    fun nextDelayMs(): Long {
        val delay = (baseMs shl attempt.coerceAtMost(MAX_SHIFT)).coerceAtMost(capMs)
        attempt++
        return delay
    }

    fun reset() {
        attempt = 0
    }

    private companion object {
        const val MAX_SHIFT = 30
    }
}
