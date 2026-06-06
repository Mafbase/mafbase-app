import Foundation

/// Параметры, которые хост передаёт overlay-вёрстке через [OverlayCatalog].
///
/// Каждый overlay сам решает, какие поля он использует. Поля nullable, потому что
/// не все overlay'и требуют контекста турнира (например, простые статичные плашки).
///
/// [phaseGate] — общий со StreamSession флаг mute'а. Overlay'и, читающие
/// `broadcastPhase` из сокета, выставляют его в `true` для всех фаз кроме `day`.
///
/// [breakPlaceholderImageUrl] — URL картинки-заглушки, которая показывается
/// поверх кадра при `broadcastPhase == break_phase`. Если nil — overlay рисует
/// только свою обычную вёрстку без замены кадра.
struct OverlayParams {
    let tournamentId: Int?
    let table: Int?
    let phaseGate: PhaseGate?
    let breakPlaceholderImageUrl: String?

    init(
        tournamentId: Int? = nil,
        table: Int? = nil,
        phaseGate: PhaseGate? = nil,
        breakPlaceholderImageUrl: String? = nil
    ) {
        self.tournamentId = tournamentId
        self.table = table
        self.phaseGate = phaseGate
        self.breakPlaceholderImageUrl = breakPlaceholderImageUrl
    }
}
