import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';

part 'clubs_event.freezed.dart';

@freezed
class ClubsEvent with _$ClubsEvent {
  const factory ClubsEvent.pageOpened() = ClubsEventPageOpened;

  const factory ClubsEvent.clubSelected({
    required ClubModel clubModel,
  }) = ClubsEventClubSelected;
}
