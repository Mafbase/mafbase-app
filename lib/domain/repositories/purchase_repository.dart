abstract class PurchaseRepository {
  Future<String> billTranslation({
    required int tournamentId,
    required int playersCount,
    required bool billedTranslation,
    required String redirectPath,
  });
}
