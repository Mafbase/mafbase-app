import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/data/requests/add_club_game_request.dart';
import 'package:seating_generator_web/data/requests/club_check_request.dart';
import 'package:seating_generator_web/data/requests/edit_club_game_request.dart';
import 'package:seating_generator_web/data/requests/get_club_game_request.dart';
import 'package:seating_generator_web/data/requests/get_club_rating_request.dart';
import 'package:seating_generator_web/domain/base_repository.dart';
import 'package:seating_generator_web/domain/models/club_rating_row.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  Future<ClubGameResult> getGame(int gameId, int clubId) {
    return GetClubGameRequest(clubId: clubId, gameId: gameId).execute(client);
  }

  @override
  Future<bool> isOwner(int clubId) async {
    return ClubCheckRequest(clubId: clubId)
        .execute(client)
        .then(
          (value) => true,
        )
        .onError((error, stackTrace) => false);
  }

  @override
  Future editGame(ClubGameResult result, int clubId, int gameId) {
    return EditClubGameRequest(clubId: clubId, gameId: gameId, result: result)
        .execute(client);
  }

  @override
  Future downloadRating({required int clubId, required DateTimeRange range}) {
    final format = DateFormat("yyyy-MM-dd");
    return launchUrl(
      Uri.parse(
        "${client.baseUrl}/api/club/$clubId/rating/download?date-start=${format.format(range.start)}&date-end=${format.format(range.end)}",
      ),
    );
  }
}
