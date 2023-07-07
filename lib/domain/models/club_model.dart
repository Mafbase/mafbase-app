import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'club_model.freezed.dart';

@freezed
class ClubModel with _$ClubModel {
  const factory ClubModel({
    required int id,
    required String name,
    DateTime? billedFor,
    String? description,
    String? imageUrl,
    String? groupLink,
    String? city,
  }) = _ClubModel;

  factory ClubModel.fromProto(Club club) => ClubModel(
        id: club.id,
        name: club.name,
        description: club.hasDescription() ? club.description : null,
        imageUrl: club.hasImageUrl() ? club.imageUrl : null,
        groupLink: club.hasGroupLink() ? club.groupLink : null,
        city: club.hasCity() ? club.city : null,
        billedFor: DateTime.tryParse(club.billedFor),
      );
}
