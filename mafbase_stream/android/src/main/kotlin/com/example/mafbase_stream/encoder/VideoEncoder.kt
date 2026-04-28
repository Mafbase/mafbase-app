package com.example.mafbase_stream.encoder

import android.media.MediaCodec
import android.media.MediaCodecInfo
import android.media.MediaFormat
import android.os.Bundle
import android.util.Log
import android.view.Surface
import java.nio.ByteBuffer

/**
 * Аппаратный H.264-энкодер на базе MediaCodec.
 *
 * Вход — Surface (createInputSurface), который добавляется в Camera2 capture session.
 * Выход — закодированные NAL-юниты, которые отдаются через [Sink] в Mp4Recorder.
 *
 * Поток дренажа output-буферов запускается в [start] и завершается:
 *  - при получении BUFFER_FLAG_END_OF_STREAM (после signalEndOfInputStream),
 *  - либо принудительно из release().
 */
internal class VideoEncoder(
    private val width: Int,
    private val height: Int,
    private val frameRate: Int = 30,
    private val bitRate: Int = 4_000_000,
    private val iFrameIntervalSec: Int = 2,
    private val sink: Sink,
) {
    interface Sink {
        fun onVideoFormatReady(format: MediaFormat)
        fun onVideoEncoded(buffer: ByteBuffer, info: MediaCodec.BufferInfo)
        fun onVideoError(t: Throwable)

        /**
         * SPS/PPS-кадр, выдаваемый MediaCodec до первого keyframe (Annex-B). Используется
         * для формирования AVCC extradata, который требует FFmpeg FLV-muxer перед write_header.
         * Default-реализация пустая — потребители (например, Mp4Recorder) могут игнорировать,
         * т.к. CODEC_CONFIG автоматически попадает в MediaFormat KEY_CSD-* и в muxer через addTrack.
         */
        fun onVideoCodecConfig(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {}
    }

    private var encoder: MediaCodec? = null
    private var inputSurface: Surface? = null
    private var drainThread: Thread? = null

    @Volatile
    private var draining = false

    val surface: Surface? get() = inputSurface

    fun prepare() {
        val mime = MediaFormat.MIMETYPE_VIDEO_AVC
        val format = MediaFormat.createVideoFormat(mime, width, height).apply {
            setInteger(
                MediaFormat.KEY_COLOR_FORMAT,
                MediaCodecInfo.CodecCapabilities.COLOR_FormatSurface,
            )
            setInteger(MediaFormat.KEY_BIT_RATE, bitRate)
            setInteger(MediaFormat.KEY_FRAME_RATE, frameRate)
            setInteger(MediaFormat.KEY_I_FRAME_INTERVAL, iFrameIntervalSec)
            // CBR, а не VBR: для live-RTMP важно держать реальный битрейт близко к
            // целевому, чтобы он совпадал с пропускной способностью сети. Плюс
            // только в CBR аппаратный энкодер надёжно honoring'ует runtime-смену
            // битрейта (PARAMETER_KEY_VIDEO_BITRATE, см. setBitrate); в VBR Exynos/
            // Tensor принимает параметр в конфиг, но реальный выход не меняет —
            // адаптивный битрейт оказывается no-op.
            setInteger(
                MediaFormat.KEY_BITRATE_MODE,
                MediaCodecInfo.EncoderCapabilities.BITRATE_MODE_CBR,
            )
        }

        val codec = MediaCodec.createEncoderByType(mime)
        codec.configure(format, null, null, MediaCodec.CONFIGURE_FLAG_ENCODE)
        inputSurface = codec.createInputSurface()
        encoder = codec
    }

    fun start() {
        val codec = encoder ?: error("VideoEncoder.prepare() not called")
        codec.start()
        draining = true
        drainThread = Thread({ drainLoop(codec) }, "VideoEncoder-drain").apply { start() }
    }

    fun signalEndOfStream() {
        try {
            encoder?.signalEndOfInputStream()
        } catch (e: Exception) {
            Log.w(TAG, "signalEndOfInputStream failed", e)
        }
    }

    /**
     * Просит энкодер выдать IDR на ближайшем кадре. Без этого после reconnect
     * плеер не может декодировать ни кадра до следующего GOP-интервала.
     */
    fun requestKeyFrame() {
        val codec = encoder ?: return
        try {
            val params = Bundle().apply {
                putInt(MediaCodec.PARAMETER_KEY_REQUEST_SYNC_FRAME, 0)
            }
            codec.setParameters(params)
        } catch (e: Exception) {
            Log.w(TAG, "requestKeyFrame failed", e)
        }
    }

    /**
     * Меняет целевой битрейт runtime'е. Применяется на следующем GOP — не
     * мгновенно, но достаточно быстро для адаптации к сети.
     */
    fun setBitrate(bitrateBps: Int) {
        val codec = encoder ?: return
        if (bitrateBps <= 0) return
        try {
            val params = Bundle().apply {
                putInt(MediaCodec.PARAMETER_KEY_VIDEO_BITRATE, bitrateBps)
            }
            codec.setParameters(params)
        } catch (e: Exception) {
            Log.w(TAG, "setBitrate failed", e)
        }
    }

    fun release() {
        // Ждём естественного завершения по EOS до 5с.
        val t = drainThread
        try {
            t?.join(5000)
            if (t != null && t.isAlive) {
                Log.w(TAG, "drain thread did not exit within 5s, interrupting")
                draining = false
                t.interrupt()
                t.join(500)
            }
        } catch (e: InterruptedException) {
            Thread.currentThread().interrupt()
        }
        drainThread = null
        draining = false

        try {
            encoder?.stop()
        } catch (e: Exception) {
            Log.w(TAG, "encoder stop failed", e)
        }
        try {
            encoder?.release()
        } catch (e: Exception) {
            Log.w(TAG, "encoder release failed", e)
        }
        try {
            inputSurface?.release()
        } catch (_: Exception) {
        }
        encoder = null
        inputSurface = null
    }

    private fun drainLoop(codec: MediaCodec) {
        val info = MediaCodec.BufferInfo()
        try {
            while (draining) {
                val index = codec.dequeueOutputBuffer(info, TIMEOUT_US)
                when {
                    index == MediaCodec.INFO_TRY_AGAIN_LATER -> {
                        // продолжаем
                    }

                    index == MediaCodec.INFO_OUTPUT_FORMAT_CHANGED -> {
                        sink.onVideoFormatReady(codec.outputFormat)
                    }

                    index >= 0 -> {
                        val buffer = codec.getOutputBuffer(index)
                        if (buffer != null && info.size > 0) {
                            if ((info.flags and MediaCodec.BUFFER_FLAG_CODEC_CONFIG) != 0) {
                                sink.onVideoCodecConfig(buffer, info)
                            } else {
                                sink.onVideoEncoded(buffer, info)
                            }
                        }
                        codec.releaseOutputBuffer(index, false)
                        if ((info.flags and MediaCodec.BUFFER_FLAG_END_OF_STREAM) != 0) {
                            draining = false
                        }
                    }
                }
            }
        } catch (e: IllegalStateException) {
            // Гонка release()↔drain: codec уже отпущен, тихо выходим.
            Log.w(TAG, "video loop ended due to released codec: ${e.message}")
        } catch (e: Exception) {
            Log.e(TAG, "video drain error", e)
            sink.onVideoError(e)
        }
    }

    companion object {
        private const val TAG = "VideoEncoder"
        private const val TIMEOUT_US = 10_000L
    }
}
