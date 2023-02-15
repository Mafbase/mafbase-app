import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/get_clubs_interactor.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_event.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_router.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_state.dart';

class ClubsBloc extends CustomBloc<ClubsEvent, ClubsState> {
  final GetClubsInteractor _getClubsInteractor;
  final ClubsRouter _router;

  ClubsBloc({
    BuildContext? context,
    required GetClubsInteractor getClubsInteractor,
    required ClubsRouter router,
  })  : _getClubsInteractor = getClubsInteractor,
        _router = router,
        super(const ClubsState(), context) {
    on<ClubsEventPageOpened>(_onPageOpened);
    on<ClubsEventClubSelected>(_onClubSelected);
  }

  _onClubSelected(ClubsEventClubSelected event, Emitter emit) {
    _router.openClubPage(
      id: event.clubModel.id,
      cachedModel: event.clubModel,
    );
  }

  _onPageOpened(ClubsEventPageOpened event, Emitter emit) async {
    final clubs = await _getClubsInteractor.run();
    emit(state.copyWith(clubs: clubs, isLoading: false));
  }

  @override
  void emitOnError(Emitter<ClubsState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}
