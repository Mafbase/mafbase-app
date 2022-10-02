import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LoginInteractor {
  final AuthRepository _authRepository;

  const LoginInteractor(this._authRepository);

  Future<LoginModel> run(String email, String password) {
    final transaction = Sentry.startTransaction('LoginInteractor.run()', 'task');
    try {
      return _authRepository.login(email, password);
    } catch (err) {
      transaction.throwable = err;
      transaction.status = const SpanStatus.internalError();
      rethrow;
    } finally {
      transaction.finish();
    }
  }
}