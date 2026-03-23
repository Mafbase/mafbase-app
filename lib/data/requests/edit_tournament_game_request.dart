import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class EditTournamentGameRequest extends BaseRequest {
  EditTournamentGameRequest({
    required int tournamentId,
    required int gameId,
    required ClubGameResult result,
  }) : super(
          '/api/tournaments/$tournamentId/editGame/$gameId',
          data: result,
        );

  @override
  FutureOr parse(List<int> bytes) {
    // nothing to return
  }
}
