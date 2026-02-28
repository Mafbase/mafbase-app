import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/data/base_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ValidateFormulaRequest extends BaseRequest<ValidateFormulaEventOut> {
  ValidateFormulaRequest({
    required int clubId,
    required String formula,
  }) : super(
          '/api/club/$clubId/custom-columns/validate',
          data: ValidateFormulaEvent()..formula = formula,
        );

  @override
  FutureOr<ValidateFormulaEventOut> parse(List<int> bytes) {
    return compute(ValidateFormulaEventOut.fromBuffer, bytes);
  }
}
