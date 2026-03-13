import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetFinalPlayersRequest extends BaseRequest<GetFinalPlayersOut> {
  GetFinalPlayersRequest({required int tournamentId}) : super('/api/tournaments/$tournamentId/finalPlayers');

  @override
  FutureOr<GetFinalPlayersOut> parse(List<int> bytes) {
    return compute(GetFinalPlayersOut.fromBuffer, bytes);
  }
}
