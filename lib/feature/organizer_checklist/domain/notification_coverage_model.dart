import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'notification_coverage_model.freezed.dart';

/// [push] — справочно: в охват [reachable] не входит.
@freezed
abstract class NotificationCoverageModel with _$NotificationCoverageModel {
  const factory NotificationCoverageModel({
    required bool isFsm,
    required int total,
    required int reachable,
    required int telegram,
    required int vk,
    required int push,
    required List<UnreachablePlayerModel> unreachable,
    required bool unavailable,
  }) = _NotificationCoverageModel;

  factory NotificationCoverageModel.fromProto(NotificationCoverageOut proto) => NotificationCoverageModel(
        isFsm: proto.isFsm,
        total: proto.total,
        reachable: proto.reachable,
        telegram: proto.telegram,
        vk: proto.vk,
        push: proto.push,
        unreachable: proto.unreachable
            .map(
              (item) => UnreachablePlayerModel(
                player: PlayerModel.fromProto(item.player),
                hasFsmNickname: item.hasFsmNickname,
              ),
            )
            .toList(),
        unavailable: proto.unavailable,
      );
}

@freezed
abstract class UnreachablePlayerModel with _$UnreachablePlayerModel {
  const factory UnreachablePlayerModel({
    required PlayerModel player,
    required bool hasFsmNickname,
  }) = _UnreachablePlayerModel;
}
