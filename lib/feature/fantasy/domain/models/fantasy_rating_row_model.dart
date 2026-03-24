import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_prediction_item_model.dart';

part 'fantasy_rating_row_model.freezed.dart';

@freezed
abstract class FantasyRatingRowModel with _$FantasyRatingRowModel {
  const factory FantasyRatingRowModel({
    required String nickname,
    required List<FantasyPredictionItemModel> predictions,
    required int totalPoints,
    required int playerId,
  }) = _FantasyRatingRowModel;
}
