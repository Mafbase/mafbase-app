import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

/// Перевыпуск токена оператора трансляции клуба — инвалидирует старую ссылку.
class RotateClubStreamTokenRequest extends BaseRequest<GameStreamAdmin> {
  RotateClubStreamTokenRequest({required int clubId, required int streamId})
      : super('/api/admin/club/$clubId/streams/$streamId/rotate-token', forcePost: true);

  @override
  FutureOr<GameStreamAdmin> parse(List<int> bytes) => compute(GameStreamAdmin.fromBuffer, bytes);
}
