import 'package:seating_generator_web/data/storages/credential_storage.dart';

class CredentialStorageMock implements CredentialStorage {
  Credentials? credentials;
  @override
  Future cleanup() async {
    credentials = null;
  }

  @override
  Future<Credentials?> read() async {
    return credentials;
  }

  @override
  Future save(Credentials credentials) async{
    this.credentials = credentials;
  }
}