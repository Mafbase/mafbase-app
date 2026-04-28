package com.example.mafbase_stream

import android.app.Activity
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.os.Bundle
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.FrameLayout
import com.example.mafbase_stream.overlay.OverlayCatalog
import com.example.mafbase_stream.overlay.OverlayDebugTarget
import com.example.mafbase_stream.overlay.OverlayInvalidator
import com.example.mafbase_stream.overlay.OverlayParams

/**
 * Полноэкранный экран превью overlay-view без камеры и стрима. Нужен для
 * отладки вёрстки overlay-view: можно итерировать вёрстку, не поднимая RTMP.
 *
 * Серый фон + смонтированная overlay-view в реальном размере кадра пайплайна
 * (1280×720). Если view реализует [OverlayDebugTarget], показывается кнопка
 * «Toggle overlay» — она дёргает [OverlayDebugTarget.onDebugToggle] для проверки
 * invalidate-цикла.
 */
class OverlayPreviewActivity : Activity() {

    private var overlayView: View? = null

    companion object {
        private const val TAG = "OverlayPreviewActivity"
        const val EXTRA_OVERLAY_VIEW_TYPE: String = "mafbase_stream.overlay_view_type"
        const val EXTRA_TOURNAMENT_ID: String = "mafbase_stream.tournament_id"
        const val EXTRA_TABLE: String = "mafbase_stream.table"

        // Размер кадра пайплайна — должен совпадать с тем, что использует Compositor
        // в реальном стриме, чтобы вёрстка отлаживалась под тот же canvas.
        private const val FRAME_WIDTH = 1920
        private const val FRAME_HEIGHT = 1080
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        window.decorView.systemUiVisibility = (
            View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN
                or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
        )

        val viewType = intent?.getStringExtra(EXTRA_OVERLAY_VIEW_TYPE)
        if (viewType.isNullOrEmpty()) {
            Log.w(TAG, "overlayViewType is empty, finishing")
            finish()
            return
        }

        val container = FrameLayout(this).apply {
            setBackgroundColor(Color.rgb(96, 96, 96))
        }

        // No-op invalidator — в preview-режиме нет GL-пайплайна, перерисовка идёт
        // штатной системой Android (postInvalidate / requestLayout). Мы только
        // соблюдаем контракт каталога: invalidator передаётся, view может его дёргать.
        val invalidator = OverlayInvalidator { /* no-op in preview mode */ }
        val tournamentId = if (intent.hasExtra(EXTRA_TOURNAMENT_ID)) intent.getIntExtra(EXTRA_TOURNAMENT_ID, 0) else null
        val table = if (intent.hasExtra(EXTRA_TABLE)) intent.getIntExtra(EXTRA_TABLE, 0) else null
        val params = OverlayParams(tournamentId = tournamentId, table = table)
        val view = OverlayCatalog.create(viewType, this, invalidator, params)
        if (view == null) {
            Log.w(TAG, "Overlay '$viewType' not found in catalog, finishing")
            finish()
            return
        }
        overlayView = view

        val viewParams = FrameLayout.LayoutParams(FRAME_WIDTH, FRAME_HEIGHT).apply {
            gravity = Gravity.CENTER
        }
        container.addView(view, viewParams)

        val closeButton = Button(this).apply {
            text = "Закрыть"
            setOnClickListener { finish() }
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

        if (view is OverlayDebugTarget) {
            val toggle = Button(this).apply {
                text = "Toggle overlay"
                setTextColor(Color.WHITE)
                background = GradientDrawable().apply {
                    shape = GradientDrawable.RECTANGLE
                    cornerRadius = resources.displayMetrics.density * 24
                    setColor(Color.argb(220, 60, 140, 220))
                }
                setOnClickListener { view.onDebugToggle() }
            }
            val toggleParams = FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT,
                FrameLayout.LayoutParams.WRAP_CONTENT,
            ).apply {
                gravity = Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL
                val margin = (resources.displayMetrics.density * 24).toInt()
                setMargins(margin, margin, margin, margin)
            }
            container.addView(toggle, toggleParams)
        }

        setContentView(container)
    }
}
