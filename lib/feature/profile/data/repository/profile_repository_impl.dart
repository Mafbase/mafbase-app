import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/profile/data/request/delete_account_request.dart';
import 'package:seating_generator_web/feature/profile/data/request/get_user_profile_request.dart';
import 'package:seating_generator_web/feature/profile/data/request/set_user_profile_request.dart';
import 'package:seating_generator_web/feature/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends BaseRepository
    implements ProfileRepository {
  ProfileRepositoryImpl(super.client);

  @override
  Future<void> deleteAccount() => DeleteAccountRequest().execute(client);

  @override
  Future<PlayerModel?> getUserProfile() async {
    try {
      final userProfile = await GetUserProfileRequest().execute(client);
      if (userProfile.hasPlayer()) {
        return PlayerModel.fromProto(userProfile.player);
      }
      return null;
    } catch (e) {
      // Если профиль не найден, возвращаем null
      return null;
    }
  }

  @override
  Future<void> setUserProfile(PlayerModel player) =>
      SetUserProfileRequest(player: player.toProto()).execute(client);
}
