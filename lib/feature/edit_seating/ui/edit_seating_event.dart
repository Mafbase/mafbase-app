import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/edit_seating/domain/models/editable_table_model.dart';

part 'edit_seating_event.freezed.dart';

@freezed
abstract class EditSeatingPageEvent with _$EditSeatingPageEvent {
  const factory EditSeatingPageEvent.init({
    required int tournamentId,
    required List<List<EditableTableModel>> seating,
  }) = EditSeatingPageEventInit;

  const factory EditSeatingPageEvent.selectRound(int roundIndex) =
      EditSeatingPageEventSelectRound;

  const factory EditSeatingPageEvent.swapPlayers({
    required int sourceTable,
    required int sourceSlot,
    required int targetTable,
    required int targetSlot,
  }) = EditSeatingPageEventSwapPlayers;

  const factory EditSeatingPageEvent.save() = EditSeatingPageEventSave;
}
