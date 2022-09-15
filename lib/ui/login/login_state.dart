import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  factory LoginState.login({required bool hasError, @Default(false) bool isLoading}) = Login;

  factory LoginState.signUp({
    required bool loginExistError,
    required bool emailExistError,
  }) = SignUp;
}
