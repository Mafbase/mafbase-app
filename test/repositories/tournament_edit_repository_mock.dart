import 'package:seating_generator_web/domain/models/ci_scheme_model.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentEditRepositoryMock implements TournamentEditRepository {
  @override
  Future<List<Pair<PlayerModel, PlayerModel>>> getSeparations({
    required int tournamentId,
  }) {
    return Future.value([]);
  }

  @override
  Future deleteSeparation({
    required int tournamentId,
    required PlayerModel player1,
    required PlayerModel player2,
  }) {
    return Future.value();
  }

  @override
  Future insertSeparation({
    required int tournamentId,
    required PlayerModel player1,
    required PlayerModel player2,
  }) {
    return Future.value();
  }

  @override
  Future<List<CiSchemeModel>> getCiSchemeModels() {
    return Future.value([]);
  }

  @override
  Future<List<List<GameResultModel>>> getResultModels({
    required int tournamentId,
  }) {
    return Future.value([]);
  }

  @override
  Future<TournamentSettingsModel> getSettings({required int tournamentId}) {
    return Future.value(
      const TournamentSettingsModel(
        defaultGames: 7,
        swissGames: 4,
        finalGames: 4,
      ),
    );
  }

  @override
  Future updateSetting({
    required int tournamentId,
    required TournamentSettingsModel settings,
  }) {
    return Future.value();
  }

  @override
  Future setFinalPlayers({
    required List<PlayerModel> players,
    required int tournamentId,
  }) {
    return Future.value();
  }

  @override
  Future<List<PlayerModel>> getFinalPlayers({required int tournamentId}) {
    return Future.value([]);
  }

  @override
  Future generateFinalGames({required int tournamentId}) {
    return Future.value();
  }

  @override
  Future<void> generateSwissGame({
    required int tournamentId,
    required int game,
  }) {
    return Future.value();
  }

  @override
  Future<void> getGomafiaSeating({
    required int tournamentId,
    required int gomafiaId,
  }) {
    // TODO: implement getGomafiaSeating
    throw UnimplementedError();
  }
}
