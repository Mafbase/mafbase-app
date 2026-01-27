import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  factory ForgotPasswordState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(false) bool isSuccess,
  }) = _ForgotPasswordState;
}
