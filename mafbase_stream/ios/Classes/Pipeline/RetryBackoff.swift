import Foundation

/// Экспоненциальный backoff без лимита попыток: `baseMs · 2^attempt`, но не больше `capMs`.
/// Таймеры — на стороне вызывающего.
final class RetryBackoff {

    private static let maxShift = 30

    private let baseMs: Int
    private let capMs: Int

    /// Сколько повторов выдано с последнего `reset()`.
    private(set) var attempt = 0

    init(baseMs: Int, capMs: Int) {
        self.baseMs = baseMs
        self.capMs = capMs
    }

    /// Задержка для очередного повтора; увеличивает `attempt`.
    func nextDelayMs() -> Int {
        let delay = min(baseMs << min(attempt, Self.maxShift), capMs)
        attempt += 1
        return delay
    }

    func reset() {
        attempt = 0
    }
}
