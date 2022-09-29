import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorageImpl implements TokenStorage {
  Future<SharedPreferences> get _storage => SharedPreferences.getInstance();
  static const _authTokenKey = "auth_token_key";
  static const _recoveryTokenKey = "recovery_token_key";

  @override
  Future<String?> get authToken =>
      _storage.then((value) => value.getString(_authTokenKey));

  @override
  Future onTokensUpdated(String authToken, String recoveryToken) async {
    (await _storage).setString(_authTokenKey, authToken);
    (await _storage).setString(_recoveryTokenKey, recoveryToken);
  }

  @override
  Future<String?> get recoveryToken =>
      _storage.then((value) => value.getString(_recoveryTokenKey));
}
