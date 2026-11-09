@Timeout(Duration(seconds: 30))
library;

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_sheet.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/widgets/organizer_setup_launcher.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_router.dart';

import '../../feature/organizer_checklist/organizer_checklist_fixtures.dart';
import '../fake_browser_history.dart';

class _FakeRepositoryFactory implements RepositoryFactory {
  _FakeRepositoryFactory(this.tournamentEditRepository);

  @override
  final TournamentEditRepository tournamentEditRepository;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeDependencyScope implements DependencyScope {
  _FakeDependencyScope(this.repositoryFactory);

  @override
  final RepositoryFactory repositoryFactory;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Страница турнира — запуск мастера над вложенным роутером, её параметры собираются так же, как
/// в сгенерированном TournamentRoute. Дочерние страницы — заглушки с теми же именами маршрутов.
class _TestRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: PageInfo('TournamentsRoute', builder: (_) => const Text('tournaments')), path: '/tournament'),
        AutoRoute(
          page: PageInfo(
            TournamentRoute.name,
            builder: (data) {
              final args = data.argsAs<TournamentRouteArgs>(
                orElse: () => TournamentRouteArgs(
                  tournamentId: data.inheritedPathParams.getInt('id'),
                  setup: data.queryParams.optInt('setup'),
                ),
              );
              return OrganizerSetupLauncher(
                tournamentId: args.tournamentId,
                enabled: args.setup == 1,
                child: const AutoRouter(),
              );
            },
          ),
          path: '/tournament/:id',
          children: [
            AutoRoute(page: PageInfo('PlayersRoute', builder: (_) => const Text('players')), path: ''),
            AutoRoute(
              page: PageInfo(OrganizerChecklistRoute.name, builder: (_) => const Text('checklist')),
              path: 'checklist',
            ),
            AutoRoute(page: PageInfo(SeatingRoute.name, builder: (_) => const Text('seating')), path: 'editSeating'),
          ],
        ),
      ];
}

class _Tournament {
  _Tournament(TournamentPageState initial) {
    bloc = RecordingTournamentPageBloc(initial, states: _states.stream);
    addTearDown(_states.close);
    addTearDown(bloc.close);
  }

  /// Широковещательный: закрытие обычного контроллера без подписчика не завершается и вешает тест.
  final _states = StreamController<TournamentPageState>.broadcast();
  late final RecordingTournamentPageBloc bloc;

  void emit(TournamentPageState state) => _states.add(state);
}

Future<_TestRouter> _pumpApp(
  WidgetTester tester, {
  required String url,
  required TournamentPageBloc tournamentBloc,
  RecordingTournamentEditRepository? repository,
}) async {
  final checklistBloc = RecordingOrganizerChecklistBloc(const OrganizerChecklistState());
  addTearDown(checklistBloc.close);

  final router = _TestRouter();
  await tester.pumpWidget(
    DependencyScopeWidget(
      scope: _FakeDependencyScope(_FakeRepositoryFactory(repository ?? RecordingTournamentEditRepository())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
          BlocProvider<OrganizerChecklistBloc>.value(value: checklistBloc),
        ],
        child: MaterialApp.router(
          theme: AppTheme.light(isMobile: true),
          locale: const Locale('ru'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router.config(deepLinkBuilder: (_) => DeepLink.path(url)),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}

/// Как после создания турнира: [TournamentsRouterImpl] открывает его с признаком мастера.
Future<void> _openCreatedTournament(WidgetTester tester) async {
  TournamentsRouterImpl(tester.element(find.text('tournaments'))).openTournament(1, setup: true);
  await tester.pumpAndSettle();
}

Future<void> _walkToTheEnd(WidgetTester tester, {required bool fsm}) async {
  if (fsm) {
    await tester.tap(find.text('Да'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'https://gomafia.pro/tournament/42');
    await tester.pump();
    await tester.tap(find.text('Сохранить'));
  } else {
    await tester.tap(find.text('Нет'));
  }
  await tester.pumpAndSettle();
  await tester.tap(find.text('Пока не знаю'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('appears once for an own new tournament, and neither navigation nor a browser refresh brings it back',
      (tester) async {
    final history = FakeBrowserHistory()..attach(tester);
    final tournament = _Tournament(const TournamentPageState());
    final router = await _pumpApp(tester, url: '/tournament', tournamentBloc: tournament.bloc);

    await _openCreatedTournament(tester);
    expect(history.url, '/tournament/1?setup=1');
    expect(find.byType(OrganizerSetupSheet), findsNothing, reason: 'waits until the tournament is known to be own');

    tournament.emit(ownerTournament);
    await tester.pumpAndSettle();
    expect(find.byType(OrganizerSetupSheet), findsOneWidget);
    expect(history.url, '/tournament/1', reason: 'the address no longer opens the wizard');
    final reportedBeforeCleanup = history.reported.length - 1;

    tournament.emit(ownerTournament.copyWith(billedPlayers: 20));
    await tester.pumpAndSettle();
    expect(find.byType(OrganizerSetupSheet), findsOneWidget);

    await tester.tap(find.byType(CloseButton));
    await tester.pumpAndSettle();
    expect(find.byType(OrganizerSetupSheet), findsNothing);
    expect(find.text('players'), findsOneWidget, reason: 'closing the wizard keeps the tournament page');

    tournament.emit(ownerTournament.copyWith(billedPlayers: 30));
    await tester.pumpAndSettle();
    router.push(OrganizerChecklistRoute(tournamentId: 1));
    await tester.pumpAndSettle();
    await router.maybePopTop();
    await tester.pumpAndSettle();
    expect(find.text('players'), findsOneWidget);
    expect(find.byType(OrganizerSetupSheet), findsNothing);
    expect(history.url, '/tournament/1');
    expect(history.reported.skip(reportedBeforeCleanup), everyElement(isNot(contains('setup'))));

    await tester.pumpWidget(const SizedBox());
    await _pumpApp(tester, url: history.url, tournamentBloc: _Tournament(ownerTournament).bloc);
    expect(find.text('players'), findsOneWidget);
    expect(find.byType(OrganizerSetupSheet), findsNothing, reason: 'refreshing the page does not show it again');
  });

  testWidgets('the wizard keeps working after the address is cleaned', (tester) async {
    FakeBrowserHistory().attach(tester);
    final tournament = _Tournament(const TournamentPageState());
    await _pumpApp(tester, url: '/tournament', tournamentBloc: tournament.bloc);
    await _openCreatedTournament(tester);

    tournament.emit(ownerTournament);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Нет'));
    await tester.pumpAndSettle();

    expect(find.text('Будете вести трансляцию с плашками?'), findsOneWidget);
  });

  testWidgets('does not appear for someone else\'s tournament', (tester) async {
    final history = FakeBrowserHistory()..attach(tester);
    final tournament = _Tournament(const TournamentPageState());
    await _pumpApp(tester, url: '/tournament', tournamentBloc: tournament.bloc);
    await _openCreatedTournament(tester);

    tournament.emit(const TournamentPageState(isLoading: false, isBillingLoaded: true));
    await tester.pumpAndSettle();

    expect(find.text('players'), findsOneWidget);
    expect(find.byType(OrganizerSetupSheet), findsNothing);
    expect(history.url, '/tournament/1?setup=1', reason: 'nothing is shown, so nothing to clean up');
  });

  testWidgets('does not appear when the tournament is opened without the flag', (tester) async {
    FakeBrowserHistory().attach(tester);
    await _pumpApp(tester, url: '/tournament/1', tournamentBloc: _Tournament(ownerTournament).bloc);

    expect(find.text('players'), findsOneWidget);
    expect(find.byType(OrganizerSetupSheet), findsNothing);
  });

  testWidgets('"Open checklist" at the end leads to the checklist page', (tester) async {
    FakeBrowserHistory().attach(tester);
    final tournament = _Tournament(const TournamentPageState());
    final router = await _pumpApp(tester, url: '/tournament', tournamentBloc: tournament.bloc);
    await _openCreatedTournament(tester);
    tournament.emit(ownerTournament);
    await tester.pumpAndSettle();

    await _walkToTheEnd(tester, fsm: false);
    expect(find.text('Загрузить участников и рассадку с GoMafia'), findsNothing);
    await tester.tap(find.text('Открыть чеклист'));
    await tester.pumpAndSettle();

    expect(find.byType(OrganizerSetupSheet), findsNothing);
    expect(router.topRoute.name, OrganizerChecklistRoute.name);
  });

  testWidgets('in an FSM tournament the main button at the end opens the GoMafia import', (tester) async {
    FakeBrowserHistory().attach(tester);
    final tournament = _Tournament(const TournamentPageState());
    final repository = RecordingTournamentEditRepository();
    final router = await _pumpApp(tester, url: '/tournament', tournamentBloc: tournament.bloc, repository: repository);
    await _openCreatedTournament(tester);
    tournament.emit(ownerTournament);
    await tester.pumpAndSettle();

    await _walkToTheEnd(tester, fsm: true);
    expect(repository.savedGomafiaUrls, ['https://gomafia.pro/tournament/42']);
    await tester.tap(find.text('Загрузить участников и рассадку с GoMafia'));
    await tester.pumpAndSettle();

    expect(find.byType(OrganizerSetupSheet), findsNothing);
    expect(router.topRoute.name, SeatingRoute.name);
    expect(router.topRoute.queryParams.optInt('gomafia'), 1);
  });
}
