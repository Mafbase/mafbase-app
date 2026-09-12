package com.example.mafbase_stream

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.content.ContentValues
import android.content.Context
import android.content.pm.PackageManager
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.hardware.camera2.CameraCaptureSession
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraDevice
import android.hardware.camera2.CameraManager
import android.hardware.camera2.CaptureRequest
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.os.Handler
import android.os.HandlerThread
import android.os.Looper
import android.os.ParcelFileDescriptor
import android.provider.MediaStore
import android.util.Log
import android.util.Size
import android.view.Gravity
import android.view.SurfaceHolder
import android.view.SurfaceView
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.FrameLayout
import android.widget.ImageButton
import android.widget.LinearLayout
import android.widget.ProgressBar
import android.widget.Toast
import com.example.mafbase_stream.encoder.AudioPipeline
import com.example.mafbase_stream.encoder.Mp4Recorder
import com.example.mafbase_stream.events.StreamEventBus
import com.example.mafbase_stream.gl.Compositor
import com.example.mafbase_stream.jni.StreamSessionNative
import com.example.mafbase_stream.overlay.OverlayCatalog
import com.example.mafbase_stream.overlay.OverlayDebugTarget
import com.example.mafbase_stream.overlay.OverlayParams
import com.example.mafbase_stream.overlay.OverlayViewRenderer
import java.io.File
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/**
 * Полноэкранный нативный экран с превью камеры по Camera2 API и записью MP4.
 *
 * Запускается из MafbaseStreamPlugin через startActivityForResult.
 * При нажатии «Закрыть» — возвращает RESULT_OK; при отказе в разрешениях — RESULT_PERMISSIONS_DENIED.
 *
 * Кнопка «Запись»:
 *  - старт: подключаем энкодер как ещё один выход Compositor'а и начинаем писать MP4.
 *    На API 29+ пишем напрямую в MediaStore через FileDescriptor, ниже — во временный
 *    файл в getExternalFilesDir(DIRECTORY_MOVIES);
 *  - стоп: отцепляем энкодер, финализируем запись на фоновом потоке и показываем toast.
 *    На API < 29 файл копируется в галерею через [SaveToGalleryService].
 */
class StreamActivity :
    Activity(),
    SurfaceHolder.Callback {

    private lateinit var surfaceView: SurfaceView
    private lateinit var surfaceContainer: AspectRatioFrameLayout
    private lateinit var recordButton: Button
    private lateinit var streamButton: Button
    private lateinit var streamProgress: ProgressBar
    // Сохраняем последнюю текстовую метку, чтобы вернуть её после завершения транзишна.
    private var streamButtonLabel: String = "Стрим"
    private var cameraDevice: CameraDevice? = null
    private var captureSession: CameraCaptureSession? = null
    // Builder repeating-запроса живой сессии — нужен для смены CONTROL_ZOOM_RATIO
    // без пересоздания сессии (путь ультраширокой без отдельного camera id).
    private var captureRequestBuilder: CaptureRequest.Builder? = null
    private var backgroundThread: HandlerThread? = null
    private var backgroundHandler: Handler? = null
    private val mainHandler = Handler(Looper.getMainLooper())
    private var hasSurface: Boolean = false
    private var previewSize: Size? = null

    private var mp4Recorder: Mp4Recorder? = null
    private var isRecording: Boolean = false

    // Сегментация записи
    private var segmentDurationMs: Long = 0L  // 0 = выключено
    private var segmentIndex: Int = 1
    private var recordingSessionId: String = ""
    private var segmentTimerRunnable: Runnable? = null

    // Проверка свободного места (см. StorageMonitor). Не блокирует запись — только
    // предупреждает и, при критически малом остатке, останавливает её.
    private var storageCheckRunnable: Runnable? = null
    private var storageWarningReported = false

    // Текущая активная запись в MediaStore (API 29+)
    private var activeMediaStoreUri: Uri? = null
    private var activeMediaStorePfd: ParcelFileDescriptor? = null

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

    // Шарится между overlay'ем (writer) и audio pipeline'ом (reader): overlay
    // выставляет muted=true когда `broadcastPhase` != day.
    private val phaseGate = PhaseGate()

    // Общий audio pipeline на жизнь камеры. Запись и стрим оба подписываются на него,
    // и AudioRecord(MIC) поднимается в одном экземпляре — иначе вторая инстанция конфликтует.
    private val audioPipeline = AudioPipeline(phaseGate = phaseGate)

    @Volatile
    private var isTransitioning: Boolean = false

    private var rtmpUrl: String = "rtmp://10.0.2.2/live"
    private var streamKey: String = "test"
    private var overlayViewType: String? = null
    private var overlayTournamentId: Int? = null
    private var overlayClubId: Int? = null
    private var overlayTable: Int? = null
    private var breakPlaceholderImageUrl: String? = null
    private var brandImageUrl: String? = null
    // Сохраняем view от текущей сессии стрима, чтобы кнопка «Toggle overlay»
    // могла её дёрнуть. Один экземпляр на сессию — пересоздаётся в startStreaming.
    private var overlayView: View? = null
    private var overlayToggleButton: Button? = null

    // Качество трансляции и выбор объектива
    private lateinit var rootContainer: FrameLayout
    private lateinit var quality: StreamQuality
    private lateinit var qualityButton: ImageButton
    private var lensSwitcher: SegmentedPillView? = null
    private var qualityPanel: QualitySettingsPanel? = null
    private var qualityScrim: View? = null
    private var cameraSelector: CameraSelector? = null
    private var useUltraWide: Boolean = false

    @Volatile
    private var isLensSwitching: Boolean = false

    companion object {
        private const val TAG = "StreamActivity"
        private const val REQUEST_PERMISSIONS = 1001
        const val RESULT_PERMISSIONS_DENIED: Int = Activity.RESULT_FIRST_USER + 1

        const val EXTRA_RTMP_URL: String = "mafbase_stream.rtmp_url"
        const val EXTRA_STREAM_KEY: String = "mafbase_stream.stream_key"
        const val EXTRA_OVERLAY_VIEW_TYPE: String = "mafbase_stream.overlay_view_type"
        const val EXTRA_TOURNAMENT_ID: String = "mafbase_stream.tournament_id"
        const val EXTRA_CLUB_ID: String = "mafbase_stream.club_id"
        const val EXTRA_TABLE: String = "mafbase_stream.table"
        const val EXTRA_BREAK_PLACEHOLDER_URL: String = "mafbase_stream.break_placeholder_url"
        const val EXTRA_BRAND_IMAGE_URL: String = "mafbase_stream.brand_image_url"
        const val EXTRA_SEGMENT_DURATION_MINUTES: String = "mafbase_stream.segment_duration_minutes"

        /** Как часто перепроверяем свободное место, пока идёт запись. */
        private const val STORAGE_CHECK_INTERVAL_MS = 30_000L

        /**
         * Аудио-битрейт записи не настраивается пользователем (см. [AudioEncoder]/[AudioPipeline] —
         * 128 kbps AAC по умолчанию), поэтому для оценки объёма записи берём его константой,
         * прибавляя к текущему видео-битрейту качества.
         */
        private const val ESTIMATED_AUDIO_BITRATE_BPS = 128_000

        /** Без этих разрешений экран работать не может — при отказе закрываемся. */
        private fun requiredPermissions(): Array<String> =
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
                arrayOf(
                    Manifest.permission.CAMERA,
                    Manifest.permission.RECORD_AUDIO,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE,
                )
            } else {
                arrayOf(
                    Manifest.permission.CAMERA,
                    Manifest.permission.RECORD_AUDIO,
                )
            }

        /**
         * Что запрашиваем при открытии экрана: обязательные плюс POST_NOTIFICATIONS.
         * Уведомление показывает прогресс сохранения записи; без разрешения оно молча
         * подавляется, но сама запись работает — поэтому отказ не блокирует экран.
         */
        private fun requestedPermissions(): Array<String> {
            val permissions = requiredPermissions().toMutableList()
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                permissions += Manifest.permission.POST_NOTIFICATIONS
            }
            return permissions.toTypedArray()
        }
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
        if (intent?.hasExtra(EXTRA_CLUB_ID) == true) {
            overlayClubId = intent.getIntExtra(EXTRA_CLUB_ID, 0)
        }
        if (intent?.hasExtra(EXTRA_TABLE) == true) {
            overlayTable = intent.getIntExtra(EXTRA_TABLE, 0)
        }
        intent?.getStringExtra(EXTRA_BREAK_PLACEHOLDER_URL)?.takeIf { it.isNotBlank() }?.let {
            breakPlaceholderImageUrl = it
        }
        intent?.getStringExtra(EXTRA_BRAND_IMAGE_URL)?.takeIf { it.isNotBlank() }?.let {
            brandImageUrl = it
        }
        if (intent?.hasExtra(EXTRA_SEGMENT_DURATION_MINUTES) == true) {
            val minutes = intent.getIntExtra(EXTRA_SEGMENT_DURATION_MINUTES, 0)
            segmentDurationMs = if (minutes > 0) minutes * 60_000L else 0L
        }
        // Android: по умолчанию сегментация выключена (segmentDurationMs = 0)

        quality = StreamQualityStore.load(this)
        cameraSelector = CameraSelector(getSystemService(Context.CAMERA_SERVICE) as CameraManager)

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
        rootContainer = container

        surfaceView = SurfaceView(this)
        surfaceView.holder.addCallback(this)
        // Обёртка нужна, чтобы SurfaceView не растягивал кадр на весь экран — она
        // вписывает SurfaceView в bounds с aspect ratio пайплайна (letterbox).
        surfaceContainer = AspectRatioFrameLayout(this).apply {
            addView(
                surfaceView,
                FrameLayout.LayoutParams(
                    FrameLayout.LayoutParams.MATCH_PARENT,
                    FrameLayout.LayoutParams.MATCH_PARENT,
                ),
            )
        }
        container.addView(
            surfaceContainer,
            FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT,
                Gravity.CENTER,
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

        qualityButton = ImageButton(this).apply {
            setImageResource(android.R.drawable.ic_menu_preferences)
            setColorFilter(Color.WHITE)
            scaleType = android.widget.ImageView.ScaleType.FIT_CENTER
            val iconPadding = (resources.displayMetrics.density * 8).toInt()
            setPadding(iconPadding, iconPadding, iconPadding, iconPadding)
            background = GradientDrawable().apply {
                shape = GradientDrawable.OVAL
                setColor(Color.argb(115, 0, 0, 0))
            }
            setOnClickListener { onQualityButtonClicked() }
        }
        val qualityButtonSize = (resources.displayMetrics.density * 40).toInt()
        val qualityParams = FrameLayout.LayoutParams(qualityButtonSize, qualityButtonSize).apply {
            gravity = Gravity.TOP or Gravity.START
            val margin = (resources.displayMetrics.density * 16).toInt()
            setMargins(margin, margin, margin, margin)
        }
        container.addView(qualityButton, qualityParams)

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
        // Колонка снизу по центру: переключатель объектива (если есть ultra-wide)
        // над рядом основных кнопок.
        val bottomColumn = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER_HORIZONTAL
        }
        if (cameraSelector?.hasUltraWide == true) {
            val uwLabel = cameraSelector?.ultraWideZoomRatio
                ?.let { String.format(Locale.US, "%.1f×", it) }
                ?: "0.5×"
            val switcher = SegmentedPillView(this, listOf(uwLabel, "1×"), initialIndex = 1).apply {
                onSegmentSelected = { index -> switchLens(toUltraWide = index == 0) }
            }
            lensSwitcher = switcher
            bottomColumn.addView(
                switcher,
                LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.WRAP_CONTENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT,
                ).apply { bottomMargin = (resources.displayMetrics.density * 14).toInt() },
            )
        }
        bottomColumn.addView(
            buttonsRow,
            LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT,
            ),
        )
        val rowParams = FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.WRAP_CONTENT,
            FrameLayout.LayoutParams.WRAP_CONTENT,
        ).apply {
            gravity = Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL
            val margin = (resources.displayMetrics.density * 24).toInt()
            setMargins(margin, margin, margin, margin)
        }
        container.addView(bottomColumn, rowParams)

        setContentView(container)

        if (!hasAllPermissions() || !hasNotificationsPermission()) {
            requestPermissions(requestedPermissions(), REQUEST_PERMISSIONS)
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

        // Отказ в POST_NOTIFICATIONS экран не закрывает — проверяем только обязательные.
        val required = requiredPermissions().toSet()
        val requiredDenied = grantResults.isEmpty() || permissions.indices.any { i ->
            permissions[i] in required && grantResults[i] != PackageManager.PERMISSION_GRANTED
        }
        if (requiredDenied) {
            finishWithResult(RESULT_PERMISSIONS_DENIED)
        } else if (hasSurface && cameraDevice == null) {
            openCamera()
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

    private fun hasAllPermissions(): Boolean = requiredPermissions().all {
        checkSelfPermission(it) == PackageManager.PERMISSION_GRANTED
    }

    private fun hasNotificationsPermission(): Boolean =
        Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU ||
            checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED

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
            val selector = cameraSelector ?: CameraSelector(manager).also { cameraSelector = it }
            val cameraId = (if (useUltraWide) selector.ultraWideCameraId else null)
                ?: selector.defaultBackCameraId
                ?: run {
                    Log.e(TAG, "Подходящая камера не найдена")
                    finishWithResult(Activity.RESULT_CANCELED)
                    return
                }

            val characteristics = manager.getCameraCharacteristics(cameraId)
            sensorOrientation = characteristics.get(CameraCharacteristics.SENSOR_ORIENTATION) ?: 0
            val map = characteristics.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP)
            val chosen = map?.getOutputSizes(SurfaceHolder::class.java)
                ?.let { chooseSizeFor(quality.resolution, it) }
                ?: Size(quality.resolution.width, quality.resolution.height)
            previewSize = chosen
            surfaceView.holder.setFixedSize(chosen.width, chosen.height)
            // Activity заблокирована в landscape, и Compositor рисует FBO в этих же
            // dimensions — значит aspect ratio превью совпадает с chosen.width/height.
            surfaceContainer.setAspectRatio(chosen.width, chosen.height)

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

    /**
     * Смена объектива «на лету»: закрываем только CameraDevice и capture session,
     * Compositor с подключёнными выходами (preview/recorder/stream encoder) живёт
     * дальше — поэтому переключение доступно и во время записи/стрима. Целевая
     * камера обязана поддерживать текущий размер кадра: Compositor фиксирован.
     */
    private fun switchLens(toUltraWide: Boolean) {
        if (isLensSwitching || toUltraWide == useUltraWide) return
        val selector = cameraSelector ?: return
        if (selector.ultraWideCameraId == null) {
            switchLensByZoomRatio(toUltraWide, selector.ultraWideZoomRatio ?: return)
            return
        }
        val targetId = (if (toUltraWide) selector.ultraWideCameraId else selector.defaultBackCameraId)
            ?: return
        if (compositor == null || cameraDevice == null) {
            // Камера ещё не поднята — openCamera применит выбор сам.
            useUltraWide = toUltraWide
            return
        }
        val size = previewSize
        if (size != null && !selector.supportsSize(targetId, size)) {
            lensSwitcher?.select(if (useUltraWide) 0 else 1)
            Toast.makeText(this, "Эта камера не поддерживает текущее качество", Toast.LENGTH_SHORT)
                .show()
            return
        }

        isLensSwitching = true
        val previousUltraWide = useUltraWide
        useUltraWide = toUltraWide
        lensSwitcher?.setInteractionEnabled(false)
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

        openCameraDeviceOnly(targetId) { success ->
            if (success) {
                finishLensSwitch()
                return@openCameraDeviceOnly
            }
            // Возвращаемся на прежний объектив, чтобы экран не остался без превью.
            useUltraWide = previousUltraWide
            lensSwitcher?.select(if (previousUltraWide) 0 else 1)
            val fallbackId =
                if (previousUltraWide) selector.ultraWideCameraId else selector.defaultBackCameraId
            if (fallbackId != null) {
                openCameraDeviceOnly(fallbackId) { finishLensSwitch() }
            } else {
                finishLensSwitch()
            }
        }
    }

    private fun finishLensSwitch() {
        isLensSwitching = false
        lensSwitcher?.setInteractionEnabled(true)
    }

    /**
     * Переключение объектива логической камеры через CONTROL_ZOOM_RATIO — путь для
     * устройств, прячущих ультраширокую как физическую камеру (Pixel и т.п.).
     * Меняется только repeating-запрос: без пересоздания устройства и сессии,
     * мгновенно и безопасно во время записи/стрима.
     */
    private fun switchLensByZoomRatio(toUltraWide: Boolean, uwRatio: Float) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) return
        if (compositor == null || cameraDevice == null) {
            useUltraWide = toUltraWide
            return
        }
        val session = captureSession
        val builder = captureRequestBuilder
        if (session == null || builder == null) {
            lensSwitcher?.select(if (useUltraWide) 0 else 1)
            return
        }
        try {
            builder.set(CaptureRequest.CONTROL_ZOOM_RATIO, if (toUltraWide) uwRatio else 1.0f)
            session.setRepeatingRequest(builder.build(), null, backgroundHandler)
            useUltraWide = toUltraWide
        } catch (e: Exception) {
            Log.e(TAG, "switchLensByZoomRatio failed", e)
            lensSwitcher?.select(if (useUltraWide) 0 else 1)
        }
    }

    /** Открывает камеру [cameraId] на живой Compositor, не пересоздавая пайплайн. */
    @SuppressLint("MissingPermission")
    private fun openCameraDeviceOnly(cameraId: String, onResult: (Boolean) -> Unit) {
        val manager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        try {
            manager.openCamera(
                cameraId,
                object : CameraDevice.StateCallback() {
                    override fun onOpened(device: CameraDevice) {
                        cameraDevice = device
                        startSingleCaptureSession()
                        mainHandler.post { onResult(true) }
                    }

                    override fun onDisconnected(device: CameraDevice) {
                        device.close()
                        cameraDevice = null
                        mainHandler.post { onResult(false) }
                    }

                    override fun onError(device: CameraDevice, error: Int) {
                        Log.e(TAG, "openCameraDeviceOnly onError: $error")
                        device.close()
                        cameraDevice = null
                        mainHandler.post { onResult(false) }
                    }
                },
                backgroundHandler,
            )
        } catch (e: Exception) {
            Log.e(TAG, "openCameraDeviceOnly failed", e)
            mainHandler.post { onResult(false) }
        }
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
        val uwRatio = cameraSelector?.ultraWideZoomRatio
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R && uwRatio != null) {
            builder.set(CaptureRequest.CONTROL_ZOOM_RATIO, if (useUltraWide) uwRatio else 1.0f)
        }
        captureRequestBuilder = builder
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
        captureRequestBuilder = null

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
     * Подключает overlay-вёрстку и/или brand-картинку к [comp]. Поднимается если
     * задан [overlayViewType] ИЛИ [brandImageUrl] — иначе overlay-слой не нужен.
     * Compose-контейнер живёт всю жизнь Compositor'а, поэтому виден в preview,
     * recording и стриме.
     */
    private fun attachOverlayIfNeeded(comp: Compositor, width: Int, height: Int) {
        val viewType = overlayViewType
        val brandUrl = brandImageUrl
        if (viewType == null && brandUrl.isNullOrBlank()) return
        Log.d(TAG, "attachOverlay: viewType=$viewType brand=$brandUrl frame=${width}x$height")
        val renderer = OverlayViewRenderer(width, height)
        val params = OverlayParams(
            tournamentId = overlayTournamentId,
            clubId = overlayClubId,
            table = overlayTable,
            phaseGate = phaseGate,
            breakPlaceholderImageUrl = breakPlaceholderImageUrl,
            brandImageUrl = brandUrl,
        )
        val view = OverlayCatalog.create(viewType, this, renderer, params)
        if (view == null) {
            Log.w(TAG, "Overlay '$viewType' not found in catalog and no brand image — running without overlay")
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

    // --- Качество трансляции ---

    /**
     * Качество меняется только в простое: смена разрешения пересоздаёт пайплайн,
     * а битрейт применяется при старте стрима.
     */
    private val isQualityLocked: Boolean get() = isRecording || isStreaming

    private fun updateQualityButtonState() {
        val locked = isQualityLocked
        qualityButton.setImageResource(
            if (locked) android.R.drawable.ic_lock_lock else android.R.drawable.ic_menu_preferences,
        )
        qualityButton.alpha = if (locked) 0.2f else 1f
    }

    private fun onQualityButtonClicked() {
        if (isQualityLocked) {
            Toast.makeText(
                this,
                "Качество можно менять только до начала трансляции",
                Toast.LENGTH_SHORT,
            ).show()
            return
        }
        openQualityPanel()
    }

    private fun openQualityPanel() {
        if (qualityPanel != null) return
        val scrim = View(this).apply {
            setBackgroundColor(Color.argb(97, 0, 0, 0))
            alpha = 0f
            setOnClickListener { closeQualityPanel() }
        }
        rootContainer.addView(
            scrim,
            FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT,
                FrameLayout.LayoutParams.MATCH_PARENT,
            ),
        )

        val panel = QualitySettingsPanel(this, quality).apply {
            onQualityChanged = { applyQuality(it) }
            onCloseRequested = { closeQualityPanel() }
        }
        val panelWidth = maxOf(
            (resources.displayMetrics.density * 300).toInt(),
            (resources.displayMetrics.widthPixels * 0.4f).toInt(),
        )
        rootContainer.addView(
            panel,
            FrameLayout.LayoutParams(panelWidth, FrameLayout.LayoutParams.MATCH_PARENT, Gravity.START),
        )
        panel.translationX = -panelWidth.toFloat()

        qualityScrim = scrim
        qualityPanel = panel
        scrim.animate().alpha(1f).setDuration(240).start()
        panel.animate().translationX(0f).setDuration(240).start()
    }

    private fun closeQualityPanel() {
        val panel = qualityPanel ?: return
        val scrim = qualityScrim
        qualityPanel = null
        qualityScrim = null
        scrim?.animate()?.alpha(0f)?.setDuration(220)
            ?.withEndAction { rootContainer.removeView(scrim) }?.start()
        panel.animate().translationX(-panel.width.toFloat()).setDuration(220)
            .withEndAction { rootContainer.removeView(panel) }.start()
    }

    private fun applyQuality(newQuality: StreamQuality) {
        val previousResolution = quality.resolution
        quality = newQuality
        StreamQualityStore.save(this, newQuality)
        if (newQuality.resolution != previousResolution && !isQualityLocked) {
            // Новый размер кадра — полное пересоздание пайплайна, только в простое.
            closeCamera()
            if (hasSurface && hasAllPermissions()) {
                openCamera()
            }
        }
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

        recordingSessionId = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date())
        segmentIndex = 1

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            startRecordingMediaStore(size, comp, isRollover = false)
        } else {
            startRecordingFile(size, comp, isRollover = false)
        }
        if (isRecording) {
            storageWarningReported = false
            checkStorageAndMaybeStop()
        }
    }

    /**
     * Общий сброс состояния, когда старт записи или очередного сегмента не удался.
     * При провале ролловера запись фактически прекращается — возвращаем кнопку в
     * исходное состояние и гасим таймер, иначе пользователь видит «Стоп» на экране,
     * где ничего не пишется.
     */
    private fun abortRecordingStart(isRollover: Boolean, message: String) {
        isTransitioning = false
        recordButton.isEnabled = true
        if (isRollover) {
            cancelSegmentTimer()
            cancelStorageCheck()
            isRecording = false
            recordButton.text = "Запись"
        }
        updateQualityButtonState()
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }

    /** Запускает запись напрямую в MediaStore через FileDescriptor. Только API 29+. */
    private fun startRecordingMediaStore(size: Size, comp: Compositor, isRollover: Boolean) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) return
        val name = buildSegmentName()
        val values = ContentValues().apply {
            put(MediaStore.Video.Media.DISPLAY_NAME, name)
            put(MediaStore.Video.Media.MIME_TYPE, "video/mp4")
            put(MediaStore.Video.Media.RELATIVE_PATH, Environment.DIRECTORY_MOVIES)
            put(MediaStore.Video.Media.IS_PENDING, 1)
        }
        val uri = contentResolver.insert(MediaStore.Video.Media.EXTERNAL_CONTENT_URI, values)
        if (uri == null) {
            Log.e(TAG, "startRecordingMediaStore: failed to create MediaStore entry")
            abortRecordingStart(isRollover, "Не удалось создать запись в галерее")
            return
        }
        val pfd = try {
            contentResolver.openFileDescriptor(uri, "w")
        } catch (e: Exception) {
            Log.e(TAG, "startRecordingMediaStore: failed to open FD", e)
            contentResolver.delete(uri, null, null)
            abortRecordingStart(isRollover, "Не удалось открыть файл галереи")
            return
        }
        if (pfd == null) {
            contentResolver.delete(uri, null, null)
            abortRecordingStart(isRollover, "Не удалось открыть файл галереи")
            return
        }

        activeMediaStoreUri = uri
        activeMediaStorePfd = pfd

        val recorder = Mp4Recorder(audioPipeline)
        try {
            @Suppress("NewApi")
            recorder.start(size.width, size.height, pfd.fileDescriptor)
        } catch (e: Exception) {
            Log.e(TAG, "Mp4Recorder.start (FD) failed", e)
            pfd.close()
            contentResolver.delete(uri, null, null)
            activeMediaStoreUri = null
            activeMediaStorePfd = null
            abortRecordingStart(isRollover, "Не удалось начать запись: ${e.message}")
            return
        }
        val encoderSurface = recorder.videoInputSurface
        if (encoderSurface == null) {
            Log.e(TAG, "startRecordingMediaStore: encoder surface is null")
            recorder.stop()
            pfd.close()
            contentResolver.delete(uri, null, null)
            activeMediaStoreUri = null
            activeMediaStorePfd = null
            abortRecordingStart(isRollover, "Не удалось начать запись")
            return
        }
        mp4Recorder = recorder
        // Capture session не трогаем — добавляем encoder как новый output Compositor'а.
        comp.attachOutput(Compositor.OutputId.RECORD_ENCODER, encoderSurface, needsPresentationTime = true)
        isRecording = true
        isTransitioning = false
        updateQualityButtonState()
        if (!isRollover) {
            recordButton.text = "Стоп"
            recordButton.isEnabled = true
        }
        scheduleNextSegment()
    }

    /** Запускает запись в файл во временное хранилище. Для API < 29. */
    private fun startRecordingFile(size: Size, comp: Compositor, isRollover: Boolean) {
        val recorder = Mp4Recorder(audioPipeline)
        try {
            val dir = getExternalFilesDir(Environment.DIRECTORY_MOVIES) ?: filesDir
            if (!dir.exists()) dir.mkdirs()
            recorder.start(size.width, size.height, File(dir, buildSegmentName()))
        } catch (e: Exception) {
            Log.e(TAG, "Mp4Recorder.start failed", e)
            recorder.stop()
            abortRecordingStart(isRollover, "Не удалось начать запись: ${e.message}")
            return
        }
        val encoderSurface = recorder.videoInputSurface
        if (encoderSurface == null) {
            Log.e(TAG, "startRecordingFile: encoder surface is null")
            recorder.stop()
            abortRecordingStart(isRollover, "Не удалось начать запись")
            return
        }
        mp4Recorder = recorder
        comp.attachOutput(Compositor.OutputId.RECORD_ENCODER, encoderSurface, needsPresentationTime = true)
        isRecording = true
        isTransitioning = false
        updateQualityButtonState()
        if (!isRollover) {
            recordButton.text = "Стоп"
            recordButton.isEnabled = true
        }
        scheduleNextSegment()
    }

    private fun buildSegmentName(): String = if (segmentDurationMs > 0) {
        "mafbase_stream_${recordingSessionId}_part${segmentIndex}.mp4"
    } else {
        "mafbase_stream_${recordingSessionId}.mp4"
    }

    private fun scheduleNextSegment() {
        if (segmentDurationMs <= 0) return
        val runnable = Runnable { rolloverSegment() }
        segmentTimerRunnable = runnable
        mainHandler.postDelayed(runnable, segmentDurationMs)
    }

    private fun cancelSegmentTimer() {
        segmentTimerRunnable?.let { mainHandler.removeCallbacks(it) }
        segmentTimerRunnable = null
    }

    private fun recordingStorageDir(): File = getExternalFilesDir(Environment.DIRECTORY_MOVIES) ?: filesDir

    /**
     * Проверяет свободное место и сама себя переставляет каждые [STORAGE_CHECK_INTERVAL_MS],
     * пока запись активна. Не блокирует запись: при нехватке места на ~8ч (см. [StorageMonitor])
     * только предупреждает тостом и событием [StreamEventBus.emitStorageEvent] — предупреждение
     * показывается один раз, пока место не появится снова. При критическом остатке
     * (< [StorageMonitor.CRITICAL_FREE_BYTES]) останавливает текущую запись.
     */
    private fun checkStorageAndMaybeStop() {
        val totalBitrateBps = quality.bitrateBps + ESTIMATED_AUDIO_BITRATE_BPS
        val check = StorageMonitor.check(recordingStorageDir(), totalBitrateBps)
        if (check.isCritical) {
            Log.w(TAG, "Свободного места критически мало (${check.freeBytes} байт) — останавливаем запись")
            StreamEventBus.emitStorageEvent(
                StreamEventBus.StorageEventType.Low,
                "low_free_space:freeBytes=${check.freeBytes}",
            )
            if (isRecording) {
                Toast.makeText(this, "Запись остановлена: на устройстве закончилось место", Toast.LENGTH_LONG).show()
                stopRecording()
            }
            return
        }
        if (check.isBelowTarget) {
            if (!storageWarningReported) {
                storageWarningReported = true
                Toast.makeText(
                    this,
                    "Мало места на устройстве: может не хватить на ${StorageMonitor.TARGET_RECORDING_HOURS}ч записи",
                    Toast.LENGTH_LONG,
                ).show()
            }
            StreamEventBus.emitStorageEvent(
                StreamEventBus.StorageEventType.Warning,
                "insufficient_free_space:freeBytes=${check.freeBytes},requiredBytes=${check.requiredBytesForTarget}",
            )
        } else {
            storageWarningReported = false
        }
        scheduleStorageCheck()
    }

    private fun scheduleStorageCheck() {
        val runnable = Runnable { checkStorageAndMaybeStop() }
        storageCheckRunnable = runnable
        mainHandler.postDelayed(runnable, STORAGE_CHECK_INTERVAL_MS)
    }

    private fun cancelStorageCheck() {
        storageCheckRunnable?.let { mainHandler.removeCallbacks(it) }
        storageCheckRunnable = null
        storageWarningReported = false
    }

    /** Автоматически завершает текущий сегмент и сразу начинает следующий. */
    private fun rolloverSegment() {
        if (!isRecording || isTransitioning) return
        val recorder = mp4Recorder ?: return
        val size = previewSize ?: return
        val comp = compositor ?: return

        isTransitioning = true
        comp.detachOutput(Compositor.OutputId.RECORD_ENCODER)
        mp4Recorder = null
        segmentIndex++

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val oldUri = activeMediaStoreUri
            val oldPfd = activeMediaStorePfd
            activeMediaStoreUri = null
            activeMediaStorePfd = null
            SaveToGalleryService.beginKeepAlive(this)
            Thread({
                try {
                    finalizeMediaStoreEntry(oldUri, oldPfd, stopRecorder(recorder))
                } finally {
                    SaveToGalleryService.endKeepAlive(applicationContext)
                }
                mainHandler.post { continueSegmentation(size, comp) }
            }, "Mp4Segment-rollover").start()
        } else {
            SaveToGalleryService.beginKeepAlive(this)
            Thread({
                val file = stopRecorderToFile(recorder)
                if (file != null) {
                    SaveToGalleryService.enqueueCopy(applicationContext, file, showToast = false)
                }
                SaveToGalleryService.endKeepAlive(applicationContext)
                mainHandler.post { continueSegmentation(size, comp) }
            }, "Mp4Segment-rollover").start()
        }
    }

    /**
     * Начинает следующий сегмент после финализации предыдущего. Пока сегмент дописывался,
     * запись могли остановить — в том числе из onPause, который успел освободить compositor.
     * Тогда новый сегмент начинать нельзя: он повиснет на мёртвом пайплайне и будет
     * бесконечно перезаводить таймер уже на приостановленном экране.
     */
    private fun continueSegmentation(size: Size, comp: Compositor) {
        isTransitioning = false
        if (!isRecording || compositor !== comp) return
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            startRecordingMediaStore(size, comp, isRollover = true)
        } else {
            startRecordingFile(size, comp, isRollover = true)
        }
    }

    /** Останавливает рекордер, возвращая признак того, что стоп не бросил исключение. */
    private fun stopRecorder(recorder: Mp4Recorder): Boolean = try {
        recorder.stop()
        true
    } catch (e: Exception) {
        Log.e(TAG, "Mp4Recorder.stop failed", e)
        false
    }

    /** Вариант для файловой записи: возвращает файл, только если в нём есть данные. */
    private fun stopRecorderToFile(recorder: Mp4Recorder): File? {
        val file = try {
            recorder.stop()
        } catch (e: Exception) {
            Log.e(TAG, "Mp4Recorder.stop failed", e)
            null
        }
        return file?.takeIf { it.exists() && it.length() > 0 }
    }

    /**
     * Закрывает дескриптор и снимает IS_PENDING, делая запись видимой в галерее.
     *
     * Одного лишь [stopOk] мало: Mp4Recorder.stop() гасит ошибки муксера внутри себя и
     * почти никогда не бросает, поэтому пустая или нефинализированная запись иначе уехала
     * бы в галерею как валидная. Настоящий признак — сколько байт реально записано.
     */
    private fun finalizeMediaStoreEntry(uri: Uri?, pfd: ParcelFileDescriptor?, stopOk: Boolean): Boolean {
        val written = try { pfd?.statSize ?: -1L } catch (e: Exception) { -1L }
        try { pfd?.close() } catch (e: Exception) { Log.w(TAG, "pfd close failed", e) }
        val ok = stopOk && written > 0
        if (uri == null) return ok
        return try {
            if (ok) {
                val values = ContentValues().apply { put(MediaStore.Video.Media.IS_PENDING, 0) }
                contentResolver.update(uri, values, null, null)
            } else {
                contentResolver.delete(uri, null, null)
            }
            ok
        } catch (e: Exception) {
            Log.e(TAG, "не удалось финализировать запись в галерее", e)
            false
        }
    }

    private fun stopRecording() {
        // Состояние сбрасываем до раннего выхода: если прямо сейчас идёт ролловер,
        // mp4Recorder уже null, и отложенный старт следующего сегмента должен увидеть,
        // что запись прекращена.
        cancelSegmentTimer()
        cancelStorageCheck()
        val recorder = mp4Recorder
        mp4Recorder = null
        isRecording = false
        updateQualityButtonState()
        if (recorder == null) {
            recordButton.text = "Запись"
            return
        }
        isTransitioning = true
        recordButton.isEnabled = false

        // Сначала отцепляем encoder Surface от Compositor'а ДО recorder.stop() —
        // иначе Compositor продолжит eglSwapBuffers на разрушенный BufferQueue.
        compositor?.detachOutput(Compositor.OutputId.RECORD_ENCODER)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val uri = activeMediaStoreUri
            val pfd = activeMediaStorePfd
            activeMediaStoreUri = null
            activeMediaStorePfd = null
            SaveToGalleryService.beginKeepAlive(this)
            Thread({
                val ok = try {
                    finalizeMediaStoreEntry(uri, pfd, stopRecorder(recorder))
                } finally {
                    SaveToGalleryService.endKeepAlive(applicationContext)
                }
                mainHandler.post {
                    recordButton.text = "Запись"
                    isTransitioning = false
                    recordButton.isEnabled = true
                    val message = if (ok) "Запись сохранена в галерею" else "Не удалось сохранить запись"
                    Toast.makeText(this@StreamActivity, message, Toast.LENGTH_SHORT).show()
                }
            }, "Mp4Recorder-stop").start()
        } else {
            Thread({
                val file = stopRecorderToFile(recorder)
                mainHandler.post {
                    recordButton.text = "Запись"
                    isTransitioning = false
                    recordButton.isEnabled = true
                    if (file != null) {
                        // Копирование в галерею идёт в foreground service — переживает
                        // сворачивание и закрытие приложения; тост показывает сервис.
                        SaveToGalleryService.enqueueCopy(this@StreamActivity, file, showToast = true)
                    } else {
                        Toast.makeText(this@StreamActivity, "Запись пуста", Toast.LENGTH_SHORT).show()
                    }
                }
            }, "Mp4Recorder-stop").start()
        }
    }

    /**
     * Вариант для onPause/закрытия: сохраняет запись в галерею без UI.
     *
     * Приложение в этот момент уходит в фон, а финализация занимает секунды (запись
     * moov-атома) — без foreground-приоритета процесс успевают заморозить или убить,
     * и запись не доезжает до галереи. Поэтому на обеих ветках держим сервис.
     */
    private fun stopRecordingSync() {
        cancelSegmentTimer()
        cancelStorageCheck()
        val recorder = mp4Recorder
        mp4Recorder = null
        isRecording = false
        updateQualityButtonState()
        recordButton.text = "Запись"
        if (recorder == null) return
        compositor?.detachOutput(Compositor.OutputId.RECORD_ENCODER)

        SaveToGalleryService.beginKeepAlive(this)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val uri = activeMediaStoreUri
            val pfd = activeMediaStorePfd
            activeMediaStoreUri = null
            activeMediaStorePfd = null
            Thread({
                try {
                    finalizeMediaStoreEntry(uri, pfd, stopRecorder(recorder))
                } finally {
                    SaveToGalleryService.endKeepAlive(applicationContext)
                }
            }, "Mp4Recorder-stop-sync").start()
        } else {
            Thread({
                val file = stopRecorderToFile(recorder)
                if (file != null) {
                    SaveToGalleryService.enqueueCopy(applicationContext, file, showToast = false)
                }
                SaveToGalleryService.endKeepAlive(applicationContext)
            }, "Mp4Recorder-stop-sync").start()
        }
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
                videoBitrate = quality.bitrateBps,
            ),
            audioPipeline = audioPipeline,
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

            override fun onStreamEvent(event: StreamSessionNative.StreamEvent) {
                StreamEventBus.emit(event)
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
                updateQualityButtonState()
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
                updateQualityButtonState()
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
        updateQualityButtonState()
        setStreamButtonLabel("Стрим")
        setStreamButtonLoading(false)
    }

}
