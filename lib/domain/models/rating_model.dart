import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/club_rating_row.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'rating_model.freezed.dart';

@freezed
abstract class RatingModel with _$RatingModel {
  const factory RatingModel({
    required String clubName,
    required List<ClubRatingRowModel> rows,
    required int games,
    required int citizenWins,
    required int mafiaWins,
  }) = _RatingModel;

  factory RatingModel.fromProto(ClubRatingEventOut event) {
    return RatingModel(
      clubName: event.clubName,
      rows: event.row.map((fromProto) => ClubRatingRowModel.fromProto(fromProto)).toList(),
      games: event.games,
      citizenWins: event.citizenWins,
      mafiaWins: event.mafiaWins,
    );
  }
}
