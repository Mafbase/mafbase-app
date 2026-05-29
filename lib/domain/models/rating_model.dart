import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/club_rating_row.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

part 'rating_model.freezed.dart';

@freezed
abstract class RatingModel with _$RatingModel {
  const factory RatingModel({
    required String clubName,
    required List<ClubRatingRowModel> rows,
    required int games,
    required int citizenWins,
    required int mafiaWins,
    DateTimeRange? range,
  }) = _RatingModel;

  factory RatingModel.fromProto(ClubRatingEventOut event) {
    final start = event.hasDateStart() ? dateFormatForRequests.tryParse(event.dateStart) : null;
    final end = event.hasDateEnd() ? dateFormatForRequests.tryParse(event.dateEnd) : null;

    return RatingModel(
      clubName: event.clubName,
      rows: event.row.map((fromProto) => ClubRatingRowModel.fromProto(fromProto)).toList(),
      games: event.games,
      citizenWins: event.citizenWins,
      mafiaWins: event.mafiaWins,
      range: (start != null && end != null) ? DateTimeRange(start: start, end: end) : null,
    );
  }
}
