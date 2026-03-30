import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/referee_assignments/data/requests/delete_referee_request.dart';
import 'package:seating_generator_web/feature/referee_assignments/data/requests/get_referees_request.dart';
import 'package:seating_generator_web/feature/referee_assignments/data/requests/set_referee_request.dart';
import 'package:seating_generator_web/feature/referee_assignments/domain/referee_assignment_model.dart';
import 'package:seating_generator_web/feature/referee_assignments/domain/referee_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class RefereeRepositoryImpl extends BaseRepository implements RefereeRepository {
  RefereeRepositoryImpl(super.client);

  @override
  Future<List<RefereeAssignmentModel>> getReferees(int tournamentId) =>
      GetRefereesRequest(tournamentId: tournamentId).execute(client).then(
            (value) => value.assignments
                .map(
                  (e) => RefereeAssignmentModel(
                    table: e.table,
                    referee: PlayerModel.fromProto(e.referee),
                  ),
                )
                .toList(),
          );

  @override
  Future<void> setReferee({
    required int tournamentId,
    required int table,
    required PlayerModel referee,
  }) =>
      SetRefereeRequest(
        tournamentId: tournamentId,
        body: SetRefereeEvent(
          table: table,
          referee: referee.toProto(),
        ),
      ).execute(client);

  @override
  Future<void> deleteReferee({
    required int tournamentId,
    required int table,
  }) =>
      DeleteRefereeRequest(
        tournamentId: tournamentId,
        body: DeleteRefereeEvent(table: table),
      ).execute(client);
}
