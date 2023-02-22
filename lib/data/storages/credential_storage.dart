abstract class CredentialStorage {
  Future save(Credentials credentials);

  Future<Credentials?> read();

  Future cleanup();
}

class Credentials {
  final String login;
  final String password;

  Credentials(this.login, this.password);

  @override
  String toString() {
    return "Credentials { login: $login, password: $password }";
  }
}