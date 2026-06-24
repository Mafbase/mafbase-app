package com.example.mafbase_stream

import android.media.MediaCodec
import android.media.MediaFormat
import android.util.Log
import android.view.Surface
import com.example.mafbase_stream.encoder.AudioEncoder
import com.example.mafbase_stream.encoder.AudioPipeline
import com.example.mafbase_stream.encoder.VideoEncoder
import com.example.mafbase_stream.jni.StreamSessionNative
import java.nio.ByteBuffer

/**
 * Оркестратор RTMP-стрима для Android.
 *
 * GL-композитинг (камера → FBO → encoder Surface) живёт в [com.example.mafbase_stream.gl.Compositor],
 * который держит [StreamActivity]. Сюда передаётся только ссылка на Surface энкодера —
 * её хост-активити сама прицепит к Compositor через `attachOutput`.
 *
 * Жизненный цикл:
 *  1. [start] — поднимает [VideoEncoder] (через него получаем encoder input-Surface) и
 *     [AudioEncoder]. После start вызывающая сторона должна забрать [encoderSurface] и
 *     прицепить его к Compositor.
 *  2. Когда Camera2 → Compositor → encoder начнёт получать кадры, MediaCodec выдаст
 *     SPS/PPS (CODEC_CONFIG). Параллельно [AudioEncoder] выдаст AudioSpecificConfig.
 *     Когда оба готовы — открываем RTMP-сессию через JNI и переходим в стриминг.
 *  3. Каждый закодированный access unit / aud-кадр публикуется через [StreamSessionNative].
 *  4. [stop] — сигнализирует EOS обоим энкодерам, ждёт дренажа, закрывает RTMP. Encoder
 *     Surface отцепляется от Compositor вызывающей стороной ДО [stop] (иначе Compositor
 *     продолжит eglSwapBuffers на разрушенный BufferQueue).
 */
class StreamSession(
    private val config: Config,
    private val audioPipeline: AudioPipeline? = null,
) {

    data class Config(
        val rtmpUrl: String,
        val width: Int,
        val height: Int,
        val fps: Int = 30,
        val videoBitrate: Int = 4_000_000,
        val audioSampleRate: Int = 44_100,
        val audioChannels: Int = 1,
        val audioBitrate: Int = 128_000,
    )

    interface Listener {
        fun onStreamStarted() {}
        fun onStreamStopped() {}
        fun onStreamError(t: Throwable) {}
        fun onStreamEvent(event: StreamSessionNative.StreamEvent) {}
    }

    private val lock = Any()

    private var videoEncoder: VideoEncoder? = null
    private var audioEncoder: AudioEncoder? = null
    private var subscribedToPipeline: Boolean = false
    private var native: StreamSessionNative? = null

    private var videoExtradata: ByteArray? = null
    private var audioExtradata: ByteArray? = null
    private var rtmpStarted: Boolean = false

    // handle.start() — это блокирующий avio_open до 10с. Если выполнять его под общим
    // lock'ом, encoder-callbacks (audioSink/videoSink.onXxxEncoded) блокируются на этом
    // локе. У AAC из-за этого MediaCodec упирается backpressure'ом во входы, AudioEncoder.
    // feed() начинает молча терять PCM (totalSamples не растёт) — и audio PTS навсегда
    // отстаёт от реального времени на длительность open(). Поэтому делаем start() в
    // отдельном потоке без удержания lock'а.
    private var rtmpStarting: Boolean = false
    private var rtmpStarterThread: Thread? = null

    /**
     * Общий референс PTS в микросекундах для AV-sync. Берётся как абсолютный
     * presentation-time первого пакета, который дошёл до push-этапа (видео или аудио —
     * что прибежит раньше). Все последующие PTS вычисляются от этого нуля. Без общего
     * референса видео и аудио стартуют каждый со своего нуля и плеер видит desync
     * 100-300 мс — это и было главной причиной «пропусков» в плеере.
     */
    private var referencePtsUs: Long = -1L

    private var videoFrameCounter: Long = 0
    private var audioFrameCounter: Long = 0

    // Диагностика A/V sync. Логируем разницу первых absolute-PTS аудио и видео и
    // периодически — текущий drift, чтобы видеть рассогласование шкал часов между
    // Camera2-timestamp и AudioRecord BOOTTIME-эпохой.
    private var firstAudioAbsUs: Long = -1L
    private var firstVideoAbsUs: Long = -1L
    private var lastAudioAbsUs: Long = -1L
    private var lastVideoAbsUs: Long = -1L
    private var lastSkewLogUs: Long = 0L

    private var listener: Listener? = null

    fun setListener(listener: Listener?) {
        this.listener = listener
    }

    /**
     * Surface входа MediaCodec видео-энкодера. Доступен после [start] — вызывающая
     * сторона цепляет его к [com.example.mafbase_stream.gl.Compositor] через
     * `attachOutput(STREAM_ENCODER, encoderSurface, needsPresentationTime = true)`.
     */
    val encoderSurface: Surface?
        get() = videoEncoder?.surface

    fun start() {
        synchronized(lock) {
            require(videoEncoder == null) { "StreamSession already started" }

            val video = VideoEncoder(
                width = config.width,
                height = config.height,
                frameRate = config.fps,
                bitRate = config.videoBitrate,
                // 1с (вместо 2с по дефолту): при плохой сети мы дропаем целыми GOP'ами,
                // и плеер ждёт следующий keyframe чтобы начать декодировать. С 1с
                // интервалом «ступор» в 2 раза короче.
                iFrameIntervalSec = 1,
                sink = videoSink,
            ).apply { prepare() }
            videoEncoder = video

            if (audioPipeline != null) {
                try {
                    audioPipeline.subscribe(pipelineSubscriber)
                    subscribedToPipeline = true
                } catch (e: Throwable) {
                    Log.w(TAG, "Audio pipeline unavailable, streaming video only", e)
                    subscribedToPipeline = false
                }
            } else {
                try {
                    audioEncoder = AudioEncoder(
                        sampleRate = config.audioSampleRate,
                        channels = config.audioChannels,
                        bitRate = config.audioBitrate,
                        sink = audioSink,
                    ).apply { prepare() }
                } catch (e: Throwable) {
                    Log.w(TAG, "Audio encoder unavailable, streaming video only", e)
                    audioEncoder = null
                }
            }

            native = StreamSessionNative.create().also { n ->
                n.setListener(object : StreamSessionNative.Listener {
                    override fun onEvent(event: StreamSessionNative.StreamEvent) {
                        listener?.onStreamEvent(event)
                    }

                    override fun onRequestKeyframe() {
                        videoEncoder?.requestKeyFrame()
                    }

                    override fun onSetVideoBitrate(bitrateBps: Int) {
                        videoEncoder?.setBitrate(bitrateBps)
                    }
                })
            }

            video.start()
            audioEncoder?.start()
        }
    }

    fun stop() {
        // Отписку от pipeline делаем ДО входа в lock — иначе deadlock: stop() держит
        // streamSession.lock и ждёт pipeline.lock в unsubscribe, а encoder-поток держит
        // pipeline.lock и в callback'е audioSink ждёт streamSession.lock.
        if (subscribedToPipeline) {
            try {
                audioPipeline?.unsubscribe(pipelineSubscriber)
            } catch (t: Throwable) {
                Log.w(TAG, "audio pipeline unsubscribe failed", t)
            }
            subscribedToPipeline = false
        }
        // RtmpStarter, если он сейчас выполняет блокирующий avio_open, тоже надо дождаться
        // ДО входа в lock — он попытается заблокировать lock в финале, и stop() в lock'e
        // уйдёт в дедлок. join() здесь корректен: если starter ещё внутри handle.start(),
        // мы ждём пока ffmpeg сам отвалится по io_timeout (10с).
        rtmpStarterThread?.let { t ->
            try {
                t.join()
            } catch (e: InterruptedException) {
                Thread.currentThread().interrupt()
            }
        }
        synchronized(lock) {
            // Compositor отцепляет encoder Surface ДО stop() — это делает StreamActivity
            // через compositor.detachOutput(STREAM_ENCODER). Иначе compositor продолжил бы
            // eglSwapBuffers на разрушенный BufferQueue → "BufferQueue has been abandoned".
            try {
                videoEncoder?.signalEndOfStream()
                audioEncoder?.signalEndOfStream()
                videoEncoder?.release()
                audioEncoder?.release()
            } catch (t: Throwable) {
                Log.w(TAG, "encoder release error", t)
            }
            videoEncoder = null
            audioEncoder = null

            try {
                native?.stop()
            } catch (t: Throwable) {
                Log.w(TAG, "native stop error", t)
            }
            try {
                native?.destroy()
            } catch (t: Throwable) {
                Log.w(TAG, "native destroy error", t)
            }
            native = null

            videoExtradata = null
            audioExtradata = null
            referencePtsUs = -1L
            videoFrameCounter = 0L
            audioFrameCounter = 0L
            firstAudioAbsUs = -1L
            firstVideoAbsUs = -1L
            lastAudioAbsUs = -1L
            lastVideoAbsUs = -1L
            lastSkewLogUs = 0L
            val wasStarted = rtmpStarted
            rtmpStarted = false
            rtmpStarting = false
            rtmpStarterThread = null
            if (wasStarted) listener?.onStreamStopped()
        }
    }

    // ---- Encoder sinks ------------------------------------------------------

    private val videoSink = object : VideoEncoder.Sink {
        override fun onVideoFormatReady(format: MediaFormat) {
            // SPS/PPS приходят как CODEC_CONFIG отдельным сэмплом, но MediaFormat также
            // содержит KEY_CSD-0 / KEY_CSD-1. Возьмём из format как первичный источник —
            // он гарантированно содержит оба NAL ещё до первого видеокадра.
            synchronized(lock) {
                if (videoExtradata == null) {
                    videoExtradata = extractH264Extradata(format)
                    maybeStartRtmp()
                }
            }
        }

        override fun onVideoCodecConfig(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {
            synchronized(lock) {
                if (videoExtradata == null) {
                    videoExtradata = copyToByteArray(buffer, info.offset, info.size)
                    maybeStartRtmp()
                }
            }
        }

        override fun onVideoEncoded(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {
            val handle = native ?: return
            synchronized(lock) {
                if (!rtmpStarted) return
                // Видео PTS приходят в системной шкале (SystemClock.elapsedRealtimeNanos / 1000),
                // т.к. MediaCodec input-Surface ставит timestamp от Surface-producer.
                val absoluteUs = info.presentationTimeUs
                if (firstVideoAbsUs < 0) {
                    firstVideoAbsUs = absoluteUs
                    if (firstAudioAbsUs >= 0) {
                        Log.i(TAG, "A/V initial skew: audio - video = ${(firstAudioAbsUs - absoluteUs) / 1000}ms")
                    }
                }
                lastVideoAbsUs = absoluteUs
                logSkewIfNeeded()
                if (referencePtsUs < 0) referencePtsUs = absoluteUs
                val pts = absoluteUs - referencePtsUs
                if (pts < 0) return
                val isKey = (info.flags and MediaCodec.BUFFER_FLAG_KEY_FRAME) != 0
                val direct = ensureDirect(buffer, info.offset, info.size)
                val result = handle.pushVideo(direct, 0, info.size, pts, isKey)
                if (!result.isOk) {
                    Log.w(TAG, "pushVideo failed: ${result.name}")
                }
                videoFrameCounter++
                if (videoFrameCounter % 60 == 0L) {
                    Log.d(TAG, "v#$videoFrameCounter pts=${pts}us key=$isKey")
                }
            }
        }

        override fun onVideoError(t: Throwable) = handleError(t)
    }

    private val pipelineSubscriber = object : AudioPipeline.Subscriber {
        override fun onAudioFormatReady(format: MediaFormat) = audioSink.onAudioFormatReady(format)
        override fun onAudioCodecConfig(buffer: ByteBuffer, info: MediaCodec.BufferInfo) =
            audioSink.onAudioCodecConfig(buffer, info)

        override fun onAudioEncoded(buffer: ByteBuffer, info: MediaCodec.BufferInfo) =
            audioSink.onAudioEncoded(buffer, info)

        override fun onAudioError(t: Throwable) = audioSink.onAudioError(t)
    }

    private val audioSink = object : AudioEncoder.Sink {
        override fun onAudioFormatReady(format: MediaFormat) {
            synchronized(lock) {
                if (audioExtradata == null) {
                    audioExtradata = extractAacExtradata(format)
                    maybeStartRtmp()
                }
            }
        }

        override fun onAudioCodecConfig(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {
            synchronized(lock) {
                if (audioExtradata == null) {
                    audioExtradata = copyToByteArray(buffer, info.offset, info.size)
                    maybeStartRtmp()
                }
            }
        }

        override fun onAudioEncoded(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {
            val handle = native ?: return
            val recordStartUs = audioEncoder?.recordStartUptimeUs
                ?: audioPipeline?.recordStartUptimeUs
                ?: return
            synchronized(lock) {
                if (!rtmpStarted) return
                // Аудио PTS от MediaCodec — totalSamples-based (с нуля от старта энкодинга).
                // Приводим к системной шкале прибавлением recordStartUptimeUs (момент
                // audioRecord.startRecording()), чтобы синхронизировать с видео-PTS.
                val absoluteUs = info.presentationTimeUs + recordStartUs
                if (firstAudioAbsUs < 0) {
                    firstAudioAbsUs = absoluteUs
                    if (firstVideoAbsUs >= 0) {
                        Log.i(TAG, "A/V initial skew: audio - video = ${(absoluteUs - firstVideoAbsUs) / 1000}ms")
                    }
                }
                lastAudioAbsUs = absoluteUs
                logSkewIfNeeded()
                if (referencePtsUs < 0) referencePtsUs = absoluteUs
                val pts = absoluteUs - referencePtsUs
                if (pts < 0) return
                val direct = ensureDirect(buffer, info.offset, info.size)
                val result = handle.pushAudio(direct, 0, info.size, pts)
                if (!result.isOk) {
                    Log.w(TAG, "pushAudio failed: ${result.name}")
                }
                audioFrameCounter++
                if (audioFrameCounter % 50 == 0L) {
                    Log.d(TAG, "a#$audioFrameCounter pts=${pts}us")
                }
            }
        }

        override fun onAudioError(t: Throwable) = handleError(t)
    }

    // ---- Helpers -----------------------------------------------------------

    /**
     * Должен вызываться под [lock]. Запускает асинхронный старт RTMP-сессии: блокирующий
     * `handle.start()` (avio_open) выполняется в отдельном потоке, чтобы encoder-callbacks
     * не зависали на этом локе и MediaCodec не упирался во входной backpressure (см.
     * [rtmpStarting] для подробного объяснения).
     */
    private fun maybeStartRtmp() {
        if (rtmpStarted || rtmpStarting) return
        val handle = native ?: return
        val needAudio = audioEncoder != null || subscribedToPipeline
        val v = videoExtradata ?: return
        val a = if (needAudio) audioExtradata ?: return else null

        rtmpStarting = true
        val cfg = config
        val starter = Thread({
            val result = handle.start(
                rtmpUrl = cfg.rtmpUrl,
                width = cfg.width,
                height = cfg.height,
                fps = cfg.fps,
                videoBitrate = cfg.videoBitrate,
                audioSampleRate = cfg.audioSampleRate,
                audioChannels = cfg.audioChannels,
                audioBitrate = cfg.audioBitrate,
                videoExtradata = v,
                audioExtradata = a,
            )
            synchronized(lock) {
                rtmpStarting = false
                rtmpStarterThread = null
                if (result.isOk) {
                    rtmpStarted = true
                    listener?.onStreamStarted()
                } else {
                    Log.e(TAG, "RTMP start failed: ${result.name}")
                    listener?.onStreamError(IllegalStateException("RTMP start: ${result.name}"))
                }
            }
        }, "RtmpStarter")
        rtmpStarterThread = starter
        starter.start()
    }

    private fun handleError(t: Throwable) {
        Log.e(TAG, "stream error", t)
        listener?.onStreamError(t)
    }

    /**
     * Раз в ~3 секунды логирует разницу absolute-PTS свежих аудио и видео фреймов.
     * Должен жить близко к нулю; нарастающее значение = clock skew между шкалами.
     * Вызывается из onAudio/VideoEncoded под общим [lock].
     */
    private fun logSkewIfNeeded() {
        if (lastAudioAbsUs < 0 || lastVideoAbsUs < 0) return
        val now = lastVideoAbsUs.coerceAtLeast(lastAudioAbsUs)
        if (now - lastSkewLogUs < 3_000_000L) return
        lastSkewLogUs = now
        val skewMs = (lastAudioAbsUs - lastVideoAbsUs) / 1000
        Log.d(TAG, "A/V skew: audio - video = ${skewMs}ms (audio=${lastAudioAbsUs}us, video=${lastVideoAbsUs}us)")
    }

    private val scratchBuffer = ThreadLocal<ByteBuffer>()

    /**
     * MediaCodec иногда отдаёт heap-buffer (особенно при getOutputBuffer на старых ABI).
     * JNI-обёртка ожидает direct buffer — копируем при необходимости в потоко-локальный
     * scratch (растёт по запросу). Мы делаем это только для пакетов, не для extradata.
     */
    private fun ensureDirect(buffer: ByteBuffer, offset: Int, size: Int): ByteBuffer {
        if (buffer.isDirect && offset == 0) return buffer
        var sb = scratchBuffer.get()
        if (sb == null || sb.capacity() < size) {
            sb = ByteBuffer.allocateDirect(maxOf(size, 64 * 1024))
            scratchBuffer.set(sb)
        }
        sb.clear()
        val saved = buffer.position()
        val limit = buffer.limit()
        buffer.position(offset)
        buffer.limit(offset + size)
        sb.put(buffer)
        buffer.position(saved)
        buffer.limit(limit)
        sb.flip()
        return sb
    }

    private fun copyToByteArray(buffer: ByteBuffer, offset: Int, size: Int): ByteArray {
        val out = ByteArray(size)
        val saved = buffer.position()
        val limit = buffer.limit()
        buffer.position(offset)
        buffer.limit(offset + size)
        buffer.get(out)
        buffer.position(saved)
        buffer.limit(limit)
        return out
    }

    /**
     * MediaFormat для H.264 содержит SPS в KEY_CSD-0 и PPS в KEY_CSD-1, оба в Annex-B.
     * Склеиваем их подряд — ядро (RtmpPublisher) умеет распознавать Annex-B.
     */
    private fun extractH264Extradata(format: MediaFormat): ByteArray? {
        val sps = format.getByteBuffer("csd-0") ?: return null
        val pps = format.getByteBuffer("csd-1") ?: return null
        val spsSize = sps.remaining()
        val out = ByteArray(spsSize + pps.remaining())
        sps.get(out, 0, spsSize)
        pps.get(out, spsSize, pps.remaining())
        return out
    }

    /** AAC LC: AudioSpecificConfig в KEY_CSD-0 (обычно 2 байта). */
    private fun extractAacExtradata(format: MediaFormat): ByteArray? {
        val csd = format.getByteBuffer("csd-0") ?: return null
        val out = ByteArray(csd.remaining())
        csd.get(out)
        return out
    }

    companion object {
        private const val TAG = "StreamSession"
    }
}
