import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/add_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/bill_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/custom_text_info_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_all_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_final_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_settings_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/set_final_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/start_game_info_interactor.dart';
import 'package:seating_generator_web/domain/interactors/tournament_check_interactor.dart';
import 'package:seating_generator_web/domain/interactors/update_settings_interactor.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/feature/photo_themes/domain/photo_theme_repository.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_effect.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_router.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_state.dart';
import 'package:url_launcher/url_launcher.dart';

class TournamentPageBloc
    extends Bloc<TournamentPageEvent, TournamentPageState>
    with EffectEmitter<TournamentPageEffect, TournamentPageState> {
  final int tournamentId;
  final BuildContext? _context;
  final GetAllPlayersInteractor _getAllPlayersInteractor = getIt();
  final GetTournamentsPlayersInteractor _getTournamentsPlayersInteractor =
      getIt();
  final PlayersRepository playerRepository = getIt();

  final AddTournamentPlayerInteractor _addPlayerInteractor = getIt();
  final DeletePlayerInteractor _deletePlayerInteractor = getIt();
  final GetSettingsInteractor _getSettingsInteractor = getIt();
  final UpdateSettingsInteractor _updateSettingsInteractor = getIt();
  final TournamentCheckInteractor _tournamentCheckInteractor = getIt();

  final GetTournamentInteractor _getTournamentInteractor = getIt();
  final GetFinalPlayersInteractor _getFinalPlayersInteractor = getIt();
  final SetFinalPlayersInteractor _setFinalPlayersInteractor = getIt();

  final CustomTextInfoInteractor _customTextInfoInteractor = getIt();
  final StartGameInfoInteractor _startGameInfoInteractor = getIt();
  final PhotoThemeRepository _photoThemeRepository = getIt();

  late final BillTournamentInteractor _billTournamentInteractor = getIt(
    param1: _context,
  );

  @visibleForTesting
  late final TournamentPageRouter router =
      getIt<TournamentPageRouter>(param1: _context);

  TournamentPageBloc({BuildContext? context, required this.tournamentId})
      : _context = context,
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
    on<TournamentPageEventSelectPhotoTheme>(_onSelectPhotoTheme);
    on<TournamentPageEventSetActivePhotoTheme>(_onSetActivePhotoTheme);
  }

  Future _onStartGameInfo(
    TournamentPageEventStartGameInfo event,
    Emitter emit,
  ) =>
      _startGameInfoInteractor(
        tournamentId: tournamentId,
        game: event.game,
        time: event.time,
      );

  Future _onCustomTextInfo(
    TournamentPageEventCustomTextInfo event,
    Emitter emit,
  ) =>
      _customTextInfoInteractor(
        tournamentId: tournamentId,
        text: event.text,
      );

  Future _updateFinalPlayers(Emitter emit) async {
    final finalPlayer = await _getFinalPlayersInteractor(
      tournamentId: tournamentId,
    );
    emit(state.copyWith(finalPlayers: finalPlayer));
  }

  _onSetFinalPlayers(
    TournamentPageEventSetFinalPlayers event,
    Emitter emit,
  ) async {
    await _setFinalPlayersInteractor(
      players: event.players,
      tournamentId: tournamentId,
    );
    await _updateFinalPlayers(emit);
  }

  _openRating(TournamentPageEventOpenRating event, Emitter emit) async {
    router.openRating(tournamentId: tournamentId);
  }

  _onBill(TournamentPageEventBill event, Emitter emit) async {
    final url = await _billTournamentInteractor(
      tournamentId: tournamentId,
      playersCount: event.playersCount,
      billedTranslation: event.billedTranlsation,
    );

    if (kIsWeb) {
      await launchUrl(
        Uri.parse(url),
        webOnlyWindowName: '_self',
      );
    } else {
      router.openWebView(url);
    }
  }

  _onPageOpened(TournamentPageEventPageOpened event, Emitter emit) async {
    await Future.wait([
      _tournamentCheckInteractor(tournamentId: tournamentId)
          .onError((error, _) => false)
          .then(
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
    ]);
  }

  _onPlayersListTapped(
    TournamentPageEventPlayersListTapped event,
    Emitter emit,
  ) {
    router.openPlayersList(tournamentId: tournamentId);
  }

  _onOpenSeatingPage(
    TournamentPageEventOpenSeatingPage event,
    Emitter emit,
  ) {
    router.openSeatingPage(tournamentId: tournamentId);
  }

  _onOpenProfile(
    TournamentPageEventOpenProfileDialog event,
    Emitter emit,
  ) async {
    final hasChange =
        await router.showPlayerProfileDialog(player: event.player);
    if (hasChange) {
      emit(state.copyWith(isLoading: true));
      final players = await _getTournamentsPlayersInteractor.run(
        tournamentId: tournamentId,
      );
      emit(state.copyWith(isLoading: false, tournamentPlayers: players));
    }
  }

  _onDeletePlayer(TournamentPageEventDeletePlayer event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
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
  }

  Future _onAddPlayerTapped(
    TournamentPageEventAddPlayer event,
    Emitter<TournamentPageState> emit,
  ) async {
    final player = await router.showAddPlayerDialog(
      availablePlayers: state.players
          .where((element) => !state.tournamentPlayers.contains(element))
          .toList(),
    );
    if (player == null) {
      return;
    }
    router.openPlayersList(tournamentId: tournamentId);
    emit(state.copyWith(isLoading: true));
    await _addPlayerInteractor.run(
      tournamentId: tournamentId,
      playerModel: player,
    );
    await _updatePlayers(emit);
    emit(state.copyWith(isLoading: false));
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
    await Future.wait([
      _updatePlayers(emit),
      _getSettingsInteractor.run(tournamentId: tournamentId).then((settings) {
        emit(state.copyWith(settings: settings));
      }),
    ]);
    emit(state.copyWith(isLoading: false));
  }

  Future _updatePlayers(Emitter<TournamentPageState> emit) {
    final first = _getAllPlayersInteractor.run().then((value) {
      emit(state.copyWith(players: value));
    });
    final second = _getTournamentsPlayersInteractor
        .run(tournamentId: tournamentId)
        .then((value) {
      emit(state.copyWith(tournamentPlayers: value));
    });
    return Future.wait([first, second]);
  }

  Future<void> _onSelectPhotoTheme(
    TournamentPageEventSelectPhotoTheme event,
    Emitter<TournamentPageState> emit,
  ) async {
    final themeId = event.themeId;
    if (themeId == null) {
      emit(state.copyWith(
        activePhotoThemeId: null,
        activeThemePhotos: {},
      ),);
      return;
    }
    try {
      final players = await _photoThemeRepository.getThemePlayers(themeId);
      final photosMap = <int, String>{};
      for (final player in players) {
        if (player.themeImageUrl != null) {
          photosMap[player.playerId] = player.themeImageUrl!;
        }
      }
      emit(state.copyWith(
        activePhotoThemeId: themeId,
        activeThemePhotos: photosMap,
      ),);
    } catch (_) {
      emit(state.copyWith(
        activePhotoThemeId: themeId,
        activeThemePhotos: {},
      ),);
    }
  }

  Future<void> _onSetActivePhotoTheme(
    TournamentPageEventSetActivePhotoTheme event,
    Emitter<TournamentPageState> emit,
  ) async {
    await _photoThemeRepository.setTournamentPhotoTheme(
      tournamentId,
      event.themeId,
    );
    emit(state.copyWith(activePhotoThemeId: event.themeId));
  }
}
