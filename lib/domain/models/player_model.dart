import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'player_model.freezed.dart';

@freezed
class PlayerModel with _$PlayerModel {
  static const int undefinedId = -1;

  const factory PlayerModel({
    @Default(PlayerModel.undefinedId) int id,
    required String nickname,
    String? fsmNickaname,
    String? mafbankNickname,
    String? imageUrl,
  }) = _PlayerModel;

  factory PlayerModel.fromProto(Player proto) => PlayerModel(
        id: proto.id,
        nickname: proto.nickname,
        fsmNickaname: proto.fsmNickname.isNotEmpty ? proto.fsmNickname : null,
        mafbankNickname: proto.mafbankNickname.isNotEmpty ? proto.mafbankNickname : null,
        imageUrl: proto.hasImage() ? proto.image : null,
      );
}

extension PlayerModelExt on PlayerModel {
  Player toProto() => Player(
        id: id,
        nickname: nickname,
        fsmNickname: fsmNickaname,
        mafbankNickname: mafbankNickname,
        image: imageUrl,
      );
}
