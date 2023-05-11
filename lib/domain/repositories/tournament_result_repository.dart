import 'package:seating_generator_web/domain/models/rating_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

abstract class TournamentResultRepository {
  Future editGame({
    required int tournamentId,
    required int gameId,
    required ClubGameResult result,
  });

  Future<ClubGameResult> getGame({
    required int tournamentId,
    required int gameId,
  });

  Future<RatingModel> getRatingEvent({required int tournamentId});
}
