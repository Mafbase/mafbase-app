import 'dart:async';

import 'package:seating_generator_web/core/network/base_request.dart';

class TournamentCanDeleteRequest extends BaseRequest<bool> {
  TournamentCanDeleteRequest({required int tournamentId}) : super('/api/tournaments/$tournamentId/canDelete');

  @override
  FutureOr<bool> parse(List<int> bytes) {
    return true;
  }
}
