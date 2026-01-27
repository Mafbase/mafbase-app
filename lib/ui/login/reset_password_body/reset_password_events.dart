import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_events.freezed.dart';

@freezed
class ResetPasswordEvents with _$ResetPasswordEvents {
  const factory ResetPasswordEvents.submit({
    required String token,
    required String email,
    required String newPassword,
  }) = Submit;
  const factory ResetPasswordEvents.backButtonTapped() = BackButtonTapped;
}
