import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/data/requests/add_owner_request.dart';
import 'package:seating_generator_web/data/requests/add_club_owner_request.dart';
import 'package:seating_generator_web/data/requests/delete_owner_request.dart';
import 'package:seating_generator_web/data/requests/delete_club_owner_request.dart';
import 'package:seating_generator_web/data/requests/get_owners_request.dart';
import 'package:seating_generator_web/data/requests/get_club_owners_request.dart';
import 'package:seating_generator_web/domain/models/user_model.dart';
import 'package:seating_generator_web/domain/repositories/owners_repository.dart';

class OwnersRepositoryImpl extends BaseRepository implements OwnersRepository {
  OwnersRepositoryImpl(super.client);

  @override
  Future<List<UserModel>> getOwners({required int tournamentId}) async {
    return GetOwnersRequest(tournamentId: tournamentId)
        .execute(client)
        .then((value) {
      return value.owners.map((e) => UserModel.fromProto(e)).toList();
    });
  }

  @override
  Future<void> addOwner(
      {required int tournamentId, required String email}) async {
    await AddOwnerRequest(tournamentId: tournamentId, email: email)
        .execute(client);
  }

  @override
  Future<void> deleteOwner(
      {required int tournamentId, required int ownerId}) async {
    await DeleteOwnerRequest(tournamentId: tournamentId, ownerId: ownerId)
        .execute(client);
  }

  @override
  Future<List<UserModel>> getClubOwners({required int clubId}) async {
    return GetClubOwnersRequest(clubId: clubId).execute(client).then((value) {
      return value.owners.map((e) => UserModel.fromProto(e)).toList();
    });
  }

  @override
  Future<void> addClubOwner(
      {required int clubId, required String email}) async {
    await AddClubOwnerRequest(clubId: clubId, email: email).execute(client);
  }

  @override
  Future<void> deleteClubOwner(
      {required int clubId, required int ownerId}) async {
    await DeleteClubOwnerRequest(clubId: clubId, ownerId: ownerId)
        .execute(client);
  }
}
