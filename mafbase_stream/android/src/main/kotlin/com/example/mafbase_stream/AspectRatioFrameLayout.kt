package com.example.mafbase_stream

import android.content.Context
import android.widget.FrameLayout

/**
 * FrameLayout, который при `setAspectRatio(w, h)` уменьшает свои measured-размеры
 * до прямоугольника c заданным aspect ratio, вписанного в родительские bounds.
 *
 * Используется для preview SurfaceView: чтобы кадр пайплайна не растягивался на
 * весь экран теряя ratio, а отображался как letterbox с чёрными полями по краям.
 */
internal class AspectRatioFrameLayout(context: Context) : FrameLayout(context) {

    // width / height; 0 — режим обычного FrameLayout (без коррекции).
    private var aspectRatio: Float = 0f

    fun setAspectRatio(width: Int, height: Int) {
        val ratio = if (height <= 0) 0f else width.toFloat() / height.toFloat()
        if (ratio == aspectRatio) return
        aspectRatio = ratio
        requestLayout()
    }

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        if (aspectRatio <= 0f) {
            super.onMeasure(widthMeasureSpec, heightMeasureSpec)
            return
        }
        val parentWidth = MeasureSpec.getSize(widthMeasureSpec)
        val parentHeight = MeasureSpec.getSize(heightMeasureSpec)
        if (parentWidth <= 0 || parentHeight <= 0) {
            super.onMeasure(widthMeasureSpec, heightMeasureSpec)
            return
        }
        val parentRatio = parentWidth.toFloat() / parentHeight.toFloat()
        val (w, h) = if (parentRatio > aspectRatio) {
            // Контейнер шире цели → ограничиваем по высоте.
            ((parentHeight * aspectRatio).toInt()) to parentHeight
        } else {
            // Контейнер уже цели → ограничиваем по ширине.
            parentWidth to ((parentWidth / aspectRatio).toInt())
        }
        super.onMeasure(
            MeasureSpec.makeMeasureSpec(w, MeasureSpec.EXACTLY),
            MeasureSpec.makeMeasureSpec(h, MeasureSpec.EXACTLY),
        )
    }
}
