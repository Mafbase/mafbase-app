import 'package:seating_generator_web/domain/repositories/translation_repository.dart';

class TranslationRepositoryMock implements TranslationRepository {
  @override
  Future<bool> insertSeating(List<int> bytes, int tournamentId) async {
    return true;
  }
}