import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetStreamsRequest extends BaseRequest<GetStreamsEventOut> {
  GetStreamsRequest({required int tournamentId}) : super('/api/tournament/$tournamentId/streams');

  @override
  FutureOr<GetStreamsEventOut> parse(List<int> bytes) => compute(GetStreamsEventOut.fromBuffer, bytes);
}
