import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/service_provider.dart';
import 'package:seating_generator_web/app/di/storage_factory.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/repositories/auth_repository_impl.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';

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

  final Map<Type, Object> _instances;

  DependencyScope({this.isIntegrationTest = false, Map<Type, Object> overrides = const {}})
      : _instances = Map.of(overrides);

  /// Lazy singleton keyed by [T]; an instance passed in `overrides` wins over [create].
  T resolve<T extends Object>(T Function() create) => _instances.putIfAbsent(T, create) as T;

  late final StorageFactory storageFactory = StorageFactory();

  late final MyHttpClient client = (kReleaseMode && kIsWeb ? MyHttpClient.autoForWeb : MyHttpClient.withDefaultUrl)(
    storageFactory.tokenStorage,
    storageFactory.credentialStorage,
  );

  late final AuthNotifier authNotifier = AuthNotifier();

  late final ServiceProvider serviceProvider = ServiceProvider(authRepository);

  AuthRepository get authRepository =>
      resolve<AuthRepository>(() => AuthRepositoryImpl(client, storageFactory.tokenStorage));

  void dispose() {
    serviceProvider.dispose();
  }

  static DependencyScope of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<DependencyScopeWidget>()!.scope;
}
