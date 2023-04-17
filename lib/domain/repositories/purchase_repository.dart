abstract class PurchaseRepository {
  Future<String> billTranslation({
    required int tournamentId,
    required int playersCount,
    required bool billedTranslation,
    required String redirectPath,
  });

  Future<String> billClub({
    required int clubId,
    required int days,
    required String redirectPath,
  });
}
