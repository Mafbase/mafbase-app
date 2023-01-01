import 'dart:async';

abstract class TokenStorage {
  FutureOr<String?> get authToken;

  FutureOr<String?> get recoveryToken;

  Future onTokensUpdated(String authToken, String recoveryToken);
}
