import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';

class LoginInteractor extends BaseInteractor {
  final AuthRepository _authRepository;

  LoginInteractor(this._authRepository);

  Future<LoginModel> run(String email, String password) {
    return wrap(() async {
      return _authRepository.login(email, password);
    });
  }

  @override
  String get interactorName => "LoginInteractor";
}