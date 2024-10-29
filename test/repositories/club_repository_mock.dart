import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/domain/models/rating_model.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ClubRepositoryMock implements ClubRepository {
  @override
  Future<int> addGame(ClubGameResult result, int clubId) async {
    return 13;
  }

  @override
  Future<RatingModel> getRating({
    required int clubId,
    required DateTimeRange range,
  }) async {
    return const RatingModel(
      clubName: "clubName",
      rows: [],
      games: 0,
      citizenWins: 0,
      mafiaWins: 0,
    );
  }

  @override
  Future<ClubGameResult> getGame(int gameId, int clubId) async {
    return ClubGameResult();
  }

  @override
  Future<bool> isOwner(int clubId) async {
    return true;
  }

  @override
  Future editGame(ClubGameResult result, int clubId, int gameId) async {}

  @override
  Future downloadRating({
    required int clubId,
    required DateTimeRange range,
  }) async {}

  @override
  Future<ClubModel> getClub({required int id}) {
    return Future.value(ClubModel(id: id, name: "Club name"));
  }

  @override
  Future<List<ClubModel>> getClubs({bool onlyMy = false}) async {
    return [await getClub(id: 1)];
  }

  @override
  Future downloadStats({
    required int clubId,
    required DateTimeRange range,
  }) async {}

  @override
  Future<List<GameResultModel>> getGames({required int clubId, required DateTimeRange range}) {
    // TODO: implement getGames
    throw UnimplementedError();
  }
}
