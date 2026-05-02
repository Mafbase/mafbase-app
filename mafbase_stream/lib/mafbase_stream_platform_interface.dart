import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:mafbase_stream/mafbase_stream_method_channel.dart';

abstract class MafbaseStreamPlatform extends PlatformInterface {
  /// Constructs a MafbaseStreamPlatform.
  MafbaseStreamPlatform() : super(token: _token);

  static final Object _token = Object();

  static MafbaseStreamPlatform _instance = MethodChannelMafbaseStream();

  /// The default instance of [MafbaseStreamPlatform] to use.
  ///
  /// Defaults to [MethodChannelMafbaseStream].
  static MafbaseStreamPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MafbaseStreamPlatform] when
  /// they register themselves.
  static set instance(MafbaseStreamPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> openStreamScreen({
    String? rtmpUrl,
    String? streamKey,
    String? overlayViewType,
    int? tournamentId,
    int? table,
  }) {
    throw UnimplementedError('openStreamScreen() has not been implemented.');
  }

  Future<void> openOverlayPreview({required String overlayViewType, int? tournamentId, int? table}) {
    throw UnimplementedError('openOverlayPreview() has not been implemented.');
  }
}
