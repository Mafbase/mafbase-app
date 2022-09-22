abstract class TranslationRepository {
  Future<bool> insertSeating(List<int> bytes, int tournamentId);
}