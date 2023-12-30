import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';

const _loginKey = "credential_login_key";

const _passwordKey = "credential_password_key";

class CredentialSecureStorageImpl implements CredentialStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<Credentials?> read() async {
    try {
      if (await Future.wait([
        _storage.containsKey(key: _loginKey),
        _storage.containsKey(key: _passwordKey),
      ]).then((value) => value.any((element) => !element))) {
        return null;
      }
      final login = await _storage.read(key: _loginKey);
      final password = await _storage.read(key: _passwordKey);
      if (login == null || password == null) {
        return null;
      }

      return Credentials(login, password);
    } catch (_) {
      return cleanup().then((value) => null);
    }
  }

  @override
  Future save(Credentials credentials) {
    return Future.wait([
      _storage.write(key: _loginKey, value: credentials.login),
      _storage.write(key: _passwordKey, value: credentials.password),
    ]);
  }

  @override
  Future cleanup() {
    return Future.wait([
      _storage.delete(key: _loginKey),
      _storage.delete(key: _passwordKey),
    ]);
  }
}
