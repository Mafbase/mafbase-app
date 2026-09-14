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

    /** Синтетические типы событий — не приходят из C-ядра, см. [emitStorageEvent]. */
    enum class StorageEventType(val code: Int) {
        /** Места может не хватить примерно на [StorageMonitor.TARGET_RECORDING_HOURS] часов записи. */
        Warning(6),

        /** Свободного места критически мало — запись остановлена. */
        Low(7),
    }

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

    /**
     * Публикует событие о состоянии свободного места на устройстве — источник не
     * C-ядро RTMP-сессии (как в [emit]), а [StorageMonitor] на host-стороне записи.
     * Остальные поля события заполняются нулями/дефолтами — они не имеют смысла для
     * этого типа событий, значение несёт только [type] и [reason].
     */
    fun emitStorageEvent(type: StorageEventType, reason: String) {
        sink ?: return
        val payload = mapOf(
            "type" to type.code,
            "state" to 0,
            "bitrate_bps" to 0,
            "queue_depth_video_ms" to 0,
            "queue_depth_audio_ms" to 0,
            "dropped_frames_total" to 0,
            "backpressure" to 0,
            "network_quality" to 0,
            "reconnect_attempt" to 0,
            "io_subcode" to 0,
            "reason" to reason,
        )
        mainHandler.post {
            // sink мог отвалиться, пока пост ехал.
            sink?.success(payload)
        }
    }
}
