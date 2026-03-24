import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_reset_model.freezed.dart';

@freezed
abstract class ForgotPasswordModel with _$ForgotPasswordModel {
  const factory ForgotPasswordModel.success() = ForgotPasswordSuccess;
  const factory ForgotPasswordModel.error() = ForgotPasswordError;
}

@freezed
abstract class ResetPasswordModel with _$ResetPasswordModel {
  const factory ResetPasswordModel.success() = ResetPasswordSuccess;
  const factory ResetPasswordModel.error(ResetPasswordError error) = ResetPasswordErrorState;
}

enum ResetPasswordError {
  invalidToken,
  weakPassword,
}
