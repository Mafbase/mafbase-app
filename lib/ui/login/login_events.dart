import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_events.freezed.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.loginButtonTapped({required String email, required String password,}) = LoginButtonTapped;

  const factory LoginEvent.forgotPasswordTapped() = ForgotPasswordTapped;

  const factory LoginEvent.signUpButtonTapped() = SignUpButtonTapped;
}