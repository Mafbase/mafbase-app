import 'golden_utils.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/domain/models/translation_key_model.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_info_sheet.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_item_sheet.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/utils.dart';

import '../feature/organizer_checklist/organizer_checklist_fixtures.dart';

class _MockTournamentPageBloc extends MockBloc<TournamentPageEvent, TournamentPageState>
    implements TournamentPageBloc {}

class _FakeTranslationRepository implements TranslationRepository {
  @override
  Future<TranslationKeyModel> getKey({required int tournamentId}) =>
      Future.value(const TranslationKeyModel(key: 'tournament-key', designs: []));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeRepositoryFactory implements RepositoryFactory {
  @override
  final TranslationRepository translationRepository = _FakeTranslationRepository();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeDependencyScope implements DependencyScope {
  @override
  final RepositoryFactory repositoryFactory = _FakeRepositoryFactory();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Справка длинная: на высоких экранах лист со скриншотами виден целиком.
List<Device> _tallDevices(double height) => [
      Device(name: 'light_desktop', size: Size(1100, height)),
      Device(name: 'light_mobile', size: Size(390, height)),
      Device(name: 'dark_desktop', size: Size(1100, height), brightness: Brightness.dark),
      Device(name: 'dark_mobile', size: Size(390, height), brightness: Brightness.dark),
    ];

/// Свой Navigator у каждого сценария держит модальный лист внутри рамки устройства.
Widget _sheetScenario(void Function(BuildContext context) open) {
  final tournamentBloc = _MockTournamentPageBloc();
  whenListen(
    tournamentBloc,
    const Stream<TournamentPageState>.empty(),
    initialState: const TournamentPageState(isLoading: false, isMyTournament: true, isBillingLoaded: true),
  );
  addTearDown(tournamentBloc.close);
  final checklistBloc = RecordingOrganizerChecklistBloc(const OrganizerChecklistState());
  addTearDown(checklistBloc.close);

  return adaptiveThemedWidget(
    DependencyScopeWidget(
      scope: _FakeDependencyScope(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
          BlocProvider<OrganizerChecklistBloc>.value(value: checklistBloc),
        ],
        child: Navigator(
          onGenerateRoute: (_) => MaterialPageRoute<void>(
            builder: (_) => Scaffold(body: _SheetOpener(open: open)),
          ),
        ),
      ),
    ),
  );
}

/// Лист пункта со страницы чеклиста, где в турнире только этот пункт.
Widget _itemScenario(ChecklistItemModel item) => _sheetScenario(
      (context) => OrganizerChecklistItemSheet.show(
        context,
        tournamentId: 1,
        item: item,
        checklist: OrganizerChecklistModel(isFsm: false, items: [item]),
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

Future<void> _matchGolden(
  WidgetTester tester,
  Widget scenario,
  String name, {
  List<Device> devices = appDevices,
}) async {
  final builder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: devices)
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
          (context) => OrganizerChecklistItemSheet.show(
            context,
            tournamentId: 1,
            item: const ChecklistItemModel(key: ChecklistKey.translationBilling, status: ChecklistStatus.todo),
            title: context.locale.translationDialogTitle,
            showStatus: false,
            showDismiss: false,
          ),
        ),
        'info_sheet_translation',
      );
    });

    testGoldens('notifications sheet before payment', (tester) async {
      await _matchGolden(
        tester,
        _sheetScenario(
          (context) => OrganizerChecklistItemSheet.show(
            context,
            tournamentId: 1,
            item: const ChecklistItemModel(key: ChecklistKey.notifyCoverage, status: ChecklistStatus.locked),
            title: context.locale.tournamentMenuNotifications,
            showStatus: false,
            showDismiss: false,
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

    // Ссылки для OBS по столам в листе оплаченных плашек рисуются шрифтом Inter, который в тестах не грузится,
    // поэтому шаги со скриншотами сняты у пункта до оплаты.
    testGoldens('OBS widget steps with screenshots', (tester) async {
      await _matchGolden(
        tester,
        _itemScenario(const ChecklistItemModel(key: ChecklistKey.obsWidget, status: ChecklistStatus.locked)),
        'info_sheet_obs_widget',
        devices: _tallDevices(2300),
      );
    });

    testGoldens('OBS scenes with the control page screenshot', (tester) async {
      await _matchGolden(
        tester,
        _itemScenario(const ChecklistItemModel(key: ChecklistKey.obsScenes, status: ChecklistStatus.todo)),
        'info_sheet_obs_scenes',
        devices: _tallDevices(1900),
      );
    });

    testGoldens('stream method choice', (tester) async {
      await _matchGolden(
        tester,
        _itemScenario(const ChecklistItemModel(key: ChecklistKey.streamMethod, status: ChecklistStatus.todo)),
        'info_sheet_stream_method',
        devices: _tallDevices(1500),
      );
    });

    testGoldens('phone operator steps', (tester) async {
      await _matchGolden(
        tester,
        _itemScenario(
          const ChecklistItemModel(key: ChecklistKey.phoneOperator, status: ChecklistStatus.todo, current: 0, total: 1),
        ),
        'info_sheet_phone_operator',
        devices: _tallDevices(1900),
      );
    });
  });
}
