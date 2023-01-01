import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetSeatingRequest extends BaseRequest<SeatingEventOut> {
  GetSeatingRequest({required int tournamentId})
      : super("/api/tournament/$tournamentId/getSeating");

  @override
  FutureOr<SeatingEventOut> parse(List<int> bytes) {
    return compute(SeatingEventOut.fromBuffer, bytes);
  }
}
