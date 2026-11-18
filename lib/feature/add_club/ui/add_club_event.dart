import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_club_event.freezed.dart';

@freezed
abstract class AddClubEvent with _$AddClubEvent {
  const factory AddClubEvent.formSubmitted({
    required String name,
    String? description,
    String? groupLink,
  }) = AddClubEventFormSubmitted;
}
