package com.example.mafbase_stream.overlay

/**
 * Параметры, которые хост передаёт overlay-вёрстке через [OverlayCatalog].
 *
 * Каждый overlay сам решает, какие поля он использует. Поля nullable, потому что
 * не все overlay'и требуют контекста турнира (например, простые статичные плашки).
 */
internal data class OverlayParams(
    val tournamentId: Int? = null,
    val table: Int? = null,
)
