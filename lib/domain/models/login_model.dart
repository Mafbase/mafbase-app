import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_model.freezed.dart';

@freezed
class LoginModel with _$LoginModel {
  const factory LoginModel.success() = Success;

  const factory LoginModel.needVerification({required int id}) =
      NeedVerification;

  const factory LoginModel.error({String? message}) = Error;
}
