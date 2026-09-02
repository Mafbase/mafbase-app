import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetClubStreamSettingsRequest extends BaseRequest<StreamSettingsOut> {
  GetClubStreamSettingsRequest({required int clubId}) : super('/api/admin/club/$clubId/stream-settings');

  @override
  FutureOr<StreamSettingsOut> parse(List<int> bytes) => compute(StreamSettingsOut.fromBuffer, bytes);
}
