import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_events.freezed.dart';

@freezed
abstract class VerificationEvents with _$VerificationEvents {
  const factory VerificationEvents.submit({required String token}) = VerificationEventSubmit;

  const factory VerificationEvents.signUpButtonTapped() = OnSignUpButtonTapped;

  const factory VerificationEvents.loginButtonTapped() = OnLoginButtonTapped;
}
