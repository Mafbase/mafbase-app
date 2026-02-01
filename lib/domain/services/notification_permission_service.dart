import 'package:permission_handler/permission_handler.dart';

abstract class NotificationPermissionService {
  /// Получить текущий статус разрешения на уведомления
  Future<PermissionStatus> getNotificationStatus();

  /// Запросить разрешение на уведомления
  /// Если разрешение было отклонено навсегда, открывает настройки приложения
  Future<PermissionStatus> requestNotificationPermission();

  /// Открыть настройки приложения
  Future<bool> openAppSettings();

  /// Stream изменений статуса разрешения на уведомления
  Stream<PermissionStatus> get notificationStatusStream;
}
