import 'package:seating_generator_web/domain/models/ci_scheme_model.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/utils.dart';

abstract class TournamentEditRepository {
  Future<List<Pair<PlayerModel, PlayerModel>>> getSeparations({
    required int tournamentId,
  });

  Future insertSeparation({
    required int tournamentId,
    required PlayerModel player1,
    required PlayerModel player2,
  });

  Future deleteSeparation({
    required int tournamentId,
    required PlayerModel player1,
    required PlayerModel player2,
  });

  Future<List<CiSchemeModel>> getCiSchemeModels();

  Future<List<List<GameResultModel>>> getResultModels({
    required int tournamentId,
  });

  Future<TournamentSettingsModel> getSettings({required int tournamentId});

  Future updateSetting({
    required int tournamentId,
    required TournamentSettingsModel settings,
  });

  Future setFinalPlayers({
    required List<PlayerModel> players,
    required int tournamentId,
  });

  Future<List<PlayerModel>> getFinalPlayers({required int tournamentId});

  Future generateFinalGames({required int tournamentId});
}
