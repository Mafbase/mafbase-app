import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';

class LoginInteractor {
  final AuthRepository _authRepository;

  const LoginInteractor(this._authRepository);

  Future<LoginModel> run(String email, String password) {
    return _authRepository.login(email, password);
  }
}