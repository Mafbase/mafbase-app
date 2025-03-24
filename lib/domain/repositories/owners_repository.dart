import 'package:seating_generator_web/domain/models/user_model.dart';

abstract class OwnersRepository {
  Future<List<UserModel>> getOwners({required int tournamentId});

  Future<void> addOwner({required int tournamentId, required String email});

  Future<void> deleteOwner({required int tournamentId, required int ownerId});
}