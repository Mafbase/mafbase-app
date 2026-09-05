import Combine
import Foundation
import Network

/// Базовый WebSocket-клиент контент-сокетов плашек (кодовые аналоги Kotlin-классов
/// в android/.../data/sockets/ и Dart-классов в lib/data/sockets/): бинарный
/// proto-формат SeatingContent, auto-reconnect через 3 секунды.
///
/// URLSessionWebSocketTask, в отличие от OkHttp на Android, сам не фейлит
/// «зомби»-соединения: после смены сетевого пути receive и sendPing могут молча
/// зависнуть без ошибки. Поэтому кроме реакции на явные ошибки здесь есть:
///  - pong-watchdog: ping без ответа к следующему тику → реконнект (то, что
///    OkHttp делает сам через pingInterval);
///  - реконнект по didCompleteWithError (на части abnormal-обрывов это
///    единственный колбэк, который приходит);
///  - NWPathMonitor: мгновенный реконнект при смене сетевого пути, не дожидаясь
///    watchdog-таймаута.
///
/// Состояние отдаётся через `state` (`@Published`); SwiftUI подписывается через
/// `@StateObject`/`@ObservedObject`, нативный код может использовать Combine.
class SeatingContentSocket: NSObject, ObservableObject {

    @Published private(set) var state: Generated_SeatingContent?

    private let url: URL
    private let logTag: String
    private lazy var session: URLSession = URLSession(
        configuration: .default,
        delegate: self,
        delegateQueue: nil
    )
    private var task: URLSessionWebSocketTask?
    private var pingTimer: DispatchSourceTimer?
    private var pingInFlight = false
    private var reconnectWork: DispatchWorkItem?
    private let queue = DispatchQueue(label: "com.example.mafbase_stream.content_socket")
    private var manualClosed = false
    private var pathMonitor: NWPathMonitor?
    private var lastPathKey: String?

    init(url: URL, logTag: String) {
        self.url = url
        self.logTag = logTag
        super.init()
    }

    func connect() {
        queue.async { [weak self] in
            guard let self = self else { return }
            self.startPathMonitor()
            self.connectOnQueue()
        }
    }

    func dispose() {
        queue.async { [weak self] in
            guard let self = self else { return }
            self.manualClosed = true
            self.cancelReconnect()
            self.pathMonitor?.cancel()
            self.pathMonitor = nil
            self.pingTimer?.cancel()
            self.pingTimer = nil
            self.task?.cancel(with: .goingAway, reason: nil)
            self.task = nil
            self.session.invalidateAndCancel()
        }
    }

    // MARK: - Private

    private func connectOnQueue() {
        guard !manualClosed else { return }
        cancelReconnect()
        task?.cancel(with: .goingAway, reason: nil)
        NSLog("[\(logTag)] connect \(url.absoluteString)")
        // Заголовок Origin требуют некоторые WebSocket-серверы (включая ноду на mafbase.ru)
        // для отдачи кадров обратно — без него соединение может молча закрываться сразу
        // после handshake. На Android OkHttp подставляет Origin автоматически, на iOS —
        // надо ставить вручную через URLRequest.
        var request = URLRequest(url: url)
        request.setValue("https://mafbase.ru", forHTTPHeaderField: "Origin")
        let newTask = session.webSocketTask(with: request)
        task = newTask
        newTask.resume()
        startPingLoop(for: newTask)
        receiveLoop(on: newTask)
    }

    private func receiveLoop(on currentTask: URLSessionWebSocketTask) {
        currentTask.receive { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let message):
                self.handleMessage(message)
                self.queue.async {
                    if self.task === currentTask {
                        self.receiveLoop(on: currentTask)
                    }
                }
            case .failure(let error):
                NSLog("[\(self.logTag)] receive failed: \(error)")
                self.queue.async {
                    guard self.task === currentTask else { return }
                    self.scheduleReconnect()
                }
            }
        }
    }

    private func handleMessage(_ message: URLSessionWebSocketTask.Message) {
        switch message {
        case .data(let data):
            NSLog("[\(logTag)] received data: \(data.count) bytes")
            parsePayload(data)
        case .string(let text):
            NSLog("[\(logTag)] received string: \(text.count) chars, head=\(text.prefix(80))")
            if let data = text.data(using: .utf8) {
                parsePayload(data)
            }
        @unknown default:
            NSLog("[\(logTag)] received unknown message kind")
        }
    }

    /// Разбирает бинарный кадр сокета. Турнирный эндпоинт отдаёт `SeatingContent`;
    /// клубный — своё сообщение, см. переопределение в [ClubContentSocket].
    func decode(_ data: Data) throws -> Generated_SeatingContent {
        try Generated_SeatingContent(serializedBytes: data)
    }

    private func parsePayload(_ data: Data) {
        do {
            let parsed = try decode(data)
            NSLog(
                "[\(logTag)] parsed: roles=\(parsed.roles.count) names=\(parsed.names.count)"
                    + " images=\(parsed.images.count) game=\(parsed.game) phase=\(parsed.broadcastPhase)"
            )
            DispatchQueue.main.async { [weak self] in
                self?.state = parsed
            }
        } catch {
            NSLog("[\(logTag)] parse failed: \(error); first16=\(data.prefix(16).map { String(format: "%02x", $0) }.joined(separator: " "))")
        }
    }

    private func startPingLoop(for currentTask: URLSessionWebSocketTask) {
        pingTimer?.cancel()
        pingInFlight = false
        // 20 сек — тот же интервал, что у OkHttpClient.pingInterval на Android.
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: .now() + 20, repeating: 20)
        timer.setEventHandler { [weak self, weak currentTask] in
            guard let self = self, let task = currentTask, self.task === task else { return }
            // Watchdog: completion прошлого ping'а так и не пришёл — соединение
            // зомби (URLSessionWebSocketTask в этом случае не выдаёт ошибку).
            if self.pingInFlight {
                NSLog("[\(self.logTag)] pong timeout — reconnect")
                self.scheduleReconnect()
                return
            }
            self.pingInFlight = true
            task.sendPing { error in
                self.queue.async {
                    guard self.task === task else { return }
                    self.pingInFlight = false
                    if let error = error {
                        NSLog("[\(self.logTag)] ping failed: \(error)")
                        self.scheduleReconnect()
                    }
                }
            }
        }
        timer.resume()
        pingTimer = timer
    }

    /// Реконнект при смене сетевого пути: статус или набор интерфейсов изменился
    /// и сеть доступна → пересоздаём соединение сразу. Старое после блипа обычно
    /// уже мёртвое, даже если ошибок не приходило.
    private func startPathMonitor() {
        guard pathMonitor == nil else { return }
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            let interfaces = path.availableInterfaces.map { "\($0.type)" }.sorted().joined(separator: ",")
            let key = "\(path.status)|\(interfaces)"
            let previous = self.lastPathKey
            self.lastPathKey = key
            // Первый колбэк приходит сразу при старте монитора — это не смена сети.
            guard previous != nil, previous != key, path.status == .satisfied else { return }
            NSLog("[\(self.logTag)] network path changed (\(key)) — reconnect")
            self.reconnectNow()
        }
        monitor.start(queue: queue)
        pathMonitor = monitor
    }

    private func reconnectNow() {
        guard !manualClosed else { return }
        cancelReconnect()
        pingTimer?.cancel()
        pingTimer = nil
        pingInFlight = false
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
        connectOnQueue()
    }

    private func scheduleReconnect() {
        guard !manualClosed, reconnectWork == nil else { return }
        pingTimer?.cancel()
        pingTimer = nil
        pingInFlight = false
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
        let work = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.reconnectWork = nil
            self.connectOnQueue()
        }
        reconnectWork = work
        queue.asyncAfter(deadline: .now() + 3, execute: work)
    }

    private func cancelReconnect() {
        reconnectWork?.cancel()
        reconnectWork = nil
    }
}

// MARK: - URLSessionWebSocketDelegate

extension SeatingContentSocket: URLSessionWebSocketDelegate {
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocolName: String?
    ) {
        NSLog("[\(logTag)] didOpen protocol=\(protocolName ?? "nil")")
    }

    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {
        let reasonText = reason.flatMap { String(data: $0, encoding: .utf8) } ?? "nil"
        NSLog("[\(logTag)] didClose code=\(closeCode.rawValue) reason=\(reasonText)")
        queue.async { [weak self] in
            guard let self = self, self.task === webSocketTask else { return }
            self.scheduleReconnect()
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            NSLog("[\(logTag)] task didComplete error=\(error)")
        }
        queue.async { [weak self] in
            guard let self = self, self.task === task else { return }
            self.scheduleReconnect()
        }
    }
}
