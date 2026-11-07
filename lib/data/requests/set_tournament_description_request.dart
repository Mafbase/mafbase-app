import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetTournamentDescriptionRequest extends BaseRequest<void> {
  SetTournamentDescriptionRequest({
    required int tournamentId,
    required TournamentDescription description,
  }) : super(
          '/api/tournament/$tournamentId/description',
          data: description,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
