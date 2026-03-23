import 'package:seating_generator_web/data/services/device_id/device_id.dart';

class DeviceIdService {
  /// Получить уникальный идентификатор устройства
  Future<String?> getDeviceId() async {
    try {
      return await deviceId;
    } catch (e) {
      return null;
    }
  }
}
