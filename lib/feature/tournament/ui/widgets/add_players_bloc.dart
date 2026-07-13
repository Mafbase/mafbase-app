import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_players_effect.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_players_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_players_state.dart';

class AddPlayersBloc extends Bloc<AddPlayersEvent, AddPlayersState>
    with EffectEmitter<AddPlayersEffect, AddPlayersState> {
  final PlayersRepository _playersRepository;
  final int _tournamentId;
  final List<PlayerModel> _existingPlayers;

  AddPlayersBloc({
    required PlayersRepository playersRepository,
    required int tournamentId,
    required List<PlayerModel> existingPlayers,
  })  : _playersRepository = playersRepository,
        _tournamentId = tournamentId,
        _existingPlayers = List.unmodifiable(existingPlayers),
        super(const AddPlayersState()) {
    on<AddPlayersEventPlayerAdded>(_onPlayerAdded);
    on<AddPlayersEventPlayerUpdated>(_onPlayerUpdated);
    on<AddPlayersEventPlayerRemoved>(_onPlayerRemoved);
    on<AddPlayersEventSubmitted>(_onSubmitted);
  }

  /// Множество id, которые уже присутствуют в турнире или в staged-списке.
  /// Передаётся в [PlayerAutoComplete.excludeIds], чтобы suggest не предлагал
  /// уже добавленных игроков.
  Set<int> get excludedIds => {
        ..._existingPlayers.map((p) => p.id),
        ...state.staged.where((p) => p.id != PlayerModel.undefinedId).map((p) => p.id),
      };

  bool _isDuplicate(PlayerModel player) {
    if (player.id == PlayerModel.undefinedId) {
      bool sameNick(PlayerModel other) => other.nickname.toLowerCase() == player.nickname.toLowerCase();
      return state.staged.any(sameNick) || _existingPlayers.any(sameNick);
    }
    return state.staged.any((p) => p.id == player.id) || _existingPlayers.any((p) => p.id == player.id);
  }

  void _onPlayerAdded(AddPlayersEventPlayerAdded event, Emitter<AddPlayersState> emit) {
    if (_isDuplicate(event.player)) {
      emitEffect(const AddPlayersEffect.showDuplicateWarning());
      return;
    }
    emit(state.copyWith(staged: [...state.staged, event.player]));
  }

  void _onPlayerUpdated(AddPlayersEventPlayerUpdated event, Emitter<AddPlayersState> emit) {
    final updated = [...state.staged];
    updated[event.index] = event.player;
    emit(state.copyWith(staged: updated));
  }

  void _onPlayerRemoved(AddPlayersEventPlayerRemoved event, Emitter<AddPlayersState> emit) {
    final updated = [...state.staged];
    updated.removeAt(event.index);
    emit(state.copyWith(staged: updated));
  }

  Future<void> _onSubmitted(AddPlayersEventSubmitted event, Emitter<AddPlayersState> emit) async {
    if (state.staged.isEmpty || state.isSubmitting) return;

    emit(state.copyWith(isSubmitting: true));
    try {
      // Снимок staged: обновляется по мере создания новых игроков, чтобы retry
      // не вызвал createPlayer повторно для уже созданных.
      final staged = [...state.staged];
      final resolvedPlayers = <PlayerModel>[];

      for (int i = 0; i < staged.length; i++) {
        final player = staged[i];
        if (player.id == PlayerModel.undefinedId) {
          final newId = await _playersRepository.createPlayer(player);
          final resolved = player.copyWith(id: newId);
          staged[i] = resolved;
          emit(state.copyWith(isSubmitting: true, staged: [...staged]));
          resolvedPlayers.add(resolved);
        } else {
          resolvedPlayers.add(player);
        }
      }

      final addedCount = await _playersRepository.addPlayers(_tournamentId, resolvedPlayers);
      emitEffect(AddPlayersEffect.submitCompleted(addedAny: addedCount > 0));
    } finally {
      emit(state.copyWith(isSubmitting: false));
    }
  }
}
