import 'package:flutter/cupertino.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/domain/base_interactor.dart';
import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

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
    required bool rememberMe,
    BuildContext? context,
  }) {
    return wrap(() async {
      final model = await _authRepository.login(email, password);
      if (model is Success && rememberMe) {
        await _credentialStorage.save(Credentials(email, password));
      }
      if (model is Success) {
        context?.read<AuthNotifier>().value = const AuthNotifierModel.authorized();
      }
      return model;
    });
  }

  @override
  String get interactorName => "LoginInteractor";
}
