import 'package:freezed_annotation/freezed_annotation.dart';

part 'fantasy_current_game_info_model.freezed.dart';

@freezed
class FantasyCurrentGameInfoModel with _$FantasyCurrentGameInfoModel {
  const factory FantasyCurrentGameInfoModel({
    required int gameNumber,
    required bool canPredict,
    required bool canParticipate,
  }) = _FantasyCurrentGameInfoModel;
}
