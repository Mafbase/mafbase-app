import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';

class RemoveFantasyParticipantRequest extends BaseRequest<void> {
  RemoveFantasyParticipantRequest({required int tournamentId, required int userId})
      : super(
          '/api/tournament/$tournamentId/fantasy/participants/$userId',
          methodType: Method.delete,
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
