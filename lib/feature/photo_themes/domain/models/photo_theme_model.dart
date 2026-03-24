import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'photo_theme_model.freezed.dart';

@freezed
abstract class PhotoThemeModel with _$PhotoThemeModel {
  const factory PhotoThemeModel({
    required int id,
    required String name,
    required int ownerId,
    required int photosCount,
  }) = _PhotoThemeModel;

  factory PhotoThemeModel.fromProto(PhotoTheme proto) => PhotoThemeModel(
        id: proto.id,
        name: proto.name,
        ownerId: proto.ownerId,
        photosCount: proto.photosCount,
      );
}
