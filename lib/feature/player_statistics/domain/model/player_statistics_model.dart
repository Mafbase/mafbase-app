import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'player_statistics_model.freezed.dart';

@freezed
class PlayerStatisticsModel with _$PlayerStatisticsModel {
  const factory PlayerStatisticsModel({
    required int playerId,
    required String nickname,
    required PlayerRoleStatsModel overall,
    required PlayerRoleStatsModel citizen,
    required PlayerRoleStatsModel mafia,
    required PlayerRoleStatsModel don,
    required PlayerRoleStatsModel sheriff,
    required List<PlayerPairStatModel> sameCityTop,
    required List<PlayerPairStatModel> sameMafiaTop,
    required List<PlayerPairStatModel> diffTeamTop,
    required List<PlayerPairStatModel> sameCityBottom,
    required List<PlayerPairStatModel> sameMafiaBottom,
    required List<PlayerPairStatModel> diffTeamBottom,
  }) = _PlayerStatisticsModel;

  factory PlayerStatisticsModel.fromProto(PlayerStatisticsEventOut proto) =>
      PlayerStatisticsModel(
        playerId: proto.playerId,
        nickname: proto.nickname,
        overall: PlayerRoleStatsModel.fromProto(proto.overall),
        citizen: PlayerRoleStatsModel.fromProto(proto.citizen),
        mafia: PlayerRoleStatsModel.fromProto(proto.mafia),
        don: PlayerRoleStatsModel.fromProto(proto.don),
        sheriff: PlayerRoleStatsModel.fromProto(proto.sheriff),
        sameCityTop: proto.sameCityTop
            .map((e) => PlayerPairStatModel.fromProto(e))
            .toList(),
        sameMafiaTop: proto.sameMafiaTop
            .map((e) => PlayerPairStatModel.fromProto(e))
            .toList(),
        diffTeamTop: proto.diffTeamTop
            .map((e) => PlayerPairStatModel.fromProto(e))
            .toList(),
        sameCityBottom: proto.sameCityBottom
            .map((e) => PlayerPairStatModel.fromProto(e))
            .toList(),
        sameMafiaBottom: proto.sameMafiaBottom
            .map((e) => PlayerPairStatModel.fromProto(e))
            .toList(),
        diffTeamBottom: proto.diffTeamBottom
            .map((e) => PlayerPairStatModel.fromProto(e))
            .toList(),
      );
}

@freezed
class PlayerRoleStatsModel with _$PlayerRoleStatsModel {
  const factory PlayerRoleStatsModel({
    required int games,
    required int wins,
    required double winRate,
    required double avgBonusScore,
  }) = _PlayerRoleStatsModel;

  factory PlayerRoleStatsModel.fromProto(PlayerRoleStats proto) =>
      PlayerRoleStatsModel(
        games: proto.games,
        wins: proto.wins,
        winRate: proto.winRate,
        avgBonusScore: proto.avgBonusScore,
      );
}

@freezed
class PlayerPairStatModel with _$PlayerPairStatModel {
  const factory PlayerPairStatModel({
    required int playerId,
    required String nickname,
    required int games,
    required int wins,
    required double winRate,
  }) = _PlayerPairStatModel;

  factory PlayerPairStatModel.fromProto(PlayerPairStat proto) =>
      PlayerPairStatModel(
        playerId: proto.playerId,
        nickname: proto.nickname,
        games: proto.games,
        wins: proto.wins,
        winRate: proto.winRate,
      );
}
