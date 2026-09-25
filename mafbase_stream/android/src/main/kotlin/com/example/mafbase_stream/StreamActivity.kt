package com.example.mafbase_stream

import android.Manifest
import android.app.Activity
import android.app.AlertDialog
import android.content.pm.PackageManager
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.Gravity
import android.view.SurfaceHolder
import android.view.SurfaceView
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.window.OnBackInvokedCallback
import android.window.OnBackInvokedDispatcher
import android.widget.FrameLayout
import android.widget.ImageButton
import android.widget.LinearLayout
import android.widget.ProgressBar
import android.widget.Toast
import com.example.mafbase_stream.pipeline.StreamPipeline
import com.example.mafbase_stream.service.StreamForegroundService
import java.util.Locale

/**
 * Полноэкранный нативный экран трансляции: превью камеры и кнопки поверх [StreamPipeline].
 *
 * Сам пайплайн (камера, запись MP4, RTMP-стрим) живёт в [StreamForegroundService] и
 * activity не принадлежит: onPause/onStop лишь отцепляют превью, уничтожение activity
 * при активном стриме или записи пайплайн не трогает, а новая activity присоединяется
 * к нему. Так всплывшее поверх окно (шторка Fast Pair, системный диалог) или сворачивание
 * приложения не обрывают трансляцию.
 *
 * Запускается из MafbaseStreamPlugin через startActivityForResult.
 * При нажатии «Закрыть» — возвращает RESULT_OK; при отказе в разрешениях — RESULT_PERMISSIONS_DENIED.
 */
class StreamActivity :
    Activity(),
    SurfaceHolder.Callback {

    private lateinit var pipeline: StreamPipeline
    private lateinit var rootContainer: FrameLayout
    private lateinit var surfaceView: SurfaceView
    private lateinit var surfaceContainer: AspectRatioFrameLayout
    private lateinit var recordButton: Button
    private lateinit var streamButton: Button
    private lateinit var streamProgress: ProgressBar
    private lateinit var qualityButton: ImageButton
    private var lensSwitcher: SegmentedPillView? = null
    private var overlayToggleButton: Button? = null
    private var qualityPanel: QualitySettingsPanel? = null
    private var qualityScrim: View? = null
    private var stopDialog: AlertDialog? = null
    private var backInvokedCallback: OnBackInvokedCallback? = null
    private var hasSurface: Boolean = false
    private var previewAttached: Boolean = false

    private val pipelineListener = object : StreamPipeline.Listener {
        override fun onStateChanged() = syncUiFromPipeline()

        override fun onFrameSizeChanged(width: Int, height: Int) = applyFrameSize(width, height)

        override fun onMessage(text: String, long: Boolean) {
            Toast.makeText(this@StreamActivity, text, if (long) Toast.LENGTH_LONG else Toast.LENGTH_SHORT).show()
        }

        override fun onFatalError(message: String) {
            finishWithResult(Activity.RESULT_CANCELED)
        }
    }

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

        private const val DEFAULT_RTMP_URL = "rtmp://10.0.2.2/live"
        private const val DEFAULT_STREAM_KEY = "test"

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
         * Уведомления показывают фоновую трансляцию и прогресс сохранения записи; без
         * разрешения они молча подавляются, но сама работа идёт — поэтому отказ не
         * блокирует экран.
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

        val existing = StreamForegroundService.pipeline
        pipeline = if (existing != null && existing.isActive) {
            // Одна трансляция на процесс: присоединяемся к живой, extras нового intent'а игнорируем.
            Log.i(TAG, "joining active pipeline")
            existing
        } else {
            existing?.release()
            StreamForegroundService.createPipeline(this, configFromIntent())
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
            setOnClickListener { onCloseRequested() }
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
            setOnClickListener { pipeline.toggleRecording() }
        }
        streamButton = Button(this).apply {
            text = "Стрим"
            setTextColor(Color.WHITE)
            background = GradientDrawable().apply {
                shape = GradientDrawable.RECTANGLE
                cornerRadius = resources.displayMetrics.density * 24
                setColor(Color.argb(220, 60, 140, 220))
            }
            setOnClickListener { pipeline.toggleStreaming() }
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
            setOnClickListener { pipeline.overlayDebugTarget?.onDebugToggle() }
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
        if (pipeline.hasUltraWide) {
            val uwLabel = pipeline.ultraWideZoomRatio
                ?.let { String.format(Locale.US, "%.1f×", it) }
                ?: "0.5×"
            val switcher = SegmentedPillView(
                this,
                listOf(uwLabel, "1×"),
                initialIndex = if (pipeline.useUltraWide) 0 else 1,
            ).apply {
                onSegmentSelected = { index -> pipeline.switchLens(toUltraWide = index == 0) }
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

        pipeline.setListener(pipelineListener)
        pipeline.setOverlayHost(this)
        syncUiFromPipeline()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            // С targetSdk 33+ predictive back включён по умолчанию: Activity регистрирует системный
            // колбэк, который сразу делает finish, а onBackPressed не вызывается. Свой колбэк с
            // PRIORITY_DEFAULT перекрывает его; Back внутри AlertDialog обрабатывает окно диалога.
            val callback = OnBackInvokedCallback { onCloseRequested() }
            onBackInvokedDispatcher.registerOnBackInvokedCallback(OnBackInvokedDispatcher.PRIORITY_DEFAULT, callback)
            backInvokedCallback = callback
        }

        if (!hasAllPermissions() || !hasNotificationsPermission()) {
            requestPermissions(requestedPermissions(), REQUEST_PERMISSIONS)
        }
    }

    private fun configFromIntent(): StreamPipeline.Config {
        val intent = intent
        val segmentMinutes = if (intent?.hasExtra(EXTRA_SEGMENT_DURATION_MINUTES) == true) {
            intent.getIntExtra(EXTRA_SEGMENT_DURATION_MINUTES, 0)
        } else {
            0
        }
        return StreamPipeline.Config(
            rtmpUrl = intent?.getStringExtra(EXTRA_RTMP_URL)?.takeIf { it.isNotBlank() } ?: DEFAULT_RTMP_URL,
            streamKey = intent?.getStringExtra(EXTRA_STREAM_KEY)?.takeIf { it.isNotBlank() } ?: DEFAULT_STREAM_KEY,
            overlayViewType = intent?.getStringExtra(EXTRA_OVERLAY_VIEW_TYPE)?.takeIf { it.isNotBlank() },
            overlayTournamentId = intent?.takeIf { it.hasExtra(EXTRA_TOURNAMENT_ID) }?.getIntExtra(EXTRA_TOURNAMENT_ID, 0),
            overlayClubId = intent?.takeIf { it.hasExtra(EXTRA_CLUB_ID) }?.getIntExtra(EXTRA_CLUB_ID, 0),
            overlayTable = intent?.takeIf { it.hasExtra(EXTRA_TABLE) }?.getIntExtra(EXTRA_TABLE, 0),
            breakPlaceholderImageUrl = intent?.getStringExtra(EXTRA_BREAK_PLACEHOLDER_URL)?.takeIf { it.isNotBlank() },
            brandImageUrl = intent?.getStringExtra(EXTRA_BRAND_IMAGE_URL)?.takeIf { it.isNotBlank() },
            // Android: по умолчанию сегментация выключена (segmentDurationMs = 0)
            segmentDurationMs = if (segmentMinutes > 0) segmentMinutes * 60_000L else 0L,
        )
    }

    override fun onResume() {
        super.onResume()
        attachPreviewIfNeeded()
        pipeline.syncService()
    }

    // onPause пайплайн намеренно не трогает: всплывшее поверх окно даёт только onPause,
    // и стрим с записью должны его пережить.

    override fun onStop() {
        detachPreviewIfNeeded()
        super.onStop()
    }

    override fun onDestroy() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            backInvokedCallback?.let { onBackInvokedDispatcher.unregisterOnBackInvokedCallback(it) }
            backInvokedCallback = null
        }
        stopDialog?.dismiss()
        stopDialog = null
        detachPreviewIfNeeded()
        pipeline.clearOverlayHost(this)
        pipeline.clearListener(pipelineListener)
        if (!pipeline.isActive) {
            pipeline.release()
        }
        super.onDestroy()
    }

    /** Путь системного Back для API < 33; на новых версиях работает [backInvokedCallback]. */
    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        onCloseRequested()
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
        } else {
            ensurePipelineStartedAndPreview()
        }
    }

    override fun surfaceCreated(holder: SurfaceHolder) {
        hasSurface = true
        ensurePipelineStartedAndPreview()
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
        detachPreviewIfNeeded()
    }

    private fun hasAllPermissions(): Boolean = requiredPermissions().all {
        checkSelfPermission(it) == PackageManager.PERMISSION_GRANTED
    }

    private fun hasNotificationsPermission(): Boolean =
        Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU ||
            checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED

    // --- Превью ---

    private fun ensurePipelineStartedAndPreview() {
        if (!hasSurface || !hasAllPermissions() || pipeline.isReleased) return
        if (!pipeline.isStarted) {
            pipeline.start()
        } else {
            pipeline.frameSize?.let { applyFrameSize(it.width, it.height) }
        }
        attachPreviewIfNeeded()
    }

    private fun applyFrameSize(width: Int, height: Int) {
        surfaceView.holder.setFixedSize(width, height)
        // Activity заблокирована в landscape, и Compositor рисует FBO в этих же
        // dimensions — значит aspect ratio превью совпадает с width/height.
        surfaceContainer.setAspectRatio(width, height)
    }

    private fun attachPreviewIfNeeded() {
        if (previewAttached || !hasSurface || !pipeline.isStarted || pipeline.isReleased) return
        pipeline.attachPreview(surfaceView.holder.surface)
        previewAttached = true
    }

    private fun detachPreviewIfNeeded() {
        if (!previewAttached) return
        previewAttached = false
        pipeline.detachPreview(surfaceView.holder.surface)
    }

    // --- Закрытие ---

    private fun onCloseRequested() {
        if (pipeline.isActive) {
            confirmStopAndClose()
        } else {
            finishWithResult(Activity.RESULT_OK)
        }
    }

    private fun confirmStopAndClose() {
        if (stopDialog != null) return
        stopDialog = AlertDialog.Builder(this, android.R.style.Theme_DeviceDefault_Dialog_Alert)
            .setMessage("Остановить трансляцию и запись?")
            .setPositiveButton("Остановить") { _, _ ->
                pipeline.release()
                finishWithResult(Activity.RESULT_OK)
            }
            .setNegativeButton("Отмена", null)
            .setOnDismissListener { stopDialog = null }
            .show()
    }

    private fun finishWithResult(resultCode: Int) {
        setResult(resultCode)
        finish()
    }

    // --- Состояние кнопок ---

    private fun syncUiFromPipeline() {
        val p = pipeline
        recordButton.text = if (p.isRecording) "Стоп" else "Запись"
        recordButton.isEnabled = !p.isRecordTransition
        streamButton.isEnabled = !p.isStreamTransition
        if (p.isStreamTransition) {
            streamButton.text = ""
            streamProgress.visibility = View.VISIBLE
        } else {
            streamProgress.visibility = View.GONE
            streamButton.text = if (p.isStreaming) "Стоп" else "Стрим"
        }
        val locked = p.isQualityLocked
        qualityButton.setImageResource(
            if (locked) android.R.drawable.ic_lock_lock else android.R.drawable.ic_menu_preferences,
        )
        qualityButton.alpha = if (locked) 0.2f else 1f
        lensSwitcher?.let {
            it.select(if (p.useUltraWide) 0 else 1)
            it.setInteractionEnabled(!p.isLensSwitching)
        }
        overlayToggleButton?.visibility = if (p.overlayDebugTarget != null) View.VISIBLE else View.GONE
    }

    // --- Качество трансляции ---

    private fun onQualityButtonClicked() {
        if (pipeline.isQualityLocked) {
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

        val panel = QualitySettingsPanel(this, pipeline.quality).apply {
            onQualityChanged = { pipeline.applyQuality(it) }
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
}
