import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class GetCustomColumnsRequest extends BaseRequest<CustomColumnsEventOut> {
  GetCustomColumnsRequest({required int clubId}) : super('/api/club/$clubId/custom-columns');

  @override
  FutureOr<CustomColumnsEventOut> parse(List<int> bytes) {
    return compute(CustomColumnsEventOut.fromBuffer, bytes);
  }
}
