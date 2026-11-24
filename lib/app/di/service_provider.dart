import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/core/push/device_id_service.dart';
import 'package:seating_generator_web/core/push/notification_permission_service_impl.dart';
import 'package:seating_generator_web/core/push/push_token_service.dart';
import 'package:seating_generator_web/core/auth/domain/auth_repository.dart';
import 'package:seating_generator_web/core/push/notification_permission_service.dart';

class ServiceProvider {
  final AuthRepository _authRepository;

  ServiceProvider(this._authRepository);

  static ServiceProvider of(BuildContext context) => DependencyScope.of(context).serviceProvider;

  late final DeviceIdService deviceIdService = DeviceIdService();

  late final PushTokenService pushTokenService = PushTokenService(
    _authRepository,
    deviceIdService,
  );

  NotificationPermissionServiceImpl? _notificationPermissionService;

  NotificationPermissionService get notificationPermissionService =>
      _notificationPermissionService ??= NotificationPermissionServiceImpl(pushTokenService);

  void dispose() {
    _notificationPermissionService?.dispose();
  }
}
