package com.example.mafbase_stream.overlay

import com.example.mafbase_stream.PhaseGate

/**
 * Параметры, которые хост передаёт overlay-вёрстке через [OverlayCatalog].
 *
 * Каждый overlay сам решает, какие поля он использует. Поля nullable, потому что
 * не все overlay'и требуют контекста турнира (например, простые статичные плашки).
 *
 * [phaseGate] — общий со StreamSession флаг mute'а. Overlay'и, читающие
 * `broadcastPhase` из сокета (например, плашки mafbase), выставляют его в
 * `true` для всех фаз кроме `day`.
 *
 * [breakPlaceholderImageUrl] — URL картинки-заглушки, которая показывается
 * поверх кадра при `broadcastPhase == break_phase`. Если null — overlay рисует
 * только свою обычную вёрстку без замены кадра.
 */
internal data class OverlayParams(
    val tournamentId: Int? = null,
    val table: Int? = null,
    val phaseGate: PhaseGate? = null,
    val breakPlaceholderImageUrl: String? = null,
)
