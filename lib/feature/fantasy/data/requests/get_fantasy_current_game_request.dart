import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetFantasyCurrentGameRequest extends BaseRequest<FantasyCurrentGameEventOut> {
  GetFantasyCurrentGameRequest({required int tournamentId})
      : super('/api/tournament/$tournamentId/fantasy/currentGame');

  @override
  FutureOr<FantasyCurrentGameEventOut> parse(List<int> bytes) => compute(FantasyCurrentGameEventOut.fromBuffer, bytes);
}
