import 'golden_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_info_sheet.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_locked_sheets.dart';

/// Свой Navigator у каждого сценария держит модальный лист внутри рамки устройства.
Widget _sheetScenario(void Function(BuildContext context) open) => adaptiveThemedWidget(
      Navigator(
        onGenerateRoute: (_) => MaterialPageRoute<void>(
          builder: (_) => Scaffold(body: _SheetOpener(open: open)),
        ),
      ),
    );

class _SheetOpener extends StatefulWidget {
  final void Function(BuildContext context) open;

  const _SheetOpener({required this.open});

  @override
  State<_SheetOpener> createState() => _SheetOpenerState();
}

class _SheetOpenerState extends State<_SheetOpener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.open(context));
  }

  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}

Future<void> _matchGolden(WidgetTester tester, Widget scenario, String name) async {
  final builder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: appDevices)
    ..addScenario(widget: scenario, name: name);

  await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  await screenMatchesGolden(
    tester,
    goldenName('organizer_checklist/$name'),
    customPump: (t) => t.pump(),
  );
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('OrganizerChecklistInfoSheet golden tests', () {
    testGoldens('translation sheet before payment', (tester) async {
      await _matchGolden(
        tester,
        _sheetScenario(
          (context) => OrganizerChecklistLockedSheets.showTranslation(
            context,
            billedPlayers: 10,
            onPay: () {},
          ),
        ),
        'info_sheet_translation',
      );
    });

    testGoldens('notifications sheet before payment', (tester) async {
      await _matchGolden(
        tester,
        _sheetScenario(
          (context) => OrganizerChecklistLockedSheets.showNotifications(
            context,
            onPay: () {},
          ),
        ),
        'info_sheet_notifications',
      );
    });

    testGoldens('sheet with primary and secondary actions', (tester) async {
      await _matchGolden(
        tester,
        _sheetScenario(
          (context) => OrganizerChecklistInfoSheet.show(
            context,
            title: 'Количество игр',
            body: const [
              Text('Без количества игр не получится сгенерировать рассадку.'),
              Text('Укажите его в настройках турнира.'),
            ],
            primaryAction: OrganizerChecklistInfoSheetAction(text: 'Сделать', onTap: () {}),
            secondaryAction: OrganizerChecklistInfoSheetAction(text: 'Не нужно', onTap: () {}),
          ),
        ),
        'info_sheet_actions',
      );
    });
  });
}
