import 'package:flutter/cupertino.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LoginInteractor extends BaseInteractor {
  static const hideBillEmails = ['test@mail.ru'];
  final AuthRepository _authRepository;
  final CredentialStorage _credentialStorage;
  final AuthNotifier _authNotifier;

  LoginInteractor(
    this._authRepository,
    this._credentialStorage,
    this._authNotifier,
  );

  Future<LoginModel> run(
    String email,
    String password, {
    BuildContext? context,
  }) =>
      wrap(() async {
        final model = await _authRepository.login(email, password);
        if (model is Success) {
          Sentry.configureScope(
            (p0) => p0.setUser(
              SentryUser(username: email),
            ),
          );

          _credentialStorage.save(Credentials(email, password));

          _authNotifier.value = AuthNotifierModel.authorized(
            userId: model.userId,
            hideBilling: hideBillEmails.contains(email),
          );
        }

        return model;
      });

  @override
  String get interactorName => 'LoginInteractor';
}
