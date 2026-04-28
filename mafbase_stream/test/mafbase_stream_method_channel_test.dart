import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mafbase_stream/mafbase_stream_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMafbaseStream platform = MethodChannelMafbaseStream();
  const MethodChannel channel = MethodChannel('mafbase_stream');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (
      MethodCall methodCall,
    ) async {
      return '42';
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
