import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'custom_column_model.freezed.dart';

@freezed
class CustomColumnModel with _$CustomColumnModel {
  const factory CustomColumnModel({
    required int id,
    required String title,
    required String formula,
  }) = _CustomColumnModel;

  factory CustomColumnModel.fromProto(CustomColumnDefinition proto) => CustomColumnModel(
        id: proto.id,
        title: proto.title,
        formula: proto.formula,
      );
}
