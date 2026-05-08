import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GenerateStreamRequest extends BaseRequest<GameStreamAdmin> {
  GenerateStreamRequest({required int tournamentId, required GenerateStreamEvent body})
      : super('/api/admin/tournament/$tournamentId/streams/generate', data: body);

  @override
  FutureOr<GameStreamAdmin> parse(List<int> bytes) => compute(GameStreamAdmin.fromBuffer, bytes);
}
