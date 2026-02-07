import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/domain/interactors/create_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/logout_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/profile/domain/interactor/delete_profile_interactor.dart';
import 'package:seating_generator_web/feature/profile/domain/repository/profile_repository.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final CredentialStorage _credentialStorage;
  final LogoutInteractor _logoutInteractor;
  final DeleteProfileInteractor _deleteProfileInteractor;
  final ProfileRepository _profileRepository;
  final CreatePlayerInteractor _createPlayerInteractor;
  final BuildContext? _context;

  ProfileBloc(
    this._logoutInteractor,
    this._credentialStorage,
    this._deleteProfileInteractor,
    this._profileRepository,
    this._createPlayerInteractor,
    BuildContext? context,
  ) : _context = context,
        super(const ProfileState()) {
    on<ProfileEventLogoutPressed>(_onLogoutPressed);
    on<ProfileEventPageOpened>(_init);
    on<ProfileEventDeleteProfile>(_deleteProfile);
    on<ProfileEventLoadUserProfile>(_loadUserProfile);
    on<ProfileEventSetUserProfile>(_setUserProfile);
  }

  Future<void> _deleteProfile(
    ProfileEventDeleteProfile event,
    Emitter emit,
  ) =>
      _deleteProfileInteractor.run().whenComplete(() => _context?.pop());

  Future<void> _init(ProfileEventPageOpened event, Emitter emit) async {
    final login = await _credentialStorage.read().then((value) => value?.login);

    emit(
      state.copyWith(
        isLoading: false,
        login: login,
      ),
    );
    add(const ProfileEvent.loadUserProfile());
  }

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
      
      // Если id == 0, сначала создаем нового игрока
      if (playerToSet.id == 0) {
        final newPlayerId = await _createPlayerInteractor.run(
          playerModel: playerToSet,
        );
        // Обновляем игрока с полученным id
        playerToSet = playerToSet.copyWith(id: newPlayerId);
      }
      
      // Отправляем POST запрос с игроком (созданным или существующим)
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

  _onLogoutPressed(ProfileEventLogoutPressed event, Emitter emit) {
    return _logoutInteractor().whenComplete(() => _context?.pop());
  }

}
