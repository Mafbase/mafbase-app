import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetFantasyParticipantsRequest extends BaseRequest<FantasyParticipantsEventOut> {
  GetFantasyParticipantsRequest({required int tournamentId})
      : super('/api/tournament/$tournamentId/fantasy/participants');

  @override
  FutureOr<FantasyParticipantsEventOut> parse(List<int> bytes) =>
      compute(FantasyParticipantsEventOut.fromBuffer, bytes);
}
