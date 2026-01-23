import 'package:seating_generator_web/domain/models/user_model.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_current_game_info_model.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_rating_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

abstract interface class FantasyRepository {
  Future<FantasyRatingModel> getRating(int tournamentId);

  Future<FantasyCurrentGameInfoModel> getCurrentGameInfo(int tournamentId);

  Future<List<UserModel>> getParticipants(int tournamentId);

  Future<void> addParticipant(int tournamentId, String email);

  Future<void> removeParticipant(int tournamentId, int userId);

  Future<void> setPrediction(int tournamentId, GameWin prediction);
}
