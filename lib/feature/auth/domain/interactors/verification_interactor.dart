import 'package:seating_generator_web/core/domain/base_interactor.dart';
import 'package:seating_generator_web/core/auth/domain/auth_repository.dart';

class VerificationInteractor extends BaseInteractor {
  final AuthRepository _authRepository;

  VerificationInteractor(this._authRepository);

  Future<bool> run(int id, String token) async {
    return wrap(() async {
      return _authRepository.verificate(id, token);
    });
  }

  @override
  String get interactorName => 'VerificationInteractor';
}
