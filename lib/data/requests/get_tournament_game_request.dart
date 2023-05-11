import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetTournamentGameRequest extends BaseRequest<ClubGameResult> {
  GetTournamentGameRequest({required int tournamentId, required int gameId})
      : super("/api/tournaments/$tournamentId/game/$gameId");

  @override
  FutureOr<ClubGameResult> parse(List<int> bytes) {
    return compute(ClubGameResult.fromBuffer, bytes);
  }
}
