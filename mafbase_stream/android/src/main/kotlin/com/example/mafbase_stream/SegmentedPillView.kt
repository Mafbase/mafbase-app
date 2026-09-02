package com.example.mafbase_stream

import android.animation.ValueAnimator
import android.content.Context
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.view.Gravity
import android.widget.LinearLayout
import android.widget.TextView

/**
 * Сегментированная pill-капсула в стиле кнопок экрана трансляции: полупрозрачный
 * чёрный фон, активный сегмент — белая подложка с тёмным текстом. Используется
 * переключателем объектива и панелью качества.
 */
internal class SegmentedPillView(
    context: Context,
    titles: List<String>,
    initialIndex: Int = 0,
) : LinearLayout(context) {

    var onSegmentSelected: ((Int) -> Unit)? = null

    var selectedIndex: Int = initialIndex
        private set

    private val segments = mutableListOf<TextView>()
    private val segmentBackgrounds = mutableListOf<GradientDrawable>()
    private val currentColors: IntArray

    init {
        orientation = HORIZONTAL
        background = GradientDrawable().apply {
            cornerRadius = dp(18).toFloat()
            setColor(Color.argb(115, 0, 0, 0))
        }
        val pad = dp(4)
        setPadding(pad, pad, pad, pad)

        titles.forEachIndexed { index, title ->
            val segmentBackground = GradientDrawable().apply {
                cornerRadius = dp(14).toFloat()
                setColor(Color.TRANSPARENT)
            }
            val segment = TextView(context).apply {
                text = title
                textSize = 14f
                gravity = Gravity.CENTER
                setPadding(dp(14), dp(5), dp(14), dp(5))
                minimumWidth = dp(48)
                background = segmentBackground
                setOnClickListener { select(index, fromUser = true) }
            }
            segments += segment
            segmentBackgrounds += segmentBackground
            addView(segment, LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.MATCH_PARENT))
        }
        currentColors = IntArray(segments.size) { Color.TRANSPARENT }
        applySelection(animated = false)
    }

    fun select(index: Int, fromUser: Boolean = false, animated: Boolean = true) {
        if (index == selectedIndex || index !in segments.indices) return
        selectedIndex = index
        applySelection(animated)
        if (fromUser) onSegmentSelected?.invoke(index)
    }

    /** Приглушает капсулу и блокирует тапы — на время реконфигурации камеры. */
    fun setInteractionEnabled(enabled: Boolean) {
        alpha = if (enabled) 1f else 0.6f
        segments.forEach { it.isClickable = enabled }
    }

    private fun applySelection(animated: Boolean) {
        segments.forEachIndexed { index, segment ->
            val selected = index == selectedIndex
            val target = if (selected) SELECTED_BACKGROUND else Color.TRANSPARENT
            val from = currentColors[index]
            currentColors[index] = target
            if (animated && from != target) {
                ValueAnimator.ofArgb(from, target).apply {
                    duration = 180
                    addUpdateListener { animator ->
                        segmentBackgrounds[index].setColor(animator.animatedValue as Int)
                    }
                    start()
                }
            } else {
                segmentBackgrounds[index].setColor(target)
            }
            segment.setTextColor(
                if (selected) Color.argb(217, 0, 0, 0) else Color.argb(153, 255, 255, 255),
            )
        }
    }

    private fun dp(value: Int): Int = (resources.displayMetrics.density * value).toInt()

    private companion object {
        val SELECTED_BACKGROUND = Color.argb(230, 255, 255, 255)
    }
}
