import 'package:flutter_test/flutter_test.dart';
import 'package:mafbase_stream/mafbase_stream.dart';
import 'package:mafbase_stream/mafbase_stream_platform_interface.dart';
import 'package:mafbase_stream/mafbase_stream_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMafbaseStreamPlatform with MockPlatformInterfaceMixin implements MafbaseStreamPlatform {
  @override
  Future<String> getPlatformVersion() => Future.value('42');

  @override
  Future<void> openStreamScreen({
    String? rtmpUrl,
    String? streamKey,
    String? overlayViewType,
    int? tournamentId,
    int? table,
  }) => Future.value();

  @override
  Future<void> openOverlayPreview({required String overlayViewType, int? tournamentId, int? table}) => Future.value();
}

void main() {
  final MafbaseStreamPlatform initialPlatform = MafbaseStreamPlatform.instance;

  test('$MethodChannelMafbaseStream is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMafbaseStream>());
  });

  test('getPlatformVersion', () async {
    MafbaseStream mafbaseStreamPlugin = MafbaseStream();
    MockMafbaseStreamPlatform fakePlatform = MockMafbaseStreamPlatform();
    MafbaseStreamPlatform.instance = fakePlatform;

    expect(await mafbaseStreamPlugin.getPlatformVersion(), '42');
  });
}
