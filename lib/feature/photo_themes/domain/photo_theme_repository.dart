import 'dart:typed_data';

import 'package:seating_generator_web/feature/photo_themes/domain/models/photo_theme_entry_model.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/models/photo_theme_model.dart';

abstract interface class PhotoThemeRepository {
  Future<List<PhotoThemeModel>> getThemes();

  Future<int> createTheme(String name);

  Future<void> updateTheme(int themeId, String name);

  Future<void> deleteTheme(int themeId);

  Future<List<PhotoThemeEntryModel>> getThemePlayers(int themeId);

  Future<void> uploadPhoto(
    int themeId,
    int playerId,
    Uint8List bytes,
    String filename,
  );

  Future<void> deletePhoto(int themeId, int playerId);

  Future<void> setTournamentPhotoTheme(int tournamentId, int? themeId);

  Future<void> addPlayerToTheme(int themeId, int playerId);

  Future<int> addPlayersFromTournament(int themeId, int tournamentId);

  Future<void> removePlayerFromTheme(int themeId, int playerId);
}
