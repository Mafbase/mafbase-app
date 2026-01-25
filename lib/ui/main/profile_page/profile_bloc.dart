import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/domain/interactors/logout_interactor.dart';
import 'package:seating_generator_web/feature/profile/domain/interactor/delete_profile_interactor.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final CredentialStorage _credentialStorage;
  final LogoutInteractor _logoutInteractor;
  final DeleteProfileInteractor _deleteProfileInteractor;
  final BuildContext? _context;

  ProfileBloc(
    this._logoutInteractor,
    this._credentialStorage,
    this._deleteProfileInteractor,
    BuildContext? context,
  ) : _context = context,
        super(const ProfileState()) {
    on<ProfileEventLogoutPressed>(_onLogoutPressed);
    on<ProfileEventPageOpened>(_init);
    on<ProfileEventDeleteProfile>(_deleteProfile);
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
  }

  _onLogoutPressed(ProfileEventLogoutPressed event, Emitter emit) {
    return _logoutInteractor().whenComplete(() => _context?.pop());
  }

}
