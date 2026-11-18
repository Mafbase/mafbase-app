import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/core/network/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetCiSchemesRequest extends BaseRequest<AvailableCiEventOut> {
  GetCiSchemesRequest() : super('/api/ciSchemes');

  @override
  FutureOr<AvailableCiEventOut> parse(List<int> bytes) {
    return compute(AvailableCiEventOut.fromBuffer, bytes);
  }
}
