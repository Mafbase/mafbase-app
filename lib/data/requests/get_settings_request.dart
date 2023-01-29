import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetSettingsRequest extends BaseRequest<TournamentSettings> {
  GetSettingsRequest({required int tournamentId})
      : super("/api/tournament/$tournamentId/settings");

  @override
  FutureOr<TournamentSettings> parse(List<int> bytes) {
    return compute(TournamentSettings.fromBuffer, bytes);
  }
}
