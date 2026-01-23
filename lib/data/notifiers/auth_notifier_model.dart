import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_notifier_model.freezed.dart';
@freezed
class AuthNotifierModel with _$AuthNotifierModel {
  const factory AuthNotifierModel.unauthorized() = AuthNotifierUnauthorizedModel;

  const factory AuthNotifierModel.loading() = AuthNotifierLoadingModel;

  const factory AuthNotifierModel.authorized({
    required int userId,
    @Default(false) bool hideBilling,
  }) = AuthNotifierAuthorizedModel;
}