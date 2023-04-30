import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/logout_interactor.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';

class ProfileBloc extends CustomBloc<ProfileEvent, ProfileState> {
  final LogoutInteractor _logoutInteractor;

  ProfileBloc(this._logoutInteractor, BuildContext? context)
      : super(const ProfileState(), context) {
    on<ProfileEventLogoutPressed>(_onLogoutPressed);
    on<ProfileEventPageOpened>((_, __) {
      // TODO
    });
  }

  _onLogoutPressed(ProfileEventLogoutPressed event, Emitter emit) {
    return _logoutInteractor().whenComplete(() => context?.pop());
  }

  @override
  void emitOnError(Emitter<ProfileState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}
