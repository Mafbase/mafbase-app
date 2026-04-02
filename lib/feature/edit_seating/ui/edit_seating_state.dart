import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/edit_seating/domain/models/editable_table_model.dart';

part 'edit_seating_state.freezed.dart';

@freezed
abstract class EditSeatingPageState with _$EditSeatingPageState {
  const factory EditSeatingPageState({
    @Default(true) bool isLoading,
    @Default(false) bool isSaving,
    @Default(0) int selectedRound,
    @Default([]) List<List<EditableTableModel>> originalSeating,
    @Default([]) List<List<EditableTableModel>> editedSeating,
  }) = _EditSeatingPageState;
}
