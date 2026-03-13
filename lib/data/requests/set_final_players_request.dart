import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetFinalPlayersRequest extends BaseRequest<dynamic> {
  SetFinalPlayersRequest({
    required int tournamentId,
    required List<int> players,
  }) : super(
          '/api/tournaments/$tournamentId/setFinalPlayers',
          data: SetFinalPlayersEvent(id: players),
        );

  @override
  FutureOr parse(List<int> bytes) {
    return null;
  }
}
