package com.example.mafbase_stream.pipeline

import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import android.util.Log
import android.util.Size
import android.view.Surface
import com.example.mafbase_stream.StreamSession
import com.example.mafbase_stream.encoder.AudioPipeline
import com.example.mafbase_stream.events.StreamEventBus
import com.example.mafbase_stream.gl.Compositor
import com.example.mafbase_stream.jni.StreamSessionNative

/**
 * RTMP-стрим: [StreamSession] как выход компоситора плюс супервизор, который пересоздаёт
 * сессию после фатальной ошибки с backoff, пока стрим не остановил пользователь.
 *
 * Публичные методы — с main-потока, колбэки [Host] — на нём же. Старт и стоп сессии
 * (MediaCodec, AudioRecord, RTMP) блокирующие и выполняются в фоновых потоках.
 */
internal class StreamingController(
    private val config: StreamPipeline.Config,
    private val audioPipeline: AudioPipeline,
    private val compositorHost: CompositorHost,
    private val host: Host,
) {

    interface Host {
        fun isReleased(): Boolean

        /** Общий переход пайплайна: перезапуск стрима ждёт ролловер записи. */
        fun isTransitioning(): Boolean

        fun frameSize(): Size?

        fun videoBitrateBps(): Int

        fun onStateChanged()

        fun onActiveChanged()

        fun onMessage(text: String, long: Boolean)
    }

    private val mainHandler = Handler(Looper.getMainLooper())
    private var session: StreamSession? = null

    /**
     * Стрим включён пользователем. Остаётся true и пока сессия пересоздаётся после
     * ошибки — сбрасывается только по [stop] или провалу первого старта.
     */
    var isStreaming: Boolean = false
        private set

    var isStreamTransition: Boolean = false
        private set

    private var restartRunnable: Runnable? = null
    private val restartBackoff = RetryBackoff(baseMs = RESTART_BASE_MS, capMs = RESTART_CAP_MS)
    private var lastErrorMessageMs: Long = 0L
    private var stopRequested: Boolean = false

    fun start() {
        if (isStreaming || isStreamTransition) return
        val size = host.frameSize() ?: return
        if (!compositorHost.isCreated) return
        isStreamTransition = true
        stopRequested = false
        restartBackoff.reset()
        host.onStateChanged()

        val fresh = createSession(size, isRestart = false)
        Thread({ startBlocking(fresh, isRestart = false) }, "StreamSession-start").start()
    }

    fun stop() {
        cancelRestart()
        val current = session
        if (current == null) {
            if (isStreamTransition) {
                // Сессия сейчас стартует или пересоздаётся — её завершение подхватит флаг.
                stopRequested = true
            } else if (isStreaming) {
                // Ждали backoff перед пересозданием — сессии нет, просто гасим намерение.
                isStreaming = false
                host.onActiveChanged()
                host.onStateChanged()
            }
            return
        }
        session = null
        isStreamTransition = true
        host.onStateChanged()

        // Сначала отцепляем encoder Surface от Compositor'а ДО session.stop() —
        // иначе compositor продолжит eglSwapBuffers на разрушенный BufferQueue.
        compositorHost.detachOutput(Compositor.OutputId.STREAM_ENCODER)

        stopAsync(current) {
            isStreaming = false
            isStreamTransition = false
            host.onActiveChanged()
            host.onStateChanged()
            host.onMessage("Стрим остановлен", long = false)
        }
    }

    /** Вариант для освобождения пайплайна: без UI, стартующую сессию догонит [onSessionStarted]. */
    fun stopForRelease() {
        isStreaming = false
        val current = session ?: return
        session = null
        compositorHost.detachOutput(Compositor.OutputId.STREAM_ENCODER)
        stopAsync(current, onDone = null)
    }

    fun cancelRestart() {
        restartRunnable?.let { mainHandler.removeCallbacks(it) }
        restartRunnable = null
    }

    private fun createSession(size: Size, isRestart: Boolean): StreamSession {
        val fullUrl = if (config.streamKey.isNotBlank()) {
            "${config.rtmpUrl.trimEnd('/')}/${config.streamKey}"
        } else {
            config.rtmpUrl
        }
        val fresh = StreamSession(
            StreamSession.Config(
                rtmpUrl = fullUrl,
                width = size.width,
                height = size.height,
                videoBitrate = host.videoBitrateBps(),
            ),
            audioPipeline = audioPipeline,
        )
        fresh.setListener(object : StreamSession.Listener {
            override fun onStreamStarted() {
                mainHandler.post {
                    if (session !== fresh) return@post
                    restartBackoff.reset()
                    host.onMessage(if (isRestart) "Стрим восстановлен" else "Стрим запущен", long = false)
                }
            }

            override fun onStreamError(t: Throwable) {
                Log.e(TAG, "stream error", t)
                mainHandler.post { onSessionFailed(fresh, t.message ?: t.javaClass.simpleName) }
            }

            override fun onStreamEvent(event: StreamSessionNative.StreamEvent) {
                StreamEventBus.emit(event)
                if (event.type == StreamSessionNative.EventType.Failed) {
                    mainHandler.post { onSessionFailed(fresh, event.reason ?: "reconnect exhausted") }
                }
            }
        })
        return fresh
    }

    /**
     * Тело фонового потока старта: StreamSession.start() выполняет MediaCodec
     * prepare/configure/createInputSurface и AudioRecord init — на устройствах это
     * занимает 200-500 мс, на UI-потоке Choreographer писал бы «Skipped 41 frames!».
     */
    private fun startBlocking(fresh: StreamSession, isRestart: Boolean) {
        val ok = try {
            fresh.start()
            true
        } catch (e: Exception) {
            Log.e(TAG, "StreamSession.start failed", e)
            try {
                fresh.stop()
            } catch (_: Throwable) {
            }
            mainHandler.post { onSessionStartFailed(isRestart, e.message) }
            false
        }
        if (!ok) return

        val encoderSurface = fresh.encoderSurface
        if (encoderSurface == null) {
            Log.e(TAG, "stream encoder surface is null")
            fresh.stop()
            mainHandler.post { onSessionStartFailed(isRestart, null) }
            return
        }

        mainHandler.post { onSessionStarted(fresh, encoderSurface) }
    }

    private fun onSessionStartFailed(isRestart: Boolean, message: String?) {
        isStreamTransition = false
        if (isRestart && isStreaming && !stopRequested && !host.isReleased()) {
            scheduleRestart()
        } else {
            isStreaming = false
            stopRequested = false
            host.onActiveChanged()
            if (!isRestart) host.onMessage("Не удалось начать стрим: $message", long = true)
        }
        host.onStateChanged()
    }

    private fun onSessionStarted(fresh: StreamSession, encoderSurface: Surface) {
        if (host.isReleased() || stopRequested || !compositorHost.isCreated) {
            // Пока сессия поднималась, стрим остановили — гасим её, не подключая.
            stopAsync(fresh) {
                isStreamTransition = false
                isStreaming = false
                stopRequested = false
                host.onActiveChanged()
                host.onStateChanged()
            }
            return
        }
        session = fresh
        compositorHost.attachOutput(Compositor.OutputId.STREAM_ENCODER, encoderSurface, needsPresentationTime = true)
        val wasStreaming = isStreaming
        isStreaming = true
        isStreamTransition = false
        if (!wasStreaming) host.onActiveChanged()
        host.onStateChanged()
    }

    private fun stopAsync(target: StreamSession, onDone: (() -> Unit)?) {
        Thread({
            try {
                target.stop()
            } catch (e: Exception) {
                Log.e(TAG, "StreamSession.stop failed", e)
            }
            if (onDone != null) mainHandler.post(onDone)
        }, "StreamSession-stop").start()
    }

    /**
     * Сессия умерла (ядро прислало Failed или энкодер выдал ошибку) — пересоздаём её
     * с backoff, пока стрим не остановил пользователь.
     */
    private fun onSessionFailed(failed: StreamSession, reason: String) {
        if (host.isReleased() || session !== failed || !isStreaming) return
        val now = SystemClock.elapsedRealtime()
        if (now - lastErrorMessageMs >= ERROR_MESSAGE_INTERVAL_MS) {
            lastErrorMessageMs = now
            host.onMessage("Ошибка стрима: $reason. Переподключаемся…", long = true)
        }
        scheduleRestart()
    }

    /** Backoff 2→4→8→15 с без лимита попыток. */
    private fun scheduleRestart() {
        if (host.isReleased() || restartRunnable != null) return
        val delayMs = restartBackoff.nextDelayMs()
        Log.w(TAG, "stream restart #${restartBackoff.attempt} in ${delayMs}ms")
        postRestart(delayMs)
    }

    private fun postRestart(delayMs: Long) {
        val runnable = Runnable {
            restartRunnable = null
            restartNow()
        }
        restartRunnable = runnable
        mainHandler.postDelayed(runnable, delayMs)
    }

    private fun restartNow() {
        if (host.isReleased() || !isStreaming) return
        if (host.isTransitioning()) {
            // Идёт ролловер сегмента записи или другой переход — не мешаем, пробуем позже.
            postRestart(TRANSITION_RETRY_MS)
            return
        }
        val size = host.frameSize() ?: return
        if (!compositorHost.isCreated) return
        val old = session
        session = null
        isStreamTransition = true
        host.onStateChanged()
        compositorHost.detachOutput(Compositor.OutputId.STREAM_ENCODER)

        val fresh = createSession(size, isRestart = true)
        Thread({
            if (old != null) {
                try {
                    old.stop()
                } catch (e: Exception) {
                    Log.e(TAG, "StreamSession.stop (restart) failed", e)
                }
            }
            startBlocking(fresh, isRestart = true)
        }, "StreamSession-restart").start()
    }

    companion object {
        private const val TAG = "StreamingController"
        private const val RESTART_BASE_MS = 2_000L
        private const val RESTART_CAP_MS = 15_000L
        private const val ERROR_MESSAGE_INTERVAL_MS = 60_000L
    }
}
