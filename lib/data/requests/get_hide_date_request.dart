import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetHideDateRequest extends BaseRequest<UpdateHideDateRequest> {
  GetHideDateRequest(String clubId) : super('/api/club/$clubId/hide-date');

  @override
  FutureOr<UpdateHideDateRequest> parse(List<int> bytes) => compute(UpdateHideDateRequest.fromBuffer, bytes);
}
