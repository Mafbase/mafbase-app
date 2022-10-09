import 'package:seating_generator_web/domain/models/player_model.dart';

abstract class PlayersRepository {
  Future<List<PlayerModel>> get players;

  Future<List<PlayerModel>> tournamentsPlayer(int tournamentId);

  Future addPlayer(int tournamentId, PlayerModel player);

  Future deletePlayer(int tournamentId, PlayerModel player);
}