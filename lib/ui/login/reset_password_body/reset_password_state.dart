import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/password_reset_model.dart';

part 'reset_password_state.freezed.dart';

@freezed
abstract class ResetPasswordState with _$ResetPasswordState {
  factory ResetPasswordState({
    @Default(false) bool isLoading,
    ResetPasswordError? error,
  }) = _ResetPasswordState;
}
