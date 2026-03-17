import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/photo_theme_repository.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_event.dart';
import 'package:seating_generator_web/feature/photo_themes/ui/photo_themes_state.dart';

class PhotoThemesBloc extends Bloc<PhotoThemesEvent, PhotoThemesState> {
  final PhotoThemeRepository _repository;

  PhotoThemesBloc(
    super.initialState,
    this._repository,
  ) {
    on<PhotoThemesEventInit>(_onInit);
    on<PhotoThemesEventSelectTheme>(_onSelectTheme);
    on<PhotoThemesEventCreateTheme>(_onCreateTheme);
    on<PhotoThemesEventRenameTheme>(_onRenameTheme);
    on<PhotoThemesEventDeleteTheme>(_onDeleteTheme);
    on<PhotoThemesEventUploadPhoto>(_onUploadPhoto);
    on<PhotoThemesEventDeletePhoto>(_onDeletePhoto);
    on<PhotoThemesEventAddPlayer>(_onAddPlayer);
    on<PhotoThemesEventAddFromTournament>(_onAddFromTournament);
    on<PhotoThemesEventRemovePlayer>(_onRemovePlayer);
  }

  Future<void> _onInit(
    PhotoThemesEventInit event,
    Emitter<PhotoThemesState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        error: null,
      ),
    );
    try {
      final themes = await _repository.getThemes();
      emit(
        state.copyWith(
          themes: themes,
          isLoading: false,
        ),
      );

      if (themes.isNotEmpty) {
        final firstThemeId = themes.first.id;
        emit(state.copyWith(selectedThemeId: firstThemeId));
        await _loadPlayers(firstThemeId, emit);
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSelectTheme(
    PhotoThemesEventSelectTheme event,
    Emitter<PhotoThemesState> emit,
  ) async {
    emit(state.copyWith(selectedThemeId: event.themeId, isLoading: true));
    await _loadPlayers(event.themeId, emit);
  }

  Future<void> _onCreateTheme(
    PhotoThemesEventCreateTheme event,
    Emitter<PhotoThemesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final newId = await _repository.createTheme(event.name);
      final themes = await _repository.getThemes();
      emit(
        state.copyWith(
          themes: themes,
          selectedThemeId: newId,
          isLoading: false,
        ),
      );
      await _loadPlayers(newId, emit);
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onRenameTheme(
    PhotoThemesEventRenameTheme event,
    Emitter<PhotoThemesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.updateTheme(event.themeId, event.name);
      final themes = await _repository.getThemes();
      emit(state.copyWith(themes: themes, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onDeleteTheme(
    PhotoThemesEventDeleteTheme event,
    Emitter<PhotoThemesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.deleteTheme(event.themeId);
      final themes = await _repository.getThemes();
      final newSelectedId = themes.isNotEmpty ? themes.first.id : null;
      emit(
        state.copyWith(
          themes: themes,
          selectedThemeId: newSelectedId,
          players: [],
          isLoading: false,
        ),
      );
      if (newSelectedId != null) {
        await _loadPlayers(newSelectedId, emit);
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onUploadPhoto(
    PhotoThemesEventUploadPhoto event,
    Emitter<PhotoThemesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.uploadPhoto(
        event.themeId,
        event.playerId,
        event.bytes,
        event.filename,
      );
      await _loadPlayers(event.themeId, emit);
      final themes = await _repository.getThemes();
      emit(state.copyWith(themes: themes));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onDeletePhoto(
    PhotoThemesEventDeletePhoto event,
    Emitter<PhotoThemesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.deletePhoto(event.themeId, event.playerId);
      await _loadPlayers(event.themeId, emit);
      final themes = await _repository.getThemes();
      emit(state.copyWith(themes: themes));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onAddPlayer(
    PhotoThemesEventAddPlayer event,
    Emitter<PhotoThemesState> emit,
  ) async {
    final themeId = state.selectedThemeId;
    if (themeId == null) return;
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.addPlayerToTheme(themeId, event.playerId);
      await _loadPlayers(themeId, emit);
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onAddFromTournament(
    PhotoThemesEventAddFromTournament event,
    Emitter<PhotoThemesState> emit,
  ) async {
    final themeId = state.selectedThemeId;
    if (themeId == null) return;
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.addPlayersFromTournament(
        themeId,
        event.tournamentId,
      );
      await _loadPlayers(themeId, emit);
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onRemovePlayer(
    PhotoThemesEventRemovePlayer event,
    Emitter<PhotoThemesState> emit,
  ) async {
    final themeId = state.selectedThemeId;
    if (themeId == null) return;
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.removePlayerFromTheme(themeId, event.playerId);
      await _loadPlayers(themeId, emit);
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _loadPlayers(
    int themeId,
    Emitter<PhotoThemesState> emit,
  ) async {
    try {
      final players = await _repository.getThemePlayers(themeId);
      emit(state.copyWith(players: players, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
