import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AddPlayersFromTournamentRequest extends BaseRequest<AddPlayersFromTournamentEventOut> {
  AddPlayersFromTournamentRequest({
    required int themeId,
    required int tournamentId,
  }) : super(
          '/api/photoThemes/$themeId/addFromTournament',
          data: AddPlayersFromTournamentEvent(tournamentId: tournamentId),
        );

  @override
  FutureOr<AddPlayersFromTournamentEventOut> parse(List<int> bytes) =>
      compute(AddPlayersFromTournamentEventOut.fromBuffer, bytes);
}
