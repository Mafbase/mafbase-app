import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/domain/interactors/create_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/logout_interactor.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/profile/domain/interactor/delete_profile_interactor.dart';
import 'package:seating_generator_web/feature/profile/domain/repository/profile_repository.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_effect.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>
    with EffectEmitter<ProfileEffect, ProfileState> {
  final LogoutInteractor _logoutInteractor;
  final DeleteProfileInteractor _deleteProfileInteractor;
  final ProfileRepository _profileRepository;
  final CreatePlayerInteractor _createPlayerInteractor;
  final AuthNotifier _authNotifier;

  late final VoidCallback _authListener;

  ProfileBloc(
    this._logoutInteractor,
    this._deleteProfileInteractor,
    this._profileRepository,
    this._createPlayerInteractor,
    this._authNotifier,
  ) : super(const ProfileState()) {
    on<ProfileEventLogoutPressed>(_onLogoutPressed);
    on<ProfileEventDeleteProfile>(_deleteProfile);
    on<ProfileEventLoadUserProfile>(_loadUserProfile);
    on<ProfileEventSetUserProfile>(_setUserProfile);

    _authListener = () {
      final model = _authNotifier.value;
      if (model is AuthNotifierAuthorizedModel) {
        add(const ProfileEvent.loadUserProfile());
      } else if (model is AuthNotifierUnauthorizedModel) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(const ProfileState());
      }
    };
    _authNotifier.addListener(_authListener);

    // Загрузить профиль сразу, если уже авторизован
    if (_authNotifier.value is AuthNotifierAuthorizedModel) {
      add(const ProfileEvent.loadUserProfile());
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
      _deleteProfileInteractor
          .run()
          .whenComplete(() => emitEffect(const ProfileEffect.navigateBack()));

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
    return _logoutInteractor()
        .whenComplete(() => emitEffect(const ProfileEffect.navigateBack()));
  }
}
