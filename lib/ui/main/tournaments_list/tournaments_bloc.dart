import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_events.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_state.dart';

class TournamentsBloc extends Bloc<TournamentsEvent, TournamentsState> {
  final GetTournamentsInteractor _getTournamentsInteractor;
  TournamentsBloc(this._getTournamentsInteractor)
      : super(
          const TournamentsState(tournaments: [], isLoading: true),
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
}
