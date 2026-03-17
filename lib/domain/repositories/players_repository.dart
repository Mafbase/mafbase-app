import 'dart:typed_data';

import 'package:seating_generator_web/domain/models/player_model.dart';

abstract class PlayersRepository {
  Future<List<PlayerModel>> get players;

  Future<List<PlayerModel>> searchPlayers(
    String search, {
    int limit = 5,
    int offset = 0,
  });

  Future<List<PlayerModel>> tournamentsPlayer(int tournamentId);

  Future addPlayer(int tournamentId, PlayerModel player);

  Future deletePlayer(int tournamentId, PlayerModel player);

  Future addPhoto(int playerId, Uint8List bytes, String filename);

  Future<int> createPlayer(PlayerModel player);

  Future editPlayer(PlayerModel player);
}