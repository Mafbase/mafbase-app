import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/referee_assignments/domain/referee_assignment_model.dart';

abstract interface class RefereeRepository {
  Future<List<RefereeAssignmentModel>> getReferees(int tournamentId);

  Future<void> setReferee({
    required int tournamentId,
    required int table,
    required PlayerModel referee,
  });

  Future<void> deleteReferee({
    required int tournamentId,
    required int table,
  });
}
