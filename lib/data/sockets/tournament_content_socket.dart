import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_socket.dart';

class TournamentContentSocket extends BaseSocket {
  TournamentContentSocket({required int tournamentId, required int table})
      : super(
          '${getScheme()}://${getHost()}/api/seatingContent?table=$table&tournamentId=$tournamentId',
        );
}

String getScheme() {
  if (kIsWeb && kReleaseMode) {
    return Uri.base.scheme == 'https' ? 'wss' : 'ws';
  }

  return 'wss';
}

String getHost() {
  if (kIsWeb && kReleaseMode) {
    return '${Uri.base.host}:${Uri.base.port}';
  }

  return 'mafbase.ru';
}
