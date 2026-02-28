import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/custom_columns/domain/models/custom_column_model.dart';

part 'custom_columns_editor_state.freezed.dart';

@freezed
class CustomColumnsEditorState with _$CustomColumnsEditorState {
  const factory CustomColumnsEditorState({
    @Default(true) bool isLoading,
    @Default([]) List<CustomColumnModel> columns,
    String? error,
  }) = _CustomColumnsEditorState;
}
