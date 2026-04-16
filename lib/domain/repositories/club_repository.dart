import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/domain/models/rating_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'dart:typed_data';

abstract class ClubRepository {
  Future<int> addGame(ClubGameResult result, int clubId);

  Future editGame(ClubGameResult result, int clubId, int gameId);

  Future<RatingModel> getRating({
    required int clubId,
    required DateTimeRange range,
  });

  Future<List<GameResultModel>> getGames({
    required int clubId,
    required DateTimeRange range,
  });

  Future<List<ClubModel>> getClubs({bool onlyMy = false});

  Future<ClubGameResult> getGame(int gameId, int clubId);

  Future<bool> isOwner(int clubId);

  Future downloadRating({
    required int clubId,
    required DateTimeRange range,
  });

  Future downloadStats({
    required int clubId,
    required DateTimeRange range,
  });

  Future<ClubModel> getClub({required int id});

  Future<DateTime?> getHideDate({required int id});

  Future<void> updateHideDate({
    required int id,
    required DateTime? dateTime,
  });

  Future<void> deleteGame({
    required int gameId,
    required int clubId,
  });

  Future<void> updateDescription({
    required int clubId,
    required ClubModel club,
  });

  Future<void> updatePhoto({
    required int clubId,
    required Uint8List bytes,
    required String fileName,
  });

  Future<ClubModel> createClub({
    required String name,
    String? description,
    String? groupLink,
  });
}
