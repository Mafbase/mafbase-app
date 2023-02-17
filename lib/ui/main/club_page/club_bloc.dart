import 'package:bloc/src/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/get_club_interactor.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/ui/main/club_page/club_event.dart';
import 'package:seating_generator_web/ui/main/club_page/club_router.dart';
import 'package:seating_generator_web/ui/main/club_page/club_state.dart';

class ClubBlocArgs {
  final int clubId;
  final ClubModel? cachedModel;

  ClubBlocArgs({
    required this.clubId,
    this.cachedModel,
  });
}

class ClubBloc extends CustomBloc<ClubEvent, ClubState> {
  final int _clubId;
  final GetClubInteractor _getClubInteractor;
  final ClubRouter router;

  ClubBloc({
    BuildContext? context,
    required this.router,
    required ClubBlocArgs args,
    required GetClubInteractor getClubInteractor,
  })  : _clubId = args.clubId,
        _getClubInteractor = getClubInteractor,
        super(
          args.cachedModel == null
              ? const ClubState()
              : ClubState(
                  isLoading: false,
                  model: args.cachedModel,
                ),
          context,
        ) {
    on<ClubEventPageOpened>(_onPageOpened);
    on<ClubEventOpenRating>(_onOpenRating);
  }

  _onOpenRating(ClubEventOpenRating event, Emitter emit) async {
    router.openRating(clubId: _clubId);
  }

  _onPageOpened(ClubEventPageOpened event, Emitter emit) async {
    final club = await _getClubInteractor.run(clubId: _clubId);
    emit(state.copyWith(isLoading: false, model: club));
  }

  @override
  void emitOnError(Emitter<ClubState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}
