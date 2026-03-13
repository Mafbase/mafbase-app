import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetOwnersRequest extends BaseRequest<TournamentOwnersEventOut> {
  GetOwnersRequest({required int tournamentId}) : super('/api/tournaments/$tournamentId/owners');

  @override
  FutureOr<TournamentOwnersEventOut> parse(List<int> bytes) {
    return compute(TournamentOwnersEventOut.fromBuffer, bytes);
  }
}
