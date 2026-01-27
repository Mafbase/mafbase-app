import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/login/reset_password_body/reset_password_events.dart';
import 'package:seating_generator_web/ui/login/reset_password_body/reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvents, ResetPasswordState> {
  final AuthRepository _authRepository;
  final LoginInteractor _loginInteractor;
  final ResetPasswordPageRouter router;
  final String email;

  ResetPasswordBloc(
    this._authRepository,
    this._loginInteractor,
    this.router,
    this.email,
  ) : super(ResetPasswordState()) {
    on<Submit>(_onSubmit);
    on<BackButtonTapped>(_onBackButtonTapped);
  }

  Future _onSubmit(
    Submit event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    final resetResult = await _authRepository.resetPassword(
      event.token,
      event.email,
      event.newPassword,
    );

    await resetResult.when(
      success: () async {
        // После успешного сброса пароля автоматически входим в аккаунт
        final loginResult = await _loginInteractor.run(
          event.email,
          event.newPassword,
        );

        if (loginResult is Success) {
          emit(state.copyWith(isLoading: false));
          router.openMainPage();
        } else {
          // Если вход не удался, все равно переходим на страницу логина
          emit(state.copyWith(isLoading: false));
          router.openLoginPage();
        }
      },
      error: (error) {
        emit(state.copyWith(isLoading: false, error: error));
      },
    );
  }

  Future _onBackButtonTapped(
    BackButtonTapped event,
    Emitter<ResetPasswordState> emit,
  ) async {
    router.openLoginPage();
  }
}

abstract class ResetPasswordPageRouter {
  void openLoginPage();
  void openMainPage();
}

class ResetPasswordPageRouterImpl implements ResetPasswordPageRouter {
  final BuildContext _context;

  const ResetPasswordPageRouterImpl(this._context);

  @override
  void openLoginPage() {
    GoRouter.of(_context).go(LoginPageBody.createLocation(context: _context));
  }

  @override
  void openMainPage() {
    GoRouter.of(_context).go('/');
  }
}
