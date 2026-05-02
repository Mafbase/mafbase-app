package com.example.mafbase_stream.jni

import java.nio.ByteBuffer

/**
 * Тонкая Kotlin-обёртка над C-API ядра mafbase_stream (см. session.h в native/).
 *
 * Видео/аудио передаются через прямые ByteBuffer (allocateDirect) — JNI читает
 * указатель напрямую, без копирования. PTS — в микросекундах от старта сессии,
 * должен быть монотонно возрастающим.
 *
 * Жизненный цикл: create() → start(...) → pushVideo/pushAudio (много раз) → stop() → destroy().
 * После stop() сессию нельзя перезапустить — нужно создать новую.
 */
internal class StreamSessionNative private constructor(private var handle: Long) {

    /**
     * Запускает RTMP-сессию. Возвращает [Result.Ok] либо ошибку с человекочитаемым кодом.
     *
     * extradata: для H.264 — AVCC (без startcodes, длина-NALU), либо первые SPS+PPS Annex-B.
     * Для AAC — AudioSpecificConfig (обычно 2 байта). Если переданы пустые массивы —
     * ядро попытается извлечь SPS/PPS из первых пакетов само.
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
        init {
            System.loadLibrary("mafbase_stream_jni")
        }

        fun create(): StreamSessionNative {
            val handle = nativeCreate()
            check(handle != 0L) { "ms_session_create returned null" }
            return StreamSessionNative(handle)
        }

        @JvmStatic private external fun nativeCreate(): Long
        @JvmStatic private external fun nativeDestroy(handle: Long)
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
