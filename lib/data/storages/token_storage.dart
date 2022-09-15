abstract class TokenStorage {
  Future<String?> get authToken;

  Future<String?> get recoveryToken;

  Future onTokensUpdated(String authToken, String recoveryToken);
}
