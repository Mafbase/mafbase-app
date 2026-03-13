import 'package:seating_generator_web/data/requests/delete_cannot_meet_request.dart';
import 'package:seating_generator_web/data/requests/get_cannot_meet_pairs_request.dart';
import 'package:seating_generator_web/data/requests/insert_cannot_meet_request.dart';
import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/cannot_meet_tournament_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class CannotMeetTournamentRepositoryImpl extends BaseRepository implements CannotMeetTournamentRepository {
  CannotMeetTournamentRepositoryImpl(super.client);

  @override
  Future deletePair(int tournamentId, PlayerModel first, PlayerModel second) {
    return DeleteCannotMeetRequest(
      tournamentId: tournamentId,
      event: CannotMeetEditionEvent(
        player1: first.toProto(),
        player2: second.toProto(),
      ),
    ).execute(client);
  }

  @override
  Future insertPair(int tournamentId, PlayerModel first, PlayerModel second) {
    return InsertCannotMeetRequest(
      tournamentId: tournamentId,
      event: CannotMeetEditionEvent(
        player1: first.toProto(),
        player2: second.toProto(),
      ),
    ).execute(client);
  }

  @override
  Future<List<List<PlayerModel>>> pairs(int tournamentId) {
    return GetCannotMeetPairsRequest(tournamentId: tournamentId).execute(client).then((eventOut) {
      return eventOut.pairs
          .map(
            (e) => [
              PlayerModel.fromProto(e.player1),
              PlayerModel.fromProto(e.player2),
            ],
          )
          .toList();
    });
  }
}
