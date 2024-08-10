import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';

class StorageFactory {
  final TokenStorage tokenStorage = getIt();
  final CredentialStorage credentialStorage = getIt();

  static StorageFactory of(BuildContext context) =>
      DependencyScope.of(context).storageFactory;
}
