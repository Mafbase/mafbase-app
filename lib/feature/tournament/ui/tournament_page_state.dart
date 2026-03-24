import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/models/photo_theme_model.dart';

part 'tournament_page_state.freezed.dart';

@freezed
abstract class TournamentPageState with _$TournamentPageState {
  const factory TournamentPageState({
    @Default(true) bool isLoading,
    @Default([]) List<PlayerModel> tournamentPlayers,
    @Default([]) List<List<PlayerModel>> cannotMeet,
    @Default([]) List<PlayerModel> finalPlayers,
    @Default(
      TournamentSettingsModel(
        defaultGames: 0,
        swissGames: 0,
        finalGames: 0,
      ),
    )
    TournamentSettingsModel settings,
    @Default(10) int billedPlayers,
    @Default(false) bool billedTranslation,
    @Default(false) bool isMyTournament,
    @Default(false) bool notificationEnabled,
    String? gomafiaUrl,
    int? activePhotoThemeId,
    @Default({}) Map<int, String> activeThemePhotos,
    @Default([]) List<PhotoThemeModel> photoThemes,
  }) = _TournamentPageState;
}
