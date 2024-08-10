import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.onPageOpened() = ProfileEventPageOpened;

  const factory ProfileEvent.onLogoutPressed() = ProfileEventLogoutPressed;

  const factory ProfileEvent.deleteProfile() = ProfileEventDeleteProfile;
}
