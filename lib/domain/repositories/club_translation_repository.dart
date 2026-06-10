import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

abstract class ClubTranslationRepository {
  Future<void> changeRole({
    required int playerIndex,
    required PlayerRole role,
    required int clubId,
    required int table,
    required String key,
  });

  Future<void> changeStatus({
    required int playerIndex,
    required PlayerStatus status,
    required int clubId,
    required int table,
    required String key,
  });

  Future<void> changeBroadcastPhase({
    required BroadcastPhase phase,
    required int clubId,
    required int table,
    required String key,
  });

  Future<void> changePlayer({
    required int playerIndex,
    required int playerId,
    required int clubId,
    required int table,
    required String key,
  });

  Future<String> getKey({required int clubId});
}
