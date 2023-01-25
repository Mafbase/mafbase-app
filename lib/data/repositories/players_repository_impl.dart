import 'dart:typed_data';

import 'package:seating_generator_web/data/requests/add_photo_request.dart';
import 'package:seating_generator_web/data/requests/add_player_request.dart';
import 'package:seating_generator_web/data/requests/create_player_request.dart';
import 'package:seating_generator_web/data/requests/delete_player_request.dart';
import 'package:seating_generator_web/data/requests/edit_player_request.dart';
import 'package:seating_generator_web/data/requests/get_all_players_request.dart';
import 'package:seating_generator_web/data/requests/get_tournaments_players_request.dart';
import 'package:seating_generator_web/domain/base_repository.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class PlayersRepositoryImpl extends BaseRepository
    implements PlayersRepository {
  PlayersRepositoryImpl(super.client);

  @override
  Future addPlayer(int tournamentId, PlayerModel player) {
    return AddPlayerRequest(
      tournamentId: tournamentId,
      event: AddPlayerEvent(player: player.toProto()),
    ).execute(client);
  }

  @override
  Future deletePlayer(int tournamentId, PlayerModel player) {
    return DeletePlayerRequest(
      tournamentId: tournamentId,
      event: AddPlayerEvent(player: player.toProto()),
    ).execute(client);
  }

  @override
  Future<List<PlayerModel>> get players =>
      GetAllPlayersRequest().execute(client).then(
            (value) =>
                value.players.map((e) => PlayerModel.fromProto(e)).toList(),
          );

  @override
  Future<List<PlayerModel>> tournamentsPlayer(int tournamentId) {
    return GetTournamentsPlayersRequest(tournamentId: tournamentId)
        .execute(client)
        .then(
          (value) =>
              value.players.map((e) => PlayerModel.fromProto(e)).toList(),
        );
  }

  @override
  Future addPhoto(int playerId, Uint8List bytes, String filename) {
    return AddPhotoRequest(
      playerId: playerId,
      bytes: bytes,
      filename: filename,
    ).execute(client);
  }

  @override
  Future<int> createPlayer(PlayerModel player) {
    return CreatePlayerRequest(
      player: Player(
        nickname: player.nickname,
        fsmNickname: player.fsmNickaname,
      ),
    ).execute(client).then((value) => value.id);
  }

  @override
  Future editPlayer(PlayerModel player) {
    return EditPlayerRequest(player.toProto()).execute(client);
  }
}
