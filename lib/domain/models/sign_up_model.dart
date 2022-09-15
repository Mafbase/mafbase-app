import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_model.freezed.dart';

@freezed
class SignUpModel with _$SignUpModel {
  const factory SignUpModel.success({ErrorEnum? error}) = Success;

  const factory SignUpModel.error({String? message}) = Error;
}

enum ErrorEnum {
  emailExist,
  weakPassword,
}
