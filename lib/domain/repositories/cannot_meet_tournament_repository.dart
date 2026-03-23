import 'package:seating_generator_web/domain/models/player_model.dart';

abstract class CannotMeetTournamentRepository {
  Future<List<List<PlayerModel>>> pairs(int tournamentId);

  Future insertPair(int tournamentId, PlayerModel first, PlayerModel second);

  Future deletePair(int tournamentId, PlayerModel first, PlayerModel second);
}
