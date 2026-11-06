import 'golden_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/feature/streams/ui/broadcast_page.dart';
import 'package:seating_generator_web/utils/platform.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('BroadcastPage golden tests', () {
    testGoldens('operator link opened in a browser', (tester) async {
      debugIsWebOverride = true;
      addTearDown(() => debugIsWebOverride = null);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(
          widget: adaptiveThemedWidget(const BroadcastPage(tournamentId: 1, table: 2, broadcastKey: 'operator-token')),
          name: 'web',
        );

      await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
      await screenMatchesGolden(tester, goldenName('broadcast_page/web'), customPump: (t) => t.pump());
    });
  });
}
