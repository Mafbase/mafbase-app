import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'custom_column_value_model.freezed.dart';

@freezed
abstract class CustomColumnValueModel with _$CustomColumnValueModel {
  const factory CustomColumnValueModel({
    required String title,
    double? value,
  }) = _CustomColumnValueModel;

  factory CustomColumnValueModel.fromProto(CustomColumnValue proto) => CustomColumnValueModel(
        title: proto.title,
        value: proto.hasValue() ? proto.value : null,
      );
}
