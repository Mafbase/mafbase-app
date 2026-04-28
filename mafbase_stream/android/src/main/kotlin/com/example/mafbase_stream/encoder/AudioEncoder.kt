package com.example.mafbase_stream.encoder

import android.annotation.SuppressLint
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaCodec
import android.media.MediaCodecInfo
import android.media.MediaFormat
import android.media.MediaRecorder
import android.os.SystemClock
import android.util.Log
import java.nio.ByteBuffer

/**
 * Захват PCM с микрофона + AAC LC энкодер.
 *
 * PTS считается от количества переданных в кодек сэмплов (totalSamples * 1_000_000 / sampleRate),
 * что обеспечивает монотонную и независимую от системного времени временную шкалу. Mp4Recorder
 * затем зануляет её относительно первого закодированного сэмпла.
 */
internal class AudioEncoder(
    private val sampleRate: Int = 44_100,
    private val channels: Int = 1,
    private val bitRate: Int = 128_000,
    private val sink: Sink,
) {
    interface Sink {
        fun onAudioFormatReady(format: MediaFormat)
        fun onAudioEncoded(buffer: ByteBuffer, info: MediaCodec.BufferInfo)
        fun onAudioError(t: Throwable)

        /**
         * AudioSpecificConfig (raw 2 байта для AAC LC), выдаётся MediaCodec до первого aud-кадра.
         * Используется для формирования extradata, который ожидает FFmpeg FLV-muxer.
         */
        fun onAudioCodecConfig(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {}
    }

    private var encoder: MediaCodec? = null
    private var audioRecord: AudioRecord? = null
    private var thread: Thread? = null

    @Volatile
    private var running = false

    private var bufferSize = 0
    private var totalSamples = 0L

    /**
     * Момент `audioRecord.startRecording()` в общей системной шкале (`SystemClock.elapsedRealtimeNanos / 1000`).
     * MediaCodec выдаёт `presentationTimeUs` относительно начала энкодинга (totalSamples-based),
     * поэтому для AV-sync с видео-PTS (которые в той же системной шкале) нужно прибавить этот offset:
     *   absolute_us = info.presentationTimeUs + recordStartUptimeUs
     */
    var recordStartUptimeUs: Long = -1L
        private set

    @SuppressLint("MissingPermission")
    fun prepare() {
        val channelConfig = if (channels == 1) {
            AudioFormat.CHANNEL_IN_MONO
        } else {
            AudioFormat.CHANNEL_IN_STEREO
        }
        val pcmFormat = AudioFormat.ENCODING_PCM_16BIT
        val minBuf = AudioRecord.getMinBufferSize(sampleRate, channelConfig, pcmFormat)
        require(minBuf > 0) { "AudioRecord.getMinBufferSize returned $minBuf" }
        bufferSize = minBuf * 2

        val record = AudioRecord(
            MediaRecorder.AudioSource.MIC,
            sampleRate,
            channelConfig,
            pcmFormat,
            bufferSize,
        )
        if (record.state != AudioRecord.STATE_INITIALIZED) {
            record.release()
            error("AudioRecord init failed (state=${record.state})")
        }
        audioRecord = record

        val mime = MediaFormat.MIMETYPE_AUDIO_AAC
        val format = MediaFormat.createAudioFormat(mime, sampleRate, channels).apply {
            setInteger(MediaFormat.KEY_AAC_PROFILE, MediaCodecInfo.CodecProfileLevel.AACObjectLC)
            setInteger(MediaFormat.KEY_BIT_RATE, bitRate)
            setInteger(MediaFormat.KEY_MAX_INPUT_SIZE, bufferSize)
        }
        encoder = MediaCodec.createEncoderByType(mime).apply {
            configure(format, null, null, MediaCodec.CONFIGURE_FLAG_ENCODE)
        }
    }

    fun start() {
        val codec = encoder ?: error("AudioEncoder.prepare() not called")
        val record = audioRecord ?: error("AudioEncoder.prepare() not called")
        codec.start()
        record.startRecording()
        recordStartUptimeUs = SystemClock.elapsedRealtimeNanos() / 1000L
        running = true
        thread = Thread({ run(codec, record) }, "AudioEncoder").apply { start() }
    }

    fun signalEndOfStream() {
        running = false
    }

    fun release() {
        running = false
        // Дренаж сам выйдет, как только обработает EOS — даём ему до 5 секунд.
        // Если зависнет — interrupt и безопасный fallback (drain ловит IllegalStateException).
        val t = thread
        try {
            t?.join(5000)
            if (t != null && t.isAlive) {
                Log.w(TAG, "drain thread did not exit within 5s, interrupting")
                t.interrupt()
                t.join(500)
            }
        } catch (e: InterruptedException) {
            Thread.currentThread().interrupt()
        }
        thread = null

        try {
            audioRecord?.stop()
        } catch (e: Exception) {
            Log.w(TAG, "audioRecord stop failed", e)
        }
        try {
            audioRecord?.release()
        } catch (_: Exception) {
        }
        audioRecord = null

        try {
            encoder?.stop()
        } catch (e: Exception) {
            Log.w(TAG, "encoder stop failed", e)
        }
        try {
            encoder?.release()
        } catch (_: Exception) {
        }
        encoder = null
    }

    private fun run(codec: MediaCodec, record: AudioRecord) {
        val info = MediaCodec.BufferInfo()
        val pcm = ByteArray(bufferSize)
        var sentEos = false
        try {
            while (true) {
                if (running) {
                    val read = record.read(pcm, 0, pcm.size)
                    if (read > 0) {
                        feed(codec, pcm, read, eos = false)
                    }
                } else if (!sentEos) {
                    feedEos(codec)
                    sentEos = true
                }

                val drainResult = drain(codec, info)
                if (drainResult == DrainResult.Eos) {
                    break
                }
                if (sentEos && drainResult == DrainResult.NoOutput) {
                    Thread.sleep(5)
                }
            }
        } catch (e: InterruptedException) {
            Thread.currentThread().interrupt()
        } catch (e: IllegalStateException) {
            // Гонка release()↔drain: codec уже отпущен, тихо выходим.
            Log.w(TAG, "audio loop ended due to released codec: ${e.message}")
        } catch (e: Exception) {
            Log.e(TAG, "audio loop error", e)
            sink.onAudioError(e)
        }
    }

    private fun feed(codec: MediaCodec, pcm: ByteArray, length: Int, eos: Boolean) {
        val index = codec.dequeueInputBuffer(TIMEOUT_US)
        if (index < 0) return
        val input = codec.getInputBuffer(index) ?: return
        input.clear()
        input.put(pcm, 0, length)
        val ptsUs = totalSamples * 1_000_000L / sampleRate
        val flags = if (eos) MediaCodec.BUFFER_FLAG_END_OF_STREAM else 0
        codec.queueInputBuffer(index, 0, length, ptsUs, flags)
        // 16-bit PCM = 2 байта на сэмпл на канал.
        val bytesPerFrame = 2 * channels
        totalSamples += (length / bytesPerFrame).toLong()
    }

    private fun feedEos(codec: MediaCodec) {
        repeat(20) {
            val index = codec.dequeueInputBuffer(50_000L)
            if (index >= 0) {
                val ptsUs = totalSamples * 1_000_000L / sampleRate
                codec.queueInputBuffer(index, 0, 0, ptsUs, MediaCodec.BUFFER_FLAG_END_OF_STREAM)
                return
            }
        }
        Log.w(TAG, "feedEos: no input buffer available")
    }

    private fun drain(codec: MediaCodec, info: MediaCodec.BufferInfo): DrainResult {
        var hadOutput = false
        while (true) {
            val index = codec.dequeueOutputBuffer(info, 0L)
            when {
                index == MediaCodec.INFO_TRY_AGAIN_LATER ->
                    return if (hadOutput) DrainResult.HasOutput else DrainResult.NoOutput

                index == MediaCodec.INFO_OUTPUT_FORMAT_CHANGED -> {
                    sink.onAudioFormatReady(codec.outputFormat)
                }

                index >= 0 -> {
                    hadOutput = true
                    val buffer = codec.getOutputBuffer(index)
                    if (buffer != null && info.size > 0) {
                        if ((info.flags and MediaCodec.BUFFER_FLAG_CODEC_CONFIG) != 0) {
                            sink.onAudioCodecConfig(buffer, info)
                        } else {
                            sink.onAudioEncoded(buffer, info)
                        }
                    }
                    codec.releaseOutputBuffer(index, false)
                    if ((info.flags and MediaCodec.BUFFER_FLAG_END_OF_STREAM) != 0) {
                        return DrainResult.Eos
                    }
                }
            }
        }
    }

    private enum class DrainResult { NoOutput, HasOutput, Eos }

    companion object {
        private const val TAG = "AudioEncoder"
        private const val TIMEOUT_US = 10_000L
    }
}
