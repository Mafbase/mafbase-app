package com.example.mafbase_stream.overlay

/**
 * Колбэк, который overlay-view дёргает, когда содержимое изменилось и нужно
 * пересобрать GL-текстуру оверлея.
 *
 * Для статичных оверлеев — вызывается при явных изменениях. Для анимированных —
 * view сама подписывается на vsync (`View.postInvalidateOnAnimation`,
 * `Choreographer.postFrameCallback`) и вызывает [invalidate] в каждом tick.
 */
fun interface OverlayInvalidator {
    fun invalidate()
}
