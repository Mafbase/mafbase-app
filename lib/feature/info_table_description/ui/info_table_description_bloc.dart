import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/info_table_description/domain/info_table_description_repository.dart';
import 'package:seating_generator_web/feature/info_table_description/ui/info_table_description_event.dart';
import 'package:seating_generator_web/feature/info_table_description/ui/info_table_description_state.dart';

class InfoTableDescriptionBloc extends Bloc<InfoTableDescriptionEvent, InfoTableState> {
  final InfoTableDescriptionRepository _repository;
  late String _tournamentId;

  InfoTableDescriptionBloc(super.initialState, this._repository) {
    on<InfoTableDescriptionEventInit>(_init);
    on<InfoTableDescriptionEventAdd>(_add);
    on<InfoTableDescriptionEventAddWithDescription>(_addWithDescription);
    on<InfoTableDescriptionEventDelete>(_delete);
    on<InfoTableDescriptionEventChange>(_change);
    on<InfoTableDescriptionEventSave>(_save);
  }

  Future<void> _init(
    InfoTableDescriptionEventInit event,
    Emitter<InfoTableState> emit,
  ) async {
    _tournamentId = event.tournamentId;
    final descriptions = await _repository.getDescriptions(event.tournamentId);

    emit(state.copyWith(tableDescriptions: descriptions, loading: false));
  }

  Future<void> _add(
    InfoTableDescriptionEventAdd event,
    Emitter<InfoTableState> emit,
  ) async {
    final descriptions = List<MapEntry<int, String>>.from(state.tableDescriptions);
    if (!descriptions.any((e) => e.key == event.table)) {
      descriptions.add(MapEntry(event.table, ''));
    }
    emit(state.copyWith(tableDescriptions: descriptions));
  }

  Future<void> _addWithDescription(
    InfoTableDescriptionEventAddWithDescription event,
    Emitter<InfoTableState> emit,
  ) async {
    final descriptions = List<MapEntry<int, String>>.from(state.tableDescriptions);
    if (!descriptions.any((e) => e.key == event.table)) {
      descriptions.add(MapEntry(event.table, event.description));
    }
    emit(state.copyWith(tableDescriptions: descriptions));
  }

  Future<void> _delete(
    InfoTableDescriptionEventDelete event,
    Emitter<InfoTableState> emit,
  ) async {
    final descriptions = state.tableDescriptions.where((entry) => entry.key != event.table).toList();
    emit(state.copyWith(tableDescriptions: descriptions));
  }

  Future<void> _change(
    InfoTableDescriptionEventChange event,
    Emitter<InfoTableState> emit,
  ) async {
    final descriptions = state.tableDescriptions.map((entry) {
      if (entry.key == event.table) {
        return MapEntry(entry.key, event.description);
      }
      return entry;
    }).toList();
    emit(state.copyWith(tableDescriptions: descriptions));
  }

  Future<void> _save(
    InfoTableDescriptionEventSave event,
    Emitter<InfoTableState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      await _repository.setDescriptions(
        tournamentId: _tournamentId,
        description: state.tableDescriptions,
      );
      emit(state.copyWith(loading: false));
      event.completer.complete();
    } catch (e) {
      event.completer.completeError(e);
      rethrow;
    }
  }
}
