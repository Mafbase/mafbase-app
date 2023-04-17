import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_event.freezed.dart';

@freezed
class ClubEvent with _$ClubEvent {
  const factory ClubEvent.pageOpened() = ClubEventPageOpened;

  const factory ClubEvent.openRating() = ClubEventOpenRating;

  const factory ClubEvent.billClub({
    required int days,
  }) = ClubEventBillClub;
}
