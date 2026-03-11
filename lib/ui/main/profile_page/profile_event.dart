import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.onLogoutPressed() = ProfileEventLogoutPressed;

  const factory ProfileEvent.deleteProfile() = ProfileEventDeleteProfile;

  const factory ProfileEvent.loadUserProfile() = ProfileEventLoadUserProfile;

  const factory ProfileEvent.setUserProfile(PlayerModel player) =
      ProfileEventSetUserProfile;

  const factory ProfileEvent.loadSubscription() =
      ProfileEventLoadSubscription;

  const factory ProfileEvent.billSubscription(
    int days,
    String redirectPath,
  ) = ProfileEventBillSubscription;
}
