import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'game_result_model.freezed.dart';

@freezed
abstract class GameResultModel with _$GameResultModel {
  const factory GameResultModel({
    required int gameId,
    List<PlayerRole>? roles,
    required List<String> nicknames,
    required String referee,
    GameWin? gameWin,
    List<double>? scores,
    List<PlayerResultStatus?>? statuses,
    required int table,
    required int game,
  }) = _GameResultModel;

  factory GameResultModel.fromProto(TableSeatingItem proto) {
    return GameResultModel(
      gameId: proto.gameId,
      nicknames: proto.seating.nickname,
      referee: proto.seating.referee,
      table: proto.seating.table,
      scores: proto.hasResult() ? proto.result.score : null,
      gameWin: proto.hasResult() ? proto.result.win : null,
      roles: proto.hasResult() ? proto.result.role : null,
      game: proto.game,
      statuses: proto.hasResult()
          ? List.generate(10, (index) {
              if (proto.result.died == index) {
                if (proto.result.bestMove != BestMove.miss) {
                  return PlayerResultStatus.diedPositive;
                } else {
                  return PlayerResultStatus.died;
                }
              }
              // Проверяем положительные баллы из addScore
              if (proto.result.addScore[index] > 0) {
                return PlayerResultStatus.positive;
              }
              // Проверяем отрицательные баллы из minusScore
              if (proto.result.minusScore[index] > 0) {
                return PlayerResultStatus.negative;
              }
              return null;
            })
          : null,
    );
  }
}

enum PlayerResultStatus {
  negative,
  positive,
  died,
  diedPositive;
}
