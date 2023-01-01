import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';
part 'game_result_model.freezed.dart';
@freezed
class GameResultModel with _$GameResultModel {
  const factory GameResultModel({
    required int gameId,
    List<PlayerRole>? roles,
    required List<String> nicknames,
    required String referee,
    GameWin? gameWin,
    required List<double> scores,
    List<PlayerResultStatus?>? statuses,
    required int table,
  }) = _GameResultModel;
}

enum PlayerResultStatus {
  negative,
  positive,
  died,
  diedPositive;
}
