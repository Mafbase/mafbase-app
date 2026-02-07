import 'package:seating_generator_web/domain/models/player_model.dart';

abstract interface class ProfileRepository {
  Future<void> deleteAccount();
  Future<PlayerModel?> getUserProfile();
  Future<void> setUserProfile(PlayerModel player);
}
