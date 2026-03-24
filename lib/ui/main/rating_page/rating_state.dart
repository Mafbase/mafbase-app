import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/club_rating_row.dart';

part 'rating_state.freezed.dart';

@freezed
abstract class RatingState with _$RatingState {
  const factory RatingState({
    @Default('') String clubName,
    @Default([]) List<ClubRatingRowModel> rows,
    @Default(0) int games,
    @Default(0) int mafiaWins,
    @Default(0) int citizenWins,
    @Default(true) bool isLoading,
    @Default(false) bool hasCustomColumns,
  }) = _RatingState;
}
