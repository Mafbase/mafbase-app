import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetClubStreamRequest extends BaseRequest<GameStreamAdmin> {
  SetClubStreamRequest({required int clubId, required SetStreamEvent body})
      : super('/api/admin/club/$clubId/streams', data: body, methodType: Method.put);

  @override
  FutureOr<GameStreamAdmin> parse(List<int> bytes) => compute(GameStreamAdmin.fromBuffer, bytes);
}
