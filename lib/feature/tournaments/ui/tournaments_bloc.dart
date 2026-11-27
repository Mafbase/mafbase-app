import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/tournaments/domain/interactors/create_tournament_interactor.dart';
import 'package:seating_generator_web/feature/tournaments/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/feature/tournaments/ui/tournaments_events.dart';
import 'package:seating_generator_web/feature/tournaments/ui/tournaments_router.dart';
import 'package:seating_generator_web/feature/tournaments/ui/tournaments_state.dart';

class TournamentsBloc extends Bloc<TournamentsEvent, TournamentsState> {
  static const _limit = 20;

  final GetTournamentsInteractor _getTournamentsInteractor;
  final CreateTournamentInteractor _createTournamentInteractor;
  @visibleForTesting
  final TournamentsRouter router;
  late final StreamSubscription<int> _deletedTournamentsSubscription;

  TournamentsBloc(
    this._getTournamentsInteractor,
    this._createTournamentInteractor,
    this.router,
    Stream<int> deletedTournamentIds,
  ) : super(
          const TournamentsState(tournaments: [], isLoading: true),
        ) {
    on<TournamentOpenedEvent>(_onOpened);
    on<TournamentsEventCreate>(_onCreateNew);
    on<TournamentsEventLoadMore>(_onLoadMore);
    on<TournamentsEventSearch>(
      _onSearch,
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
    on<TournamentsEventTournamentDeleted>(_onTournamentDeleted);
    _deletedTournamentsSubscription = deletedTournamentIds.listen(
      (id) => add(TournamentsEvent.tournamentDeleted(id)),
    );
  }

  @override
  Future<void> close() async {
    await _deletedTournamentsSubscription.cancel();
    return super.close();
  }

  void _onTournamentDeleted(TournamentsEventTournamentDeleted event, Emitter<TournamentsState> emit) {
    emit(
      state.copyWith(
        tournaments: state.tournaments.where((tournament) => tournament.id != event.tournamentId).toList(),
      ),
    );
  }

  Future<void> _onCreateNew(TournamentsEventCreate event, Emitter emit) async {
    final data = await router.openCreateTournamentDialog();
    if (data != null) {
      emit(state.copyWith(isLoading: true));
      try {
        final id = await _createTournamentInteractor.run(
          name: data.name,
          range: data.range,
        );

        router.openTournament(id, setup: true);
        emit(state.copyWith(isLoading: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false));
        rethrow;
      }
    }
  }

  Future<void> _onOpened(
    TournamentOpenedEvent event,
    Emitter<TournamentsState> emit,
  ) async {
    try {
      final tournaments = await _getTournamentsInteractor(
        limit: _limit,
        offset: 0,
        search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
      );
      emit(
        state.copyWith(
          tournaments: tournaments,
          isLoading: false,
          hasMore: tournaments.length >= _limit,
        ),
      );
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _onLoadMore(
    TournamentsEventLoadMore event,
    Emitter<TournamentsState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));
    try {
      final newTournaments = await _getTournamentsInteractor(
        limit: _limit,
        offset: state.tournaments.length,
        search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
      );

      emit(
        state.copyWith(
          tournaments: [...state.tournaments, ...newTournaments],
          isLoadingMore: false,
          hasMore: newTournaments.length >= _limit,
        ),
      );
    } finally {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _onSearch(
    TournamentsEventSearch event,
    Emitter<TournamentsState> emit,
  ) async {
    final query = event.query.trim();
    emit(
      state.copyWith(
        searchQuery: query,
      ),
    );

    final tournaments = await _getTournamentsInteractor(
      limit: _limit,
      offset: 0,
      search: query.isNotEmpty ? query : null,
    );

    emit(
      state.copyWith(
        tournaments: tournaments,
        isLoading: false,
        hasMore: tournaments.length >= _limit,
      ),
    );
  }
}
