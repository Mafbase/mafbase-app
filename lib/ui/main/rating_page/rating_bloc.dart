import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/download_rating_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_rating_interactor.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_event.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_router.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_state.dart';

class RatingBloc extends CustomBloc<RatingEvent, RatingState> {
  final DownloadRatingInteractor _downloadRatingInteractor = getIt();
  final GetRatingInteractor _getRatingRepository = getIt();
  late final RatingRouter _router = getIt(param1: context);

  RatingBloc([BuildContext? context]) : super(const RatingState(), context) {
    on<RatingEventPageOpened>(_onPageOpened);
    on<RatingEventRangeChanged>(_onRangeChanged);
    on<RatingEventGameSelected>(_onGameSelected);
    on<RatingEventDownload>(_onDownloadRatingClicked);
  }

  _onGameSelected(RatingEventGameSelected event, Emitter emit) {
    _router.openGame(event.clubId, event.gameId);
  }

  _onDownloadRatingClicked(
    RatingEventDownload event,
    Emitter emit,
  ) async {
    await _downloadRatingInteractor.run(
      clubId: event.clubId,
      range: event.range,
    );
  }

  _onRangeChanged(RatingEventRangeChanged event, Emitter emit) {
    _router.changeRange(event.range, event.clubId);
  }

  _onPageOpened(RatingEventPageOpened event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    final rating = await _getRatingRepository.run(
      clubId: event.clubId,
      range: event.range,
    );
    emit(
      state.copyWith(
        isLoading: false,
        rows: rating.rows,
        clubName: rating.clubName,
      ),
    );
  }

  @override
  void emitOnError(Emitter<RatingState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}
