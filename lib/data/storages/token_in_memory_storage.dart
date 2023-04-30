import 'dart:async';

import 'package:seating_generator_web/data/storages/token_storage.dart';

class TokenInMemoryStorage implements TokenStorage {
  String? _authToken;
  String? _recoveryToken;
  @override
  FutureOr<String?> get authToken => _authToken;

  @override
  Future onTokensUpdated(String authToken, String recoveryToken) async {
    _authToken = authToken;
    _recoveryToken = recoveryToken;
  }

  @override
  FutureOr<String?> get recoveryToken => _recoveryToken;

  @override
  FutureOr clear() {
    _authToken = null;
    _recoveryToken = null;
  }
}
