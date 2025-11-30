typedef InfoTableDescription = List<MapEntry<int, String>>;

abstract interface class InfoTableDescriptionRepository {
  Future<InfoTableDescription> getDescriptions(String tournamentId);

  Future<void> setDescriptions({required String tournamentId, required InfoTableDescription description});
}
