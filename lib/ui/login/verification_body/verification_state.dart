import 'package:freezed_annotation/freezed_annotation.dart';
part 'verification_state.freezed.dart';

@freezed
class VerificationState with _$VerificationState {
  const factory VerificationState({@Default(false) bool hasError, required bool isLoading}) = _VerificationState;
}
