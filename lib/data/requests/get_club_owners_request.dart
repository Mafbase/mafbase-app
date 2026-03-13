import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetClubOwnersRequest extends BaseRequest<TournamentOwnersEventOut> {
  GetClubOwnersRequest({required int clubId}) : super('/api/clubs/$clubId/owners');

  @override
  FutureOr<TournamentOwnersEventOut> parse(List<int> bytes) {
    return compute(TournamentOwnersEventOut.fromBuffer, bytes);
  }
}
