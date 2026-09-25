package com.example.mafbase_stream.pipeline

import android.annotation.SuppressLint
import android.content.Context
import android.hardware.camera2.CameraCaptureSession
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraDevice
import android.hardware.camera2.CameraManager
import android.hardware.camera2.CaptureRequest
import android.hardware.camera2.params.OutputConfiguration
import android.hardware.camera2.params.SessionConfiguration
import android.os.Build
import android.os.Handler
import android.os.HandlerThread
import android.os.Looper
import android.util.Log
import android.util.Size
import android.view.Surface
import android.view.SurfaceHolder
import com.example.mafbase_stream.CameraSelector
import com.example.mafbase_stream.StreamResolution
import java.util.concurrent.Executor

/**
 * Camera2-часть пайплайна: выбор камеры и размера кадра, открытие устройства, единственная
 * capture session в [Surface] компоситора, смена объектива и переоткрытие после потери.
 *
 * Публичные методы — с main-потока, колбэки [Host] — на нём же. Camera2-колбэки работают
 * на собственном [HandlerThread].
 */
internal class CameraController(appContext: Context, private val host: Host) {

    interface Host {
        fun frameSize(): Size?

        /** Простаивающему в фоне пайплайну без превью камеру не дадут — переоткрытие откладывается. */
        fun isReopenDeferred(): Boolean

        fun onStateChanged()

        /** Камера открыта, в том числе повторно после потери. */
        fun onOpened()

        /** Открытая камера потеряна; переоткрытие контроллер планирует сам. */
        fun onLost()

        fun onFatal(message: String)

        fun onMessage(text: String, long: Boolean)

        /** Повтор пришёл, а surface компоситора ещё нет — фасад повторяет настройку целиком. */
        fun onSetUpRequired()
    }

    private val cameraManager = appContext.getSystemService(Context.CAMERA_SERVICE) as CameraManager
    private val selector = CameraSelector(cameraManager)
    private val mainHandler = Handler(Looper.getMainLooper())
    private var backgroundThread: HandlerThread? = null
    private var backgroundHandler: Handler? = null

    @Volatile
    private var cameraDevice: CameraDevice? = null

    @Volatile
    private var captureSession: CameraCaptureSession? = null

    // Builder repeating-запроса живой сессии — нужен для смены CONTROL_ZOOM_RATIO
    // без пересоздания сессии (путь ультраширокой без отдельного camera id).
    @Volatile
    private var captureRequestBuilder: CaptureRequest.Builder? = null

    @Volatile
    private var targetSurface: Surface? = null

    private var desiredCameraId: String? = null
    private var openPending: Boolean = false
    private var reopenRunnable: Runnable? = null
    private val reopenBackoff = RetryBackoff(baseMs = REOPEN_BASE_MS, capMs = REOPEN_CAP_MS)
    private var stopped: Boolean = false

    val isOpen: Boolean get() = cameraDevice != null

    var useUltraWide: Boolean = false
        private set

    var isLensSwitching: Boolean = false
        private set

    val hasUltraWide: Boolean get() = selector.hasUltraWide
    val ultraWideZoomRatio: Float? get() = selector.ultraWideZoomRatio

    /** Угол сенсора (deg, по часовой относительно natural orientation устройства). */
    var sensorOrientation: Int = 0
        private set

    private val availabilityCallback = object : CameraManager.AvailabilityCallback() {
        override fun onCameraAvailable(cameraId: String) {
            if (cameraId != desiredCameraId || reopenRunnable == null) return
            Log.i(TAG, "camera $cameraId available again, reopening now")
            retryNow()
        }
    }

    /** Поднимает поток Camera2-колбэков и следит за доступностью камер. */
    fun start() {
        if (backgroundThread != null) return
        backgroundThread = HandlerThread("MafbaseStreamCamera").also { it.start() }
        backgroundHandler = Handler(backgroundThread!!.looper)
        cameraManager.registerAvailabilityCallback(availabilityCallback, mainHandler)
    }

    /** Отменяет переоткрытие и перестаёт следить за доступностью; после этого камера не переоткрывается. */
    fun stopReopening() {
        stopped = true
        cancelReopen()
        try {
            cameraManager.unregisterAvailabilityCallback(availabilityCallback)
        } catch (e: Exception) {
            Log.w(TAG, "unregisterAvailabilityCallback failed", e)
        }
    }

    /** Останавливает поток Camera2-колбэков; вызывать после [close]. */
    fun release() {
        backgroundThread?.quitSafely()
        try {
            backgroundThread?.join()
        } catch (e: InterruptedException) {
            Log.w(TAG, "release interrupted", e)
        }
        backgroundThread = null
        backgroundHandler = null
    }

    /**
     * Выбирает камеру под текущий объектив и размер кадра под [resolution].
     * null — подходящей камеры нет (уже сообщено через [Host.onFatal]); ошибка чтения
     * характеристик бросается наружу.
     */
    fun chooseFrameSize(resolution: StreamResolution): Size? {
        val cameraId = (if (useUltraWide) selector.ultraWideCameraId else null)
            ?: selector.defaultBackCameraId
            ?: run {
                Log.e(TAG, "Подходящая камера не найдена")
                host.onFatal("Подходящая камера не найдена")
                return null
            }
        desiredCameraId = cameraId
        val characteristics = cameraManager.getCameraCharacteristics(cameraId)
        sensorOrientation = characteristics.get(CameraCharacteristics.SENSOR_ORIENTATION) ?: 0
        val map = characteristics.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP)
        return map?.getOutputSizes(SurfaceHolder::class.java)
            ?.let { chooseSizeFor(resolution, it) }
            ?: Size(resolution.width, resolution.height)
    }

    /** Открывает выбранную в [chooseFrameSize] камеру на [cameraSurface] компоситора. */
    fun open(cameraSurface: Surface) {
        val cameraId = desiredCameraId ?: return
        targetSurface = cameraSurface
        openCameraDevice(cameraId) { ok ->
            if (ok) onOpenSucceeded() else scheduleReopen()
        }
    }

    /** Закрывает сессию и устройство; поток и слежение за доступностью остаются. */
    fun close() {
        cancelReopen()
        try {
            captureSession?.close()
        } catch (e: Exception) {
            Log.w(TAG, "captureSession close failed", e)
        }
        captureSession = null
        captureRequestBuilder = null

        try {
            cameraDevice?.close()
        } catch (e: Exception) {
            Log.w(TAG, "cameraDevice close failed", e)
        }
        cameraDevice = null
        targetSurface = null
    }

    /** Переоткрывает камеру сразу, минуя backoff: превью вернулось или камера снова доступна. */
    fun retryNow() {
        if (stopped || cameraDevice != null || openPending || isLensSwitching) return
        cancelReopen()
        if (targetSurface == null) {
            host.onSetUpRequired()
            return
        }
        val cameraId = desiredCameraId ?: return
        openCameraDevice(cameraId) { ok ->
            if (ok) onOpenSucceeded() else scheduleReopen()
        }
    }

    /** Backoff 1→2→4→8→10 с без лимита попыток; `onCameraAvailable` ускоряет очередную. */
    fun scheduleReopen() {
        if (stopped || reopenRunnable != null) return
        if (host.isReopenDeferred()) {
            // Фоновому приложению без стрима камеру не дадут (CAMERA_DISABLED) — повтор запустит attachPreview.
            Log.i(TAG, "camera reopen deferred until preview attached")
            return
        }
        val delayMs = reopenBackoff.nextDelayMs()
        Log.w(TAG, "camera reopen #${reopenBackoff.attempt} in ${delayMs}ms")
        val runnable = Runnable {
            reopenRunnable = null
            retryNow()
        }
        reopenRunnable = runnable
        mainHandler.postDelayed(runnable, delayMs)
    }

    private fun cancelReopen() {
        reopenRunnable?.let { mainHandler.removeCallbacks(it) }
        reopenRunnable = null
    }

    private fun onOpenSucceeded() {
        reopenBackoff.reset()
        host.onOpened()
    }

    /**
     * Открывает камеру [cameraId] на живой surface компоситора. [onResult] приходит на main:
     * успех, либо провал открытия. Потеря уже открытой камеры (её отобрало другое
     * приложение или система) в [onResult] не попадает — уходит в [onCameraLost].
     */
    @SuppressLint("MissingPermission")
    private fun openCameraDevice(cameraId: String, onResult: (Boolean) -> Unit) {
        openPending = true
        val finish: (Boolean) -> Unit = { ok ->
            openPending = false
            onResult(ok)
        }
        try {
            cameraManager.openCamera(
                cameraId,
                object : CameraDevice.StateCallback() {
                    private var opened = false

                    override fun onOpened(device: CameraDevice) {
                        opened = true
                        cameraDevice = device
                        startSingleCaptureSession()
                        mainHandler.post { finish(true) }
                    }

                    override fun onDisconnected(device: CameraDevice) {
                        Log.w(TAG, "camera $cameraId disconnected (opened=$opened)")
                        device.close()
                        if (cameraDevice === device) cameraDevice = null
                        mainHandler.post { if (opened) onCameraLost() else finish(false) }
                    }

                    override fun onError(device: CameraDevice, error: Int) {
                        Log.e(TAG, "camera $cameraId error $error (opened=$opened)")
                        device.close()
                        if (cameraDevice === device) cameraDevice = null
                        mainHandler.post { if (opened) onCameraLost() else finish(false) }
                    }
                },
                backgroundHandler,
            )
        } catch (e: Exception) {
            Log.e(TAG, "openCamera($cameraId) failed", e)
            mainHandler.post { finish(false) }
        }
    }

    private fun onCameraLost() {
        if (stopped) return
        try {
            captureSession?.close()
        } catch (e: Exception) {
            Log.w(TAG, "captureSession close failed", e)
        }
        captureSession = null
        captureRequestBuilder = null
        host.onLost()
        if (isLensSwitching) return
        scheduleReopen()
    }

    /**
     * Смена объектива «на лету»: закрываем только CameraDevice и capture session,
     * Compositor с подключёнными выходами (preview/recorder/stream encoder) живёт
     * дальше — поэтому переключение доступно и во время записи/стрима. Целевая
     * камера обязана поддерживать текущий размер кадра: Compositor фиксирован.
     */
    fun switchLens(toUltraWide: Boolean) {
        if (stopped || isLensSwitching || toUltraWide == useUltraWide) return
        if (selector.ultraWideCameraId == null) {
            switchLensByZoomRatio(toUltraWide, selector.ultraWideZoomRatio ?: return)
            return
        }
        val targetId = (if (toUltraWide) selector.ultraWideCameraId else selector.defaultBackCameraId)
            ?: return
        if (targetSurface == null || cameraDevice == null) {
            // Камера ещё не поднята — открытие применит выбор само.
            useUltraWide = toUltraWide
            desiredCameraId = targetId
            host.onStateChanged()
            return
        }
        val size = host.frameSize()
        if (size != null && !selector.supportsSize(targetId, size)) {
            host.onStateChanged()
            host.onMessage("Эта камера не поддерживает текущее качество", long = false)
            return
        }

        isLensSwitching = true
        val previousUltraWide = useUltraWide
        useUltraWide = toUltraWide
        desiredCameraId = targetId
        host.onStateChanged()
        try {
            captureSession?.close()
        } catch (e: Exception) {
            Log.w(TAG, "captureSession close failed", e)
        }
        captureSession = null
        try {
            cameraDevice?.close()
        } catch (e: Exception) {
            Log.w(TAG, "cameraDevice close failed", e)
        }
        cameraDevice = null

        openCameraDevice(targetId) { success ->
            if (success) {
                finishLensSwitch()
                return@openCameraDevice
            }
            // Возвращаемся на прежний объектив, чтобы экран не остался без превью.
            useUltraWide = previousUltraWide
            val fallbackId =
                if (previousUltraWide) selector.ultraWideCameraId else selector.defaultBackCameraId
            desiredCameraId = fallbackId
            if (fallbackId != null) {
                openCameraDevice(fallbackId) { ok ->
                    finishLensSwitch()
                    if (!ok) scheduleReopen()
                }
            } else {
                finishLensSwitch()
            }
        }
    }

    private fun finishLensSwitch() {
        isLensSwitching = false
        host.onStateChanged()
    }

    /**
     * Переключение объектива логической камеры через CONTROL_ZOOM_RATIO — путь для
     * устройств, прячущих ультраширокую как физическую камеру (Pixel и т.п.).
     * Меняется только repeating-запрос: без пересоздания устройства и сессии,
     * мгновенно и безопасно во время записи/стрима.
     */
    private fun switchLensByZoomRatio(toUltraWide: Boolean, uwRatio: Float) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) return
        if (targetSurface == null || cameraDevice == null) {
            useUltraWide = toUltraWide
            host.onStateChanged()
            return
        }
        val session = captureSession
        val builder = captureRequestBuilder
        if (session == null || builder == null) {
            host.onStateChanged()
            return
        }
        try {
            builder.set(CaptureRequest.CONTROL_ZOOM_RATIO, if (toUltraWide) uwRatio else 1.0f)
            session.setRepeatingRequest(builder.build(), null, backgroundHandler)
            useUltraWide = toUltraWide
        } catch (e: Exception) {
            Log.e(TAG, "switchLensByZoomRatio failed", e)
        }
        host.onStateChanged()
    }

    /**
     * Поворот кадра для шейдера композитора. Camera2 для SurfaceTexture-target отдаёт
     * буфер в "родной" sensor-ориентации; getTransformMatrix() даёт только UV-flip/crop,
     * sensor rotation сама не применяет. Поэтому крутим вручную на полный
     * SENSOR_ORIENTATION. Для preview SurfaceView это делает SurfaceFlinger автоматически —
     * там фикс не нужен, и наш поворот его не затрагивает.
     *
     * Activity заблокирована в landscape, так что устройство всегда в одной ориентации
     * относительно сенсора и фиксированного значения достаточно.
     */
    fun frameRotationDegrees(): Int {
        // SurfaceTexture transform matrix содержит Y-flip (UV ось Y направлена вверх,
        // а framebuffer Y вниз). Это инвертирует направление поворота в UV space:
        // чтобы повернуть content на +deg по часовой, нужно применить -deg в UV.
        // Поэтому 360 - sensorOrientation, а не просто sensorOrientation.
        val deg = (360 - sensorOrientation) % 360
        Log.d(TAG, "frame rotation: sensor=$sensorOrientation → $deg")
        return deg
    }

    /**
     * Ближайший к запрошенному разрешению поддерживаемый размер: точное совпадение,
     * иначе 16:9 с минимальной разницей по высоте, иначе прежняя эвристика.
     */
    private fun chooseSizeFor(resolution: StreamResolution, sizes: Array<Size>): Size {
        if (sizes.isEmpty()) return Size(resolution.width, resolution.height)
        sizes.firstOrNull { it.width == resolution.width && it.height == resolution.height }
            ?.let { return it }
        val widescreen = sizes.filter { it.width * 9 == it.height * 16 && it.width <= 1920 }
        return widescreen.minByOrNull { kotlin.math.abs(it.height - resolution.height) }
            ?: sizes.filter { it.width <= 1920 }.maxByOrNull { it.width.toLong() * it.height }
            ?: sizes.first()
    }

    /**
     * Создаёт единственную capture session: камера → surface компоситора.
     * Compositor дальше сам разводит кадр по подключённым output-окнам (preview SurfaceView,
     * recorder encoder, stream encoder). Session не пересоздаётся при старте/остановке
     * записи или стрима — меняются только output-окна Compositor'а.
     */
    private fun startSingleCaptureSession() {
        val device = cameraDevice ?: return
        val cameraSurface = targetSurface ?: run {
            Log.e(TAG, "camera target surface is null")
            return
        }
        val builder = device.createCaptureRequest(CameraDevice.TEMPLATE_RECORD)
        builder.addTarget(cameraSurface)
        builder.set(CaptureRequest.CONTROL_MODE, CaptureRequest.CONTROL_MODE_AUTO)
        builder.set(
            CaptureRequest.CONTROL_AF_MODE,
            CaptureRequest.CONTROL_AF_MODE_CONTINUOUS_VIDEO,
        )
        val uwRatio = selector.ultraWideZoomRatio
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R && uwRatio != null) {
            builder.set(CaptureRequest.CONTROL_ZOOM_RATIO, if (useUltraWide) uwRatio else 1.0f)
        }
        captureRequestBuilder = builder
        createCaptureSession(device, listOf(cameraSurface), builder)
    }

    private fun createCaptureSession(
        device: CameraDevice,
        surfaces: List<Surface>,
        builder: CaptureRequest.Builder,
    ) {
        try {
            // Закрываем старую сессию синхронно — Camera2 корректно её освободит при создании новой.
            captureSession?.close()
            captureSession = null

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                createSessionApi28(device, surfaces, builder)
            } else {
                createSessionLegacy(device, surfaces, builder)
            }
        } catch (e: Exception) {
            Log.e(TAG, "createCaptureSession failed", e)
        }
    }

    private fun sessionStateCallback(builder: CaptureRequest.Builder): CameraCaptureSession.StateCallback =
        object : CameraCaptureSession.StateCallback() {
            override fun onConfigured(session: CameraCaptureSession) {
                captureSession = session
                try {
                    session.setRepeatingRequest(builder.build(), null, backgroundHandler)
                } catch (e: Exception) {
                    Log.e(TAG, "setRepeatingRequest failed", e)
                }
            }

            override fun onConfigureFailed(session: CameraCaptureSession) {
                Log.e(TAG, "createCaptureSession configure failed")
            }
        }

    @Suppress("DEPRECATION")
    private fun createSessionLegacy(
        device: CameraDevice,
        surfaces: List<Surface>,
        builder: CaptureRequest.Builder,
    ) {
        device.createCaptureSession(surfaces, sessionStateCallback(builder), backgroundHandler)
    }

    private fun createSessionApi28(
        device: CameraDevice,
        surfaces: List<Surface>,
        builder: CaptureRequest.Builder,
    ) {
        val outputs = surfaces.map { OutputConfiguration(it) }
        val executor = Executor { runnable ->
            backgroundHandler?.post(runnable) ?: runnable.run()
        }
        val sessionConfig = SessionConfiguration(
            SessionConfiguration.SESSION_REGULAR,
            outputs,
            executor,
            sessionStateCallback(builder),
        )
        device.createCaptureSession(sessionConfig)
    }

    companion object {
        private const val TAG = "CameraController"
        private const val REOPEN_BASE_MS = 1_000L
        private const val REOPEN_CAP_MS = 10_000L
    }
}
