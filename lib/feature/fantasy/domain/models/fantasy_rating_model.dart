import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_rating_row_model.dart';

part 'fantasy_rating_model.freezed.dart';

@freezed
class FantasyRatingModel with _$FantasyRatingModel {
  const factory FantasyRatingModel({
    required List<FantasyRatingRowModel> rows,
  }) = _FantasyRatingModel;
}
