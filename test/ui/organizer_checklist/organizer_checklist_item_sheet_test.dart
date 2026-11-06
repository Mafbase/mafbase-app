@Timeout(Duration(seconds: 20))
library;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/domain/models/translation_key_model.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_item_sheet.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/utils/platform.dart';

import '../../feature/organizer_checklist/organizer_checklist_fixtures.dart';

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

/// Страницы назначения подменены заглушками с теми же именами маршрутов: лист ведёт туда же, что в приложении.
class _TestRouter extends RootStackRouter {
  _TestRouter(this.home);

  final Widget home;

  static final _targets = [
    TournamentSettingsRoute.name,
    SeatingRoute.name,
    InfoTableDescriptionRoute.name,
    NotificationCoverageRoute.name,
    StreamsRoute.name,
    TranslationControlRoute.name,
  ];

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: PageInfo('HomeRoute', builder: (_) => home), path: '/'),
        for (final name in _targets)
          AutoRoute(
            page: PageInfo(name, builder: (_) => Scaffold(body: Text('page $name'))),
            path: '/$name',
          ),
      ];
}

class _Harness {
  _Harness(this.router, this.tournamentBloc);

  final _TestRouter router;
  final RecordingTournamentPageBloc tournamentBloc;

  RouteData get current => router.current;
}

Future<_Harness> _pumpSheet(
  WidgetTester tester,
  ChecklistItemModel item, {
  bool isFsm = false,
  bool hideBilling = false,
}) async {
  final checklist = OrganizerChecklistModel(isFsm: isFsm, items: [item]);
  final checklistBloc = RecordingOrganizerChecklistBloc(OrganizerChecklistState(checklist: checklist));
  final tournamentBloc = RecordingTournamentPageBloc(ownerTournament);
  final seatingBloc = RecordingSeatingPageBloc(const SeatingPageState(isLoading: false));
  final authNotifier = AuthNotifier()..value = AuthNotifierModel.authorized(userId: 1, hideBilling: hideBilling);
  addTearDown(checklistBloc.close);
  addTearDown(tournamentBloc.close);
  addTearDown(seatingBloc.close);
  addTearDown(authNotifier.dispose);

  final router = _TestRouter(
    Scaffold(
      body: Builder(
        builder: (context) => TextButton(
          onPressed: () => OrganizerChecklistItemSheet.show(
            context,
            tournamentId: 1,
            item: item,
            checklist: checklist,
          ),
          child: const Text('open'),
        ),
      ),
    ),
  );

  await tester.pumpWidget(
    DependencyScopeWidget(
      scope: _FakeDependencyScope(),
      child: ChangeNotifierProvider<AuthNotifier>.value(
        value: authNotifier,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<OrganizerChecklistBloc>.value(value: checklistBloc),
            BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
            BlocProvider<SeatingPageBloc>.value(value: seatingBloc),
          ],
          child: MaterialApp.router(
            theme: AppTheme.light(isMobile: false),
            locale: const Locale('ru'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router.config(),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return _Harness(router, tournamentBloc);
}

Future<void> _tapAndSettle(WidgetTester tester, String text) async {
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('number of games leads to the tournament settings', (tester) async {
    final harness = await _pumpSheet(tester, checklistItem(ChecklistKey.gamesCount, ChecklistStatus.todo));

    await _tapAndSettle(tester, 'Сделать');

    expect(harness.current.name, TournamentSettingsRoute.name);
  });

  testWidgets('participants open the add dialog, in an FSM tournament the GoMafia import', (tester) async {
    var harness = await _pumpSheet(tester, checklistItem(ChecklistKey.players, ChecklistStatus.todo, current: 4));
    await _tapAndSettle(tester, 'Сделать');
    expect(harness.tournamentBloc.added, [const TournamentPageEvent.addPlayerTapped()]);
    expect(harness.current.name, 'HomeRoute');

    await tester.pumpWidget(const SizedBox());
    harness = await _pumpSheet(
      tester,
      checklistItem(ChecklistKey.players, ChecklistStatus.todo, current: 0),
      isFsm: true,
    );
    await _tapAndSettle(tester, 'Сделать');
    expect(harness.current.name, SeatingRoute.name);
    expect(harness.current.queryParams.optInt('gomafia'), 1);
  });

  testWidgets('seating opens the GoMafia import only in an FSM tournament', (tester) async {
    var harness = await _pumpSheet(tester, checklistItem(ChecklistKey.seating, ChecklistStatus.todo));
    await _tapAndSettle(tester, 'Сделать');
    expect(harness.current.name, SeatingRoute.name);
    expect(harness.current.queryParams.optInt('gomafia'), isNull);

    await tester.pumpWidget(const SizedBox());
    harness = await _pumpSheet(tester, checklistItem(ChecklistKey.seating, ChecklistStatus.todo), isFsm: true);
    await _tapAndSettle(tester, 'Сделать');
    expect(harness.current.name, SeatingRoute.name);
    expect(harness.current.queryParams.optInt('gomafia'), 1);
  });

  testWidgets('notification reach, table descriptions and phone items lead to their pages', (tester) async {
    final cases = {
      ChecklistKey.notifyCoverage: NotificationCoverageRoute.name,
      ChecklistKey.tableDescriptions: InfoTableDescriptionRoute.name,
      ChecklistKey.phoneStream: StreamsRoute.name,
      ChecklistKey.phoneOperator: StreamsRoute.name,
    };
    for (final MapEntry(:key, :value) in cases.entries) {
      await tester.pumpWidget(const SizedBox());
      final harness = await _pumpSheet(tester, checklistItem(key, ChecklistStatus.todo));
      await _tapAndSettle(tester, 'Сделать');
      expect(harness.current.name, value, reason: '$key');
    }
  });

  testWidgets('scenes open the control page of table 1 inside the app', (tester) async {
    debugIsWebOverride = false;
    addTearDown(() => debugIsWebOverride = null);
    final harness = await _pumpSheet(tester, checklistItem(ChecklistKey.obsScenes, ChecklistStatus.todo));

    await _tapAndSettle(tester, 'Сделать');

    expect(harness.current.name, TranslationControlRoute.name);
    expect(harness.current.queryParams.optInt('tournamentId'), 1);
    expect(harness.current.queryParams.optInt('table'), 1);
    expect(harness.current.queryParams.optString('key'), 'tournament-key');
  });

  testWidgets('a locked overlay item pays for overlays, a locked notification item for the tournament', (tester) async {
    await _pumpSheet(tester, checklistItem(ChecklistKey.obsWidget, ChecklistStatus.locked));
    expect(find.text('Сделать'), findsNothing);
    await _tapAndSettle(tester, 'Оплатить');
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);

    await tester.pumpWidget(const SizedBox());
    await _pumpSheet(tester, checklistItem(ChecklistKey.tableDescriptions, ChecklistStatus.locked));
    await _tapAndSettle(tester, 'Оплатить');
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);
  });

  testWidgets('paid overlays and hidden billing leave no payment button', (tester) async {
    await _pumpSheet(tester, checklistItem(ChecklistKey.translationBilling, ChecklistStatus.done));
    expect(find.text('Оплатить'), findsNothing);

    await tester.pumpWidget(const SizedBox());
    await _pumpSheet(tester, checklistItem(ChecklistKey.billing, ChecklistStatus.todo), hideBilling: true);
    expect(find.text('Оплатить'), findsNothing);
    expect(find.text('Не нужно'), findsOneWidget);
  });
}
