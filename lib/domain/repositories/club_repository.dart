import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/models/club_rating_row.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

abstract class ClubRepository {
  Future addGame(ClubGameResult result, int clubId);

  Future<List<ClubRatingRowModel>> getRating({
    required int clubId,
    required DateTimeRange range,
  });
}
