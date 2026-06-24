import Flutter
import Foundation

/// Шина событий стрим-сессии. EventChannel.StreamHandler хранит sink здесь;
/// StreamSession (с любого native-экрана) шлёт события через `emit(_:)`.
///
/// Singleton: native-экран стрима живёт в отдельном UIViewController, а
/// EventChannel поднимается на FlutterEngine при register. Чтобы не пробрасывать
/// sink через VC, держим один глобальный.
final class StreamEventBus: NSObject, FlutterStreamHandler {

    static let shared = StreamEventBus()

    private var sink: FlutterEventSink?

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        return nil
    }

    /// Публикует событие в Dart. FlutterEventSink не thread-safe — всегда диспатчим
    /// на main queue. Если подписчика нет — событие тихо дропается.
    func emit(_ event: MafbaseStreamCoreEvent) {
        guard let sink = sink else { return }
        let payload: [String: Any?] = [
            "type": event.type.rawValue,
            "state": event.state.rawValue,
            "bitrate_bps": Int(event.bitrateBps),
            "queue_depth_video_ms": Int(event.queueDepthVideoMs),
            "queue_depth_audio_ms": Int(event.queueDepthAudioMs),
            "dropped_frames_total": Int(event.droppedFramesTotal),
            "backpressure": event.backpressure.rawValue,
            "network_quality": event.networkQuality.rawValue,
            "reconnect_attempt": Int(event.reconnectAttempt),
            "io_subcode": event.ioSubcode.rawValue,
            "reason": event.reason as Any?,
        ]
        DispatchQueue.main.async {
            // sink мог отвалиться к моменту диспатча.
            self.sink?(payload.compactMapValues { $0 })
        }
    }
}
