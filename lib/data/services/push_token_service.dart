import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seating_generator_web/data/services/device_id_service.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';

class PushTokenService {
  final AuthRepository _authRepository;
  final DeviceIdService _deviceIdService;
  String? _lastSentToken;
  String? _lastSentDeviceId;

  PushTokenService(this._authRepository, this._deviceIdService);

  /// Получить FCM токен
  /// Возвращает null если разрешение на уведомления не выдано
  Future<String?> getFcmToken() async {
    try {
      // Проверяем статус разрешения перед запросом токена
      // getToken() сам запрашивает разрешение, что не нужно на старте
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        return null;
      }
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      return null;
    }
  }

  /// Получить deviceId
  Future<String?> getDeviceId() async {
    return await _deviceIdService.getDeviceId();
  }

  Stream<String> get tokenUpdatedStream => FirebaseMessaging.instance.onTokenRefresh;

  /// Отправить push token и deviceId на сервер через auth запрос
  Future<void> sendPushTokenToServer() async {
    try {
      final token = await getFcmToken();
      final deviceId = await getDeviceId();

      final shouldSendToken = token != null && token.isNotEmpty && token != _lastSentToken;
      final shouldSendDeviceId = deviceId != null && deviceId.isNotEmpty && deviceId != _lastSentDeviceId;

      if (shouldSendToken || shouldSendDeviceId) {
        await _authRepository.auth(
          pushToken: token,
          deviceId: deviceId,
        );
        if (token != null) _lastSentToken = token;
        if (deviceId != null) _lastSentDeviceId = deviceId;
      }
    } catch (e) {
      // Игнорируем ошибки отправки токена
    }
  }
}
