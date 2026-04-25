import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/add_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/bill_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/custom_text_info_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_final_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_settings_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/set_final_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/start_game_info_interactor.dart';
import 'package:seating_generator_web/domain/interactors/tournament_check_interactor.dart';
import 'package:seating_generator_web/domain/interactors/update_settings_interactor.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/photo_theme_repository.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_effect.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_router.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:url_launcher/url_launcher.dart';

class TournamentPageBloc extends Bloc<TournamentPageEvent, TournamentPageState>
    with EffectEmitter<TournamentPageEffect, TournamentPageState> {
  final int tournamentId;
  final RepositoryFactory _repos;
  final BuildContext? _context;

  late final GetTournamentsPlayersInteractor _getTournamentsPlayersInteractor =
      GetTournamentsPlayersInteractor(_repos.playersRepository);
  late final AddTournamentPlayerInteractor _addPlayerInteractor =
      AddTournamentPlayerInteractor(_repos.playersRepository);
  late final DeletePlayerInteractor _deletePlayerInteractor = DeletePlayerInteractor(_repos.playersRepository);
  late final GetSettingsInteractor _getSettingsInteractor = GetSettingsInteractor(_repos.tournamentEditRepository);
  late final UpdateSettingsInteractor _updateSettingsInteractor =
      UpdateSettingsInteractor(_repos.tournamentEditRepository);
  late final TournamentCheckInteractor _tournamentCheckInteractor =
      TournamentCheckInteractor(_repos.tournamentsRepository);
  late final GetTournamentInteractor _getTournamentInteractor = GetTournamentInteractor(_repos.tournamentsRepository);
  late final GetFinalPlayersInteractor _getFinalPlayersInteractor =
      GetFinalPlayersInteractor(_repos.tournamentEditRepository);
  late final SetFinalPlayersInteractor _setFinalPlayersInteractor =
      SetFinalPlayersInteractor(_repos.tournamentEditRepository);
  late final CustomTextInfoInteractor _customTextInfoInteractor = CustomTextInfoInteractor(_repos.infoRepository);
  late final StartGameInfoInteractor _startGameInfoInteractor = StartGameInfoInteractor(_repos.infoRepository);
  late final PhotoThemeRepository _photoThemeRepository = _repos.photoThemeRepository;
  late final BillTournamentInteractor _billTournamentInteractor =
      BillTournamentInteractor(_repos.purchaseRepository, _context!);

  @visibleForTesting
  final TournamentPageRouter router;

  TournamentPageBloc({
    required RepositoryFactory repos,
    required this.router,
    required this.tournamentId,
    BuildContext? context,
  })  : _repos = repos,
        _context = context,
        super(const TournamentPageState()) {
    on<TournamentPagePlayerListOpenedEvent>(_onPlayerListOpened);
    on<TournamentPageEventAddPlayer>(_onAddPlayerTapped);
    on<TournamentPageEventDeletePlayer>(_onDeletePlayer);
    on<TournamentPageEventOpenProfileDialog>(_onOpenProfile);
    on<TournamentPageEventOpenSeatingPage>(_onOpenSeatingPage);
    on<TournamentPageEventPlayersListTapped>(_onPlayersListTapped);
    on<TournamentPageEventUpdateSettings>(_onUpdateSettings);
    on<TournamentPageEventBill>(_onBill);
    on<TournamentPageEventPageOpened>(_onPageOpened);
    on<TournamentPageEventOpenRating>(_openRating);
    on<TournamentPageEventSetFinalPlayers>(_onSetFinalPlayers);
    on<TournamentPageEventStartGameInfo>(_onStartGameInfo);
    on<TournamentPageEventCustomTextInfo>(_onCustomTextInfo);
    on<TournamentPageEventSetActivePhotoTheme>(_applyPhotoTheme);
    on<TournamentPageEventSubstitutePlayer>(_onSubstitutePlayer);
  }

  Future _onStartGameInfo(
    TournamentPageEventStartGameInfo event,
    Emitter emit,
  ) async {
    await _startGameInfoInteractor(
      tournamentId: tournamentId,
      game: event.game,
      time: event.time,
    );
    emitEffect(const TournamentPageEffect.showNotificationSentSuccess());
  }

  Future _onCustomTextInfo(
    TournamentPageEventCustomTextInfo event,
    Emitter emit,
  ) async {
    await _customTextInfoInteractor(
      tournamentId: tournamentId,
      text: event.text,
    );
    emitEffect(const TournamentPageEffect.showNotificationSentSuccess());
  }

  Future _updateFinalPlayers(Emitter emit) async {
    final finalPlayer = await _getFinalPlayersInteractor(
      tournamentId: tournamentId,
    );
    emit(state.copyWith(finalPlayers: finalPlayer));
  }

  Future<void> _onSetFinalPlayers(
    TournamentPageEventSetFinalPlayers event,
    Emitter emit,
  ) async {
    await _setFinalPlayersInteractor(
      players: event.players,
      tournamentId: tournamentId,
    );
    await _updateFinalPlayers(emit);
  }

  Future<void> _openRating(TournamentPageEventOpenRating event, Emitter emit) async {
    router.openRating(tournamentId: tournamentId);
  }

  Future<void> _onBill(TournamentPageEventBill event, Emitter emit) async {
    final result = await _billTournamentInteractor(
      tournamentId: tournamentId,
      playersCount: event.playersCount,
      billedTranslation: event.billedTranlsation,
    );
    final nextPath = router.getLocation();
    final uri = Uri.parse(result.redirectLink);
    if (kIsWeb) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } else {
      launchUrl(uri);
    }
    router.openPaymentWaiting(purchaseId: result.purchaseId, nextPath: nextPath);
  }

  Future<void> _onPageOpened(TournamentPageEventPageOpened event, Emitter emit) async {
    await Future.wait([
      _tournamentCheckInteractor(tournamentId: tournamentId).onError((error, _) => false).then(
            (value) => emit(
              state.copyWith(isMyTournament: value),
            ),
          ),
      Future(() async {
        final tournament = await _getTournamentInteractor(
          tournamentId: tournamentId,
        );

        emit(
          state.copyWith(
            billedPlayers: tournament.billedPlayers,
            billedTranslation: tournament.billedTranslation,
            notificationEnabled: tournament.notificationEnabled,
            gomafiaUrl: tournament.gomafiaUrl,
            activePhotoThemeId: tournament.photoThemeId,
          ),
        );
      }),
      _updateFinalPlayers(emit),
      _getSettingsInteractor
          .run(tournamentId: tournamentId)
          .then((settings) => emit(state.copyWith(settings: settings)))
          .onError((_, __) {}),
    ]);
  }

  void _onPlayersListTapped(
    TournamentPageEventPlayersListTapped event,
    Emitter emit,
  ) {
    router.openPlayersList(tournamentId: tournamentId);
  }

  void _onOpenSeatingPage(
    TournamentPageEventOpenSeatingPage event,
    Emitter emit,
  ) {
    router.openSeatingPage(tournamentId: tournamentId);
  }

  Future<void> _onOpenProfile(
    TournamentPageEventOpenProfileDialog event,
    Emitter emit,
  ) async {
    final hasChange = await router.showPlayerProfileDialog(player: event.player);
    if (hasChange) {
      emit(state.copyWith(isLoading: true));
      try {
        final players = await _getTournamentsPlayersInteractor.run(
          tournamentId: tournamentId,
        );
        emit(state.copyWith(isLoading: false, tournamentPlayers: players));
      } catch (e) {
        emit(state.copyWith(isLoading: false));
        rethrow;
      }
    }
  }

  Future<void> _onDeletePlayer(TournamentPageEventDeletePlayer event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _deletePlayerInteractor.run(
        tournamentId: tournamentId,
        playerModel: event.player,
      );
      final players = await _getTournamentsPlayersInteractor.run(
        tournamentId: tournamentId,
      );
      emit(
        state.copyWith(
          isLoading: false,
          tournamentPlayers: players,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }

  Future _onAddPlayerTapped(
    TournamentPageEventAddPlayer event,
    Emitter<TournamentPageState> emit,
  ) async {
    final player = await router.showAddPlayerDialog();
    if (player == null) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    try {
      await _addPlayerInteractor.run(
        tournamentId: tournamentId,
        playerModel: player,
      );
      await _updatePlayers(emit);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }

  Future _onUpdateSettings(
    TournamentPageEventUpdateSettings event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        settings: await _updateSettingsInteractor
            .run(
              tournamentId: tournamentId,
              model: event.settings,
            )
            .then(
              (_) => _getSettingsInteractor.run(
                tournamentId: tournamentId,
              ),
            )
            .then((settings) {
          emitEffect(const TournamentPageEffect.showUpdateSettingsSuccess());
          return settings;
        }),
      ),
    );
  }

  Future _onPlayerListOpened(
    TournamentPagePlayerListOpenedEvent event,
    Emitter<TournamentPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await Future.wait([
        _updatePlayers(emit),
        _getSettingsInteractor.run(tournamentId: tournamentId).then((settings) {
          emit(state.copyWith(settings: settings));
        }),
        _photoThemeRepository.getThemes().then((themes) {
          emit(state.copyWith(photoThemes: themes));
        }).onError((_, __) {}),
      ]);
      if (state.activePhotoThemeId != null) {
        await _loadThemePhotos(state.activePhotoThemeId!, emit);
      }
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }

  Future<void> _loadThemePhotos(int themeId, Emitter<TournamentPageState> emit) async {
    try {
      final players = await _photoThemeRepository.getThemePlayers(themeId);
      final photosMap = <int, String>{};
      for (final player in players) {
        if (player.themeImageUrl != null) {
          photosMap[player.playerId] = player.themeImageUrl!;
        }
      }
      emit(state.copyWith(activeThemePhotos: photosMap));
    } catch (_) {
      // Theme photos loading is optional
    }
  }

  Future _updatePlayers(Emitter<TournamentPageState> emit) async {
    final players = await _getTournamentsPlayersInteractor.run(tournamentId: tournamentId);
    emit(state.copyWith(tournamentPlayers: players));
  }

  Future _onSubstitutePlayer(
    TournamentPageEventSubstitutePlayer event,
    Emitter<TournamentPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final allGames = await _repos.tournamentEditRepository.getResultModels(
        tournamentId: tournamentId,
      );

      final playerGames =
          allGames.expand((round) => round).where((game) => game.nicknames.contains(event.oldPlayer.nickname)).toList();

      final gameNumbers = playerGames.map((g) => g.game).toSet().toList()..sort();

      final result = await router.openSubstituteDialog(
        oldPlayer: event.oldPlayer,
        gameNumbers: gameNumbers,
      );

      if (result != null) {
        await _repos.tournamentEditRepository.substitutePlayer(
          tournamentId: tournamentId,
          oldPlayerId: event.oldPlayer.id,
          newPlayerId: result.newPlayerId,
          games: result.games,
        );
        await _updatePlayers(emit);
      }
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }

  Future<void> _applyPhotoTheme(
    TournamentPageEventSetActivePhotoTheme event,
    Emitter<TournamentPageState> emit,
  ) async {
    final themeId = event.themeId;

    await _photoThemeRepository.setTournamentPhotoTheme(
      tournamentId,
      themeId,
    );

    if (themeId == null) {
      emit(
        state.copyWith(
          activePhotoThemeId: null,
          activeThemePhotos: {},
        ),
      );
      return;
    }

    emit(state.copyWith(activePhotoThemeId: themeId));
    await _loadThemePhotos(themeId, emit);
  }
}
