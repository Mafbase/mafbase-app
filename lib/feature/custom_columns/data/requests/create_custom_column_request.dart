import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class CreateCustomColumnRequest extends BaseRequest<CustomColumnDefinition> {
  CreateCustomColumnRequest({
    required int clubId,
    required String title,
    required String formula,
  }) : super(
          '/api/club/$clubId/custom-columns',
          data: CreateCustomColumnEvent()
            ..title = title
            ..formula = formula,
        );

  @override
  FutureOr<CustomColumnDefinition> parse(List<int> bytes) {
    return compute(CustomColumnDefinition.fromBuffer, bytes);
  }
}
