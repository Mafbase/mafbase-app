import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'fantasy_prediction_item_model.freezed.dart';

@freezed
abstract class FantasyPredictionItemModel with _$FantasyPredictionItemModel {
  const factory FantasyPredictionItemModel({
    required int gameNumber,
    GameWin? prediction,
    GameWin? actualResult,
    required int points,
  }) = _FantasyPredictionItemModel;
}
