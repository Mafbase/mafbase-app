package com.example.mafbase_stream.encoder

import android.media.MediaCodec
import android.media.MediaFormat
import android.util.Log
import com.example.mafbase_stream.PhaseGate
import java.nio.ByteBuffer

/**
 * Общий audio-пайплайн с одним [AudioEncoder] и refcount-подпиской.
 *
 * Зачем: на Android две `AudioRecord` на `AudioSource.MIC` в одном процессе конфликтуют —
 * один из клиентов будет получать тишину или ошибку при start. Когда мы хотим параллельно
 * вести запись MP4 и RTMP-стрим, оба потребителя должны слушать один и тот же
 * энкодер.
 *
 * Жизненный цикл:
 *  - первый [subscribe] поднимает энкодер (`prepare` + `start`). Все подписчики получают
 *    `MediaFormat`, кешированный AAC `csd-0` и далее каждый encoded sample.
 *  - последующие подписки получают кешированные format/codec-config немедленно
 *    (MediaCodec выдаёт их один раз — без кеша второй подписчик не дождался бы).
 *  - последний [unsubscribe] дренажит и освобождает энкодер.
 *
 * Фанаут под общим [lock] сериализует обоих подписчиков, поэтому одного `ByteBuffer`
 * достаточно: каждый подписчик читает из него синхронно, мы сохраняем/восстанавливаем
 * position/limit между вызовами.
 *
 * [recordStartUptimeUs] переиспользуется `StreamSession` для приведения PTS аудио в
 * системную шкалу (та же, что у видео-PTS) для AV-sync.
 */
class AudioPipeline(
    private val sampleRate: Int = 44_100,
    private val channels: Int = 1,
    private val bitRate: Int = 128_000,
    private val phaseGate: PhaseGate? = null,
) {
    interface Subscriber {
        fun onAudioFormatReady(format: MediaFormat) {}
        fun onAudioCodecConfig(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {}
        fun onAudioEncoded(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {}
        fun onAudioError(t: Throwable) {}
    }

    private val lock = Any()
    private val subscribers = mutableListOf<Subscriber>()

    private var encoder: AudioEncoder? = null
    private var cachedFormat: MediaFormat? = null
    private var cachedCsd: ByteArray? = null

    /** Доступно после первого [subscribe]; -1 пока энкодер не запущен. */
    var recordStartUptimeUs: Long = -1L
        private set

    fun subscribe(subscriber: Subscriber) {
        synchronized(lock) {
            subscribers.add(subscriber)
            if (encoder == null) {
                val enc = AudioEncoder(
                    sampleRate = sampleRate,
                    channels = channels,
                    bitRate = bitRate,
                    sink = encoderSink,
                    phaseGate = phaseGate,
                )
                try {
                    enc.prepare()
                    enc.start()
                } catch (t: Throwable) {
                    Log.e(TAG, "AudioEncoder start failed", t)
                    try {
                        enc.release()
                    } catch (_: Throwable) {
                    }
                    subscribers.remove(subscriber)
                    throw t
                }
                encoder = enc
                recordStartUptimeUs = enc.recordStartUptimeUs
            } else {
                cachedFormat?.let { subscriber.onAudioFormatReady(it) }
                cachedCsd?.let { csd ->
                    val bb = ByteBuffer.wrap(csd)
                    val info = MediaCodec.BufferInfo().apply {
                        set(0, csd.size, 0, MediaCodec.BUFFER_FLAG_CODEC_CONFIG)
                    }
                    subscriber.onAudioCodecConfig(bb, info)
                }
            }
        }
    }

    fun unsubscribe(subscriber: Subscriber) {
        val toRelease: AudioEncoder?
        synchronized(lock) {
            subscribers.remove(subscriber)
            if (subscribers.isNotEmpty()) return
            toRelease = encoder
            encoder = null
            cachedFormat = null
            cachedCsd = null
            recordStartUptimeUs = -1L
        }
        // release() блокирующий (join до 5с) — выполняем вне lock, чтобы не задерживать
        // потенциальные subscribe от другого подписчика и не держать lock на drain-потоке.
        try {
            toRelease?.signalEndOfStream()
            toRelease?.release()
        } catch (t: Throwable) {
            Log.w(TAG, "encoder release error", t)
        }
    }

    private val encoderSink = object : AudioEncoder.Sink {
        override fun onAudioFormatReady(format: MediaFormat) {
            synchronized(lock) {
                cachedFormat = format
                subscribers.forEach { sub ->
                    try {
                        sub.onAudioFormatReady(format)
                    } catch (t: Throwable) {
                        Log.w(TAG, "subscriber onAudioFormatReady error", t)
                    }
                }
            }
        }

        override fun onAudioCodecConfig(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {
            synchronized(lock) {
                val bytes = ByteArray(info.size)
                val savedPos = buffer.position()
                val savedLimit = buffer.limit()
                buffer.position(info.offset)
                buffer.limit(info.offset + info.size)
                buffer.get(bytes)
                buffer.position(savedPos)
                buffer.limit(savedLimit)
                cachedCsd = bytes

                subscribers.forEach { sub ->
                    val replay = ByteBuffer.wrap(bytes)
                    val replayInfo = MediaCodec.BufferInfo().apply {
                        set(0, bytes.size, info.presentationTimeUs, info.flags)
                    }
                    try {
                        sub.onAudioCodecConfig(replay, replayInfo)
                    } catch (t: Throwable) {
                        Log.w(TAG, "subscriber onAudioCodecConfig error", t)
                    }
                }
            }
        }

        override fun onAudioEncoded(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {
            synchronized(lock) {
                val savedPos = buffer.position()
                val savedLimit = buffer.limit()
                subscribers.forEach { sub ->
                    buffer.position(savedPos)
                    buffer.limit(savedLimit)
                    try {
                        sub.onAudioEncoded(buffer, info)
                    } catch (t: Throwable) {
                        Log.w(TAG, "subscriber onAudioEncoded error", t)
                    }
                }
                buffer.position(savedPos)
                buffer.limit(savedLimit)
            }
        }

        override fun onAudioError(t: Throwable) {
            synchronized(lock) {
                subscribers.forEach { sub ->
                    try {
                        sub.onAudioError(t)
                    } catch (e: Throwable) {
                        Log.w(TAG, "subscriber onAudioError error", e)
                    }
                }
            }
        }
    }

    companion object {
        private const val TAG = "AudioPipeline"
    }
}
