import 'package:seating_generator_web/core/auth/auth_notifier.dart';
import 'package:seating_generator_web/core/auth/auth_notifier_model.dart';
import 'package:seating_generator_web/core/storage/credential_storage.dart';
import 'package:seating_generator_web/core/storage/token_storage.dart';
import 'package:seating_generator_web/core/domain/base_interactor.dart';

class LogoutInteractor extends BaseInteractor {
  final TokenStorage _storage;
  final CredentialStorage _credentialStorage;
  final AuthNotifier _authNotifier;

  LogoutInteractor(this._storage, this._authNotifier, this._credentialStorage);

  Future call() => wrap(
        () async => Future.wait(
          [
            Future(_storage.clear),
            _credentialStorage.cleanup(),
          ],
        ),
      ).whenComplete(
        () => _authNotifier.value = const AuthNotifierModel.unauthorized(),
      );

  @override
  String get interactorName => 'LogoutInteractor';
}
