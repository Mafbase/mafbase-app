import 'dart:typed_data';

import 'package:seating_generator_web/data/base_repository.dart';
import 'package:seating_generator_web/data/requests/get_all_players_request.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/photo_themes/data/requests/add_theme_photo_request.dart';
import 'package:seating_generator_web/feature/photo_themes/data/requests/add_player_to_theme_request.dart';
import 'package:seating_generator_web/feature/photo_themes/data/requests/add_players_from_tournament_request.dart';
import 'package:seating_generator_web/feature/photo_themes/data/requests/create_photo_theme_request.dart';
import 'package:seating_generator_web/feature/photo_themes/data/requests/delete_photo_theme_request.dart';
import 'package:seating_generator_web/feature/photo_themes/data/requests/delete_theme_photo_request.dart';
import 'package:seating_generator_web/feature/photo_themes/data/requests/get_photo_themes_request.dart';
import 'package:seating_generator_web/feature/photo_themes/data/requests/get_theme_players_request.dart';
import 'package:seating_generator_web/feature/photo_themes/data/requests/remove_player_from_theme_request.dart';
import 'package:seating_generator_web/feature/photo_themes/data/requests/set_active_theme_request.dart';
import 'package:seating_generator_web/feature/photo_themes/data/requests/update_photo_theme_request.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/models/photo_theme_entry_model.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/models/photo_theme_model.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/photo_theme_repository.dart';

class PhotoThemeRepositoryImpl extends BaseRepository implements PhotoThemeRepository {
  PhotoThemeRepositoryImpl(super.client);

  @override
  Future<List<PhotoThemeModel>> getThemes() => GetPhotoThemesRequest().execute(client).then(
        (value) => value.themes.map(PhotoThemeModel.fromProto).toList(),
      );

  @override
  Future<int> createTheme(String name) => CreatePhotoThemeRequest(name: name).execute(client).then((value) => value.id);

  @override
  Future<void> updateTheme(int themeId, String name) =>
      UpdatePhotoThemeRequest(themeId: themeId, name: name).execute(client);

  @override
  Future<void> deleteTheme(int themeId) => DeletePhotoThemeRequest(themeId: themeId).execute(client);

  @override
  Future<List<PhotoThemeEntryModel>> getThemePlayers(int themeId) =>
      GetThemePlayersRequest(themeId: themeId).execute(client).then(
            (value) => value.players.map(PhotoThemeEntryModel.fromProto).toList(),
          );

  @override
  Future<void> uploadPhoto(
    int themeId,
    int playerId,
    Uint8List bytes,
    String filename,
  ) =>
      AddThemePhotoRequest(
        themeId: themeId,
        playerId: playerId,
        bytes: bytes,
        filename: filename,
      ).execute(client);

  @override
  Future<void> deletePhoto(int themeId, int playerId) =>
      DeleteThemePhotoRequest(themeId: themeId, playerId: playerId).execute(client);

  @override
  Future<void> setTournamentPhotoTheme(int tournamentId, int? themeId) =>
      SetActiveThemeRequest(tournamentId: tournamentId, themeId: themeId).execute(client);

  @override
  Future<void> addPlayerToTheme(int themeId, int playerId) =>
      AddPlayerToThemeRequest(themeId: themeId, playerId: playerId).execute(client);

  @override
  Future<int> addPlayersFromTournament(int themeId, int tournamentId) => AddPlayersFromTournamentRequest(
        themeId: themeId,
        tournamentId: tournamentId,
      ).execute(client).then((value) => value.addedCount);

  @override
  Future<void> removePlayerFromTheme(int themeId, int playerId) =>
      RemovePlayerFromThemeRequest(themeId: themeId, playerId: playerId).execute(client);

  @override
  Future<List<PlayerModel>> getAvailablePlayers() => GetAllPlayersRequest().execute(client).then(
        (value) => value.players.map(PlayerModel.fromProto).toList(),
      );
}
