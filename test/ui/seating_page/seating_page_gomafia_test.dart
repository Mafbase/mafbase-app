@Timeout(Duration(seconds: 20))
library;

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/gomafia_input_dialog.dart';

import '../../feature/organizer_checklist/organizer_checklist_fixtures.dart';
import '../fake_browser_history.dart';

const _gomafiaUrl = 'https://gomafia.pro/tournament/42';

Future<StreamController<TournamentPageState>> _pumpSeating(
  WidgetTester tester, {
  required TournamentPageState tournament,
  int? gomafia,
}) async {
  final tournamentStates = StreamController<TournamentPageState>();
  final tournamentBloc = RecordingTournamentPageBloc(tournament, states: tournamentStates.stream);
  final seatingBloc = RecordingSeatingPageBloc(const SeatingPageState(isLoading: false));
  addTearDown(tournamentStates.close);
  addTearDown(tournamentBloc.close);
  addTearDown(seatingBloc.close);

  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
        BlocProvider<SeatingPageBloc>.value(value: seatingBloc),
      ],
      child: MaterialApp(
        theme: AppTheme.light(isMobile: true),
        locale: const Locale('ru'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SeatingPage(tournamentId: 1, gomafia: gomafia),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return tournamentStates;
}

void main() {
  final loaded = ownerTournament.copyWith(gomafiaUrl: _gomafiaUrl);

  testWidgets('gomafia=1 opens the import with the saved GoMafia link', (tester) async {
    await _pumpSeating(tester, tournament: loaded, gomafia: 1);

    expect(find.byType(GomafiaInputDialog), findsOneWidget);
    expect(find.widgetWithText(TextField, _gomafiaUrl), findsOneWidget);
  });

  testWidgets('waits until the tournament is loaded and known to be own', (tester) async {
    final states = await _pumpSeating(
      tester,
      tournament: const TournamentPageState(),
      gomafia: 1,
    );
    expect(find.byType(GomafiaInputDialog), findsNothing);

    states.add(const TournamentPageState(isMyTournament: true));
    await tester.pumpAndSettle();
    expect(find.byType(GomafiaInputDialog), findsNothing);

    states.add(loaded);
    await tester.pumpAndSettle();
    expect(find.byType(GomafiaInputDialog), findsOneWidget);

    await tester.tap(find.byType(CloseButton));
    await tester.pumpAndSettle();
    states.add(loaded.copyWith(billedPlayers: 20));
    await tester.pumpAndSettle();
    expect(find.byType(GomafiaInputDialog), findsNothing, reason: 'opens only once');
  });

  testWidgets('without the parameter the page opens as usual', (tester) async {
    await _pumpSeating(tester, tournament: loaded);

    expect(find.byType(GomafiaInputDialog), findsNothing);
  });

  testWidgets('the browser address loses gomafia=1 once the import opens, so a refresh does not reopen it',
      (tester) async {
    final history = FakeBrowserHistory()..attach(tester);
    final router = await _pumpSeatingRouter(tester, url: '/tournament/1', tournament: loaded);

    router.push(SeatingRoute(tournamentId: 1, gomafia: 1));
    await tester.pumpAndSettle();
    expect(find.byType(GomafiaInputDialog), findsOneWidget);
    expect(history.url, '/tournament/1/editSeating');

    await tester.tap(find.byType(CloseButton));
    await tester.pumpAndSettle();
    expect(find.byType(SeatingPage), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await _pumpSeatingRouter(tester, url: history.url, tournament: loaded);
    expect(find.byType(SeatingPage), findsOneWidget);
    expect(find.byType(GomafiaInputDialog), findsNothing);
  });
}

class _SeatingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: PageInfo('TournamentRoute', builder: (_) => const AutoRouter()),
          path: '/tournament/:id',
          children: [
            AutoRoute(page: PageInfo('PlayersRoute', builder: (_) => const Text('players')), path: ''),
            AutoRoute(page: SeatingRoute.page, path: 'editSeating'),
          ],
        ),
      ];
}

Future<_SeatingRouter> _pumpSeatingRouter(
  WidgetTester tester, {
  required String url,
  required TournamentPageState tournament,
}) async {
  final tournamentBloc = RecordingTournamentPageBloc(tournament);
  final seatingBloc = RecordingSeatingPageBloc(const SeatingPageState(isLoading: false));
  addTearDown(tournamentBloc.close);
  addTearDown(seatingBloc.close);

  final router = _SeatingRouter();
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
        BlocProvider<SeatingPageBloc>.value(value: seatingBloc),
      ],
      child: MaterialApp.router(
        theme: AppTheme.light(isMobile: true),
        locale: const Locale('ru'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router.config(deepLinkBuilder: (_) => DeepLink.path(url)),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}
