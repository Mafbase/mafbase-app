import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/bill_club_interactor.dart';
import 'package:seating_generator_web/domain/interactors/check_club_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_club_interactor.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/ui/main/club_page/club_event.dart';
import 'package:seating_generator_web/ui/main/club_page/club_router.dart';
import 'package:seating_generator_web/ui/main/club_page/club_state.dart';
import 'package:url_launcher/url_launcher.dart';

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
  @visibleForTesting
  final ClubRouter router;
  final CheckClubInteractor _checkClubInteractor;
  final BillClubInteractor _billClubInteractor;

  ClubBloc({
    BuildContext? context,
    required this.router,
    required ClubBlocArgs args,
    required GetClubInteractor getClubInteractor,
    required BillClubInteractor billClubInteractor,
    required CheckClubInteractor checkClubInteractor,
  })  : _clubId = args.clubId,
        _checkClubInteractor = checkClubInteractor,
        _billClubInteractor = billClubInteractor,
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
    on<ClubEventBillClub>(_onBillClub);
  }

  _onOpenRating(ClubEventOpenRating event, Emitter emit) async {
    router.openRating(clubId: _clubId);
  }

  _onPageOpened(ClubEventPageOpened event, Emitter emit) async {
    final list = await Future.wait([
      _getClubInteractor.run(clubId: _clubId),
      _checkClubInteractor(_clubId),
    ]);
    final club = list[0] as ClubModel;
    final isOwner = list[1] as bool;
    emit(
      state.copyWith(
        isLoading: false,
        model: club,
        isOwner: isOwner,
      ),
    );
  }

  _onBillClub(ClubEventBillClub event, Emitter emit) async {
    launchUrl(
      await _billClubInteractor(
        clubId: _clubId,
        redirectPath: router.getLocation(),
        days: event.days,
      ).then((str) => Uri.parse(str)),
      webOnlyWindowName: '_self',
    );
  }

  @override
  void emitOnError(Emitter<ClubState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}
