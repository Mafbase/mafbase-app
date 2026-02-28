import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class UpdateCustomColumnRequest extends BaseRequest<CustomColumnDefinition> {
  UpdateCustomColumnRequest({
    required int clubId,
    required int columnId,
    required String title,
    required String formula,
  }) : super(
          '/api/club/$clubId/custom-columns/$columnId',
          data: UpdateCustomColumnEvent()
            ..title = title
            ..formula = formula,
          methodType: Method.put,
        );

  @override
  FutureOr<CustomColumnDefinition> parse(List<int> bytes) {
    return compute(CustomColumnDefinition.fromBuffer, bytes);
  }
}
