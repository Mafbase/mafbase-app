import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/domain/interactors/insert_seating_interactor.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_event.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_router.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_state.dart';

class SeatingInsertingBloc
    extends Bloc<SeatingInsertingEvent, SeatingInsertingState> {
  final SeatingInsertingRouter _router;
  final InsertSeatingInteractor _insertSeatingInteractor;
  List<int> bytes = [];

  SeatingInsertingBloc(
    this._router,
    this._insertSeatingInteractor,
  ) : super(const SeatingInsertingState()) {
    on<SeatingInsertingSaveEvent>(_onSaveEvent);
    on<SeatingInsertingFileSelectedEvent>(_onFileSelected);
  }

  Future _onFileSelected(
    SeatingInsertingFileSelectedEvent event,
    Emitter<SeatingInsertingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      bytes = await event.bytesStream
          .fold(<int>[], (previous, element) => previous..addAll(element));
      debugPrint(bytes.join(", "));
    } catch (e) {
      _router.showErrorDialog();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future _onSaveEvent(
    SeatingInsertingSaveEvent event,
    Emitter<SeatingInsertingState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await _insertSeatingInteractor.run(
        bytes,
        event.tournamentId,
      );
      _router.showSuccessDialog();
    } catch (error, stacktrace) {
      debugPrint(error.toString() + stacktrace.toString());
      _router.showErrorDialog();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
