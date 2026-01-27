import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_events.freezed.dart';

@freezed
class ForgotPasswordEvents with _$ForgotPasswordEvents {
  const factory ForgotPasswordEvents.submit({required String email}) = Submit;
  const factory ForgotPasswordEvents.backButtonTapped() = BackButtonTapped;
}
