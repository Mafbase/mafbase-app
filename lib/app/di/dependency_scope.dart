import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/di/storage_factory.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';

class DependencyScopeWidget extends InheritedWidget {
  final DependencyScope scope;

  const DependencyScopeWidget({
    super.key,
    required super.child,
    required this.scope,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class DependencyScope {
  late final StorageFactory storageFactory = StorageFactory();
  late final RepositoryFactory repositoryFactory = RepositoryFactory(_client);
  final AuthNotifier authNotifier = getIt();
  final MyHttpClient _client = getIt();

  static DependencyScope of(BuildContext context) => context
      .getInheritedWidgetOfExactType<DependencyScopeWidget>()!
      .scope;
}
