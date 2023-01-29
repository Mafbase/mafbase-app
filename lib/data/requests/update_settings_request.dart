import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class UpdateSettingsRequest extends BaseRequest<void> {
  UpdateSettingsRequest({
    required int tournamentId,
    required TournamentSettings settings,
  }) : super(
          "/api/tournament/$tournamentId/updateSettings",
          data: settings,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
