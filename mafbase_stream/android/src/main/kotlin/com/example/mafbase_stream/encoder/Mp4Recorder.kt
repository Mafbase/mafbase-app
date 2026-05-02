package com.example.mafbase_stream.encoder

import android.content.Context
import android.media.MediaCodec
import android.media.MediaFormat
import android.media.MediaMuxer
import android.os.Environment
import android.util.Log
import android.view.Surface
import java.io.File
import java.nio.ByteBuffer
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/**
 * Оркестратор аппаратного энкодинга и записи MP4.
 *
 * Шаги:
 *  1. start(width, height) — создаёт MediaMuxer и оба энкодера. После этого
 *     [videoInputSurface] становится доступным для добавления в Camera2 capture session.
 *  2. Когда оба энкодера сообщают output-format, добавляем треки в muxer и стартуем его.
 *  3. Каждый закодированный сэмпл нормализуется по PTS (зануляется относительно первого
 *     сэмпла трека) и пишется в muxer под общим lock.
 *  4. stop() сигналит EOS обоим энкодерам, дожидается дренажа и закрывает muxer.
 *
 * Если AudioRecord/AAC недоступен (например, эмулятор без микрофона) — пишется только видео.
 */
class Mp4Recorder(private val context: Context) {

    private val lock = Any()
    private var muxer: MediaMuxer? = null
    private var videoEncoder: VideoEncoder? = null
    private var audioEncoder: AudioEncoder? = null
    private var outputFile: File? = null

    private var videoTrack = -1
    private var audioTrack = -1
    private var muxerStarted = false
    private var hasAudioTrack = false

    private var videoOffsetUs = -1L
    private var audioOffsetUs = -1L

    val videoInputSurface: Surface? get() = videoEncoder?.surface

    fun start(width: Int, height: Int): File {
        val dir = context.getExternalFilesDir(Environment.DIRECTORY_MOVIES)
            ?: context.filesDir
        if (!dir.exists()) {
            dir.mkdirs()
        }
        val timestamp = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date())
        val file = File(dir, "mafbase_stream_$timestamp.mp4")
        outputFile = file

        muxer = MediaMuxer(file.absolutePath, MediaMuxer.OutputFormat.MUXER_OUTPUT_MPEG_4)

        videoEncoder = VideoEncoder(width, height, sink = videoSink).also { it.prepare() }
        try {
            audioEncoder = AudioEncoder(sink = audioSink).also { it.prepare() }
            hasAudioTrack = true
        } catch (e: Throwable) {
            Log.w(TAG, "audio encoder unavailable, recording video only", e)
            hasAudioTrack = false
        }

        videoEncoder?.start()
        audioEncoder?.start()
        return file
    }

    fun stop(): File? {
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
