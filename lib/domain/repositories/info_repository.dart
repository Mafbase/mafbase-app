abstract class InfoRepository {
  Future startGameInfo({required int tournamentId, required int game});

  Future customTextInfo({required int tournamentId, required String text});
}
