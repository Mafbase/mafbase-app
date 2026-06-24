package com.example.mafbase_stream.events

import android.os.Handler
import android.os.Looper
import com.example.mafbase_stream.jni.StreamSessionNative
import io.flutter.plugin.common.EventChannel

/**
 * Шина событий стрим-сессии. EventChannel обращается к ней через [StreamHandler];
 * StreamSession (с любого экрана) шлёт события через [emit].
 *
 * Singleton специально: native-экран стрима живёт в отдельном Activity, а
 * EventChannel поднимается на FlutterEngine в момент onAttachedToEngine. Чтобы
 * не пробрасывать sink через Activity, держим один глобальный sink и фанаутим
 * через UI-handler.
 */
object StreamEventBus : EventChannel.StreamHandler {

    private val mainHandler = Handler(Looper.getMainLooper())

    @Volatile
    private var sink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
    }

    override fun onCancel(arguments: Any?) {
        sink = null
    }

    /**
     * Публикует событие в Dart. Сериализация на UI-thread — Flutter EventSink
     * не thread-safe, его нужно дёргать на main looper'е. Если sink не подключён
     * (Dart не подписан) — событие тихо дропается.
     */
    fun emit(event: StreamSessionNative.StreamEvent) {
        val current = sink ?: return
        val payload = mapOf(
            "type" to event.type.ordinal,
            "state" to event.state.ordinal,
            "bitrate_bps" to event.bitrateBps,
            "queue_depth_video_ms" to event.queueDepthVideoMs,
            "queue_depth_audio_ms" to event.queueDepthAudioMs,
            "dropped_frames_total" to event.droppedFramesTotal,
            "backpressure" to event.backpressure.ordinal,
            "network_quality" to event.networkQuality.ordinal,
            "reconnect_attempt" to event.reconnectAttempt,
            "io_subcode" to event.ioSubcode.ordinal,
            "reason" to event.reason,
        )
        mainHandler.post {
            // sink мог отвалиться, пока пост ехал.
            sink?.success(payload)
        }
    }
}
