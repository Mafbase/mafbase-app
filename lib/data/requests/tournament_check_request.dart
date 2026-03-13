import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';

class TournamentCheckRequest extends BaseRequest<bool> {
  TournamentCheckRequest({required int tournamentId}) : super('/api/tournament/$tournamentId/isOwner');

  @override
  FutureOr<bool> parse(List<int> bytes) {
    return true;
  }
}
