import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete_event.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete_state.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';

class PlayerAutoCompleteBloc extends Bloc<PlayerAutoCompleteEvent, PlayerAutoCompleteState> {
  final PlayersRepository? _repository;
  final List<PlayerModel>? _availablePlayers;
  int _searchGeneration = 0;

  PlayerAutoCompleteBloc(this._repository, {List<PlayerModel>? availablePlayers})
      : _availablePlayers = availablePlayers,
        super(const PlayerAutoCompleteState()) {
    on<PlayerAutoCompleteEventSearch>(
      _onSearch,
      transformer: restartable(),
    );
    on<PlayerAutoCompleteEventClear>(_onClear);
  }

  Future<void> _onSearch(
    PlayerAutoCompleteEventSearch event,
    Emitter<PlayerAutoCompleteState> emit,
  ) async {
    final generation = ++_searchGeneration;
    if (event.query.isEmpty) {
      emit(const PlayerAutoCompleteState(query: ''));
      return;
    }

    if (_availablePlayers != null) {
      final lowerQuery = event.query.toLowerCase();
      final results = _availablePlayers!.where((p) => p.nickname.toLowerCase().contains(lowerQuery)).toList();
      emit(state.copyWith(results: results, query: event.query));
      return;
    }

    emit(const PlayerAutoCompleteState(isLoading: true));
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (emit.isDone || generation != _searchGeneration) return;

    try {
      final results = await _repository!.searchPlayers(event.query, limit: 5);
      if (emit.isDone || generation != _searchGeneration) return;
      emit(state.copyWith(results: results, query: event.query, isLoading: false));
    } catch (_) {
      if (emit.isDone || generation != _searchGeneration) return;
      // A failed search must not validate the nickname for player creation.
      emit(const PlayerAutoCompleteState());
    }
  }

  void _onClear(
    PlayerAutoCompleteEventClear event,
    Emitter<PlayerAutoCompleteState> emit,
  ) {
    _searchGeneration++;
    emit(const PlayerAutoCompleteState());
  }
}
