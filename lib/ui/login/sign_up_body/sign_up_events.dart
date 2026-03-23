import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_events.freezed.dart';

@freezed
class SignUpEvents with _$SignUpEvents {
  const factory SignUpEvents.backButtonTapped() = BackButtonTapped;

  const factory SignUpEvents.signUpButtonTapped({required String email, required String password}) = SignUpButtonTapped;
}
