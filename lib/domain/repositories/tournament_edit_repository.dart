import 'package:seating_generator_web/domain/models/player_model.dart';
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
}
