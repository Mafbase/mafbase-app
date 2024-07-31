import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LoginInteractor extends BaseInteractor {
  final AuthRepository _authRepository;
  final CredentialStorage _credentialStorage;

  LoginInteractor(
    this._authRepository,
    this._credentialStorage,
  );

  Future<LoginModel> run(
    String email,
    String password, {
    BuildContext? context,
  }) {
    return wrap(() async {
      final model = await _authRepository.login(email, password);
      if (model is Success) {
        Sentry.configureScope(
          (p0) => p0.setUser(
            SentryUser(username: email),
          ),
        );

        _credentialStorage.save(Credentials(email, password));

        context?.read<AuthNotifier>().value =
            const AuthNotifierModel.authorized();
      }
      return model;
    });
  }

  @override
  String get interactorName => "LoginInteractor";
}
