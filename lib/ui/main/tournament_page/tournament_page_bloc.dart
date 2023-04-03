import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/add_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/bill_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_all_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_settings_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/update_settings_interactor.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_effect.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_router.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_state.dart';
import 'package:url_launcher/url_launcher.dart';

class TournamentPageBloc
    extends CustomBloc<TournamentPageEvent, TournamentPageState>
    with EffectEmitter<TournamentPageEffect, TournamentPageState> {
  final int tournamentId;
  final GetAllPlayersInteractor _getAllPlayersInteractor = getIt();
  final GetTournamentsPlayersInteractor _getTournamentsPlayersInteractor =
      getIt();
  final PlayersRepository playerRepository = getIt();

  final AddTournamentPlayerInteractor _addPlayerInteractor = getIt();
  final DeletePlayerInteractor _deletePlayerInteractor = getIt();
  final GetSettingsInteractor _getSettingsInteractor = getIt();
  final UpdateSettingsInteractor _updateSettingsInteractor = getIt();
  final GetTournamentInteractor _getTournamentInteractor = getIt();
  late final BillTournamentInteractor _billTournamentInteractor = getIt(
    param1: context,
  );

  @visibleForTesting
  late final TournamentPageRouter router =
      getIt<TournamentPageRouter>(param1: context);

  TournamentPageBloc({BuildContext? context, required this.tournamentId})
      : super(const TournamentPageState(), context) {
    on<TournamentPagePlayerListOpenedEvent>(_onPlayerListOpened);
    on<TournamentPageEventAddPlayer>(_onAddPlayerTapped);
    on<TournamentPageEventDeletePlayer>(_onDeletePlayer);
    on<TournamentPageEventOpenProfileDialog>(_onOpenProfile);
    on<TournamentPageEventOpenSeatingPage>(_onOpenSeatingPage);
    on<TournamentPageEventPlayersListTapped>(_onPlayersListTapped);
    on<TournamentPageEventUpdateSettings>(_onUpdateSettings);
    on<TournamentPageEventBill>(_onBill);
    on<TournamentPageEventPageOpened>(_onPageOpened);
  }

  _onBill(TournamentPageEventBill event, Emitter emit) async {
    await launchUrl(
      Uri.parse(
        await _billTournamentInteractor(
          tournamentId: tournamentId,
          playersCount: event.playersCount,
          billedTranslation: event.billedTranlsation,
        ),
      ),
    );
  }

  _onPageOpened(TournamentPageEventPageOpened event, Emitter emit) async {
    final tournament = await _getTournamentInteractor(
      tournamentId: tournamentId,
    );

    emit(
      state.copyWith(
        billedPlayers: tournament.billedPlayers,
        billedTranslation: tournament.billedTranslation,
      ),
    );
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
      })
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

  @override
  void emitOnError(Emitter<TournamentPageState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}
