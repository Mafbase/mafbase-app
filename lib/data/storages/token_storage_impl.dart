import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageImpl implements TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const _authTokenKey = "auth_token_key";
  static const _recoveryTokenKey = "recovery_token_key";

  @override
  Future<String?> get authToken => _storage.read(key: _authTokenKey);

  @override
  Future onTokensUpdated(String authToken, String recoveryToken) async {
    await _storage.write(key: _authTokenKey, value: authToken);
    await _storage.write(key: _recoveryTokenKey, value: recoveryToken);
  }

  @override
  Future<String?> get recoveryToken => _storage.read(key: _recoveryTokenKey);

}