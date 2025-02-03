import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'ci_scheme_model.freezed.dart';

@freezed
class CiSchemeModel with _$CiSchemeModel {
  const factory CiSchemeModel({
    required int id,
    required String name,
  }) = _CiSchemeModel;

  factory CiSchemeModel.fromProto(CiScheme proto) => CiSchemeModel(
        id: proto.id,
        name: proto.name,
      );

  static const CiSchemeModel empty = CiSchemeModel(id: -1, name: 'Без коменсации');
}
