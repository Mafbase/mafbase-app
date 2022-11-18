import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/models/club_rating_row.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ClubRepositoryMock implements ClubRepository {
  @override
  Future addGame(ClubGameResult result, int clubId) async {}

  @override
  Future<List<ClubRatingRowModel>> getRating({
    required int clubId,
    required DateTimeRange range,
  }) async {
    return [];
  }
}