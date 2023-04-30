import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/domain/base_interactor.dart';

class LogoutInteractor extends BaseInteractor {
  final TokenStorage _storage;
  final AuthNotifier _authNotifier;

  LogoutInteractor(this._storage, this._authNotifier);

  Future call() => wrap(() async => _storage.clear()).whenComplete(
        () => _authNotifier.value = const AuthNotifierModel.unauthorized(),
      );

  @override
  String get interactorName => 'LogoutInteractor';
}
