import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/feature/tournaments/domain/interactors/create_tournament_interactor.dart';
import 'package:seating_generator_web/feature/tournaments/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournaments_repository.dart';
import 'package:seating_generator_web/feature/tournaments/ui/tournaments_bloc.dart';
import 'package:seating_generator_web/feature/tournaments/ui/tournaments_events.dart';
import 'package:seating_generator_web/feature/tournaments/ui/tournaments_router.dart';
import 'package:seating_generator_web/feature/tournaments/ui/tournaments_state.dart';
import 'package:seating_generator_web/feature/tournaments/ui/widgets/create_tournament_dialog.dart';

class _FakeTournamentsRepository implements TournamentsRepository {
  @override
  Future<int> createTournament({required String name, required DateTimeRange range}) async => 42;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RecordingRouter implements TournamentsRouter {
  _RecordingRouter({required this.created});

  final CreateTournamentData? created;
  final opened = <({int id, bool setup})>[];

  @override
  Future<CreateTournamentData?> openCreateTournamentDialog() async => created;

  @override
  void openTournament(int id, {bool setup = false}) => opened.add((id: id, setup: setup));
}

void main() {
  late _RecordingRouter router;

  TournamentsBloc buildBloc() {
    final repository = _FakeTournamentsRepository();
    return TournamentsBloc(GetTournamentsInteractor(repository), CreateTournamentInteractor(repository), router);
  }

  blocTest<TournamentsBloc, TournamentsState>(
    'a created tournament opens with the setup wizard',
    setUp: () => router = _RecordingRouter(
      created: CreateTournamentData(DateTimeRange(start: DateTime(2026, 12, 5), end: DateTime(2026, 12, 6)), 'Кубок'),
    ),
    build: buildBloc,
    act: (bloc) => bloc.add(const TournamentsEvent.create()),
    verify: (_) => expect(router.opened, [(id: 42, setup: true)]),
  );

  blocTest<TournamentsBloc, TournamentsState>(
    'a cancelled creation opens nothing',
    setUp: () => router = _RecordingRouter(created: null),
    build: buildBloc,
    act: (bloc) => bloc.add(const TournamentsEvent.create()),
    verify: (_) => expect(router.opened, isEmpty),
  );
}
