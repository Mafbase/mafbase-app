import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/referee_assignments/domain/referee_repository.dart';
import 'package:seating_generator_web/feature/referee_assignments/ui/referee_event.dart';
import 'package:seating_generator_web/feature/referee_assignments/ui/referee_state.dart';

class RefereeBloc extends Bloc<RefereeEvent, RefereeState> {
  final RefereeRepository _repository;
  late int _tournamentId;

  RefereeBloc(super.initialState, this._repository) {
    on<RefereeEventInit>(_init);
    on<RefereeEventSetReferee>(_setReferee);
    on<RefereeEventDeleteReferee>(_deleteReferee);
  }

  Future<void> _init(
    RefereeEventInit event,
    Emitter<RefereeState> emit,
  ) async {
    _tournamentId = event.tournamentId;
    final assignments = await _repository.getReferees(event.tournamentId);
    emit(state.copyWith(assignments: assignments, loading: false));
  }

  Future<void> _setReferee(
    RefereeEventSetReferee event,
    Emitter<RefereeState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      await _repository.setReferee(
        tournamentId: _tournamentId,
        table: event.table,
        referee: event.referee,
      );
      final assignments = await _repository.getReferees(_tournamentId);
      emit(state.copyWith(assignments: assignments, loading: false));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> _deleteReferee(
    RefereeEventDeleteReferee event,
    Emitter<RefereeState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      await _repository.deleteReferee(
        tournamentId: _tournamentId,
        table: event.table,
      );
      final assignments = await _repository.getReferees(_tournamentId);
      emit(state.copyWith(assignments: assignments, loading: false));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
