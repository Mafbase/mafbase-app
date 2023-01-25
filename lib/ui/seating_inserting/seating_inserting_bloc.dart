import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/insert_seating_interactor.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_event.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_router.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_state.dart';

class SeatingInsertingBloc
    extends CustomBloc<SeatingInsertingEvent, SeatingInsertingState> {
  final SeatingInsertingRouter _router;
  final InsertSeatingInteractor _insertSeatingInteractor = getIt();
  final int tournamentId;
  List<int> bytes = [];

  SeatingInsertingBloc(this._router, this.tournamentId, [BuildContext? context])
      : super(const SeatingInsertingState(), context) {
    on<SeatingInsertingSaveEvent>(_onSaveEvent);
    on<SeatingInsertingFileSelectedEvent>(_onFileSelected);
  }

  Future _onFileSelected(
    SeatingInsertingFileSelectedEvent event,
    Emitter<SeatingInsertingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    bytes = await event.bytesStream
        .fold(<int>[], (previous, element) => previous..addAll(element));
    emit(state.copyWith(isLoading: false));
  }

  Future _onSaveEvent(
    SeatingInsertingSaveEvent event,
    Emitter<SeatingInsertingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await _insertSeatingInteractor.run(
      bytes,
      tournamentId,
    );
    _router.showSuccessDialog();
  }

  @override
  void emitOnError(Emitter<SeatingInsertingState> emit) {
    _router.showErrorDialog();
    emit(state.copyWith(isLoading: false));
  }
}
