import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetStreamRequest extends BaseRequest<GameStreamAdmin> {
  SetStreamRequest({required int tournamentId, required SetStreamEvent body})
      : super('/api/admin/tournament/$tournamentId/streams', data: body, methodType: Method.put);

  @override
  FutureOr<GameStreamAdmin> parse(List<int> bytes) => compute(GameStreamAdmin.fromBuffer, bytes);
}
