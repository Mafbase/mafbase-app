import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/domain/repositories/stream_repository.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_effect.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog_state.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_effect.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_router.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/utils.dart';

void main() {
  for (final createNew in [true, false]) {
    final repository = _PlayersRepository();
    final effects = <SeatingPageDialogEffect>[];
    blocTest<SeatingPageDialogBloc, SeatingPageDialogState>(
      '${createNew ? 'Creating' : 'Linking'} a player recovers after failure and allows retry',
      build: () {
        final bloc = SeatingPageDialogBloc(
          const SeatingPageDialogState(loading: false, incorrectPlayer: 'Gomafia', notFound: ['Gomafia']),
          repository,
        );
        final subscription = bloc.effectsStream.listen(effects.add);
        addTearDown(subscription.cancel);
        return bloc;
      },
      act: (bloc) async {
        final event = createNew
            ? const SeatingPageDialogEvent.newPlayer('Nickname')
            : const SeatingPageDialogEvent.existingPlayer(PlayerModel(id: 1, nickname: 'Nickname'));
        final recovered = bloc.stream.firstWhere((state) => !state.loading);
        bloc.add(event);
        await recovered;
        expect(bloc.state.notFound, ['Gomafia']);
        expect(bloc.state.incorrectPlayer, 'Gomafia');
        expect(effects, isEmpty);

        final retried = bloc.stream.firstWhere((state) => !state.loading);
        bloc.add(event);
        await retried;
      },
      expect: () => [
        for (final loading in [true, false, true, false])
          isA<SeatingPageDialogState>().having((state) => state.loading, 'loading', loading),
      ],
      errors: () => [isA<StateError>()],
      verify: (_) {
        expect(repository.saved, hasLength(2));
        expect(repository.saved.every((player) => player.fsmNickaname == 'Gomafia'), isTrue);
        expect(effects, [isA<SeatingPageDialogEffectSuccess>()]);
      },
    );
  }

  for (final failRefresh in [false, true]) {
    final repository = _TournamentEditRepository()
      ..failImport = !failRefresh
      ..failRefresh = failRefresh;
    final completions = <bool>[];
    blocTest<SeatingPageBloc, SeatingPageState>(
      '${failRefresh ? 'Refreshing' : 'Importing'} seating recovers after failure and completes retry',
      build: () => SeatingPageBloc(repos: _Repositories(repository), router: _Router())..tournamentId = 1,
      seed: () => const SeatingPageState(isLoading: false),
      act: (bloc) async {
        for (var attempt = 0; attempt < 2; attempt++) {
          final completer = Completer<bool>();
          bloc.add(SeatingPageEvent.autoFsmSeating(42, completer: completer));
          completions.add(await completer.future);
          expect(bloc.state.isLoading, isFalse);
        }
      },
      expect: () => [
        for (final loading in [true, false, true, false])
          isA<SeatingPageState>().having((state) => state.isLoading, 'isLoading', loading),
      ],
      errors: () => [isA<StateError>()],
      verify: (_) => expect(completions, [false, true]),
    );
  }

  test('Missing players open the correction flow and release page loading', () async {
    final repository = _TournamentEditRepository()..missingPlayers = ['Gomafia'];
    final bloc = SeatingPageBloc(repos: _Repositories(repository), router: _Router())..tournamentId = 1;
    addTearDown(bloc.close);
    final effect = bloc.effectsStream.first;
    final completer = Completer<bool>();
    bloc.add(SeatingPageEvent.autoFsmSeating(42, completer: completer));

    expect(await completer.future, isTrue);
    expect(bloc.state.isLoading, isFalse);
    expect(await effect, isA<SeatingPageEffectFixPlayers>().having((effect) => effect.players, 'players', ['Gomafia']));
  });
}

class _PlayersRepository extends Fake implements PlayersRepository {
  final saved = <PlayerModel>[];

  void _save(PlayerModel player) {
    saved.add(player);
    if (saved.length == 1) throw StateError('Save failed');
  }

  @override
  Future<int> createPlayer(PlayerModel player) async {
    _save(player);
    return 1;
  }

  @override
  Future<void> editPlayer(PlayerModel player) async => _save(player);
}

class _TournamentEditRepository extends Fake implements TournamentEditRepository {
  bool failImport = false;
  bool failRefresh = false;
  List<String> missingPlayers = [];

  @override
  Future<List<String>> getGomafiaSeating({required int tournamentId, required int gomafiaId}) async {
    if (failImport) {
      failImport = false;
      throw StateError('Import failed');
    }
    return missingPlayers;
  }

  @override
  Future<List<Pair<PlayerModel, PlayerModel>>> getSeparations({required int tournamentId}) async => [];

  @override
  Future<TournamentSettingsModel> getSettings({required int tournamentId}) async =>
      const TournamentSettingsModel(defaultGames: 1, swissGames: 0, finalGames: 0);

  @override
  Future<List<List<GameResultModel>>> getResultModels({required int tournamentId, RatingScheme? ratingScheme}) async {
    if (failRefresh) {
      failRefresh = false;
      throw StateError('Refresh failed');
    }
    return [];
  }
}

class _StreamsRepository extends Fake implements StreamRepository {
  @override
  Future<List<GameStream>> getStreams({required int tournamentId}) async => [];
}

class _Repositories extends Fake implements RepositoryFactory {
  _Repositories(this.tournamentEditRepository);

  @override
  final TournamentEditRepository tournamentEditRepository;

  @override
  final StreamRepository streamRepository = _StreamsRepository();
}

class _Router extends Fake implements SeatingPageRouter {}
