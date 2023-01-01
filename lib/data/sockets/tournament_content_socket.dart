import 'package:seating_generator_web/data/base_socket.dart';

class TournamentContentSocket extends BaseSocket {
  TournamentContentSocket({required int tournamentId, required int table})
      : super(
          "ws://mafbase.ru/api/seatingContent?table=$table&tournamentId=$tournamentId",
        );
}
