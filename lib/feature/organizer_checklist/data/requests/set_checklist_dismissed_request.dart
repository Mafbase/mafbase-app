import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetChecklistDismissedRequest extends BaseRequest<TournamentChecklistOut> {
  SetChecklistDismissedRequest({required int tournamentId, required SetChecklistDismissedEvent body})
      : super('/api/tournament/$tournamentId/checklist/dismiss', data: body);

  @override
  FutureOr<TournamentChecklistOut> parse(List<int> bytes) => compute(TournamentChecklistOut.fromBuffer, bytes);
}
