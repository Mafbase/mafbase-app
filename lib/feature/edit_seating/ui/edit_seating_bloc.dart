import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/edit_seating/domain/models/editable_table_model.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/edit_seating_effect.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/edit_seating_event.dart';
import 'package:seating_generator_web/feature/edit_seating/ui/edit_seating_state.dart';

class EditSeatingBloc extends Bloc<EditSeatingPageEvent, EditSeatingPageState>
    with EffectEmitter<EditSeatingPageEffect, EditSeatingPageState> {
  final RepositoryFactory _repos;

  EditSeatingBloc({required RepositoryFactory repos})
      : _repos = repos,
        super(const EditSeatingPageState()) {
    on<EditSeatingPageEventInit>(_onInit);
    on<EditSeatingPageEventSelectRound>(_onSelectRound);
    on<EditSeatingPageEventSwapPlayers>(_onSwapPlayers);
    on<EditSeatingPageEventSave>(_onSave);
  }

  late int _tournamentId;

  void _onInit(
    EditSeatingPageEventInit event,
    Emitter<EditSeatingPageState> emit,
  ) {
    _tournamentId = event.tournamentId;
    emit(state.copyWith(
      isLoading: false,
      originalSeating: event.seating,
      editedSeating: event.seating,
    ),);
  }

  void _onSelectRound(
    EditSeatingPageEventSelectRound event,
    Emitter<EditSeatingPageState> emit,
  ) {
    emit(state.copyWith(selectedRound: event.roundIndex));
  }

  void _onSwapPlayers(
    EditSeatingPageEventSwapPlayers event,
    Emitter<EditSeatingPageState> emit,
  ) {
    final round = state.selectedRound;
    final oldTables = state.editedSeating[round];

    final sourcePlayer = oldTables[event.sourceTable].players[event.sourceSlot];
    final targetPlayer = oldTables[event.targetTable].players[event.targetSlot];

    var newTables = [...oldTables];

    // Update source table
    final sourcePlayers = [...oldTables[event.sourceTable].players];
    sourcePlayers[event.sourceSlot] = targetPlayer;
    newTables[event.sourceTable] =
        oldTables[event.sourceTable].copyWith(players: sourcePlayers);

    // Update target table (re-read from newTables in case same table)
    final targetPlayers = [...newTables[event.targetTable].players];
    targetPlayers[event.targetSlot] = sourcePlayer;
    newTables[event.targetTable] =
        newTables[event.targetTable].copyWith(players: targetPlayers);

    final newSeating = [...state.editedSeating];
    newSeating[round] = newTables;

    emit(state.copyWith(editedSeating: newSeating));
  }

  Future<void> _onSave(
    EditSeatingPageEventSave event,
    Emitter<EditSeatingPageState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));
    try {
      final futures = <Future<void>>[];

      for (int round = 0; round < state.editedSeating.length; round++) {
        for (int t = 0; t < state.editedSeating[round].length; t++) {
          final edited = state.editedSeating[round][t];
          final original = state.originalSeating[round][t];

          if (_isTableChanged(original, edited)) {
            futures.add(
              _repos.tournamentEditRepository.editSeating(
                tournamentId: _tournamentId,
                game: edited.game,
                table: edited.table,
                playerIds: edited.players.map((p) => p.playerId).toList(),
                refereeId: edited.refereeId,
              ),
            );
          }
        }
      }

      await Future.wait(futures);
      emit(state.copyWith(originalSeating: state.editedSeating));
      emitEffect(const EditSeatingPageEffect.saveSuccess());
    } finally {
      emit(state.copyWith(isSaving: false));
    }
  }

  bool _isTableChanged(
    EditableTableModel original,
    EditableTableModel edited,
  ) {
    for (int i = 0; i < original.players.length; i++) {
      if (original.players[i].playerId != edited.players[i].playerId) {
        return true;
      }
    }
    return false;
  }
}
