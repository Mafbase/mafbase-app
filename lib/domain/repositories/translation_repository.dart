import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

abstract class TranslationRepository {
  Future<bool> insertSeating(List<int> bytes, int tournamentId);

  Future changeRole({
    required int playerIndex,
    required PlayerRole role,
    required int table,
    required int tournamentId,
  });

  Future changeStatus({
    required int playerIndex,
    required PlayerStatus status,
    required int table,
    required int tournamentId,
  });

  Future selectGame({
    required int gameIndex,
    required int table,
    required int tournamentId,
  });
}
