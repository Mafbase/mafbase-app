import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/insert_seating_interactor.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_event.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_router.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_state.dart';

class SeatingInsertingBloc
    extends Bloc<SeatingInsertingEvent, SeatingInsertingState> {
  final SeatingInsertingRouter _router;
  late final InsertSeatingInteractor _insertSeatingInteractor =
      InsertSeatingInteractor(_repos.translationRepository);
  final RepositoryFactory _repos;
  final int tournamentId;
  List<int> bytes = [];

  SeatingInsertingBloc({
    required SeatingInsertingRouter router,
    required RepositoryFactory repos,
    required this.tournamentId,
  })  : _router = router,
        _repos = repos,
        super(const SeatingInsertingState()) {
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

}
