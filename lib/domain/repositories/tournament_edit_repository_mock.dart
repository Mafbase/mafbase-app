import 'package:seating_generator_web/domain/models/player_model.dart';
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
}
