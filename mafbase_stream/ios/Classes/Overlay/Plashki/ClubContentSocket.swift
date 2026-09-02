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
}
