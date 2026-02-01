import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/models/password_reset_model.dart';
import 'package:seating_generator_web/domain/models/sign_up_model.dart';

abstract class AuthRepository {
  Future<LoginModel> login(String email, String password);

  Future<SignUpModel> signUp(String email, String password);

  Future<bool> verificate(int id, String token);

  Future<ForgotPasswordModel> forgotPassword(String email);

  Future<ResetPasswordModel> resetPassword(String token, String email, String newPassword);

  /// Отправить запрос авторизации с push token и deviceId
  /// Возвращает userId если авторизация успешна, null если нет
  Future<int?> auth({String? pushToken, String? deviceId});
}
