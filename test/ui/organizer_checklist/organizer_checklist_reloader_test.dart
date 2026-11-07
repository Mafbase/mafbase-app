@Timeout(Duration(seconds: 20))
library;

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_reloader.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';

import '../../feature/organizer_checklist/organizer_checklist_fixtures.dart';

class _TestRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        RedirectRoute(path: '/', redirectTo: '/tournament/1'),
        AutoRoute(
          page: PageInfo(
            'TournamentRoute',
            builder: (_) => const OrganizerChecklistReloader(tournamentId: 1, child: AutoRouter()),
          ),
          path: '/tournament/1',
          children: [
            AutoRoute(page: PageInfo('PlayersRoute', builder: (_) => const Text('players')), path: ''),
            AutoRoute(page: PageInfo('SettingsRoute', builder: (_) => const Text('settings')), path: 'settings'),
          ],
        ),
        AutoRoute(page: PageInfo('ClubsRoute', builder: (_) => const Text('clubs')), path: '/club'),
        AutoRoute(page: PageInfo('OtherTournamentRoute', builder: (_) => const Text('other')), path: '/tournament/12'),
      ];
}

class _Harness {
  _Harness(this.router, this.checklistBloc, this.tournamentStates, this.seatingStates);

  final _TestRouter router;
  final RecordingOrganizerChecklistBloc checklistBloc;
  final StreamController<TournamentPageState> tournamentStates;
  final StreamController<SeatingPageState> seatingStates;
}

Future<_Harness> _pump(WidgetTester tester, TournamentPageState tournament) async {
  final tournamentStates = StreamController<TournamentPageState>();
  final seatingStates = StreamController<SeatingPageState>();
  final checklistBloc = RecordingOrganizerChecklistBloc(const OrganizerChecklistState());
  final tournamentBloc = RecordingTournamentPageBloc(tournament, states: tournamentStates.stream);
  final seatingBloc = RecordingSeatingPageBloc(const SeatingPageState(), states: seatingStates.stream);
  addTearDown(tournamentStates.close);
  addTearDown(seatingStates.close);
  addTearDown(checklistBloc.close);
  addTearDown(tournamentBloc.close);
  addTearDown(seatingBloc.close);

  final router = _TestRouter();
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<OrganizerChecklistBloc>.value(value: checklistBloc),
        BlocProvider<TournamentPageBloc>.value(value: tournamentBloc),
        BlocProvider<SeatingPageBloc>.value(value: seatingBloc),
      ],
      child: MaterialApp.router(routerConfig: router.config()),
    ),
  );
  await tester.pumpAndSettle();
  return _Harness(router, checklistBloc, tournamentStates, seatingStates);
}

void main() {
  testWidgets('reloads when the child route of its tournament changes, in both directions', (tester) async {
    final harness = await _pump(tester, ownerTournament);
    final initial = harness.checklistBloc.loadCount;

    harness.router.navigatePath('/tournament/1/settings');
    await tester.pumpAndSettle();
    expect(harness.checklistBloc.loadCount, initial + 1);

    harness.router.navigatePath('/tournament/1');
    await tester.pumpAndSettle();
    expect(find.text('players'), findsOneWidget);
    expect(harness.checklistBloc.loadCount, initial + 2);
  });

  testWidgets('ignores other places and tournaments with a similar id', (tester) async {
    final harness = await _pump(tester, ownerTournament);
    final initial = harness.checklistBloc.loadCount;

    harness.router.pushPath('/tournament/12');
    await tester.pumpAndSettle();
    harness.router.pushPath('/club');
    await tester.pumpAndSettle();

    expect(harness.checklistBloc.loadCount, initial);
  });

  testWidgets('a foreign tournament is never loaded', (tester) async {
    final harness = await _pump(tester, ownerTournament.copyWith(isMyTournament: false));

    harness.router.navigatePath('/tournament/1/settings');
    await tester.pumpAndSettle();
    harness.tournamentStates.add(ownerTournament.copyWith(isMyTournament: false, billedPlayers: 30));
    await tester.pumpAndSettle();

    expect(harness.checklistBloc.loadCount, 0);
  });

  testWidgets('loads once the tournament turns out to be own and after changes that affect items', (tester) async {
    final notOwner = ownerTournament.copyWith(isMyTournament: false);
    final harness = await _pump(tester, notOwner);
    int loads() => harness.checklistBloc.loadCount;

    harness.tournamentStates.add(ownerTournament);
    await tester.pump();
    expect(loads(), 1);

    final steps = <(TournamentPageState, int)>[
      (ownerTournament.copyWith(isLoading: true), 1),
      (
        ownerTournament.copyWith(
          settings: const TournamentSettingsModel(defaultGames: 10, swissGames: 0, finalGames: 0),
        ),
        2
      ),
      (ownerTournament.copyWith(tournamentPlayers: const [PlayerModel(id: 1, nickname: 'Дон')]), 3),
      (ownerTournament.copyWith(notificationEnabled: true), 4),
      (ownerTournament.copyWith(notificationEnabled: true, billedTranslation: true), 5),
      (
        ownerTournament.copyWith(notificationEnabled: true, billedTranslation: true, gomafiaUrl: 'https://gomafia.pro'),
        6
      ),
    ];
    for (final (state, expected) in steps) {
      harness.tournamentStates.add(state);
      await tester.pump();
      expect(loads(), expected, reason: '$state');
    }

    harness.seatingStates.add(const SeatingPageState(isLoading: false));
    await tester.pump();
    expect(loads(), 6, reason: 'loading flag of the seating does not change items');

    harness.seatingStates.add(const SeatingPageState(isLoading: false, games: [[]]));
    await tester.pump();
    expect(loads(), 7);
  });
}
