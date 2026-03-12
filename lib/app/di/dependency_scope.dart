import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/di/service_provider.dart';
import 'package:seating_generator_web/app/di/storage_factory.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';

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
  final bool isIntegrationTest;

  DependencyScope({this.isIntegrationTest = false});

  late final StorageFactory storageFactory = StorageFactory(isIntegrationTest: isIntegrationTest);

  late final MyHttpClient client = (kReleaseMode && kIsWeb && false ? MyHttpClient.autoForWeb : MyHttpClient.withDefaultUrl)(
    storageFactory.tokenStorage,
    storageFactory.credentialStorage,
  );

  late final RepositoryFactory repositoryFactory = RepositoryFactory(client, storageFactory);

  late final AuthNotifier authNotifier = AuthNotifier();

  late final ServiceProvider serviceProvider = ServiceProvider(repositoryFactory);

  void dispose() {
    serviceProvider.dispose();
  }

  static DependencyScope of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<DependencyScopeWidget>()!.scope;
}
