package com.example.mafbase_stream.pipeline

import android.app.Activity
import android.content.Context
import android.os.SystemClock
import android.util.Log
import android.util.Size
import android.view.Surface
import com.example.mafbase_stream.PhaseGate
import com.example.mafbase_stream.StreamQuality
import com.example.mafbase_stream.StreamQualityStore
import com.example.mafbase_stream.encoder.AudioPipeline
import com.example.mafbase_stream.overlay.OverlayDebugTarget
import com.example.mafbase_stream.service.StreamForegroundService

/**
 * Движок экрана трансляции: Camera2 → Compositor → превью / MP4-запись / RTMP-стрим.
 *
 * Живёт отдельно от `StreamActivity`: один экземпляр на процесс держит
 * [StreamForegroundService], activity лишь подключает превью ([attachPreview]),
 * хостит overlay-view в своём окне и отражает состояние через [Listener]. Поэтому
 * всплывшее поверх окно, сворачивание или пересоздание activity стрим и запись не
 * трогают.
 *
 * Сам фасад только связывает компоненты: [CameraController] (камера и её переоткрытие),
 * [CompositorHost] (компоситор, превью, overlay), [RecordingController] и
 * [StreamingController]. Все публичные методы вызываются с main-потока; колбэки
 * [Listener] приходят на нём же.
 */
internal class StreamPipeline(context: Context, val config: Config) {

    data class Config(
        val rtmpUrl: String,
        val streamKey: String,
        val overlayViewType: String?,
        val overlayTournamentId: Int?,
        val overlayClubId: Int?,
        val overlayTable: Int?,
        val breakPlaceholderImageUrl: String?,
        val brandImageUrl: String?,
        val segmentDurationMs: Long,
    )

    interface Listener {
        /** Изменились запись/стрим/транзишны, объектив, качество или overlay. */
        fun onStateChanged() {}

        /** Размер кадра выбран заново — превью нужно подогнать до [attachPreview]. */
        fun onFrameSizeChanged(width: Int, height: Int) {}

        fun onMessage(text: String, long: Boolean) {}

        /** Пайплайн не может работать (нет камеры) — экран закрывается. */
        fun onFatalError(message: String) {}
    }

    private val appContext: Context = context.applicationContext
    private var listener: Listener? = null

    var quality: StreamQuality = StreamQualityStore.load(appContext)
        private set

    /** Размер кадра пайплайна; известен после [start]. */
    var frameSize: Size? = null
        private set

    // Шарится между overlay'ем (writer) и audio pipeline'ом (reader): overlay
    // выставляет muted=true когда `broadcastPhase` != day.
    private val phaseGate = PhaseGate()

    // Общий audio pipeline на жизнь пайплайна. Запись и стрим оба подписываются на него,
    // и AudioRecord(MIC) поднимается в одном экземпляре — иначе вторая инстанция конфликтует.
    private val audioPipeline = AudioPipeline(phaseGate = phaseGate)

    private val compositorHost = CompositorHost(appContext, config, phaseGate)

    private val camera = CameraController(
        appContext,
        object : CameraController.Host {
            override fun frameSize(): Size? = this@StreamPipeline.frameSize
            override fun isReopenDeferred(): Boolean =
                !isActive && !isTransitioning && compositorHost.previewSurface == null
            override fun onStateChanged() = notifyState()
            override fun onOpened() = notifyState()
            override fun onLost() = notifyState()
            override fun onFatal(message: String) {
                listener?.onFatalError(message)
            }
            override fun onMessage(text: String, long: Boolean) {
                listener?.onMessage(text, long)
            }
            override fun onSetUpRequired() = setUpPipeline()
        },
    )

    private val recording = RecordingController(
        appContext,
        config,
        audioPipeline,
        compositorHost,
        object : RecordingController.Host {
            override fun frameSize(): Size? = this@StreamPipeline.frameSize
            override fun isTransitioning(): Boolean = this@StreamPipeline.isTransitioning
            override fun onStateChanged() = notifyState()
            override fun onActiveChanged() = this@StreamPipeline.onActiveChanged()
            override fun onMessage(text: String, long: Boolean) {
                listener?.onMessage(text, long)
            }
        },
    )

    private val streaming = StreamingController(
        config,
        audioPipeline,
        compositorHost,
        object : StreamingController.Host {
            override fun isReleased(): Boolean = this@StreamPipeline.isReleased
            override fun isTransitioning(): Boolean = this@StreamPipeline.isTransitioning
            override fun frameSize(): Size? = this@StreamPipeline.frameSize
            override fun videoBitrateBps(): Int = quality.bitrateBps
            override fun onStateChanged() = notifyState()
            override fun onActiveChanged() = this@StreamPipeline.onActiveChanged()
            override fun onMessage(text: String, long: Boolean) {
                listener?.onMessage(text, long)
            }
        },
    )

    val isRecording: Boolean get() = recording.isRecording
    val isStreaming: Boolean get() = streaming.isStreaming
    val isRecordTransition: Boolean get() = recording.isRecordTransition
    val isStreamTransition: Boolean get() = streaming.isStreamTransition
    val isTransitioning: Boolean get() = isRecordTransition || isStreamTransition

    val useUltraWide: Boolean get() = camera.useUltraWide
    val isLensSwitching: Boolean get() = camera.isLensSwitching
    val hasUltraWide: Boolean get() = camera.hasUltraWide
    val ultraWideZoomRatio: Float? get() = camera.ultraWideZoomRatio
    val isCameraOpen: Boolean get() = camera.isOpen

    val overlayDebugTarget: OverlayDebugTarget? get() = compositorHost.overlayDebugTarget

    var isStarted: Boolean = false
        private set

    var isReleased: Boolean = false
        private set

    /** Идёт стрим или запись — то, ради чего пайплайн держат в фоне. */
    val isActive: Boolean get() = isRecording || isStreaming

    /**
     * Сервису нужен foreground-приоритет и на время переходов: финализация записи
     * (moov-атом) и старт стрима не должны застать процесс без него.
     */
    val isForegroundNeeded: Boolean get() = isActive || isRecordTransition || isStreamTransition
    private var lastForegroundNeeded = false

    /** `SystemClock.elapsedRealtime()` момента, когда пайплайн стал активным; 0 в простое. */
    var activeSinceElapsedMs: Long = 0L
        private set

    /**
     * Качество меняется только в простое: смена разрешения пересоздаёт пайплайн,
     * а битрейт применяется при старте стрима. Переходы тоже блокируют — стартующая
     * сессия рассчитана на текущий размер кадра.
     */
    val isQualityLocked: Boolean get() = isRecording || isStreaming || isTransitioning

    private var foregroundUnavailableReported = false

    fun setListener(listener: Listener?) {
        this.listener = listener
    }

    fun clearListener(listener: Listener) {
        if (this.listener === listener) this.listener = null
    }

    // --- Жизненный цикл ---

    /** Открывает камеру и поднимает сервис. Вызывать, когда разрешения уже выданы. */
    fun start() {
        if (isStarted || isReleased) return
        isStarted = true
        camera.start()
        StreamForegroundService.onPipelineStarted(appContext)
        setUpPipeline()
    }

    fun attachPreview(surface: Surface) {
        if (isReleased) return
        compositorHost.attachPreview(surface)
        // Простаивавший в фоне пайплайн камеру не переоткрывал — открываем сразу, не ждём backoff.
        if (isStarted) camera.retryNow()
    }

    /** Отцепляет только превью [surface] (чужое игнорируется): камера, компоситор и энкодеры работают дальше. */
    fun detachPreview(surface: Surface) {
        if (isReleased) return
        compositorHost.detachPreview(surface)
    }

    fun setOverlayHost(activity: Activity) {
        if (isReleased) return
        compositorHost.setOverlayHost(activity)
    }

    fun clearOverlayHost(activity: Activity) {
        compositorHost.clearOverlayHost(activity)
    }

    /** Перепроверяет foreground-статус сервиса — например, когда activity вернулась на экран. */
    fun syncService() {
        if (isReleased || !isStarted) return
        StreamForegroundService.onPipelineStateChanged(appContext)
    }

    /** Вызывается сервисом, когда `startForeground` не удался. */
    fun onForegroundUnavailable() {
        if (foregroundUnavailableReported) return
        foregroundUnavailableReported = true
        listener?.onMessage(
            "Не удалось включить фоновый режим: трансляция остановится при сворачивании",
            long = true,
        )
    }

    fun stopAll() {
        if (recording.isRecording) recording.stop()
        streaming.stop()
    }

    /** Останавливает всё и освобождает камеру, компоситор и сервис. Необратимо. */
    fun release() {
        if (isReleased) return
        isReleased = true
        streaming.cancelRestart()
        camera.stopReopening()
        recording.stopForRelease()
        streaming.stopForRelease()
        camera.close()
        compositorHost.release()
        camera.release()
        compositorHost.clear()
        listener = null
        StreamForegroundService.onPipelineReleased(appContext, this)
    }

    /**
     * Единственная точка оповещения: слушатель, сервис (по смене [isForegroundNeeded])
     * и авто-освобождение простаивающего пайплайна, у которого не осталось activity.
     */
    private fun notifyState() {
        listener?.onStateChanged()
        val needed = isForegroundNeeded
        if (needed != lastForegroundNeeded) {
            lastForegroundNeeded = needed
            if (!isReleased) StreamForegroundService.onPipelineStateChanged(appContext)
        }
        if (!isReleased && !needed && compositorHost.overlayHost == null && compositorHost.previewSurface == null) {
            // overlayHost снимается в onDestroy: ни одной activity нет, держать в фоне нечего.
            Log.i(TAG, "idle without activity, releasing")
            release()
        }
    }

    /** Обновляет отсчёт длительности и текст нотификации. */
    private fun onActiveChanged() {
        val active = isActive
        if (active && activeSinceElapsedMs == 0L) {
            activeSinceElapsedMs = SystemClock.elapsedRealtime()
        } else if (!active) {
            activeSinceElapsedMs = 0L
            foregroundUnavailableReported = false
        }
        if (!isReleased) StreamForegroundService.onPipelineStateChanged(appContext)
    }

    /**
     * Выбирает размер кадра под текущее качество, поднимает компоситор с overlay'ем и
     * открывает камеру. Повторно вызывается при смене разрешения и при переоткрытии
     * камеры, если компоситор так и не поднялся.
     */
    private fun setUpPipeline() {
        if (compositorHost.isCreated) {
            compositorHost.cameraSurface?.let { camera.open(it) }
            return
        }
        try {
            val size = camera.chooseFrameSize(quality.resolution) ?: return
            frameSize = size
            // Activity должна выставить setFixedSize превью до того, как Compositor
            // создаст EGL-окно на этом Surface.
            listener?.onFrameSizeChanged(size.width, size.height)
            compositorHost.create(size.width, size.height, camera.frameRotationDegrees())
            notifyState()
        } catch (e: Exception) {
            Log.e(TAG, "setUpPipeline failed", e)
            camera.scheduleReopen()
            return
        }
        val cameraSurface = compositorHost.cameraSurface ?: run {
            Log.e(TAG, "compositor.cameraSurface is null")
            return
        }
        camera.open(cameraSurface)
    }

    // --- Управление ---

    fun switchLens(toUltraWide: Boolean) {
        if (isReleased) return
        camera.switchLens(toUltraWide)
    }

    fun applyQuality(newQuality: StreamQuality) {
        if (isReleased) return
        val previousResolution = quality.resolution
        quality = newQuality
        StreamQualityStore.save(appContext, newQuality)
        if (newQuality.resolution != previousResolution && !isQualityLocked && isStarted) {
            // Новый размер кадра — полное пересоздание пайплайна, только в простое.
            camera.close()
            compositorHost.release()
            setUpPipeline()
        }
        notifyState()
    }

    fun toggleRecording() {
        if (isTransitioning || !camera.isOpen) return
        if (recording.isRecording) stopRecording() else startRecording()
    }

    fun startRecording() {
        if (isReleased) return
        recording.start()
    }

    fun stopRecording() {
        recording.stop()
    }

    fun toggleStreaming() {
        if (isTransitioning || !camera.isOpen) return
        if (streaming.isStreaming) stopStreaming() else startStreaming()
    }

    fun startStreaming() {
        if (isReleased) return
        streaming.start()
    }

    fun stopStreaming() {
        streaming.stop()
    }

    companion object {
        private const val TAG = "StreamPipeline"
    }
}
