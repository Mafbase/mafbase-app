import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/sign_up_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';

class SignUpInteractor extends BaseInteractor {
  final AuthRepository _authRepository;

  SignUpInteractor(this._authRepository);

  Future<SignUpModel> run(String email, String password) {
    return wrap(() async {
      return _authRepository.signUp(email, password);
    });
  }

  @override
  String get interactorName => 'SignUpInteractor';
}
