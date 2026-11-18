import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

Future<String?> get deviceId async {
  if (Platform.isAndroid) {
    final androidInfo = await _deviceInfo.androidInfo;
    return androidInfo.id; // Android ID
  } else if (Platform.isIOS) {
    final iosInfo = await _deviceInfo.iosInfo;
    return iosInfo.identifierForVendor; // IDFV для iOS
  } else if (Platform.isWindows) {
    final windowsInfo = await _deviceInfo.windowsInfo;
    return windowsInfo.deviceId;
  } else if (Platform.isMacOS) {
    final macInfo = await _deviceInfo.macOsInfo;
    return macInfo.systemGUID;
  } else if (Platform.isLinux) {
    final linuxInfo = await _deviceInfo.linuxInfo;
    return linuxInfo.machineId;
  }

  return null;
}
