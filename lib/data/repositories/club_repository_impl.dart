import 'dart:html' show AnchorElement;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/data/requests/add_club_game_request.dart';
import 'package:seating_generator_web/data/requests/club_check_request.dart';
import 'package:seating_generator_web/data/requests/clubs_list_request.dart';
import 'package:seating_generator_web/data/requests/clubs_my_request.dart';
import 'package:seating_generator_web/data/requests/edit_club_game_request.dart';
import 'package:seating_generator_web/data/requests/get_club_game_request.dart';
import 'package:seating_generator_web/data/requests/get_club_rating_request.dart';
import 'package:seating_generator_web/data/requests/get_club_request.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/domain/models/rating_model.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

class ClubRepositoryImpl extends BaseRepository implements ClubRepository {
  ClubRepositoryImpl(super.client);

  @override
  Future<int> addGame(ClubGameResult result, int clubId) {
    return AddClubGameRequest(clubId: clubId, result: result)
        .execute(client)
        .then((value) => value.gameId);
  }

  @override
  Future<RatingModel> getRating({
    required int clubId,
    required DateTimeRange range,
  }) {
    return GetClubRatingRequest(range: range, clubId: clubId)
        .execute(client)
        .then((event) {
      return RatingModel.fromProto(event);
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
  Future downloadRating({
    required int clubId,
    required DateTimeRange range,
  }) async {
    final response = await client.get<Uint8List>(
      '/api/club/$clubId/rating/download?date-start=${dateFormatForRequests.format(range.start)}&date-end=${dateFormatForRequests.format(range.end)}"',
    );

    final uri = Uri.dataFromBytes(
      response.data ?? Uint8List(0),
      mimeType: 'text/xlsx',
    );

    AnchorElement()
      ..href = uri.toString()
      ..download = 'rating.xlsx'
      ..click();
  }

  @override
  Future downloadStats({
    required int clubId,
    required DateTimeRange range,
  }) async {
    final response = await client.get<Uint8List>(
      '/api/club/$clubId/rating/download-stats?date-start=${dateFormatForRequests.format(range.start)}&date-end=${dateFormatForRequests.format(range.end)}',
    );

    final uri = Uri.dataFromBytes(
      response.data ?? Uint8List(0),
      mimeType: 'text/xlsx',
    );

    AnchorElement()
      ..href = uri.toString()
      ..download = 'stats.xlsx'
      ..click();
  }

  @override
  Future<ClubModel> getClub({required int id}) {
    return GetClubRequest(id: id).execute(client).then(
          (value) => ClubModel.fromProto(value),
        );
  }

  @override
  Future<List<ClubModel>> getClubs({bool onlyMy = false}) {
    final Future<ClubsEventOut> result;
    if (onlyMy) {
      result = ClubsMyRequest().execute(client);
    } else {
      result = ClubsListRequest().execute(client);
    }
    return result.then(
      (value) => value.club.map((e) => ClubModel.fromProto(e)).toList(),
    );
  }
}
