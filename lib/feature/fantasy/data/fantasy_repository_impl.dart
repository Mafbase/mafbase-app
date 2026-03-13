import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/domain/models/user_model.dart';
import 'package:seating_generator_web/feature/fantasy/data/fantasy_extensions.dart';
import 'package:seating_generator_web/feature/fantasy/data/requests/add_fantasy_participant_request.dart';
import 'package:seating_generator_web/feature/fantasy/data/requests/get_fantasy_current_game_request.dart';
import 'package:seating_generator_web/feature/fantasy/data/requests/get_fantasy_participants_request.dart';
import 'package:seating_generator_web/feature/fantasy/data/requests/get_fantasy_rating_request.dart';
import 'package:seating_generator_web/feature/fantasy/data/requests/remove_fantasy_participant_request.dart';
import 'package:seating_generator_web/feature/fantasy/data/requests/set_fantasy_prediction_request.dart';
import 'package:seating_generator_web/feature/fantasy/domain/fantasy_repository.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_current_game_info_model.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_rating_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class FantasyRepositoryImpl extends BaseRepository implements FantasyRepository {
  FantasyRepositoryImpl(super.client);

  @override
  Future<FantasyRatingModel> getRating(int tournamentId) =>
      GetFantasyRatingRequest(tournamentId: tournamentId).execute(client).then((value) => value.toDomain());

  @override
  Future<FantasyCurrentGameInfoModel> getCurrentGameInfo(int tournamentId) =>
      GetFantasyCurrentGameRequest(tournamentId: tournamentId).execute(client).then((value) => value.toDomain());

  @override
  Future<List<UserModel>> getParticipants(int tournamentId) =>
      GetFantasyParticipantsRequest(tournamentId: tournamentId).execute(client).then((value) => value.toDomain());

  @override
  Future<void> addParticipant(int tournamentId, String email) =>
      AddFantasyParticipantRequest(tournamentId: tournamentId, email: email).execute(client);

  @override
  Future<void> removeParticipant(int tournamentId, int userId) =>
      RemoveFantasyParticipantRequest(tournamentId: tournamentId, userId: userId).execute(client);

  @override
  Future<void> setPrediction(int tournamentId, GameWin prediction) =>
      SetFantasyPredictionRequest(tournamentId: tournamentId, prediction: prediction).execute(client);
}
