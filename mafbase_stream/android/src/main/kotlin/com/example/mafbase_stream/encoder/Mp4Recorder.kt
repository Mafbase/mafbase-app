package com.example.mafbase_stream.encoder

import android.media.MediaCodec
import android.media.MediaFormat
import android.media.MediaMuxer
import android.os.Build
import android.util.Log
import android.view.Surface
import androidx.annotation.RequiresApi
import java.io.File
import java.io.FileDescriptor
import java.nio.ByteBuffer

/**
 * Оркестратор аппаратного энкодинга и записи MP4.
 *
 * Шаги:
 *  1. start(width, height, file|fd) — создаёт MediaMuxer и оба энкодера. После этого
 *     [videoInputSurface] становится доступным для добавления в Camera2 capture session.
 *  2. Когда оба энкодера сообщают output-format, добавляем треки в muxer и стартуем его.
 *  3. Каждый закодированный сэмпл нормализуется по PTS (зануляется относительно первого
 *     сэмпла трека) и пишется в muxer под общим lock.
 *  4. stop() сигналит EOS обоим энкодерам, дожидается дренажа и закрывает muxer.
 *
 * Если AudioRecord/AAC недоступен (например, эмулятор без микрофона) — пишется только видео.
 */
class Mp4Recorder(
    private val audioPipeline: AudioPipeline? = null,
) {

    private val lock = Any()
    private var muxer: MediaMuxer? = null
    private var videoEncoder: VideoEncoder? = null
    private var audioEncoder: AudioEncoder? = null
    private var subscribedToPipeline = false
    private var outputFile: File? = null

    private var videoTrack = -1
    private var audioTrack = -1
    private var muxerStarted = false
    private var hasAudioTrack = false

    private var videoOffsetUs = -1L
    private var audioOffsetUs = -1L

    val videoInputSurface: Surface? get() = videoEncoder?.surface

    /** Запускает запись в указанный файл. Именование сегментов — на стороне вызывающего. */
    fun start(width: Int, height: Int, file: File): File {
        outputFile = file
        muxer = MediaMuxer(file.absolutePath, MediaMuxer.OutputFormat.MUXER_OUTPUT_MPEG_4)
        startEncoders(width, height)
        return file
    }

    /**
     * Запускает запись напрямую в [fd] без создания промежуточного файла.
     * Используется для прямой записи в MediaStore на API 26+.
     */
    @RequiresApi(Build.VERSION_CODES.O)
    fun start(width: Int, height: Int, fd: FileDescriptor) {
        outputFile = null
        muxer = MediaMuxer(fd, MediaMuxer.OutputFormat.MUXER_OUTPUT_MPEG_4)
        startEncoders(width, height)
    }

    private fun startEncoders(width: Int, height: Int) {
        videoEncoder = VideoEncoder(width, height, sink = videoSink).also { it.prepare() }
        if (audioPipeline != null) {
            try {
                audioPipeline.subscribe(pipelineSubscriber)
                subscribedToPipeline = true
                hasAudioTrack = true
            } catch (e: Throwable) {
                Log.w(TAG, "audio pipeline unavailable, recording video only", e)
                hasAudioTrack = false
            }
        } else {
            try {
                audioEncoder = AudioEncoder(sink = audioSink).also { it.prepare() }
                hasAudioTrack = true
            } catch (e: Throwable) {
                Log.w(TAG, "audio encoder unavailable, recording video only", e)
                hasAudioTrack = false
            }
        }

        videoEncoder?.start()
        audioEncoder?.start()
    }

    fun stop(): File? {
        if (subscribedToPipeline) {
            try {
                audioPipeline?.unsubscribe(pipelineSubscriber)
            } catch (e: Throwable) {
                Log.w(TAG, "audio pipeline unsubscribe failed", e)
            }
            subscribedToPipeline = false
        }
        videoEncoder?.signalEndOfStream()
        audioEncoder?.signalEndOfStream()
        videoEncoder?.release()
        audioEncoder?.release()
        videoEncoder = null
        audioEncoder = null

        synchronized(lock) {
            try {
                if (muxerStarted) {
                    muxer?.stop()
                }
            } catch (e: Exception) {
                Log.w(TAG, "muxer stop failed", e)
            }
            try {
                muxer?.release()
            } catch (e: Exception) {
                Log.w(TAG, "muxer release failed", e)
            }
            muxer = null
            videoTrack = -1
            audioTrack = -1
            muxerStarted = false
            videoOffsetUs = -1L
            audioOffsetUs = -1L
        }

        val file = outputFile
        outputFile = null
        return file
    }

    private val videoSink = object : VideoEncoder.Sink {
        override fun onVideoFormatReady(format: MediaFormat) {
            synchronized(lock) {
                val muxerLocal = muxer ?: return
                if (videoTrack < 0) {
                    videoTrack = muxerLocal.addTrack(format)
                    maybeStartMuxer()
                }
            }
        }

        override fun onVideoEncoded(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {
            synchronized(lock) {
                if (!muxerStarted || videoTrack < 0) return
                if (videoOffsetUs < 0L) {
                    videoOffsetUs = info.presentationTimeUs
                }
                val pts = info.presentationTimeUs - videoOffsetUs
                if (pts < 0) return
                writeSample(videoTrack, buffer, info, pts)
            }
        }

        override fun onVideoError(t: Throwable) {
            Log.e(TAG, "video encoder error", t)
        }
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
                val muxerLocal = muxer ?: return
                if (audioTrack < 0) {
                    audioTrack = muxerLocal.addTrack(format)
                    maybeStartMuxer()
                }
            }
        }

        override fun onAudioEncoded(buffer: ByteBuffer, info: MediaCodec.BufferInfo) {
            synchronized(lock) {
                if (!muxerStarted || audioTrack < 0) return
                if (audioOffsetUs < 0L) {
                    audioOffsetUs = info.presentationTimeUs
                }
                val pts = info.presentationTimeUs - audioOffsetUs
                if (pts < 0) return
                writeSample(audioTrack, buffer, info, pts)
            }
        }

        override fun onAudioError(t: Throwable) {
            Log.e(TAG, "audio encoder error", t)
        }
    }

    private fun maybeStartMuxer() {
        val muxerLocal = muxer ?: return
        val ready = videoTrack >= 0 && (audioTrack >= 0 || !hasAudioTrack)
        if (ready && !muxerStarted) {
            muxerLocal.start()
            muxerStarted = true
        }
    }

    private fun writeSample(
        track: Int,
        buffer: ByteBuffer,
        info: MediaCodec.BufferInfo,
        ptsUs: Long,
    ) {
        try {
            val adjusted = MediaCodec.BufferInfo().apply {
                set(info.offset, info.size, ptsUs, info.flags)
            }
            buffer.position(adjusted.offset)
            buffer.limit(adjusted.offset + adjusted.size)
            muxer?.writeSampleData(track, buffer, adjusted)
        } catch (e: Exception) {
            Log.w(TAG, "writeSampleData failed", e)
        }
    }

    companion object {
        private const val TAG = "Mp4Recorder"
    }
}
