import 'dart:async';

import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class AddFantasyParticipantRequest extends BaseRequest<void> {
  AddFantasyParticipantRequest({required int tournamentId, required String email})
      : super(
          '/api/tournament/$tournamentId/fantasy/participants',
          data: SetFantasyParticipantEvent(email: email),
        );

  @override
  FutureOr<void> parse(List<int> bytes) {}
}
