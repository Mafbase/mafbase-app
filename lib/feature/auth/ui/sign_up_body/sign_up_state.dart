import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  factory SignUpState({
    @Default(false) bool isLoading,
    @Default(false) bool weakPassword,
    @Default(false) bool emailExist,
  }) = _SignUpState;
}
