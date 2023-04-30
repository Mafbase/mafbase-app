import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/create_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_my_tournaments_interactor.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_events.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_router.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_state.dart';

class TournamentsBloc extends CustomBloc<TournamentsEvent, TournamentsState> {
  final GetMyTournamentsInteractor _getTournamentsInteractor;
  final CreateTournamentInteractor _createTournamentInteractor;
  @visibleForTesting
  final TournamentsRouter router;

  TournamentsBloc(
    this._getTournamentsInteractor,
    this._createTournamentInteractor, [
    BuildContext? context,
  ])  : router = getIt(param1: context),
        super(
          const TournamentsState(tournaments: [], isLoading: true),
          context,
        ) {
    on<TournamentOpenedEvent>(_onOpened);
    on<TournamentsEventCreate>(_onCreateNew);
  }

  _onCreateNew(TournamentsEventCreate event, Emitter emit) async {
    final data = await router.openCreateTournamentDialog();
    if (data != null) {
      emit(state.copyWith(isLoading: true));
      final id = await _createTournamentInteractor.run(
        name: data.name,
        range: data.range,
      );

      router.openTournament(id);
      emit(state.copyWith(isLoading: false));
    }
  }

  _onOpened(
    TournamentOpenedEvent event,
    Emitter<TournamentsState> emit,
  ) async {
    final tournaments = await _getTournamentsInteractor();
    emit(state.copyWith(tournaments: tournaments, isLoading: false));
  }

  @override
  void emitOnError(Emitter<TournamentsState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}
