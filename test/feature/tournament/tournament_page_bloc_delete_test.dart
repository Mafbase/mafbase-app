@Timeout(Duration(seconds: 10))
library;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/core/network/http_client.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_router.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/shared/player/domain/models/player_model.dart';
import 'package:seating_generator_web/shared/tournament/domain/models/tournament_model.dart';
import 'package:seating_generator_web/shared/tournament/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournament_edit_repository.dart';
import 'package:seating_generator_web/shared/tournament/domain/tournaments_repository.dart';

const _tournamentId = 7;

class _FakeTournamentsRepository implements TournamentsRepository {
  _FakeTournamentsRepository({this.isOwnerResult = true, this.canDeleteError, this.deleteError});

  final bool isOwnerResult;
  final Object? canDeleteError;
  final Object? deleteError;
  var canDeleteCalls = 0;
  final deleted = <int>[];

  @override
  Future<bool> isOwner(int tournamentId) async => isOwnerResult;

  @override
  Future<bool> canDelete(int tournamentId) async {
    canDeleteCalls++;
    if (canDeleteError case final error?) throw error;
    return true;
  }

  @override
  Future<TournamentModel> getTournament({required int tournamentId}) async => TournamentModel(
        id: tournamentId,
        name: 'Кубок города',
        status: TournamentStatus.active,
        dateStart: DateTime(2026, 12, 5),
        dateEnd: DateTime(2026, 12, 6),
        gamesCount: 0,
        billedPlayers: 10,
        billedTranslation: false,
        notificationEnabled: false,
      );

  @override
  Future<void> deleteTournament(int tournamentId) async {
    if (deleteError case final error?) throw error;
    deleted.add(tournamentId);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeTournamentEditRepository implements TournamentEditRepository {
  @override
  Future<List<PlayerModel>> getFinalPlayers({required int tournamentId}) async => const [];

  @override
  Future<TournamentSettingsModel> getSettings({required int tournamentId}) async =>
      const TournamentSettingsModel(defaultGames: 10, swissGames: 0, finalGames: 0);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RecordingRouter implements TournamentPageRouter {
  var tournamentsListOpened = 0;

  @override
  void openTournamentsList() => tournamentsListOpened++;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _FakeTournamentsRepository repository;
  late _RecordingRouter router;

  TournamentPageBloc buildBloc() => TournamentPageBloc(
        scope: DependencyScope(
          overrides: {
            TournamentsRepository: repository,
            TournamentEditRepository: _FakeTournamentEditRepository(),
          },
        ),
        router: router,
        tournamentId: _tournamentId,
      );

  setUp(() => router = _RecordingRouter());

  group('canDelete', () {
    blocTest<TournamentPageBloc, TournamentPageState>(
      'the creator may delete the tournament',
      setUp: () => repository = _FakeTournamentsRepository(),
      build: buildBloc,
      act: (bloc) => bloc.add(const TournamentPageEvent.pageOpened()),
      verify: (bloc) {
        expect(bloc.state.isMyTournament, isTrue);
        expect(bloc.state.canDeleteTournament, isTrue);
        expect(bloc.state.tournamentName, 'Кубок города');
      },
    );

    blocTest<TournamentPageBloc, TournamentPageState>(
      'a co-owner gets 403 and may not delete, without an error dialog',
      setUp: () => repository = _FakeTournamentsRepository(
        canDeleteError: RequestError('Удалить турнир может только его создатель'),
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(const TournamentPageEvent.pageOpened()),
      verify: (bloc) {
        expect(bloc.state.isMyTournament, isTrue);
        expect(bloc.state.canDeleteTournament, isFalse);
      },
      errors: () => isEmpty,
    );

    blocTest<TournamentPageBloc, TournamentPageState>(
      'a viewer is not asked about deletion at all',
      setUp: () => repository = _FakeTournamentsRepository(isOwnerResult: false),
      build: buildBloc,
      act: (bloc) => bloc.add(const TournamentPageEvent.pageOpened()),
      verify: (bloc) {
        expect(bloc.state.canDeleteTournament, isFalse);
        expect(repository.canDeleteCalls, 0);
      },
    );
  });

  group('deleteTournament', () {
    blocTest<TournamentPageBloc, TournamentPageState>(
      'a successful deletion leaves the tournament for the tournaments list',
      setUp: () => repository = _FakeTournamentsRepository(),
      build: buildBloc,
      act: (bloc) => bloc.add(const TournamentPageEvent.deleteTournament()),
      expect: () => [
        isA<TournamentPageState>().having((state) => state.isDeletingTournament, 'isDeletingTournament', isTrue),
        isA<TournamentPageState>().having((state) => state.isDeletingTournament, 'isDeletingTournament', isFalse),
      ],
      verify: (_) {
        expect(repository.deleted, [_tournamentId]);
        expect(router.tournamentsListOpened, 1);
      },
    );

    blocTest<TournamentPageBloc, TournamentPageState>(
      'a server error keeps the tournament open and goes to the bloc observer',
      setUp: () => repository = _FakeTournamentsRepository(deleteError: RequestError('Турнир не найден')),
      build: buildBloc,
      act: (bloc) => bloc.add(const TournamentPageEvent.deleteTournament()),
      expect: () => [
        isA<TournamentPageState>().having((state) => state.isDeletingTournament, 'isDeletingTournament', isTrue),
        isA<TournamentPageState>().having((state) => state.isDeletingTournament, 'isDeletingTournament', isFalse),
      ],
      errors: () => [isA<RequestError>().having((error) => error.message, 'message', 'Турнир не найден')],
      verify: (_) => expect(router.tournamentsListOpened, 0),
    );
  });
}
