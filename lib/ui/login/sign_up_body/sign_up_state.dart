import 'package:freezed_annotation/freezed_annotation.dart';


part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  factory SignUpState({required bool hasError, @Default(false) bool isLoading}) = _SignUpState;
}