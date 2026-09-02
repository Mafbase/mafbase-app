import Foundation

/// Подписка на seatingContent через WebSocket. Кодовый аналог Kotlin-класса
/// `TournamentContentSocket.kt` (см. android/.../data/sockets/) и Dart-класса
/// `TournamentContentSocket` (см. lib/data/sockets/tournament_content_socket.dart).
/// Вся механика соединения — в базовом [SeatingContentSocket].
final class TournamentContentSocket: SeatingContentSocket {

    init(tournamentId: Int, table: Int) {
        var components = URLComponents(string: "wss://mafbase.ru/api/seatingContent")!
        components.queryItems = [
            URLQueryItem(name: "table", value: String(table)),
            URLQueryItem(name: "tournamentId", value: String(tournamentId)),
        ]
        super.init(url: components.url!, logTag: "TournamentSocket")
    }
}
