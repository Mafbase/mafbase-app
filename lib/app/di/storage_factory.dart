import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/storages/credential_secure_storage_impl.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage_impl.dart';

class StorageFactory {
  StorageFactory();

  late final TokenStorage tokenStorage = TokenStorageImpl();

  late final CredentialStorage credentialStorage = CredentialSecureStorageImpl();

  static StorageFactory of(BuildContext context) => DependencyScope.of(context).storageFactory;
}
