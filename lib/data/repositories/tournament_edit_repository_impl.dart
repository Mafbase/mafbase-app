import 'package:collection/collection.dart';
import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/data/requests/create_swiss_game_request.dart';
import 'package:seating_generator_web/data/requests/delete_separation_request.dart';
import 'package:seating_generator_web/data/requests/generate_final_seating_request.dart';
import 'package:seating_generator_web/data/requests/get_ci_schemes_request.dart';
import 'package:seating_generator_web/data/requests/get_final_players_request.dart';
import 'package:seating_generator_web/data/requests/get_seating_request.dart';
import 'package:seating_generator_web/data/requests/get_separations_request.dart';
import 'package:seating_generator_web/data/requests/get_settings_request.dart';
import 'package:seating_generator_web/data/requests/separate_players_request.dart';
import 'package:seating_generator_web/data/requests/set_final_players_request.dart';
import 'package:seating_generator_web/data/requests/update_settings_request.dart';
import 'package:seating_generator_web/domain/models/ci_scheme_model.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/domain/repositories/tournament_edit_repository.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentEditRepositoryImpl extends BaseRepository
    implements TournamentEditRepository {
  TournamentEditRepositoryImpl(super.client);

  @override
  Future<List<Pair<PlayerModel, PlayerModel>>> getSeparations({
    required int tournamentId,
  }) {
    return GetSeparationsRequest(tournamentId: tournamentId)
        .execute(client)
        .then(
          (value) => value.pairs
              .map(
                (e) => Pair(
                  PlayerModel.fromProto(e.player1),
                  PlayerModel.fromProto(e.player2),
                ),
              )
              .toList(),
        );
  }

  @override
  Future deleteSeparation({
    required int tournamentId,
    required PlayerModel player1,
    required PlayerModel player2,
  }) {
    return DeleteSeparationRequest(
      tournamentId: tournamentId,
      first: player1.toProto(),
      second: player2.toProto(),
    ).execute(client);
  }

  @override
  Future insertSeparation({
    required int tournamentId,
    required PlayerModel player1,
    required PlayerModel player2,
  }) {
    return SeparatePlayersRequest(
      tournamentId: tournamentId,
      first: player1.toProto(),
      second: player2.toProto(),
    ).execute(client);
  }

  @override
  Future<List<CiSchemeModel>> getCiSchemeModels() {
    return GetCiSchemesRequest().execute(client).then(
          (value) => value.schemes
              .map(
                (e) => CiSchemeModel.fromProto(e),
              )
              .toList(),
        );
  }

  @override
  Future<List<List<GameResultModel>>> getResultModels({
    required int tournamentId,
  }) {
    return GetSeatingRequest(tournamentId: tournamentId)
        .execute(client)
        .then((value) {
      return value.item
          .splitBetween((first, second) => first.game != second.game)
          .map((e) => e.map((e) => GameResultModel.fromProto(e)).toList())
          .toList();
    });
  }

  @override
  Future<TournamentSettingsModel> getSettings({required int tournamentId}) {
    return GetSettingsRequest(tournamentId: tournamentId)
        .execute(client)
        .then((value) => TournamentSettingsModel.fromProto(value));
  }

  @override
  Future updateSetting({
    required int tournamentId,
    required TournamentSettingsModel settings,
  }) {
    return UpdateSettingsRequest(
      tournamentId: tournamentId,
      settings: settings.toProto(),
    ).execute(client);
  }

  @override
  Future setFinalPlayers({
    required List<PlayerModel> players,
    required int tournamentId,
  }) {
    return SetFinalPlayersRequest(
      tournamentId: tournamentId,
      players: players.map((e) => e.id).toList(),
    ).execute(client);
  }

  @override
  Future<List<PlayerModel>> getFinalPlayers({required int tournamentId}) {
    return GetFinalPlayersRequest(tournamentId: tournamentId)
        .execute(client)
        .then(
          (value) => value.player.map((e) => PlayerModel.fromProto(e)).toList(),
        );
  }

  @override
  Future generateFinalGames({required int tournamentId}) {
    return GenerateFinalSeatingRequest(tournamentId: tournamentId)
        .execute(client);
  }

  @override
  Future<void> generateSwissGame({
    required int tournamentId,
    required int game,
  }) async {
    await CreateSwissGameRequest(tournamentId: tournamentId, game: game)
        .execute(client);
  }
}
