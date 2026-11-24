import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/core/storage/credential_secure_storage_impl.dart';
import 'package:seating_generator_web/core/storage/credential_storage.dart';
import 'package:seating_generator_web/core/storage/token_storage.dart';
import 'package:seating_generator_web/core/storage/token_storage_impl.dart';

class StorageFactory {
  StorageFactory();

  late final TokenStorage tokenStorage = TokenStorageImpl();

  late final CredentialStorage credentialStorage = CredentialSecureStorageImpl();

  static StorageFactory of(BuildContext context) => DependencyScope.of(context).storageFactory;
}
