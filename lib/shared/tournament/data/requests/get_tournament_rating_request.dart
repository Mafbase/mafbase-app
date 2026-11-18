import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/core/network/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetTournamentRatingRequest extends BaseRequest<ClubRatingEventOut> {
  GetTournamentRatingRequest({required int tournamentId}) : super('/api/tournaments/$tournamentId/rating');

  @override
  FutureOr<ClubRatingEventOut> parse(List<int> bytes) {
    return compute(ClubRatingEventOut.fromBuffer, bytes);
  }
}
