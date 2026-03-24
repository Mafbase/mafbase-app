import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'formula_validation_result.freezed.dart';

@freezed
abstract class FormulaValidationResult with _$FormulaValidationResult {
  const factory FormulaValidationResult({
    required bool valid,
    String? error,
  }) = _FormulaValidationResult;

  factory FormulaValidationResult.fromProto(ValidateFormulaEventOut proto) => FormulaValidationResult(
        valid: proto.valid,
        error: proto.hasError() ? proto.error : null,
      );
}
