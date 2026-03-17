import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/models/photo_theme_entry_model.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/models/photo_theme_model.dart';

part 'photo_themes_state.freezed.dart';

@freezed
class PhotoThemesState with _$PhotoThemesState {
  const factory PhotoThemesState({
    @Default([]) List<PhotoThemeModel> themes,
    int? selectedThemeId,
    @Default([]) List<PhotoThemeEntryModel> players,
    @Default(true) bool isLoading,
    String? error,
  }) = _PhotoThemesState;
}
