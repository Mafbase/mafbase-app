import 'package:seating_generator_web/domain/models/user_model.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_current_game_info_model.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_prediction_item_model.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_rating_model.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_rating_row_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

extension FantasyPredictionItemExt on FantasyPredictionItem {
  FantasyPredictionItemModel toDomain() => FantasyPredictionItemModel(
        gameNumber: gameNumber,
        prediction: hasPrediction() ? prediction : null,
        actualResult: hasActualResult() ? actualResult : null,
        points: points,
      );
}

extension FantasyRatingRowExt on FantasyRatingRow {
  FantasyRatingRowModel toDomain() => FantasyRatingRowModel(
        nickname: nickname,
        predictions: predictions.map((e) => e.toDomain()).toList(),
        totalPoints: totalPoints,
        playerId: playerId,
      );
}

extension FantasyRatingEventOutExt on FantasyRatingEventOut {
  FantasyRatingModel toDomain() => FantasyRatingModel(
        rows: rows.map((e) => e.toDomain()).toList(),
      );
}

extension FantasyCurrentGameEventOutExt on FantasyCurrentGameEventOut {
  FantasyCurrentGameInfoModel toDomain() => FantasyCurrentGameInfoModel(
        gameNumber: gameNumber,
        canPredict: canPredict,
        canParticipate: canParticipate,
      );
}

extension UserExt on User {
  UserModel toDomain() => UserModel(
        id: id,
        email: email,
      );
}

extension FantasyParticipantsEventOutExt on FantasyParticipantsEventOut {
  List<UserModel> toDomain() => participants.map((e) => e.toDomain()).toList();
}
