import Combine
import Foundation

/// Подписка на seatingContent через WebSocket. Кодовый аналог Kotlin-класса
/// `TournamentContentSocket.kt` (см. android/.../data/sockets/) и Dart-класса
/// `TournamentContentSocket` (см. lib/data/sockets/tournament_content_socket.dart):
/// тот же URL, тот же бинарный proto-формат, тот же auto-reconnect через 3 секунды.
///
/// Состояние отдаётся через `state` (`@Published`); SwiftUI подписывается через
/// `@StateObject`/`@ObservedObject`, нативный код может использовать Combine.
final class TournamentContentSocket: NSObject, ObservableObject {

    @Published private(set) var state: Generated_SeatingContent?

    private let url: URL
    private lazy var session: URLSession = URLSession(
        configuration: .default,
        delegate: self,
        delegateQueue: nil
    )
    private var task: URLSessionWebSocketTask?
    private var pingTimer: DispatchSourceTimer?
    private var reconnectWork: DispatchWorkItem?
    private let queue = DispatchQueue(label: "com.example.mafbase_stream.tournament_socket")
    private var manualClosed = false

    init(tournamentId: Int, table: Int) {
        var components = URLComponents(string: "wss://mafbase.ru/api/seatingContent")!
        components.queryItems = [
            URLQueryItem(name: "table", value: String(table)),
            URLQueryItem(name: "tournamentId", value: String(tournamentId)),
        ]
        self.url = components.url!
        super.init()
    }

    func connect() {
        queue.async { [weak self] in
            self?.connectOnQueue()
        }
    }

    func dispose() {
        queue.async { [weak self] in
            guard let self = self else { return }
            self.manualClosed = true
            self.cancelReconnect()
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
        NSLog("[TournamentSocket] connect \(url.absoluteString)")
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
                NSLog("[TournamentSocket] receive failed: \(error)")
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
            NSLog("[TournamentSocket] received data: \(data.count) bytes")
            parsePayload(data)
        case .string(let text):
            NSLog("[TournamentSocket] received string: \(text.count) chars, head=\(text.prefix(80))")
            if let data = text.data(using: .utf8) {
                parsePayload(data)
            }
        @unknown default:
            NSLog("[TournamentSocket] received unknown message kind")
        }
    }

    private func parsePayload(_ data: Data) {
        do {
            let parsed = try Generated_SeatingContent(serializedBytes: data)
            NSLog("[TournamentSocket] parsed: roles=\(parsed.roles.count) names=\(parsed.names.count) game=\(parsed.game)")
            DispatchQueue.main.async { [weak self] in
                self?.state = parsed
            }
        } catch {
            NSLog("[TournamentSocket] parse failed: \(error); first16=\(data.prefix(16).map { String(format: "%02x", $0) }.joined(separator: " "))")
        }
    }

    private func startPingLoop(for currentTask: URLSessionWebSocketTask) {
        pingTimer?.cancel()
        // 20 сек — тот же интервал, что у OkHttpClient.pingInterval на Android.
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: .now() + 20, repeating: 20)
        timer.setEventHandler { [weak self, weak currentTask] in
            guard let self = self, let task = currentTask, self.task === task else { return }
            task.sendPing { error in
                if let error = error {
                    NSLog("[TournamentSocket] ping failed: \(error)")
                    self.queue.async {
                        guard self.task === task else { return }
                        self.scheduleReconnect()
                    }
                }
            }
        }
        timer.resume()
        pingTimer = timer
    }

    private func scheduleReconnect() {
        guard !manualClosed, reconnectWork == nil else { return }
        pingTimer?.cancel()
        pingTimer = nil
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

extension TournamentContentSocket: URLSessionWebSocketDelegate {
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocolName: String?
    ) {
        NSLog("[TournamentSocket] didOpen protocol=\(protocolName ?? "nil")")
    }

    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {
        let reasonText = reason.flatMap { String(data: $0, encoding: .utf8) } ?? "nil"
        NSLog("[TournamentSocket] didClose code=\(closeCode.rawValue) reason=\(reasonText)")
        queue.async { [weak self] in
            guard let self = self, self.task === webSocketTask else { return }
            self.scheduleReconnect()
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            NSLog("[TournamentSocket] task didComplete error=\(error)")
        }
    }
}
