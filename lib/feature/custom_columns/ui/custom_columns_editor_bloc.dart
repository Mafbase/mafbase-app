import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/custom_columns/domain/repository/custom_columns_repository.dart';
import 'package:seating_generator_web/feature/custom_columns/ui/custom_columns_editor_event.dart';
import 'package:seating_generator_web/feature/custom_columns/ui/custom_columns_editor_state.dart';

class CustomColumnsEditorBloc extends Bloc<CustomColumnsEditorEvent, CustomColumnsEditorState> {
  final CustomColumnsRepository _repository;
  final int _clubId;

  CustomColumnsEditorBloc(this._repository, this._clubId) : super(const CustomColumnsEditorState()) {
    on<CustomColumnsEditorEventPageOpened>(_onPageOpened);
    on<CustomColumnsEditorEventCreateColumn>(_onCreateColumn);
    on<CustomColumnsEditorEventUpdateColumn>(_onUpdateColumn);
    on<CustomColumnsEditorEventDeleteColumn>(_onDeleteColumn);
  }

  Future<void> _onPageOpened(
    CustomColumnsEditorEventPageOpened event,
    Emitter<CustomColumnsEditorState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final columns = await _repository.getColumns(clubId: _clubId);
      emit(state.copyWith(isLoading: false, columns: columns));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onCreateColumn(
    CustomColumnsEditorEventCreateColumn event,
    Emitter<CustomColumnsEditorState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.createColumn(
        clubId: _clubId,
        title: event.title,
        formula: event.formula,
      );
      final columns = await _repository.getColumns(clubId: _clubId);
      emit(state.copyWith(isLoading: false, columns: columns));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onUpdateColumn(
    CustomColumnsEditorEventUpdateColumn event,
    Emitter<CustomColumnsEditorState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.updateColumn(
        clubId: _clubId,
        columnId: event.columnId,
        title: event.title,
        formula: event.formula,
      );
      final columns = await _repository.getColumns(clubId: _clubId);
      emit(state.copyWith(isLoading: false, columns: columns));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onDeleteColumn(
    CustomColumnsEditorEventDeleteColumn event,
    Emitter<CustomColumnsEditorState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _repository.deleteColumn(
        clubId: _clubId,
        columnId: event.columnId,
      );
      final columns = await _repository.getColumns(clubId: _clubId);
      emit(state.copyWith(isLoading: false, columns: columns));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
