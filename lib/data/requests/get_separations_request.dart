import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetSeparationsRequest extends BaseRequest<CannotMeetEventOut> {
  GetSeparationsRequest({required int tournamentId}) : super('/api/tournament/$tournamentId/cannotMeet');

  @override
  FutureOr<CannotMeetEventOut> parse(List<int> bytes) {
    return compute(CannotMeetEventOut.fromBuffer, bytes);
  }
}
