import 'golden_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_page.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_texts.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_banner.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_item_row.dart';
import 'package:seating_generator_web/utils.dart';

import '../feature/organizer_checklist/organizer_checklist_fixtures.dart';

List<Device> _devices({required double desktopHeight, required double mobileHeight}) => [
      Device(name: 'light_desktop', size: Size(1100, desktopHeight)),
      Device(name: 'light_mobile', size: Size(390, mobileHeight)),
      Device(name: 'dark_desktop', size: Size(1100, desktopHeight), brightness: Brightness.dark),
      Device(name: 'dark_mobile', size: Size(390, mobileHeight), brightness: Brightness.dark),
    ];

Widget _withBloc(OrganizerChecklistState state, Widget child) {
  final bloc = RecordingOrganizerChecklistBloc(state);
  addTearDown(bloc.close);
  return BlocProvider<OrganizerChecklistBloc>.value(value: bloc, child: adaptiveThemedWidget(child));
}

Future<void> _matchGolden(
  WidgetTester tester,
  Widget scenario,
  String name,
  List<Device> devices, {
  String? expand,
}) async {
  final builder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: devices)
    ..addScenario(widget: scenario, name: name);

  await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
  if (expand != null) {
    final targets = find.text(expand);
    for (var index = 0; index < targets.evaluate().length; index++) {
      await tester.tap(targets.at(index));
    }
    // Первый кадр запускает анимацию раскрытия, второй доводит её до конца.
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
  }
  await screenMatchesGolden(tester, goldenName('organizer_checklist/$name'), customPump: (t) => t.pump());
}

class _Rows extends StatelessWidget {
  const _Rows();

  static const _items = [
    ChecklistItemModel(key: ChecklistKey.gamesCount, status: ChecklistStatus.done),
    ChecklistItemModel(key: ChecklistKey.tableDescriptions, status: ChecklistStatus.todo, current: 0, total: 2),
    ChecklistItemModel(key: ChecklistKey.players, status: ChecklistStatus.warning, current: 23),
    ChecklistItemModel(key: ChecklistKey.obsWidget, status: ChecklistStatus.locked),
    ChecklistItemModel(key: ChecklistKey.notifyCoverage, status: ChecklistStatus.warning, unavailable: true),
  ];

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return ColoredBox(
      color: context.theme.background1,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              children: [
                for (final item in _items)
                  OrganizerChecklistItemRow(
                    status: item.status,
                    title: locale.checklistItemTitle(item.key),
                    subtitle: locale.checklistItemSubtitle(item),
                    onTap: () {},
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

OrganizerChecklistModel _nextLockedOverlays() => OrganizerChecklistModel(
      isFsm: false,
      items: [
        checklistItem(ChecklistKey.gamesCount, ChecklistStatus.done),
        checklistItem(ChecklistKey.players, ChecklistStatus.done, current: 20),
        checklistItem(ChecklistKey.seating, ChecklistStatus.done, current: 5, total: 5),
        checklistItem(ChecklistKey.billing, ChecklistStatus.done),
        checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.done, current: 20, total: 20),
        checklistItem(ChecklistKey.tableDescriptions, ChecklistStatus.dismissed),
        checklistItem(ChecklistKey.streamMethod, ChecklistStatus.done),
        checklistItem(ChecklistKey.translationBilling, ChecklistStatus.dismissed),
        checklistItem(ChecklistKey.obsWidget, ChecklistStatus.locked),
        checklistItem(ChecklistKey.obsScenes, ChecklistStatus.locked),
        checklistItem(ChecklistKey.phoneStream, ChecklistStatus.dismissed),
        checklistItem(ChecklistKey.phoneOperator, ChecklistStatus.dismissed),
      ],
    );

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('OrganizerChecklistPage golden tests', () {
    final pageDevices = _devices(desktopHeight: 1460, mobileHeight: 1640);

    testGoldens('stream method not chosen', (tester) async {
      await _matchGolden(
        tester,
        _withBloc(
          OrganizerChecklistState(checklist: checklistMethodNotChosen()),
          const OrganizerChecklistPage(tournamentId: 1),
        ),
        'page_method_not_chosen',
        pageDevices,
      );
    });

    testGoldens('FSM tournament streams from a phone', (tester) async {
      await _matchGolden(
        tester,
        _withBloc(
          OrganizerChecklistState(checklist: checklistPhoneChosen()),
          const OrganizerChecklistPage(tournamentId: 1),
        ),
        'page_fsm_phone_chosen',
        pageDevices,
        expand: 'Скрытые (2)',
      );
    });

    testGoldens('translation is not needed', (tester) async {
      await _matchGolden(
        tester,
        _withBloc(
          OrganizerChecklistState(checklist: checklistTranslationHidden()),
          const OrganizerChecklistPage(tournamentId: 1),
        ),
        'page_translation_hidden',
        _devices(desktopHeight: 940, mobileHeight: 1000),
        expand: 'Скрытые (7)',
      );
    });

    testGoldens('item rows in every status', (tester) async {
      await _matchGolden(
        tester,
        adaptiveThemedWidget(const _Rows()),
        'item_rows',
        _devices(desktopHeight: 470, mobileHeight: 470),
      );
    });

    testGoldens('banner with the next item', (tester) async {
      await _matchGolden(
        tester,
        _withBloc(
          OrganizerChecklistState(checklist: checklistMethodNotChosen()),
          const Scaffold(body: Column(children: [OrganizerChecklistBanner()])),
        ),
        'banner_next',
        _devices(desktopHeight: 110, mobileHeight: 150),
      );
    });

    testGoldens('banner with a locked next item', (tester) async {
      await _matchGolden(
        tester,
        _withBloc(
          OrganizerChecklistState(checklist: _nextLockedOverlays()),
          const Scaffold(body: Column(children: [OrganizerChecklistBanner()])),
        ),
        'banner_locked',
        _devices(desktopHeight: 110, mobileHeight: 150),
      );
    });
  });
}
