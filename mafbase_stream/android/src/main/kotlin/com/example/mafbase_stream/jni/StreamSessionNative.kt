package com.example.mafbase_stream.jni

import android.util.Log
import java.lang.ref.WeakReference
import java.nio.ByteBuffer
import java.util.concurrent.ConcurrentHashMap

/**
 * Тонкая Kotlin-обёртка над C-API ядра mafbase_stream (см. session.h в native/).
 *
 * Видео/аудио передаются через прямые ByteBuffer (allocateDirect) — JNI читает
 * указатель напрямую, без копирования. PTS — в микросекундах от старта сессии,
 * должен быть монотонно возрастающим.
 *
 * Жизненный цикл: create() → start(...) → pushVideo/pushAudio (много раз) → stop() → destroy().
 * После stop() сессию нельзя перезапустить — нужно создать новую.
 *
 * Колбеки (события, request keyframe, set bitrate) приходят из писательского
 * потока ядра. JNI диспатчит их по handle'у через статические методы (см. ниже),
 * а тут — раздаются конкретному инстансу через [Listener].
 */
class StreamSessionNative private constructor(private var handle: Long) {

    interface Listener {
        fun onEvent(event: StreamEvent) {}
        fun onRequestKeyframe() {}
        fun onSetVideoBitrate(bitrateBps: Int) {}
    }

    /** Плоское представление события из ядра — без аллокации Java-объектов из C++. */
    data class StreamEvent(
        val type: EventType,
        val state: State,
        val bitrateBps: Int,
        val queueDepthVideoMs: Int,
        val queueDepthAudioMs: Int,
        val droppedFramesTotal: Int,
        val backpressure: Backpressure,
        val networkQuality: NetworkQuality,
        val reconnectAttempt: Int,
        val ioSubcode: IoSubcode,
        val reason: String?,
    )

    enum class EventType { State, QueueDepth, Bitrate, Reconnecting, Reconnected, Failed;
        companion object { fun fromInt(v: Int): EventType = values().getOrNull(v) ?: State }
    }

    enum class Backpressure { None, Low, High;
        companion object { fun fromInt(v: Int): Backpressure = values().getOrNull(v) ?: None }
    }

    enum class NetworkQuality { Good, Degraded, Bad;
        companion object { fun fromInt(v: Int): NetworkQuality = values().getOrNull(v) ?: Good }
    }

    enum class IoSubcode { None, Timeout, Eof, ConnReset, Other;
        companion object { fun fromInt(v: Int): IoSubcode = values().getOrNull(v) ?: None }
    }

    private var listener: Listener? = null

    fun setListener(listener: Listener?) {
        this.listener = listener
        if (handle != 0L) nativeSetCallbacks(handle)
    }

    /**
     * Запускает RTMP-сессию. Возвращает [Result.Ok] либо ошибку с человекочитаемым кодом.
     *
     * extradata: для H.264 — AVCC (без startcodes, длина-NALU), либо первые SPS+PPS Annex-B.
     * Для AAC — AudioSpecificConfig (обычно 2 байта). Если переданы пустые массивы —
     * ядро попытается извлечь SPS/PPS из первых пакетов само.
     *
     * adaptiveBitrate, max/base/cap reconnect, ioTimeoutUs — 0/false передавать для дефолтов ядра.
     */
    fun start(
        rtmpUrl: String,
        width: Int,
        height: Int,
        fps: Int,
        videoBitrate: Int,
        audioSampleRate: Int,
        audioChannels: Int,
        audioBitrate: Int,
        videoExtradata: ByteArray?,
        audioExtradata: ByteArray?,
        adaptiveBitrate: Boolean = true,
        maxReconnectAttempts: Int = 0,
        reconnectBaseDelayMs: Int = 0,
        reconnectCapDelayMs: Int = 0,
        ioTimeoutUs: Int = 0,
    ): Result {
        check(handle != 0L) { "session is destroyed" }
        val code = nativeStart(
            handle,
            rtmpUrl,
            width,
            height,
            fps,
            videoBitrate,
            audioSampleRate,
            audioChannels,
            audioBitrate,
            videoExtradata,
            audioExtradata,
            adaptiveBitrate,
            maxReconnectAttempts,
            reconnectBaseDelayMs,
            reconnectCapDelayMs,
            ioTimeoutUs,
        )
        return code.toResult()
    }

    /**
     * @param data direct ByteBuffer с access unit (один или несколько NAL в Annex-B либо AVCC).
     * @param offset смещение в data от начала буфера.
     * @param size длина access unit в байтах.
     * @param ptsUs presentation timestamp в микросекундах от старта сессии.
     * @param isKeyframe true для IDR-кадров.
     */
    fun pushVideo(data: ByteBuffer, offset: Int, size: Int, ptsUs: Long, isKeyframe: Boolean): Result {
        if (handle == 0L) return Result.InvalidState
        require(data.isDirect) { "direct ByteBuffer required for zero-copy JNI" }
        return nativePushVideo(handle, data, offset, size, ptsUs, isKeyframe).toResult()
    }

    fun pushAudio(data: ByteBuffer, offset: Int, size: Int, ptsUs: Long): Result {
        if (handle == 0L) return Result.InvalidState
        require(data.isDirect) { "direct ByteBuffer required for zero-copy JNI" }
        return nativePushAudio(handle, data, offset, size, ptsUs).toResult()
    }

    fun stop(): Result {
        if (handle == 0L) return Result.Ok
        return nativeStop(handle).toResult()
    }

    fun state(): State {
        if (handle == 0L) return State.Stopped
        return State.fromInt(nativeGetState(handle))
    }

    fun destroy() {
        if (handle == 0L) return
        instances.remove(handle)
        nativeDestroy(handle)
        handle = 0L
    }

    sealed class Result(val code: Int) {
        object Ok : Result(0)
        object InvalidArg : Result(-1)
        object InvalidState : Result(-2)
        object Io : Result(-3)
        object Ffmpeg : Result(-4)
        object NoMemory : Result(-5)
        object Timeout : Result(-6)
        class Unknown(code: Int) : Result(code)

        val isOk: Boolean get() = this is Ok
        val name: String get() = nativeResultStr(code)
    }

    enum class State {
        Idle, Connecting, Streaming, Reconnecting, Stopped;

        companion object {
            fun fromInt(value: Int): State = when (value) {
                0 -> Idle
                1 -> Connecting
                2 -> Streaming
                3 -> Reconnecting
                4 -> Stopped
                else -> Stopped
            }
        }
    }

    companion object {
        private const val TAG = "StreamSessionNative"

        // handle → WeakReference на инстанс. JNI вызывает диспатчеры по handle, мы
        // находим listener соответствующего инстанса. WeakReference не мешает GC,
        // если хост-код потерял ссылку.
        private val instances = ConcurrentHashMap<Long, WeakReference<StreamSessionNative>>()

        init {
            System.loadLibrary("mafbase_stream_jni")
        }

        fun create(): StreamSessionNative {
            val handle = nativeCreate()
            check(handle != 0L) { "ms_session_create returned null" }
            val instance = StreamSessionNative(handle)
            instances[handle] = WeakReference(instance)
            return instance
        }

        // ---- JNI-диспатчеры (вызываются из C из writer-thread) ----

        @JvmStatic
        @Suppress("LongParameterList", "UNUSED_PARAMETER")
        fun dispatchEvent(
            handle: Long,
            type: Int,
            state: Int,
            bitrate: Int,
            queueDepthVideoMs: Int,
            queueDepthAudioMs: Int,
            droppedFramesTotal: Int,
            backpressure: Int,
            networkQuality: Int,
            reconnectAttempt: Int,
            ioSubcode: Int,
            reason: String?,
        ) {
            val instance = instances[handle]?.get() ?: return
            val ev = StreamEvent(
                type = EventType.fromInt(type),
                state = State.fromInt(state),
                bitrateBps = bitrate,
                queueDepthVideoMs = queueDepthVideoMs,
                queueDepthAudioMs = queueDepthAudioMs,
                droppedFramesTotal = droppedFramesTotal,
                backpressure = Backpressure.fromInt(backpressure),
                networkQuality = NetworkQuality.fromInt(networkQuality),
                reconnectAttempt = reconnectAttempt,
                ioSubcode = IoSubcode.fromInt(ioSubcode),
                reason = reason,
            )
            try {
                instance.listener?.onEvent(ev)
            } catch (t: Throwable) {
                Log.e(TAG, "listener.onEvent threw", t)
            }
        }

        @JvmStatic
        fun dispatchRequestKeyframe(handle: Long) {
            val instance = instances[handle]?.get() ?: return
            try {
                instance.listener?.onRequestKeyframe()
            } catch (t: Throwable) {
                Log.e(TAG, "listener.onRequestKeyframe threw", t)
            }
        }

        @JvmStatic
        fun dispatchSetVideoBitrate(handle: Long, bitrateBps: Int) {
            val instance = instances[handle]?.get() ?: return
            try {
                instance.listener?.onSetVideoBitrate(bitrateBps)
            } catch (t: Throwable) {
                Log.e(TAG, "listener.onSetVideoBitrate threw", t)
            }
        }

        @JvmStatic private external fun nativeCreate(): Long
        @JvmStatic private external fun nativeDestroy(handle: Long)
        @JvmStatic private external fun nativeSetCallbacks(handle: Long)

        @JvmStatic private external fun nativeStart(
            handle: Long,
            url: String,
            width: Int,
            height: Int,
            fps: Int,
            videoBitrate: Int,
            audioSampleRate: Int,
            audioChannels: Int,
            audioBitrate: Int,
            videoExtradata: ByteArray?,
            audioExtradata: ByteArray?,
            adaptiveBitrate: Boolean,
            maxReconnectAttempts: Int,
            reconnectBaseDelayMs: Int,
            reconnectCapDelayMs: Int,
            ioTimeoutUs: Int,
        ): Int

        @JvmStatic private external fun nativePushVideo(
            handle: Long,
            buffer: ByteBuffer,
            offset: Int,
            size: Int,
            ptsUs: Long,
            isKeyframe: Boolean,
        ): Int

        @JvmStatic private external fun nativePushAudio(
            handle: Long,
            buffer: ByteBuffer,
            offset: Int,
            size: Int,
            ptsUs: Long,
        ): Int

        @JvmStatic private external fun nativeStop(handle: Long): Int
        @JvmStatic private external fun nativeGetState(handle: Long): Int
        @JvmStatic private external fun nativeResultStr(code: Int): String

        private fun Int.toResult(): Result = when (this) {
            0 -> Result.Ok
            -1 -> Result.InvalidArg
            -2 -> Result.InvalidState
            -3 -> Result.Io
            -4 -> Result.Ffmpeg
            -5 -> Result.NoMemory
            -6 -> Result.Timeout
            else -> Result.Unknown(this)
        }
    }
}
