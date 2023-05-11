import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/data/requests/edit_tournament_game_request.dart';
import 'package:seating_generator_web/data/requests/get_tournament_game_request.dart';
import 'package:seating_generator_web/data/requests/get_tournament_rating_request.dart';
import 'package:seating_generator_web/domain/models/rating_model.dart';
import 'package:seating_generator_web/domain/repositories/tournament_result_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class TournamentResultRepositoryImpl extends BaseRepository
    implements TournamentResultRepository {
  TournamentResultRepositoryImpl(super.client);

  @override
  Future editGame({
    required int tournamentId,
    required int gameId,
    required ClubGameResult result,
  }) {
    return EditTournamentGameRequest(
      tournamentId: tournamentId,
      gameId: gameId,
      result: result,
    ).execute(client);
  }

  @override
  Future<RatingModel> getRatingEvent({required int tournamentId}) {
    return GetTournamentRatingRequest(tournamentId: tournamentId)
        .execute(client)
        .then((value) => RatingModel.fromProto(value));
  }

  @override
  Future<ClubGameResult> getGame({
    required int tournamentId,
    required int gameId,
  }) {
    return GetTournamentGameRequest(tournamentId: tournamentId, gameId: gameId)
        .execute(client);
  }
}
