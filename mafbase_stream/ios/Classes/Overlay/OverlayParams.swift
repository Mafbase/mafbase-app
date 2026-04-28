import Foundation

/// Параметры, которые хост передаёт overlay-вёрстке через [OverlayCatalog].
///
/// Каждый overlay сам решает, какие поля он использует. Поля nullable, потому что
/// не все overlay'и требуют контекста турнира (например, простые статичные плашки).
struct OverlayParams {
    let tournamentId: Int?
    let table: Int?

    init(tournamentId: Int? = nil, table: Int? = nil) {
        self.tournamentId = tournamentId
        self.table = table
    }
}
