import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

abstract interface class ClubOwnersRepository {
  Future<ClubOwnersEventOut> getOwners(int clubId);

  Future<void> addOwner({required int clubId, required String email});

  Future<void> deleteOwner({required int clubId, required int ownerId});
}
