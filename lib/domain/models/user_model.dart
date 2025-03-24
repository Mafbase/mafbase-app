import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String email,
  }) = _UserModel;

  factory UserModel.fromProto(User event) => UserModel(
        id: event.id,
        email: event.email,
      );
}
