import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'photo_theme_entry_model.freezed.dart';

@freezed
class PhotoThemeEntryModel with _$PhotoThemeEntryModel {
  const factory PhotoThemeEntryModel({
    required int playerId,
    required String nickname,
    String? themeImageUrl,
    String? profileImageUrl,
  }) = _PhotoThemeEntryModel;

  factory PhotoThemeEntryModel.fromProto(PhotoThemePlayer proto) => PhotoThemeEntryModel(
        playerId: proto.playerId,
        nickname: proto.nickname,
        themeImageUrl: proto.hasThemeImageUrl() ? proto.themeImageUrl : null,
        profileImageUrl: proto.hasProfileImageUrl() ? proto.profileImageUrl : null,
      );
}
