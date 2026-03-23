import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/data/services/device_id_service.dart';
import 'package:seating_generator_web/data/services/notification_permission_service_impl.dart';
import 'package:seating_generator_web/data/services/push_token_service.dart';
import 'package:seating_generator_web/domain/services/notification_permission_service.dart';

class ServiceProvider {
  final RepositoryFactory _repositoryFactory;

  ServiceProvider(this._repositoryFactory);

  static ServiceProvider of(BuildContext context) => DependencyScope.of(context).serviceProvider;

  late final DeviceIdService deviceIdService = DeviceIdService();

  late final PushTokenService pushTokenService = PushTokenService(
    _repositoryFactory.authRepository,
    deviceIdService,
  );

  NotificationPermissionServiceImpl? _notificationPermissionService;

  NotificationPermissionService get notificationPermissionService =>
      _notificationPermissionService ??= NotificationPermissionServiceImpl(pushTokenService);

  void dispose() {
    _notificationPermissionService?.dispose();
  }
}
