import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/models/sign_up_model.dart';

abstract class AuthRepository {
  Future<LoginModel> login(String email, String password);

  Future<SignUpModel> signUp(String email, String password);

  Future<bool> verificate(int id, String token);
}
