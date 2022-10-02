import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  factory LoginState({required bool hasError, @Default(false) bool isLoading}) = _LoginState;
}
