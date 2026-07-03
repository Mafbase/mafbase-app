import Foundation

/// Параметры, которые хост передаёт overlay-вёрстке через [OverlayCatalog].
///
/// Каждый overlay сам решает, какие поля он использует. Поля nullable, потому что
/// не все overlay'и требуют контекста турнира (например, простые статичные плашки).
///
/// [phaseGate] — общий со StreamSession флаг mute'а. Overlay'и, читающие
/// `broadcastPhase` из сокета, выставляют его в `true` для всех фаз кроме `day`.
///
/// [tournamentId] / [clubId] — взаимоисключающие источники данных. Если задан
/// [clubId] — overlay подписывается на `clubSeatingContent`; если задан
/// [tournamentId] — на `seatingContent`. [table] используется в обоих случаях.
///
/// [breakPlaceholderImageUrl] — URL картинки-заглушки, которая показывается
/// поверх кадра при `broadcastPhase == break_phase`. Если nil — overlay рисует
/// только свою обычную вёрстку без замены кадра.
///
/// [brandImageUrl] — URL брендированной PNG-картинки (обычно с прозрачным
/// фоном), которая постоянно накладывается под overlay-вёрсткой во всех
/// выходах. Рисуется OverlayCatalog'ом независимо от overlay-view, поэтому
/// работает даже если viewType не задан. На фазе перерыва перекрывается
/// break-заглушкой.
struct OverlayParams {
    let tournamentId: Int?
    let clubId: Int?
    let table: Int?
    let phaseGate: PhaseGate?
    let breakPlaceholderImageUrl: String?
    let brandImageUrl: String?

    init(
        tournamentId: Int? = nil,
        clubId: Int? = nil,
        table: Int? = nil,
        phaseGate: PhaseGate? = nil,
        breakPlaceholderImageUrl: String? = nil,
        brandImageUrl: String? = nil
    ) {
        self.tournamentId = tournamentId
        self.clubId = clubId
        self.table = table
        self.phaseGate = phaseGate
        self.breakPlaceholderImageUrl = breakPlaceholderImageUrl
        self.brandImageUrl = brandImageUrl
    }
}
