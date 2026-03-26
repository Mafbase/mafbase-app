import 'package:seating_generator_web/domain/models/translation_key_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

abstract class TranslationRepository {
  Future<bool> insertSeating(List<int> bytes, int tournamentId);

  Future changeRole({
    required int playerIndex,
    required PlayerRole role,
    required int table,
    required int tournamentId,
    required String key,
  });

  Future changeStatus({
    required int playerIndex,
    required PlayerStatus status,
    required int table,
    required int tournamentId,
    required String key,
  });

  Future selectGame({
    required int gameIndex,
    required int table,
    required int tournamentId,
    required String key,
  });

  Future<TranslationKeyModel> getKey({required int tournamentId});

  Future<void> saveDesign({required int tournamentId, required String designKey});
}
