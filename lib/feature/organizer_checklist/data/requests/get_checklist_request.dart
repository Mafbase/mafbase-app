import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetChecklistRequest extends BaseRequest<TournamentChecklistOut> {
  GetChecklistRequest({required int tournamentId}) : super('/api/tournament/$tournamentId/checklist');

  @override
  FutureOr<TournamentChecklistOut> parse(List<int> bytes) => compute(TournamentChecklistOut.fromBuffer, bytes);
}
