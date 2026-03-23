import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/bill_club_interactor.dart';
import 'package:seating_generator_web/domain/interactors/check_club_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_club_interactor.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/domain/repositories/club_repository.dart';
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

class ClubBloc extends Bloc<ClubEvent, ClubState> {
  final int _clubId;
  final GetClubInteractor _getClubInteractor;
  @visibleForTesting
  final ClubRouter router;
  final CheckClubInteractor _checkClubInteractor;
  final BillClubInteractor _billClubInteractor;
  final ClubRepository _clubRepository;

  ClubBloc({
    BuildContext? context,
    required this.router,
    required ClubBlocArgs args,
    required GetClubInteractor getClubInteractor,
    required BillClubInteractor billClubInteractor,
    required CheckClubInteractor checkClubInteractor,
    required ClubRepository clubRepository,
  })  : _clubId = args.clubId,
        _checkClubInteractor = checkClubInteractor,
        _billClubInteractor = billClubInteractor,
        _getClubInteractor = getClubInteractor,
        _clubRepository = clubRepository,
        super(
          args.cachedModel == null
              ? const ClubState()
              : ClubState(
                  isLoading: false,
                  model: args.cachedModel,
                ),
        ) {
    on<ClubEventPageOpened>(_onPageOpened);
    on<ClubEventOpenRating>(_onOpenRating);
    on<ClubEventBillClub>(_onBillClub);
    on<ClubEventChangeHideDate>(_onChangeHideDate);
    on<ClubEventEditDescription>(_onEditDescription);
    on<ClubEventEditPhoto>(_onEditPhoto);
  }

  _onChangeHideDate(ClubEventChangeHideDate event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    await _clubRepository.updateHideDate(
      id: _clubId,
      dateTime: event.dateTime,
    );
    add(const ClubEvent.pageOpened());
  }

  _onOpenRating(ClubEventOpenRating event, Emitter emit) async {
    router.openRating(clubId: _clubId);
  }

  _onPageOpened(ClubEventPageOpened event, Emitter emit) async {
    final [
      ClubModel club,
      bool isOwner,
    ] = await Future.wait<dynamic>([
      _getClubInteractor.run(clubId: _clubId),
      _checkClubInteractor(_clubId),
    ]);

    final hideDate = isOwner ? await _clubRepository.getHideDate(id: _clubId) : null;

    emit(
      state.copyWith(
        isLoading: false,
        model: club,
        isOwner: isOwner,
        hideDate: hideDate,
      ),
    );
  }

  _onBillClub(ClubEventBillClub event, Emitter emit) async {
    final url = await _billClubInteractor(
      clubId: _clubId,
      redirectPath: router.getLocation(),
      days: event.days,
    ).then((str) => Uri.parse(str));
    if (kIsWeb) {
      launchUrl(
        url,
        webOnlyWindowName: '_self',
      );
    } else {
      router.openWebView(url.toString());
    }
  }

  Future<void> _onEditDescription(
    ClubEventEditDescription event,
    Emitter emit,
  ) async {
    final model = state.model;
    if (model == null) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    await _clubRepository.updateDescription(
      clubId: _clubId,
      club: model.copyWith(
        description: event.description.trim().isEmpty ? null : event.description.trim(),
      ),
    );
    add(const ClubEvent.pageOpened());
  }

  Future<void> _onEditPhoto(
    ClubEventEditPhoto event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _clubRepository.updatePhoto(
      clubId: _clubId,
      bytes: event.bytes,
      fileName: event.fileName,
    );
    add(const ClubEvent.pageOpened());
  }
}
