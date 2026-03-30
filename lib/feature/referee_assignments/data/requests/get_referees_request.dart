import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetRefereesRequest extends BaseRequest<GetRefereesEventOut> {
  GetRefereesRequest({required int tournamentId}) : super('/api/tournament/$tournamentId/referees');

  @override
  FutureOr<GetRefereesEventOut> parse(List<int> bytes) => compute(GetRefereesEventOut.fromBuffer, bytes);
}
