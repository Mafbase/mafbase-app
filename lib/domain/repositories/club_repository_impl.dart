import 'package:flutter/material.dart';
import 'package:seating_generator_web/data/requests/add_club_game_request.dart';
import 'package:seating_generator_web/data/requests/get_club_rating_request.dart';
import 'package:seating_generator_web/domain/base_repository.dart';
import 'package:seating_generator_web/domain/models/club_rating_row.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

class ClubRepositoryImpl extends BaseRepository implements ClubRepository {
  ClubRepositoryImpl(super.client);

  @override
  Future addGame(ClubGameResult result, int clubId) {
    return AddClubGameRequest(clubId: clubId, result: result).execute(client);
  }

  @override
  Future<List<ClubRatingRowModel>> getRating({
    required int clubId,
    required DateTimeRange range,
  }) {
    return GetClubRatingRequest(range: range, clubId: clubId)
        .execute(client)
        .then((event) {
      return event.row
          .map((proto) => ClubRatingRowModel.fromProto(proto))
          .toList();
    });
  }
}
