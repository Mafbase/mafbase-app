import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'translation_key_model.freezed.dart';

@freezed
class TranslationKeyModel with _$TranslationKeyModel {
  const factory TranslationKeyModel({
    required String key,
    required List<DesignModel> designs,
  }) = _TranslationKeyModel;

  factory TranslationKeyModel.fromProto(TranslationKeyEventOut proto) => TranslationKeyModel(
        key: proto.key,
        designs: proto.designs.map(DesignModel.fromProto).toList(),
      );
}

@freezed
class DesignModel with _$DesignModel {
  const factory DesignModel({
    required String designKey,
    required String title,
    required String preview,
  }) = _DesignModel;

  factory DesignModel.fromProto(DesignItem proto) => DesignModel(
        designKey: proto.designKey,
        title: proto.title,
        preview: proto.preview,
      );
}
