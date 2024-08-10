import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/feature/profile/data/request/delete_account_request.dart';
import 'package:seating_generator_web/feature/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends BaseRepository
    implements ProfileRepository {
  ProfileRepositoryImpl(super.client);

  @override
  Future<void> deleteAccount() => DeleteAccountRequest().execute(client);
}
