import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_event.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_router.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_state.dart';

class RatingBloc extends CustomBloc<RatingEvent, RatingState> {
  final ClubRepository _clubRepository = getIt();
  late final RatingRouter _router = getIt(param1: context);

  RatingBloc([BuildContext? context]) : super(const RatingState(), context) {
    on<RatingEventPageOpened>(_onPageOpened);
    on<RatingEventRangeChanged>(_onRangeChanged);
  }

  _onRangeChanged(RatingEventRangeChanged event, Emitter emit) {
    _router.changeRange(event.range, event.clubId);
  }

  _onPageOpened(RatingEventPageOpened event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    emit(
      state.copyWith(
        isLoading: false,
        rows: await _clubRepository.getRating(
          clubId: event.clubId,
          range: event.range,
        ),
      ),
    );
  }

  @override
  void emitOnError(Emitter<RatingState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}
