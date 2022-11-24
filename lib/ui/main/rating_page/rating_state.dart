import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/club_rating_row.dart';

part 'rating_state.freezed.dart';

@freezed
class RatingState with _$RatingState {
  const factory RatingState({
    @Default([]) List<ClubRatingRowModel> rows,
    @Default(true) bool isLoading,
  }) = _RatingState;
}
