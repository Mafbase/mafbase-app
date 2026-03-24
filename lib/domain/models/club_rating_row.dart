import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/custom_column_value_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'club_rating_row.freezed.dart';

@freezed
abstract class ClubRatingRowModel with _$ClubRatingRowModel {
  const factory ClubRatingRowModel({
    required int playerId,
    required String nickname,
    required double score,
    required double addScore,
    required int wins,
    required int gamesCount,
    required int citizenGamesCount,
    required int donsGamesCount,
    required int sheriffGamesCount,
    required int mafiaGamesCount,
    required int citizenWinsCount,
    required int donsWinsCount,
    required int sheriffWinsCount,
    required int mafiaWinsCount,
    required int died,
    required List<GameRowItemModel> games,
    required int ci,
    required double citizenAddScore,
    required double sheriffAddScore,
    required double donAddScore,
    required double mafiaAddScore,
    required double citizenScore,
    required double sheriffScore,
    required double donScore,
    required double mafiaScore,
    @Default([]) List<CustomColumnValueModel> customColumns,
  }) = _ClubRatingRowModel;

  factory ClubRatingRowModel.fromProto(ClubRatingRow proto) => ClubRatingRowModel(
        playerId: proto.playerId,
        nickname: proto.nickname,
        score: proto.score,
        addScore: proto.addScore,
        wins: proto.wins,
        gamesCount: proto.totalGames,
        citizenGamesCount: proto.citizenGames,
        donsGamesCount: proto.donGames,
        sheriffGamesCount: proto.sheriffGames,
        mafiaGamesCount: proto.mafiaGames,
        citizenWinsCount: proto.citizenWins,
        donsWinsCount: proto.donWins,
        sheriffWinsCount: proto.sheriffWins,
        mafiaWinsCount: proto.mafiaWins,
        died: proto.firstDie,
        games: proto.item.map((e) => GameRowItemModel.fromProto(e)).toList(),
        ci: proto.ci,
        citizenAddScore: proto.citizenAddScore,
        sheriffAddScore: proto.sheriffAddScore,
        donAddScore: proto.donAddScore,
        mafiaAddScore: proto.mafiaAddScore,
        citizenScore: proto.citizenScore,
        sheriffScore: proto.sheriffScore,
        donScore: proto.donScore,
        mafiaScore: proto.mafiaScore,
        customColumns: proto.customColumns.map((e) => CustomColumnValueModel.fromProto(e)).toList(),
      );
}

extension ClubRatingRowModelExt on ClubRatingRowModel {
  int get roleWins => donsWinsCount + sheriffWinsCount;
}

@freezed
abstract class GameRowItemModel with _$GameRowItemModel {
  const factory GameRowItemModel({double? score, required int gameId}) = _GameRowItemModel;

  factory GameRowItemModel.fromProto(ClubRatingRow_GameItem proto) => GameRowItemModel(
        gameId: proto.gameId,
        score: proto.hasScore() ? proto.score : null,
      );
}
