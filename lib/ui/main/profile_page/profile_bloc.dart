import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/domain/interactors/add_photo_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/logout_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/profile/domain/interactor/delete_profile_interactor.dart';
import 'package:seating_generator_web/feature/profile/domain/model/tournament_subscription_plan_model.dart';
import 'package:seating_generator_web/feature/profile/domain/repository/profile_repository.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_effect.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> with EffectEmitter<ProfileEffect, ProfileState> {
  final LogoutInteractor _logoutInteractor;
  final DeleteProfileInteractor _deleteProfileInteractor;
  final ProfileRepository _profileRepository;
  final CreatePlayerInteractor _createPlayerInteractor;
  final AddPhotoInteractor _addPhotoInteractor;
  final AuthNotifier _authNotifier;

  late final VoidCallback _authListener;

  ProfileBloc(
    this._logoutInteractor,
    this._deleteProfileInteractor,
    this._profileRepository,
    this._createPlayerInteractor,
    this._addPhotoInteractor,
    this._authNotifier,
  ) : super(const ProfileState()) {
    on<ProfileEventLogoutPressed>(_onLogoutPressed);
    on<ProfileEventDeleteProfile>(_deleteProfile);
    on<ProfileEventLoadUserProfile>(_loadUserProfile);
    on<ProfileEventSetUserProfile>(_setUserProfile);
    on<ProfileEventLoadSubscription>(_loadSubscription);
    on<ProfileEventBillSubscription>(_billSubscription);
    on<ProfileEventReset>(_onReset);
    on<ProfileEventEditPhoto>(_editPhoto);

    _authListener = () {
      final model = _authNotifier.value;
      if (model is AuthNotifierAuthorizedModel) {
        add(const ProfileEvent.loadUserProfile());
        add(const ProfileEvent.loadSubscription());
      } else if (model is AuthNotifierUnauthorizedModel) {
        add(const ProfileEvent.reset());
      }
    };
    _authNotifier.addListener(_authListener);

    if (_authNotifier.value is AuthNotifierAuthorizedModel) {
      add(const ProfileEvent.loadUserProfile());
      add(const ProfileEvent.loadSubscription());
    }
  }

  @override
  Future<void> close() {
    _authNotifier.removeListener(_authListener);
    return super.close();
  }

  Future<void> _deleteProfile(
    ProfileEventDeleteProfile event,
    Emitter emit,
  ) =>
      _deleteProfileInteractor.run().whenComplete(() => emitEffect(const ProfileEffect.navigateBack()));

  Future<void> _loadUserProfile(
    ProfileEventLoadUserProfile event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final playerProfile = await _profileRepository.getUserProfile();
      emit(
        state.copyWith(
          isLoading: false,
          playerProfile: playerProfile,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _setUserProfile(
    ProfileEventSetUserProfile event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      PlayerModel playerToSet = event.player;

      if (playerToSet.id == 0) {
        final newPlayerId = await _createPlayerInteractor.run(
          playerModel: playerToSet,
        );
        playerToSet = playerToSet.copyWith(id: newPlayerId);
      }

      await _profileRepository.setUserProfile(playerToSet);
      emit(
        state.copyWith(
          isLoading: false,
          playerProfile: playerToSet,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }

  Future<void> _loadSubscription(
    ProfileEventLoadSubscription event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isLoadingSubscription: true, subscriptionError: null));
    try {
      final plan = await _profileRepository.getTournamentSubscriptionCurrentPlan();
      emit(
        state.copyWith(
          isLoadingSubscription: false,
          subscriptionPlan: plan,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingSubscription: false,
          subscriptionError: e.toString(),
        ),
      );
    }
  }

  Future<void> _billSubscription(
    ProfileEventBillSubscription event,
    Emitter emit,
  ) async {
    emit(state.copyWith(isBilling: true));
    try {
      final result = await _profileRepository.billTournamentSubscription(
        subscriptionType: TournamentSubscriptionTypeModel.tournamentWithAllAddons10Players,
        days: event.days,
        redirectPath: event.redirectPath,
      );
      emitEffect(ProfileEffect.navigateToPaymentWaiting(
        redirectLink: result.redirectLink,
        purchaseId: result.purchaseId,
        nextPath: event.redirectPath,
      ),);
    } finally {
      emit(state.copyWith(isBilling: false));
    }
  }

  void _onReset(ProfileEventReset event, Emitter emit) {
    emit(const ProfileState());
  }

  Future<dynamic> _onLogoutPressed(ProfileEventLogoutPressed event, Emitter emit) {
    return _logoutInteractor().whenComplete(() => emitEffect(const ProfileEffect.navigateBack()));
  }

  Future<void> _editPhoto(ProfileEventEditPhoto event, Emitter emit) async {
    final playerId = state.playerProfile?.id;
    if (playerId == null) return;

    emit(state.copyWith(isUploadingPhoto: true));
    try {
      await _addPhotoInteractor.run(
        bytes: event.bytes,
        filename: event.fileName,
        playerId: playerId,
      );
      final updatedProfile = await _profileRepository.getUserProfile();
      emit(state.copyWith(isUploadingPhoto: false, playerProfile: updatedProfile));
    } finally {
      emit(state.copyWith(isUploadingPhoto: false));
    }
  }
}
