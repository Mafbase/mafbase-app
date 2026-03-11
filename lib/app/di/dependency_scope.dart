import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/di/storage_factory.dart';
import 'package:seating_generator_web/data/http_client.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/services/device_id_service.dart';
import 'package:seating_generator_web/data/services/notification_permission_service_impl.dart';
import 'package:seating_generator_web/data/services/push_token_service.dart';
import 'package:seating_generator_web/domain/services/notification_permission_service.dart';

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

  late final StorageFactory storageFactory =
      StorageFactory(isIntegrationTest: isIntegrationTest);

  late final MyHttpClient client = kReleaseMode && kIsWeb
      ? MyHttpClient.autoForWeb(
          storageFactory.tokenStorage, storageFactory.credentialStorage)
      : MyHttpClient.withDefaultUrl(
          storageFactory.tokenStorage, storageFactory.credentialStorage);

  late final RepositoryFactory repositoryFactory =
      RepositoryFactory(client, storageFactory);

  late final AuthNotifier authNotifier = AuthNotifier();

  late final DeviceIdService deviceIdService = DeviceIdService();

  late final PushTokenService pushTokenService = PushTokenService(
    repositoryFactory.authRepository,
    deviceIdService,
  );

  NotificationPermissionServiceImpl? _notificationPermissionService;

  NotificationPermissionService get notificationPermissionService =>
      _notificationPermissionService ??=
          NotificationPermissionServiceImpl(pushTokenService);

  void dispose() {
    _notificationPermissionService?.dispose();
  }

  static DependencyScope of(BuildContext context) => context
      .getInheritedWidgetOfExactType<DependencyScopeWidget>()!
      .scope;
}
