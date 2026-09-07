import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

/// Перевыпуск токена оператора трансляции турнира — инвалидирует старую ссылку.
class RotateStreamTokenRequest extends BaseRequest<GameStreamAdmin> {
  RotateStreamTokenRequest({required int tournamentId, required int streamId})
      : super('/api/admin/tournament/$tournamentId/streams/$streamId/rotate-token', forcePost: true);

  @override
  FutureOr<GameStreamAdmin> parse(List<int> bytes) => compute(GameStreamAdmin.fromBuffer, bytes);
}
