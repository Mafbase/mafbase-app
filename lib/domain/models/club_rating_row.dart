import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'club_rating_row.freezed.dart';

@freezed
class ClubRatingRowModel with _$ClubRatingRowModel {
  const factory ClubRatingRowModel({
    required String nickname,
    required double score,
    required double addScore,
    required int wins,
    required int roleWins,
    required int died,
    required List<GameRowItemModel> games,
    required int ci,
  }) = _ClubRatingRowModel;

  factory ClubRatingRowModel.fromProto(ClubRatingRow proto) =>
      ClubRatingRowModel(
        nickname: proto.nickname,
        score: proto.score,
        addScore: proto.addScore,
        wins: proto.wins,
        roleWins: proto.donWins + proto.sheriffWins,
        died: proto.firstDie,
        games: proto.item.map((e) => GameRowItemModel.fromProto(e)).toList(),
        ci: proto.ci,
      );
}

@freezed
class GameRowItemModel with _$GameRowItemModel {
  const factory GameRowItemModel({double? score, required int gameId}) =
      _GameRowItemModel;

  factory GameRowItemModel.fromProto(ClubRatingRow_GameItem proto) =>
      GameRowItemModel(
        gameId: proto.gameId,
        score: proto.hasScore() ? proto.score : null,
      );
}
