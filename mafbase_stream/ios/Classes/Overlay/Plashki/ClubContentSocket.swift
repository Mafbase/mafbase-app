import Foundation

/// Подписка на clubSeatingContent через WebSocket. Кодовый аналог Kotlin-класса
/// `ClubContentSocket.kt` (см. android/.../data/sockets/) и Dart-класса
/// `ClubContentSocket` (см. lib/data/sockets/club_content_socket.dart).
/// Вся механика соединения — в базовом [SeatingContentSocket].
final class ClubContentSocket: SeatingContentSocket {

    init(clubId: Int, table: Int) {
        var components = URLComponents(string: "wss://mafbase.ru/api/clubSeatingContent")!
        components.queryItems = [
            URLQueryItem(name: "table", value: String(table)),
            URLQueryItem(name: "clubId", value: String(clubId)),
        ]
        super.init(url: components.url!, logTag: "ClubSocket")
    }

    /// У клуба нет нумерации игр, поэтому в `ClubSeatingContent` фаза и звук стоят
    /// на полях 5 и 6 вместо 7 и 8 — разбор как `SeatingContent` молча терял фазу.
    override func decode(_ data: Data) throws -> Generated_SeatingContent {
        let club = try Generated_ClubSeatingContent(serializedBytes: data)
        var content = Generated_SeatingContent()
        content.roles = club.roles
        content.status = club.status
        content.images = club.images
        content.names = club.names
        content.broadcastPhase = club.broadcastPhase
        content.soundEnabled = club.soundEnabled
        return content
    }
}
