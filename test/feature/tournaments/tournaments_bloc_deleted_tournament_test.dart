import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/feature/tournaments/domain/interactors/create_tournament_interactor.dart';
import 'package:seating_generator_web/feature/tournaments/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/feature/tournaments/ui/tournaments_bloc.dart';
import 'package:seating_generator_web/feature/tournaments/ui/tournaments_events.dart';
import 'package:seating_generator_web/feature/tournaments/ui/tournaments_router.dart';
import 'package:seating_generator_web/feature/tournaments/ui/tournaments_state.dart';
import 'package:seating_generator_web/shared/tournament/domain/models/tournament_model.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournaments_repository.dart';

TournamentModel _tournament(int id) => TournamentModel(
      id: id,
      name: 'Турнир $id',
      status: TournamentStatus.active,
      dateStart: DateTime(2026, 12, 5),
      dateEnd: DateTime(2026, 12, 6),
      gamesCount: 10,
      billedPlayers: 10,
      billedTranslation: false,
      notificationEnabled: false,
    );

class _FakeTournamentsRepository implements TournamentsRepository {
  final _deleted = StreamController<int>.broadcast();

  @override
  Future<List<TournamentModel>> getTournaments({required int limit, required int offset, String? search}) async =>
      [_tournament(1), _tournament(2), _tournament(3)];

  @override
  Future<void> deleteTournament(int tournamentId) async => _deleted.add(tournamentId);

  @override
  Stream<int> get deletedTournamentIds => _deleted.stream;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _UnusedRouter implements TournamentsRouter {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _FakeTournamentsRepository repository;

  blocTest<TournamentsBloc, TournamentsState>(
    'a tournament deleted on its page disappears from the loaded list',
    setUp: () => repository = _FakeTournamentsRepository(),
    build: () => TournamentsBloc(
      GetTournamentsInteractor(repository),
      CreateTournamentInteractor(repository),
      _UnusedRouter(),
      repository.deletedTournamentIds,
    ),
    act: (bloc) async {
      bloc.add(const TournamentsEvent.opened());
      await Future<void>.delayed(Duration.zero);
      await repository.deleteTournament(2);
      await Future<void>.delayed(Duration.zero);
    },
    verify: (bloc) => expect(bloc.state.tournaments.map((tournament) => tournament.id), [1, 3]),
  );
}
