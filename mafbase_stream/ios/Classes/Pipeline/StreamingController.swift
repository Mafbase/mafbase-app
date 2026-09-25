import Foundation
import Network

/// RTMP-стрим: `StreamSession` как выход компоситора плюс супервизор, который пересоздаёт
/// сессию после сбоя с backoff, пока стрим не остановил пользователь, а при смене сетевого
/// пути делает это сразу, не дожидаясь backoff.
///
/// Публичные методы и колбэки — на main queue. Старт и стоп сессии блокирующие и идут на
/// фоновой очереди; `session` читают очереди кадров и звука.
final class StreamingController {

    private static let restartBaseMs = 2000
    private static let restartCapMs = 15000
    /// Пауза перед повтором рестарта, которому помешал ролловер записи.
    private static let transitionRetry: TimeInterval = 1
    private static let errorMessageInterval: TimeInterval = 60

    /// Новая сессия с текущими параметрами пайплайна; `nil`, если пайплайна уже нет.
    var makeSession: (() -> StreamSession?)?
    var isReleased: (() -> Bool)?
    /// Рестарт стрима ждёт ролловер записи.
    var isRecordTransition: (() -> Bool)?
    var onStateChanged: (() -> Void)?
    var onMessage: ((String, Bool) -> Void)?

    /// Подключённая сессия — выход для кадров и звука; `nil`, пока сессия стартует или
    /// ждёт пересоздания.
    private(set) var session: StreamSession?
    /// Стрим включён пользователем. Остаётся true, пока сессия пересоздаётся после сбоя;
    /// сбрасывается по `stop()` или провалу самого первого старта.
    private(set) var isStreaming = false
    private(set) var isStreamTransition = false

    private let restartBackoff = RetryBackoff(
        baseMs: StreamingController.restartBaseMs,
        capMs: StreamingController.restartCapMs
    )
    private var restartTimer: Timer?
    private var lastErrorMessageAt: Date?
    /// Стоп пришёл, пока сессия стартовала — её погасит завершение старта.
    private var stopRequested = false
    private var pathMonitor: NWPathMonitor?
    private var lastPathKey: String?

    // MARK: - Controls

    func start() {
        guard !isStreaming, !isStreamTransition, let fresh = makeSession.flatMap({ $0() }) else { return }
        isStreamTransition = true
        stopRequested = false
        restartBackoff.reset()
        onStateChanged?()
        startPathMonitor()
        launch(fresh, replacing: nil, isRestart: false)
    }

    func stop() {
        cancelRestart()
        stopPathMonitor()
        guard let current = session else {
            if isStreamTransition {
                stopRequested = true
            } else if isStreaming {
                isStreaming = false
                onStateChanged?()
            }
            return
        }
        session = nil
        isStreaming = false
        isStreamTransition = true
        onStateChanged?()

        StreamPipeline.runProtectedFromSuspension(name: "mafbase_stream.stop-stream") { done in
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                current.stop()
                DispatchQueue.main.async {
                    done()
                    guard let self = self else { return }
                    self.isStreamTransition = false
                    self.onStateChanged?()
                }
            }
        }
    }

    /// Для освобождения пайплайна: без UI, стартующую сессию погасит завершение её старта.
    func stopForRelease() {
        cancelRestart()
        stopPathMonitor()
        isStreaming = false
        if isStreamTransition {
            stopRequested = true
        }
        guard let current = session else { return }
        session = nil
        StreamPipeline.runProtectedFromSuspension(name: "mafbase_stream.stop-stream") { done in
            current.stop()
            done()
        }
    }

    // MARK: - Session lifecycle

    private func launch(_ fresh: StreamSession, replacing old: StreamSession?, isRestart: Bool) {
        bind(fresh, isRestart: isRestart)
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            old?.stop()
            do {
                try fresh.start()
            } catch {
                NSLog("[mafbase_stream] StreamSession.start failed: \(error)")
                fresh.stop()
                DispatchQueue.main.async { self?.handleStartFailed(isRestart: isRestart, error: error) }
                return
            }
            DispatchQueue.main.async { self?.handleStarted(fresh) }
        }
    }

    private func bind(_ fresh: StreamSession, isRestart: Bool) {
        fresh.onStarted = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self, self.session === fresh else { return }
                self.restartBackoff.reset()
                self.onMessage?(isRestart ? "Стрим восстановлен" : "Стрим запущен", false)
            }
        }
        fresh.onError = { [weak self] error in
            DispatchQueue.main.async { self?.handleFailure(of: fresh, reason: "\(error)") }
        }
        fresh.onEvent = { [weak self] event in
            StreamEventBus.shared.emit(event)
            guard event.type == .failed else { return }
            DispatchQueue.main.async {
                self?.handleFailure(of: fresh, reason: event.reason ?? "reconnect exhausted")
            }
        }
    }

    private func handleStartFailed(isRestart: Bool, error: Error) {
        isStreamTransition = false
        if isRestart, isStreaming, !stopRequested, isReleased?() != true {
            scheduleRestart()
        } else {
            isStreaming = false
            stopRequested = false
            stopPathMonitor()
            if !isRestart {
                onMessage?("Не удалось начать стрим: \(error)", true)
            }
        }
        onStateChanged?()
    }

    private func handleStarted(_ fresh: StreamSession) {
        if isReleased?() == true || stopRequested {
            stopRequested = false
            isStreamTransition = false
            isStreaming = false
            stopPathMonitor()
            DispatchQueue.global(qos: .userInitiated).async { fresh.stop() }
            onStateChanged?()
            return
        }
        session = fresh
        isStreaming = true
        isStreamTransition = false
        onStateChanged?()
    }

    /// Сессия умерла (ядро прислало `failed` или энкодер выдал ошибку): отцепляем её и
    /// пересоздаём с backoff. Ошибки уже отцепленной сессии игнорируются.
    private func handleFailure(of failed: StreamSession, reason: String) {
        guard session === failed, isStreaming, isReleased?() != true else { return }
        session = nil
        DispatchQueue.global(qos: .userInitiated).async { failed.stop() }
        let now = Date()
        if lastErrorMessageAt.map({ now.timeIntervalSince($0) >= Self.errorMessageInterval }) ?? true {
            lastErrorMessageAt = now
            onMessage?("Ошибка стрима: \(reason). Переподключаемся…", true)
        }
        scheduleRestart()
    }

    // MARK: - Restart

    /// Backoff 2→4→8→15 с без лимита попыток.
    private func scheduleRestart() {
        guard restartTimer == nil, isReleased?() != true else { return }
        let delayMs = restartBackoff.nextDelayMs()
        NSLog("[mafbase_stream] stream restart #\(restartBackoff.attempt) in \(delayMs)ms")
        scheduleRestart(after: TimeInterval(delayMs) / 1000)
    }

    private func scheduleRestart(after delay: TimeInterval) {
        restartTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.restartTimer = nil
            self.restartNow()
        }
    }

    private func cancelRestart() {
        restartTimer?.invalidate()
        restartTimer = nil
    }

    private func restartNow() {
        guard isStreaming, !isStreamTransition, isReleased?() != true else { return }
        if isRecordTransition?() == true {
            scheduleRestart(after: Self.transitionRetry)
            return
        }
        guard let fresh = makeSession.flatMap({ $0() }) else { return }
        let old = session
        session = nil
        isStreamTransition = true
        onStateChanged?()
        launch(fresh, replacing: old, isRestart: true)
    }

    // MARK: - Network path

    private func startPathMonitor() {
        guard pathMonitor == nil else { return }
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self, self.pathMonitor === monitor else { return }
            let interfaces = path.availableInterfaces.map { "\($0.type)" }.sorted().joined(separator: ",")
            let key = "\(path.status)|\(interfaces)"
            let previous = self.lastPathKey
            self.lastPathKey = key
            // Первый колбэк приходит сразу при старте монитора — это не смена сети.
            guard previous != nil, previous != key, path.status == .satisfied else { return }
            self.handlePathChanged()
        }
        monitor.start(queue: .main)
        pathMonitor = monitor
    }

    private func stopPathMonitor() {
        pathMonitor?.cancel()
        pathMonitor = nil
        lastPathKey = nil
    }

    /// Сеть сменилась: если ждём backoff пересоздания или ядро в реконнекте — новая сессия
    /// сразу, старая после блипа обычно уже мёртвая.
    private func handlePathChanged() {
        guard isStreaming, isReleased?() != true else { return }
        let waitingForRestart = restartTimer != nil
        let coreReconnecting = session?.lastCoreState == .reconnecting
        guard waitingForRestart || coreReconnecting else { return }
        NSLog("[mafbase_stream] network path changed — reconnect now")
        cancelRestart()
        restartBackoff.reset()
        restartNow()
    }
}
