package com.example.mafbase_stream.overlay

/**
 * Опциональный интерфейс для overlay-view: если view его реализует, плагин
 * показывает в стрим/preview-экране дополнительную нативную кнопку «Toggle overlay»,
 * которая дёргает [onDebugToggle].
 *
 * Используется в example для проверки invalidate-цикла без поднятия отдельного UI.
 * Кнопка отрисовывается поверх preview-экрана и не попадает в видеопоток.
 */
interface OverlayDebugTarget {
    fun onDebugToggle()
}
