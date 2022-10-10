import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_events.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_state.dart';

class TournamentsBloc extends CustomBloc<TournamentsEvent, TournamentsState> {
  final GetTournamentsInteractor _getTournamentsInteractor;

  TournamentsBloc(this._getTournamentsInteractor, [BuildContext? context])
      : super(
          const TournamentsState(tournaments: [], isLoading: true),
          context,
        ) {
    on<TournamentOpenedEvent>(_onOpened);
  }

  _onOpened(
    TournamentOpenedEvent event,
    Emitter<TournamentsState> emit,
  ) async {
    final tournaments = await _getTournamentsInteractor.run();
    emit(state.copyWith(tournaments: tournaments, isLoading: false));
  }

  @override
  void emitOnError(Emitter<TournamentsState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}
