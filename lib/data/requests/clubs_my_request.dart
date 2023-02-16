import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ClubsMyRequest extends BaseRequest<ClubsEventOut> {
  ClubsMyRequest() : super("/api/club/my");

  @override
  FutureOr<ClubsEventOut> parse(List<int> bytes) {
    return compute(ClubsEventOut.fromBuffer, bytes);
  }
}
