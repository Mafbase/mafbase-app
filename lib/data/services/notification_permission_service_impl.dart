import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seating_generator_web/data/services/push_token_service.dart';
import 'package:seating_generator_web/domain/services/notification_permission_service.dart';

class NotificationPermissionServiceImpl with WidgetsBindingObserver implements NotificationPermissionService {
  final _statusController = StreamController<PermissionStatus>.broadcast();
  StreamSubscription<void>? _statusSubscription;
  final PushTokenService _pushTokenService;

  NotificationPermissionServiceImpl(this._pushTokenService) {
    // Регистрируем обсервер для отслеживания жизненного цикла приложения
    WidgetsBinding.instance.addObserver(this);
    // Отправляем начальный статус
    _updateStatus();
    // Подписываемся на изменения статуса для отправки push token
    _subscribeToStatusChanges();
  }

  void _subscribeToStatusChanges() {
    _statusSubscription = _statusController.stream
        .switchMap(
      (status) => status.isGranted
          ? MergeStream([
              Stream.value(null),
              _pushTokenService.tokenUpdatedStream,
            ])
          : Stream.empty(),
    )
        .listen((status) async {
      await _pushTokenService.sendPushTokenToServer();
    });
  }

  /// Обновляет статус разрешения и уведомляет подписчиков
  Future<void> _updateStatus() async {
    final status = await Permission.notification.status;
    if (!_statusController.isClosed) {
      _statusController.add(status);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // При возврате приложения в активное состояние обновляем статус
      _updateStatus();
    }
  }

  @override
  Future<PermissionStatus> getNotificationStatus() {
    return Permission.notification.status;
  }

  @override
  Future<PermissionStatus> requestNotificationPermission() async {
    final currentStatus = await Permission.notification.status;

    if (currentStatus.isPermanentlyDenied) {
      // Если разрешение отклонено навсегда, открываем настройки
      await permission_handler.openAppSettings();
      // Обновляем статус после открытия настроек
      await _updateStatus();
      return await Permission.notification.status;
    } else {
      // Иначе запрашиваем разрешение
      final result = await Permission.notification.request();
      // Обновляем статус и уведомляем подписчиков
      await _updateStatus();
      return result;
    }
  }

  @override
  Future<bool> openAppSettings() async {
    return await permission_handler.openAppSettings();
  }

  @override
  Stream<PermissionStatus> get notificationStatusStream {
    // Сначала отправляем текущий статус
    _updateStatus();
    return _statusController.stream;
  }

  void dispose() {
    _statusSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _statusController.close();
  }
}
