import 'golden_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/notification_coverage_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_page.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/start_game_info_form.dart';
import 'package:seating_generator_web/utils.dart';

import '../feature/organizer_checklist/notification_coverage_fixtures.dart';
import '../feature/organizer_checklist/organizer_checklist_fixtures.dart';

List<Device> _devices({required double desktopHeight, required double mobileHeight}) => [
      Device(name: 'light_desktop', size: Size(1100, desktopHeight)),
      Device(name: 'light_mobile', size: Size(390, mobileHeight)),
      Device(name: 'dark_desktop', size: Size(1100, desktopHeight), brightness: Brightness.dark),
      Device(name: 'dark_mobile', size: Size(390, mobileHeight), brightness: Brightness.dark),
    ];

Widget _page(NotificationCoverageModel coverage) {
  final bloc = RecordingNotificationCoverageBloc(NotificationCoverageState(coverage: coverage, isLoading: false));
  final tournamentBloc = RecordingTournamentPageBloc(ownerTournament);
  addTearDown(bloc.close);
  addTearDown(tournamentBloc.close);

  return MultiBlocProvider(
    providers: [
      BlocProvider<NotificationCoverageBloc>.value(value: bloc),
      BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
    ],
    child: adaptiveThemedWidget(const NotificationCoverageContent(tournamentId: 1)),
  );
}

/// Форма оповещения о начале игры в боковом меню: с выбранной игрой и без количества игр.
Widget _forms() {
  final checklistBloc = RecordingOrganizerChecklistBloc(
    OrganizerChecklistState(
      checklist: OrganizerChecklistModel(
        isFsm: false,
        items: [checklistItem(ChecklistKey.notifyCoverage, ChecklistStatus.warning, current: 14, total: 20)],
      ),
    ),
  );
  final tournamentBloc = RecordingTournamentPageBloc(ownerTournament);
  addTearDown(checklistBloc.close);
  addTearDown(tournamentBloc.close);

  return MultiBlocProvider(
    providers: [
      BlocProvider<OrganizerChecklistBloc>.value(value: checklistBloc),
      BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
    ],
    child: themedWidget(
      Builder(
        builder: (context) => ColoredBox(
          color: context.theme.darkBlueColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 24,
              children: [
                StartGameInfoForm(maxGame: 3, onCollapse: () {}),
                StartGameInfoForm(maxGame: 0, onCollapse: () {}),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> _matchGolden(
  WidgetTester tester,
  Widget scenario,
  String name,
  List<Device> devices, {
  Future<void> Function()? interact,
}) async {
  final builder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: devices)
    ..addScenario(widget: scenario, name: name);

  await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
  await interact?.call();
  await screenMatchesGolden(tester, goldenName('organizer_checklist/$name'), customPump: (t) => t.pump());
}

/// Выбирает игру в форме каждого устройства, чтобы кнопка «Отправить» стала активной.
Future<void> _selectGame(WidgetTester tester) async {
  final dropdowns = find.byType(DropdownButton<int>);
  for (var index = 0; index < dropdowns.evaluate().length; index++) {
    await tester.tap(dropdowns.at(index));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text('2').last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
  }
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('NotificationCoveragePage golden tests', () {
    testGoldens('FSM tournament', (tester) async {
      await _matchGolden(
        tester,
        _page(fsmCoverage()),
        'coverage_fsm',
        _devices(desktopHeight: 1250, mobileHeight: 1400),
      );
    });

    testGoldens('not an FSM tournament', (tester) async {
      await _matchGolden(
        tester,
        _page(notFsmCoverage()),
        'coverage_not_fsm',
        _devices(desktopHeight: 1100, mobileHeight: 1300),
      );
    });

    testGoldens('subscriptions unavailable', (tester) async {
      await _matchGolden(
        tester,
        _page(unavailableCoverage()),
        'coverage_unavailable',
        _devices(desktopHeight: 900, mobileHeight: 1100),
      );
    });

    testGoldens('notification form in the menu with the coverage counter', (tester) async {
      await _matchGolden(
        tester,
        _forms(),
        'coverage_form_counter',
        const [
          Device(name: 'light', size: Size(300, 340)),
          Device(name: 'dark', size: Size(300, 340), brightness: Brightness.dark),
        ],
        interact: () => _selectGame(tester),
      );
    });
  });
}
