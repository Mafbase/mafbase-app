import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:mafbase_stream/mafbase_stream_platform_interface.dart';

/// Web no-op implementation. Все методы плагина — заглушки: на web нет камеры,
/// RTMP-энкодера и нативных оверлеев, поэтому вызовы безопасно игнорируются.
/// Подключается автоматически при сборке web-таргета через flutter pub get
/// (см. pubspec.yaml → flutter.plugin.platforms.web).
class MafbaseStreamWeb extends MafbaseStreamPlatform {
  static void registerWith(Registrar registrar) {
    MafbaseStreamPlatform.instance = MafbaseStreamWeb();
  }

  @override
  Future<String> getPlatformVersion() async => 'web (unsupported)';

  @override
  Future<void> openStreamScreen({
    String? rtmpUrl,
    String? streamKey,
    String? overlayViewType,
    int? tournamentId,
    int? table,
  }) async {}

  @override
  Future<void> openOverlayPreview({required String overlayViewType, int? tournamentId, int? table}) async {}
}
