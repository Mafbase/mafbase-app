import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetFantasyRatingRequest extends BaseRequest<FantasyRatingEventOut> {
  GetFantasyRatingRequest({required int tournamentId})
      : super('/api/tournament/$tournamentId/fantasy/rating');

  @override
  FutureOr<FantasyRatingEventOut> parse(List<int> bytes) =>
      compute(FantasyRatingEventOut.fromBuffer, bytes);
}
