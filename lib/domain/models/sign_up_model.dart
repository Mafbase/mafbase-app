import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_model.freezed.dart';

@freezed
class SignUpModel with _$SignUpModel {
  const factory SignUpModel({ErrorEnum? error, int? id}) = _SignUpModel;
}

enum ErrorEnum {
  needVerification,
  emailExist,
  weakPassword,
}
