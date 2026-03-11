import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/data/storages/credential_secure_storage_impl.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/data/storages/token_in_memory_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage_hive_impl.dart';

class StorageFactory {
  static const _useHiveStorage = true;

  final bool _isIntegrationTest;

  StorageFactory({bool isIntegrationTest = false})
      : _isIntegrationTest = isIntegrationTest;

  late final TokenStorage tokenStorage = _isIntegrationTest
      ? TokenInMemoryStorage()
      : (_useHiveStorage ? TokenStorageHiveImpl() : TokenStorageHiveImpl());

  late final CredentialStorage credentialStorage =
      CredentialSecureStorageImpl();

  static StorageFactory of(BuildContext context) =>
      DependencyScope.of(context).storageFactory;
}
