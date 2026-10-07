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
    final query = event.query.trim();
    List<PlayerModel> results = [];
    try {
      if (query.isEmpty) {
        emit(const PlayerAutoCompleteState(query: ''));
        return;
      }

      if (_availablePlayers != null) {
        final lowerQuery = query.toLowerCase();
        results = _availablePlayers!.where((p) => p.nickname.toLowerCase().contains(lowerQuery)).toList();
        emit(state.copyWith(results: results, query: query));
        return;
      }

      emit(const PlayerAutoCompleteState(isLoading: true));
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (emit.isDone || generation != _searchGeneration) return;

      final searchResults = await _repository!.searchPlayers(query, limit: 5);
      if (emit.isDone || generation != _searchGeneration) return;
      results = searchResults;
      emit(state.copyWith(results: results, query: query, isLoading: false));
    } catch (_) {
      if (emit.isDone || generation != _searchGeneration) return;
      // A failed search must not validate the nickname for player creation.
      emit(const PlayerAutoCompleteState());
    } finally {
      final completer = event.completer;
      if (completer != null && !completer.isCompleted) {
        completer.complete(results);
      }
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
