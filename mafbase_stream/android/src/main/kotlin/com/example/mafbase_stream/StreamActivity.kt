package com.example.mafbase_stream

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.hardware.camera2.CameraCaptureSession
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraDevice
import android.hardware.camera2.CameraManager
import android.hardware.camera2.CaptureRequest
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.HandlerThread
import android.os.Looper
import android.util.Log
import android.util.Size
import android.view.Gravity
import android.view.SurfaceHolder
import android.view.SurfaceView
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.FrameLayout
import android.widget.LinearLayout
import android.widget.ProgressBar
import android.widget.Toast
import androidx.core.content.FileProvider
import com.example.mafbase_stream.encoder.Mp4Recorder
import com.example.mafbase_stream.gl.Compositor
import com.example.mafbase_stream.overlay.OverlayCatalog
import com.example.mafbase_stream.overlay.OverlayDebugTarget
import com.example.mafbase_stream.overlay.OverlayParams
import com.example.mafbase_stream.overlay.OverlayViewRenderer
import java.io.File

/**
 * Полноэкранный нативный экран с превью камеры по Camera2 API и записью MP4.
 *
 * Запускается из MafbaseStreamPlugin через startActivityForResult.
 * При нажатии «Закрыть» — возвращает RESULT_OK; при отказе в разрешениях — RESULT_PERMISSIONS_DENIED.
 *
 * Кнопка «Запись»:
 *  - старт: пересобираем capture session с двумя выходами (preview + энкодер) и
 *    TEMPLATE_RECORD, начинаем писать MP4 в getExternalFilesDir(DIRECTORY_MOVIES);
 *  - стоп: возвращаем preview-only session, останавливаем энкодеры на фоновом потоке,
 *    показываем toast и предлагаем share через FileProvider.
 */
class StreamActivity :
    Activity(),
    SurfaceHolder.Callback {

    private lateinit var surfaceView: SurfaceView
    private lateinit var recordButton: Button
    private lateinit var streamButton: Button
    private lateinit var streamProgress: ProgressBar
    // Сохраняем последнюю текстовую метку, чтобы вернуть её после завершения транзишна.
    private var streamButtonLabel: String = "Стрим"
    private var cameraDevice: CameraDevice? = null
    private var captureSession: CameraCaptureSession? = null
    private var backgroundThread: HandlerThread? = null
    private var backgroundHandler: Handler? = null
    private val mainHandler = Handler(Looper.getMainLooper())
    private var hasSurface: Boolean = false
    private var previewSize: Size? = null

    private var mp4Recorder: Mp4Recorder? = null
    private var isRecording: Boolean = false

    private var streamSession: StreamSession? = null
    private var isStreaming: Boolean = false
    // Угол сенсора камеры (deg, по часовой относительно natural orientation устройства).
    // Читается при openCamera. Используется для расчёта поворота кадра в композиторе.
    private var sensorOrientation: Int = 0

    // GL-композитор живёт всю жизнь камеры. Camera2 пишет ровно в compositor.cameraSurface,
    // а Compositor рисует FBO (с overlay) в подключённые output-окна: PREVIEW (SurfaceView),
    // RECORD_ENCODER (Mp4Recorder.videoInputSurface), STREAM_ENCODER (StreamSession.encoderSurface).
    private var compositor: Compositor? = null
    private var overlayRenderer: OverlayViewRenderer? = null

    @Volatile
    private var isTransitioning: Boolean = false

    private var rtmpUrl: String = "rtmp://10.0.2.2/live"
    private var streamKey: String = "test"
    private var overlayViewType: String? = null
    private var overlayTournamentId: Int? = null
    private var overlayTable: Int? = null
    // Сохраняем view от текущей сессии стрима, чтобы кнопка «Toggle overlay»
    // могла её дёрнуть. Один экземпляр на сессию — пересоздаётся в startStreaming.
    private var overlayView: View? = null
    private var overlayToggleButton: Button? = null

    companion object {
        private const val TAG = "StreamActivity"
        private const val REQUEST_PERMISSIONS = 1001
        const val RESULT_PERMISSIONS_DENIED: Int = Activity.RESULT_FIRST_USER + 1

        const val EXTRA_RTMP_URL: String = "mafbase_stream.rtmp_url"
        const val EXTRA_STREAM_KEY: String = "mafbase_stream.stream_key"
        const val EXTRA_OVERLAY_VIEW_TYPE: String = "mafbase_stream.overlay_view_type"
        const val EXTRA_TOURNAMENT_ID: String = "mafbase_stream.tournament_id"
        const val EXTRA_TABLE: String = "mafbase_stream.table"

        private val REQUIRED_PERMISSIONS = arrayOf(
            Manifest.permission.CAMERA,
            Manifest.permission.RECORD_AUDIO,
        )
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        intent?.getStringExtra(EXTRA_RTMP_URL)?.takeIf { it.isNotBlank() }?.let { rtmpUrl = it }
        intent?.getStringExtra(EXTRA_STREAM_KEY)?.takeIf { it.isNotBlank() }?.let { streamKey = it }
        intent?.getStringExtra(EXTRA_OVERLAY_VIEW_TYPE)?.takeIf { it.isNotBlank() }?.let {
            overlayViewType = it
        }
        if (intent?.hasExtra(EXTRA_TOURNAMENT_ID) == true) {
            overlayTournamentId = intent.getIntExtra(EXTRA_TOURNAMENT_ID, 0)
        }
        if (intent?.hasExtra(EXTRA_TABLE) == true) {
            overlayTable = intent.getIntExtra(EXTRA_TABLE, 0)
        }

        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        window.decorView.systemUiVisibility = (
            View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN
                or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
        )

        val container = FrameLayout(this).apply {
            setBackgroundColor(Color.BLACK)
        }

        surfaceView = SurfaceView(this)
        surfaceView.holder.addCallback(this)
        container.addView(
            surfaceView,
            FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT,
            ),
        )

        val closeButton = Button(this).apply {
            text = "Закрыть"
            setOnClickListener { finishWithResult(Activity.RESULT_OK) }
        }
        val closeParams = FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.WRAP_CONTENT,
            FrameLayout.LayoutParams.WRAP_CONTENT,
        ).apply {
            gravity = Gravity.TOP or Gravity.END
            val margin = (resources.displayMetrics.density * 16).toInt()
            setMargins(margin, margin, margin, margin)
        }
        container.addView(closeButton, closeParams)

        recordButton = Button(this).apply {
            text = "Запись"
            setTextColor(Color.WHITE)
            background = GradientDrawable().apply {
                shape = GradientDrawable.RECTANGLE
                cornerRadius = resources.displayMetrics.density * 24
                setColor(Color.argb(220, 220, 60, 60))
            }
            setOnClickListener { onRecordButtonClicked() }
        }
        streamButton = Button(this).apply {
            text = streamButtonLabel
            setTextColor(Color.WHITE)
            background = GradientDrawable().apply {
                shape = GradientDrawable.RECTANGLE
                cornerRadius = resources.displayMetrics.density * 24
                setColor(Color.argb(220, 60, 140, 220))
            }
            setOnClickListener { onStreamButtonClicked() }
        }
        streamProgress = ProgressBar(this).apply {
            isIndeterminate = true
            visibility = View.GONE
        }
        // Контейнер: кнопка + центрованный прогресс поверх. Во время старта/остановки
        // стрима текст кнопки скрывается, на его месте крутится индикатор.
        val streamButtonContainer = FrameLayout(this).apply {
            addView(
                streamButton,
                FrameLayout.LayoutParams(
                    FrameLayout.LayoutParams.WRAP_CONTENT,
                    FrameLayout.LayoutParams.WRAP_CONTENT,
                ),
            )
            val progressSize = (resources.displayMetrics.density * 24).toInt()
            addView(
                streamProgress,
                FrameLayout.LayoutParams(progressSize, progressSize, Gravity.CENTER),
            )
        }
        // Кнопка «Toggle overlay» появляется только если зарегистрирован overlayViewType
        // и эта view реализует OverlayDebugTarget. Видна стримеру, не попадает в видеопоток.
        val toggleButton = Button(this).apply {
            text = "Toggle overlay"
            setTextColor(Color.WHITE)
            background = GradientDrawable().apply {
                shape = GradientDrawable.RECTANGLE
                cornerRadius = resources.displayMetrics.density * 24
                setColor(Color.argb(220, 90, 90, 90))
            }
            visibility = View.GONE
            setOnClickListener {
                (overlayView as? OverlayDebugTarget)?.onDebugToggle()
            }
        }
        overlayToggleButton = toggleButton

        val buttonsRow = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            val gap = (resources.displayMetrics.density * 12).toInt()
            addView(
                recordButton,
                LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.WRAP_CONTENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT,
                ).apply { rightMargin = gap },
            )
            addView(
                streamButtonContainer,
                LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.WRAP_CONTENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT,
                ).apply { rightMargin = gap },
            )
            addView(
                toggleButton,
                LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.WRAP_CONTENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT,
                ),
            )
        }
        val rowParams = FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.WRAP_CONTENT,
            FrameLayout.LayoutParams.WRAP_CONTENT,
        ).apply {
            gravity = Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL
            val margin = (resources.displayMetrics.density * 24).toInt()
            setMargins(margin, margin, margin, margin)
        }
        container.addView(buttonsRow, rowParams)

        setContentView(container)

        if (!hasAllPermissions()) {
            requestPermissions(REQUIRED_PERMISSIONS, REQUEST_PERMISSIONS)
        }
    }

    override fun onResume() {
        super.onResume()
        startBackgroundThread()
        if (hasSurface && hasAllPermissions() && cameraDevice == null) {
            openCamera()
        }
    }

    override fun onPause() {
        if (isRecording) {
            stopRecordingSync()
        }
        if (isStreaming) {
            stopStreamingSync()
        }
        closeCamera()
        stopBackgroundThread()
        super.onPause()
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != REQUEST_PERMISSIONS) return

        val granted = grantResults.isNotEmpty() &&
            grantResults.all { it == PackageManager.PERMISSION_GRANTED }
        if (granted) {
            if (hasSurface && cameraDevice == null) {
                openCamera()
            }
        } else {
            finishWithResult(RESULT_PERMISSIONS_DENIED)
        }
    }

    override fun surfaceCreated(holder: SurfaceHolder) {
        hasSurface = true
        if (hasAllPermissions() && cameraDevice == null) {
            openCamera()
        }
    }

    override fun surfaceChanged(
        holder: SurfaceHolder,
        format: Int,
        width: Int,
        height: Int,
    ) {
        // Camera2 переоткрывать не нужно — превью растягивается до фиксированного размера.
    }

    override fun surfaceDestroyed(holder: SurfaceHolder) {
        hasSurface = false
        closeCamera()
    }

    private fun hasAllPermissions(): Boolean = REQUIRED_PERMISSIONS.all {
        checkSelfPermission(it) == PackageManager.PERMISSION_GRANTED
    }

    private fun startBackgroundThread() {
        if (backgroundThread != null) return
        backgroundThread = HandlerThread("MafbaseStreamCamera").also { it.start() }
        backgroundHandler = Handler(backgroundThread!!.looper)
    }

    private fun stopBackgroundThread() {
        backgroundThread?.quitSafely()
        try {
            backgroundThread?.join()
        } catch (e: InterruptedException) {
            Log.w(TAG, "stopBackgroundThread interrupted", e)
        }
        backgroundThread = null
        backgroundHandler = null
    }

    @SuppressLint("MissingPermission")
    private fun openCamera() {
        val manager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        try {
            val cameraId = pickBackCameraId(manager) ?: run {
                Log.e(TAG, "Подходящая камера не найдена")
                finishWithResult(Activity.RESULT_CANCELED)
                return
            }

            val characteristics = manager.getCameraCharacteristics(cameraId)
            sensorOrientation = characteristics.get(CameraCharacteristics.SENSOR_ORIENTATION) ?: 0
            val map = characteristics.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP)
            val chosen = map?.getOutputSizes(SurfaceHolder::class.java)?.let(::chooseOptimalSize)
                ?: Size(1280, 720)
            previewSize = chosen
            surfaceView.holder.setFixedSize(chosen.width, chosen.height)

            // Поднимаем Compositor под выбранный размер кадра. Camera2 будет писать в его
            // cameraSurface, а Compositor — рисовать в подключённые output-окна.
            val comp = Compositor(chosen.width, chosen.height, computeFrameRotationDegrees()).also {
                it.setListener(object : Compositor.Listener {
                    override fun onError(t: Throwable) {
                        Log.e(TAG, "Compositor error", t)
                    }
                })
                it.start()
            }
            compositor = comp
            comp.attachOutput(
                Compositor.OutputId.PREVIEW,
                surfaceView.holder.surface,
                needsPresentationTime = false,
            )
            attachOverlayIfNeeded(comp, chosen.width, chosen.height)

            manager.openCamera(
                cameraId,
                object : CameraDevice.StateCallback() {
                    override fun onOpened(device: CameraDevice) {
                        cameraDevice = device
                        startSingleCaptureSession()
                    }

                    override fun onDisconnected(device: CameraDevice) {
                        device.close()
                        cameraDevice = null
                    }

                    override fun onError(device: CameraDevice, error: Int) {
                        Log.e(TAG, "openCamera onError: $error")
                        device.close()
                        cameraDevice = null
                    }
                },
                backgroundHandler,
            )
        } catch (e: Exception) {
            Log.e(TAG, "openCamera failed", e)
        }
    }

    private fun pickBackCameraId(manager: CameraManager): String? {
        val ids = manager.cameraIdList
        val backId = ids.firstOrNull { id ->
            val characteristics = manager.getCameraCharacteristics(id)
            characteristics.get(CameraCharacteristics.LENS_FACING) ==
                CameraCharacteristics.LENS_FACING_BACK
        }
        return backId ?: ids.firstOrNull()
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
    private fun computeFrameRotationDegrees(): Int {
        // SurfaceTexture transform matrix содержит Y-flip (UV ось Y направлена вверх,
        // а framebuffer Y вниз). Это инвертирует направление поворота в UV space:
        // чтобы повернуть content на +deg по часовой, нужно применить -deg в UV.
        // Поэтому 360 - sensorOrientation, а не просто sensorOrientation.
        val deg = (360 - sensorOrientation) % 360
        Log.d(TAG, "frame rotation: sensor=$sensorOrientation → $deg")
        return deg
    }

    private fun chooseOptimalSize(sizes: Array<Size>): Size {
        if (sizes.isEmpty()) return Size(1280, 720)
        val widescreen = sizes.filter { it.width * 9 == it.height * 16 && it.width <= 1920 }
        return widescreen.maxByOrNull { it.width.toLong() * it.height }
            ?: sizes.filter { it.width <= 1920 }.maxByOrNull { it.width.toLong() * it.height }
            ?: sizes.first()
    }

    /**
     * Создаёт единственную capture session: камера → `compositor.cameraSurface`.
     * Compositor дальше сам разводит кадр по подключённым output-окнам (preview SurfaceView,
     * recorder encoder, stream encoder). Session не пересоздаётся при старте/остановке
     * записи или стрима — меняются только output-окна Compositor'а.
     */
    private fun startSingleCaptureSession() {
        val device = cameraDevice ?: return
        val comp = compositor ?: return
        val cameraSurface = comp.cameraSurface ?: run {
            Log.e(TAG, "compositor.cameraSurface is null")
            return
        }
        val builder = device.createCaptureRequest(CameraDevice.TEMPLATE_RECORD)
        builder.addTarget(cameraSurface)
        builder.set(CaptureRequest.CONTROL_MODE, CaptureRequest.CONTROL_MODE_AUTO)
        builder.set(
            CaptureRequest.CONTROL_AF_MODE,
            CaptureRequest.CONTROL_AF_MODE_CONTINUOUS_VIDEO,
        )
        createCaptureSession(device, listOf(cameraSurface), builder, onConfigured = null)
    }

    private fun createCaptureSession(
        device: CameraDevice,
        surfaces: List<android.view.Surface>,
        builder: CaptureRequest.Builder,
        onConfigured: (() -> Unit)?,
    ) {
        try {
            // Закрываем старую сессию синхронно — Camera2 корректно её освободит при создании новой.
            captureSession?.close()
            captureSession = null

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                createSessionApi28(device, surfaces, builder, onConfigured)
            } else {
                createSessionLegacy(device, surfaces, builder, onConfigured)
            }
        } catch (e: Exception) {
            Log.e(TAG, "createCaptureSession failed", e)
        }
    }

    @Suppress("DEPRECATION")
    private fun createSessionLegacy(
        device: CameraDevice,
        surfaces: List<android.view.Surface>,
        builder: CaptureRequest.Builder,
        onConfigured: (() -> Unit)?,
    ) {
        device.createCaptureSession(
            surfaces,
            object : CameraCaptureSession.StateCallback() {
                override fun onConfigured(session: CameraCaptureSession) {
                    captureSession = session
                    try {
                        session.setRepeatingRequest(builder.build(), null, backgroundHandler)
                        onConfigured?.invoke()
                    } catch (e: Exception) {
                        Log.e(TAG, "setRepeatingRequest failed", e)
                    }
                }

                override fun onConfigureFailed(session: CameraCaptureSession) {
                    Log.e(TAG, "createCaptureSession configure failed")
                }
            },
            backgroundHandler,
        )
    }

    private fun createSessionApi28(
        device: CameraDevice,
        surfaces: List<android.view.Surface>,
        builder: CaptureRequest.Builder,
        onConfigured: (() -> Unit)?,
    ) {
        val outputs = surfaces.map { android.hardware.camera2.params.OutputConfiguration(it) }
        val executor = java.util.concurrent.Executor { runnable ->
            backgroundHandler?.post(runnable) ?: runnable.run()
        }
        val sessionConfig = android.hardware.camera2.params.SessionConfiguration(
            android.hardware.camera2.params.SessionConfiguration.SESSION_REGULAR,
            outputs,
            executor,
            object : CameraCaptureSession.StateCallback() {
                override fun onConfigured(session: CameraCaptureSession) {
                    captureSession = session
                    try {
                        session.setRepeatingRequest(builder.build(), null, backgroundHandler)
                        onConfigured?.invoke()
                    } catch (e: Exception) {
                        Log.e(TAG, "setRepeatingRequest failed", e)
                    }
                }

                override fun onConfigureFailed(session: CameraCaptureSession) {
                    Log.e(TAG, "createCaptureSession configure failed")
                }
            },
        )
        device.createCaptureSession(sessionConfig)
    }

    private fun closeCamera() {
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

        // Сначала overlay (он держит compositor через attach), потом сам compositor.
        try {
            overlayRenderer?.detach()
        } catch (e: Exception) {
            Log.w(TAG, "overlayRenderer.detach failed", e)
        }
        overlayRenderer = null
        overlayView = null
        overlayToggleButton?.visibility = View.GONE

        try {
            compositor?.release()
        } catch (e: Exception) {
            Log.w(TAG, "compositor release failed", e)
        }
        compositor = null
    }

    /**
     * Если задан [overlayViewType] — создаёт Compose-overlay и привязывает к [comp].
     * Overlay живёт всю жизнь Compositor'а, поэтому видим в preview, recording и стриме.
     */
    private fun attachOverlayIfNeeded(comp: Compositor, width: Int, height: Int) {
        val viewType = overlayViewType ?: return
        Log.d(TAG, "attachOverlay: viewType=$viewType, frame=${width}x$height")
        val renderer = OverlayViewRenderer(width, height)
        val params = OverlayParams(tournamentId = overlayTournamentId, table = overlayTable)
        val view = OverlayCatalog.create(viewType, this, renderer, params)
        if (view == null) {
            Log.w(TAG, "Overlay '$viewType' not found in catalog — running without overlay")
            return
        }
        renderer.setView(view)
        renderer.attach(comp)
        overlayRenderer = renderer
        overlayView = view
        if (view is OverlayDebugTarget) {
            overlayToggleButton?.visibility = View.VISIBLE
        }
    }

    private fun finishWithResult(resultCode: Int) {
        setResult(resultCode)
        finish()
    }

    // --- Запись ---

    private fun onRecordButtonClicked() {
        if (isTransitioning) return
        if (cameraDevice == null) return
        if (isRecording) {
            stopRecording()
        } else {
            startRecording()
        }
    }

    private fun startRecording() {
        val size = previewSize ?: return
        val comp = compositor ?: return
        isTransitioning = true
        recordButton.isEnabled = false

        val recorder = Mp4Recorder(this)
        try {
            recorder.start(size.width, size.height)
        } catch (e: Exception) {
            Log.e(TAG, "Mp4Recorder.start failed", e)
            recorder.stop()
            Toast.makeText(this, "Не удалось начать запись: ${e.message}", Toast.LENGTH_LONG).show()
            isTransitioning = false
            recordButton.isEnabled = true
            return
        }
        val encoderSurface = recorder.videoInputSurface
        if (encoderSurface == null) {
            Log.e(TAG, "encoder input surface is null")
            recorder.stop()
            isTransitioning = false
            recordButton.isEnabled = true
            return
        }
        mp4Recorder = recorder

        // Capture session не трогаем — добавляем encoder как новый output Compositor'а.
        comp.attachOutput(
            Compositor.OutputId.RECORD_ENCODER,
            encoderSurface,
            needsPresentationTime = true,
        )
        isRecording = true
        isTransitioning = false
        recordButton.text = "Стоп"
        recordButton.isEnabled = true
    }

    private fun stopRecording() {
        val recorder = mp4Recorder ?: return
        isTransitioning = true
        recordButton.isEnabled = false

        // Сначала отцепляем encoder Surface от Compositor'а ДО recorder.stop() —
        // иначе Compositor продолжит eglSwapBuffers на разрушенный BufferQueue.
        compositor?.detachOutput(Compositor.OutputId.RECORD_ENCODER)

        Thread({
            val file = try {
                recorder.stop()
            } catch (e: Exception) {
                Log.e(TAG, "Mp4Recorder.stop failed", e)
                null
            }

            mainHandler.post {
                mp4Recorder = null
                isRecording = false
                recordButton.text = "Запись"
                isTransitioning = false
                recordButton.isEnabled = true

                if (file != null && file.exists() && file.length() > 0) {
                    Toast.makeText(
                        this@StreamActivity,
                        "Сохранено: ${file.absolutePath}",
                        Toast.LENGTH_LONG,
                    ).show()
                    shareRecording(file)
                } else {
                    Toast.makeText(this@StreamActivity, "Запись пуста", Toast.LENGTH_SHORT).show()
                }
            }
        }, "Mp4Recorder-stop").start()
    }

    /** Синхронный вариант для onPause: останавливает запись прямо в UI-потоке. */
    private fun stopRecordingSync() {
        val recorder = mp4Recorder ?: return
        compositor?.detachOutput(Compositor.OutputId.RECORD_ENCODER)
        try {
            recorder.stop()
        } catch (e: Exception) {
            Log.w(TAG, "Mp4Recorder.stop (sync) failed", e)
        }
        mp4Recorder = null
        isRecording = false
        recordButton.text = "Запись"
    }

    // --- Стрим ---

    private fun setStreamButtonLoading(loading: Boolean) {
        if (loading) {
            streamButton.text = ""
            streamProgress.visibility = View.VISIBLE
        } else {
            streamProgress.visibility = View.GONE
            streamButton.text = streamButtonLabel
        }
    }

    private fun setStreamButtonLabel(label: String) {
        streamButtonLabel = label
        if (streamProgress.visibility != View.VISIBLE) {
            streamButton.text = label
        }
    }

    private fun onStreamButtonClicked() {
        if (isTransitioning) return
        if (cameraDevice == null) return
        if (isRecording) {
            Toast.makeText(this, "Сначала остановите запись", Toast.LENGTH_SHORT).show()
            return
        }
        if (isStreaming) stopStreaming() else startStreaming()
    }

    private fun startStreaming() {
        val size = previewSize ?: return
        val comp = compositor ?: return
        isTransitioning = true
        streamButton.isEnabled = false
        setStreamButtonLoading(true)

        val fullUrl = if (streamKey.isNotBlank()) {
            "${rtmpUrl.trimEnd('/')}/$streamKey"
        } else {
            rtmpUrl
        }

        val session = StreamSession(
            StreamSession.Config(
                rtmpUrl = fullUrl,
                width = size.width,
                height = size.height,
            ),
        )
        session.setListener(object : StreamSession.Listener {
            override fun onStreamStarted() {
                mainHandler.post {
                    Toast.makeText(this@StreamActivity, "Стрим запущен", Toast.LENGTH_SHORT).show()
                }
            }

            override fun onStreamError(t: Throwable) {
                Log.e(TAG, "stream error", t)
                mainHandler.post {
                    Toast.makeText(
                        this@StreamActivity,
                        "Ошибка стрима: ${t.message ?: t.javaClass.simpleName}",
                        Toast.LENGTH_LONG,
                    ).show()
                }
            }
        })

        // StreamSession.start() выполняет MediaCodec.prepare/configure/createInputSurface
        // и AudioRecord init — на устройствах это занимает 200-500 мс. Если делать на UI,
        // Choreographer пишет «Skipped 41 frames!». Уносим в фоновый поток.
        Thread({
            val ok = try {
                session.start()
                true
            } catch (e: Exception) {
                Log.e(TAG, "StreamSession.start failed", e)
                try {
                    session.stop()
                } catch (_: Throwable) {
                }
                mainHandler.post {
                    Toast.makeText(
                        this@StreamActivity,
                        "Не удалось начать стрим: ${e.message}",
                        Toast.LENGTH_LONG,
                    ).show()
                    isTransitioning = false
                    setStreamButtonLoading(false)
                    streamButton.isEnabled = true
                }
                false
            }
            if (!ok) return@Thread

            val encoderSurface = session.encoderSurface
            if (encoderSurface == null) {
                Log.e(TAG, "stream encoder surface is null")
                session.stop()
                mainHandler.post {
                    isTransitioning = false
                    setStreamButtonLoading(false)
                    streamButton.isEnabled = true
                }
                return@Thread
            }

            mainHandler.post {
                streamSession = session
                comp.attachOutput(
                    Compositor.OutputId.STREAM_ENCODER,
                    encoderSurface,
                    needsPresentationTime = true,
                )
                isStreaming = true
                isTransitioning = false
                setStreamButtonLabel("Стоп")
                setStreamButtonLoading(false)
                streamButton.isEnabled = true
            }
        }, "StreamSession-start").start()
    }

    private fun stopStreaming() {
        val session = streamSession ?: return
        isTransitioning = true
        streamButton.isEnabled = false
        setStreamButtonLoading(true)

        // Сначала отцепляем encoder Surface от Compositor'а ДО session.stop() —
        // иначе compositor продолжит eglSwapBuffers на разрушенный BufferQueue.
        compositor?.detachOutput(Compositor.OutputId.STREAM_ENCODER)

        Thread({
            try {
                session.stop()
            } catch (e: Exception) {
                Log.e(TAG, "StreamSession.stop failed", e)
            }
            mainHandler.post {
                streamSession = null
                isStreaming = false
                setStreamButtonLabel("Стрим")
                setStreamButtonLoading(false)
                isTransitioning = false
                streamButton.isEnabled = true
                Toast.makeText(this@StreamActivity, "Стрим остановлен", Toast.LENGTH_SHORT).show()
            }
        }, "StreamSession-stop").start()
    }

    private fun stopStreamingSync() {
        val session = streamSession ?: return
        compositor?.detachOutput(Compositor.OutputId.STREAM_ENCODER)
        try {
            session.stop()
        } catch (e: Exception) {
            Log.w(TAG, "StreamSession.stop (sync) failed", e)
        }
        streamSession = null
        isStreaming = false
        setStreamButtonLabel("Стрим")
        setStreamButtonLoading(false)
    }

    private fun shareRecording(file: File) {
        try {
            val authority = "${packageName}.mafbase_stream.fileprovider"
            val uri = FileProvider.getUriForFile(this, authority, file)
            val intent = Intent(Intent.ACTION_SEND).apply {
                type = "video/mp4"
                putExtra(Intent.EXTRA_STREAM, uri)
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }
            startActivity(Intent.createChooser(intent, "Поделиться записью"))
        } catch (e: Exception) {
            Log.w(TAG, "share failed", e)
        }
    }
}
