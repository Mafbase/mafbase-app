import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/data/requests/get_tournaments_players_request.dart';
import 'package:seating_generator_web/domain/interactors/add_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/delete_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_all_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_players_interactor.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_router.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_state.dart';

class TournamentPageBloc
    extends CustomBloc<TournamentPageEvent, TournamentPageState> {
  final int tournamentId;
  final GetAllPlayersInteractor _getAllPlayersInteractor = getIt();
  final GetTournamentsPlayersInteractor _getTournamentsPlayersInteractor =
      getIt();
  final PlayersRepository playerRepository = getIt();

  final AddTournamentPlayerInteractor _addPlayerInteractor = getIt();
  final DeletePlayerInteractor _deletePlayerInteractor = getIt();

  @visibleForTesting
  late final TournamentPageRouter router =
      getIt<TournamentPageRouter>(param1: context);

  TournamentPageBloc({required this.tournamentId, BuildContext? context})
      : super(const TournamentPageState(), context) {
    on<TournamentPagePlayerListOpenedEvent>(_onPlayerListOpened);
    on<TournamentPageEventAddPlayer>(_onAddPlayerTapped);
    on<TournamentPageEventAddPhoto>(_onAddPhoto);
    on<TournamentPageEventDeletePlayer>(_onDeletePlayer);
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

  _onAddPhoto(
    TournamentPageEventAddPhoto event,
    Emitter emit,
  ) {
    return playerRepository.addPhoto(
      event.playerId,
      event.bytes,
      event.filename,
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
    emit(state.copyWith(isLoading: true));
    await _addPlayerInteractor.run(
      tournamentId: tournamentId,
      playerModel: player,
    );
    await _updatePlayers(emit);
    emit(state.copyWith(isLoading: false));
  }

  Future _onPlayerListOpened(
    TournamentPagePlayerListOpenedEvent event,
    Emitter<TournamentPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _updatePlayers(emit);
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
