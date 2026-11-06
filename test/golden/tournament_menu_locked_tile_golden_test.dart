import 'golden_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/feature/tournament/ui/models/tournament_menu_models.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_locked_tile.dart';
import 'package:seating_generator_web/utils.dart';

const _sidebarLight = Device(name: 'light', size: Size(300, 260));
const _sidebarDark = Device(name: 'dark', size: Size(300, 260), brightness: Brightness.dark);

/// Шрифты меню (Inter из google_fonts) в тестах не грузятся, поэтому плитки получают Roboto тех же размеров.
Widget _lockedTiles() => themedWidget(
      Builder(
        builder: (context) {
          final locale = context.locale;
          final items = [
            TournamentMenuLockedItem(
              text: locale.translationDialogTitle,
              icon: Icons.layers_outlined,
              hint: locale.tournamentMenuLockedHint,
              onTap: () {},
            ),
            TournamentMenuLockedItem(
              text: locale.tournamentMenuNotifications,
              icon: Icons.notifications_outlined,
              hint: locale.tournamentMenuLockedHint,
              onTap: () {},
            ),
          ];

          return ColoredBox(
            color: context.theme.darkBlueColor,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 4,
                children: [
                  for (final item in items)
                    TournamentMenuLockedTile(
                      item: item,
                      iconSize: 20,
                      minHeight: 42,
                      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      hintStyle: const TextStyle(fontSize: 11),
                    ),
                  const SizedBox(height: 16),
                  for (final item in items)
                    TournamentMenuLockedTile(
                      item: item,
                      iconSize: 22,
                      minHeight: 46,
                      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      hintStyle: const TextStyle(fontSize: 12),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('TournamentMenuLockedTile golden tests', () {
    testGoldens('desktop menu and drawer tiles', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: const [_sidebarLight, _sidebarDark])
        ..addScenario(widget: _lockedTiles(), name: 'locked_tiles');

      await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('tournament_menu/locked_tiles'),
        customPump: (t) => t.pump(),
      );
    });
  });
}
