import 'package:bloc_event_transformers/bloc_event_transformers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete_event.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete_state.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';

class PlayerAutoCompleteBloc extends Bloc<PlayerAutoCompleteEvent, PlayerAutoCompleteState> {
  final PlayersRepository? _repository;
  final List<PlayerModel>? _availablePlayers;

  PlayerAutoCompleteBloc(this._repository, {List<PlayerModel>? availablePlayers})
      : _availablePlayers = availablePlayers,
        super(const PlayerAutoCompleteState()) {
    on<PlayerAutoCompleteEventSearch>(
      _onSearch,
      transformer: availablePlayers != null ? null : debounce(Duration(milliseconds: 300)),
    );
    on<PlayerAutoCompleteEventClear>(_onClear);
  }

  Future<void> _onSearch(
    PlayerAutoCompleteEventSearch event,
    Emitter<PlayerAutoCompleteState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(results: []));
      return;
    }

    if (_availablePlayers != null) {
      final lowerQuery = event.query.toLowerCase();
      final results = _availablePlayers!.where((p) => p.nickname.toLowerCase().contains(lowerQuery)).toList();
      emit(state.copyWith(results: results, query: event.query));
      return;
    }

    final results = await _repository!.searchPlayers(event.query, limit: 5);
    emit(state.copyWith(results: results, query: event.query));
  }

  void _onClear(
    PlayerAutoCompleteEventClear event,
    Emitter<PlayerAutoCompleteState> emit,
  ) {
    emit(const PlayerAutoCompleteState());
  }
}
