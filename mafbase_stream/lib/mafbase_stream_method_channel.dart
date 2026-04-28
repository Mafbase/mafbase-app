import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:mafbase_stream/mafbase_stream_platform_interface.dart';

/// An implementation of [MafbaseStreamPlatform] that uses method channels.
class MethodChannelMafbaseStream extends MafbaseStreamPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mafbase_stream');

  @override
  Future<String> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    if (version == null) {
      throw StateError('Native side returned null for getPlatformVersion');
    }
    return version;
  }

  @override
  Future<void> openStreamScreen({
    String? rtmpUrl,
    String? streamKey,
    String? overlayViewType,
    int? tournamentId,
    int? table,
  }) async {
    await methodChannel.invokeMethod<void>('openStreamScreen', <String, dynamic>{
      'rtmpUrl': ?rtmpUrl,
      'streamKey': ?streamKey,
      'overlayViewType': ?overlayViewType,
      'tournamentId': ?tournamentId,
      'table': ?table,
    });
  }

  @override
  Future<void> openOverlayPreview({required String overlayViewType, int? tournamentId, int? table}) async {
    await methodChannel.invokeMethod<void>('openOverlayPreview', <String, dynamic>{
      'overlayViewType': overlayViewType,
      'tournamentId': ?tournamentId,
      'table': ?table,
    });
  }
}
