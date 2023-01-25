import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

class TranslationRepositoryMock implements TranslationRepository {
  @override
  Future<bool> insertSeating(List<int> bytes, int tournamentId) async {
    return Future.microtask(() => true);
  }

  @override
  Future changeRole({
    required int playerIndex,
    required PlayerRole role,
    required int table,
    required int tournamentId,
  }) async {}

  @override
  Future changeStatus({
    required int playerIndex,
    required PlayerStatus status,
    required int table,
    required int tournamentId,
  }) async {}

  @override
  Future selectGame({
    required int gameIndex,
    required int table,
    required int tournamentId,
  }) async {}
}
