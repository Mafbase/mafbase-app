import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_columns_editor_event.freezed.dart';

@freezed
sealed class CustomColumnsEditorEvent with _$CustomColumnsEditorEvent {
  const factory CustomColumnsEditorEvent.pageOpened() =
      CustomColumnsEditorEventPageOpened;

  const factory CustomColumnsEditorEvent.createColumn({
    required String title,
    required String formula,
  }) = CustomColumnsEditorEventCreateColumn;

  const factory CustomColumnsEditorEvent.updateColumn({
    required int columnId,
    required String title,
    required String formula,
  }) = CustomColumnsEditorEventUpdateColumn;

  const factory CustomColumnsEditorEvent.deleteColumn({
    required int columnId,
  }) = CustomColumnsEditorEventDeleteColumn;
}
