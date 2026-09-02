import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class SetClubStreamSettingsRequest extends BaseRequest<StreamSettingsOut> {
  SetClubStreamSettingsRequest({required int clubId, required SetStreamSettingsEvent body})
      : super('/api/admin/club/$clubId/stream-settings', data: body, methodType: Method.put);

  @override
  FutureOr<StreamSettingsOut> parse(List<int> bytes) => compute(StreamSettingsOut.fromBuffer, bytes);
}
