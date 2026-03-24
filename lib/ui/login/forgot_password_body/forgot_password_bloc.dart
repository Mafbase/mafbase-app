import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/models/password_reset_model.dart';
import 'package:seating_generator_web/domain/repositories/auth_repository.dart';
import 'package:seating_generator_web/ui/login/forgot_password_body/forgot_password_events.dart';
import 'package:seating_generator_web/ui/login/forgot_password_body/forgot_password_state.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/login/reset_password_body/reset_password_page_body.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvents, ForgotPasswordState> {
  final AuthRepository _authRepository;
  final ForgotPasswordPageRouter router;

  ForgotPasswordBloc(this._authRepository, this.router) : super(ForgotPasswordState()) {
    on<Submit>(_onSubmit);
    on<BackButtonTapped>(_onBackButtonTapped);
  }

  Future _onSubmit(
    Submit event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, hasError: false, isSuccess: false));

    final result = await _authRepository.forgotPassword(event.email);

    result.when(
      success: () {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        router.openResetPasswordPage(event.email);
      },
      error: () {
        emit(state.copyWith(isLoading: false, hasError: true));
      },
    );
  }

  Future _onBackButtonTapped(
    BackButtonTapped event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    router.openLoginPage();
  }
}

abstract class ForgotPasswordPageRouter {
  void openLoginPage();
  void openResetPasswordPage(String email);
}

class ForgotPasswordPageRouterImpl implements ForgotPasswordPageRouter {
  final BuildContext _context;

  const ForgotPasswordPageRouterImpl(this._context);

  @override
  void openLoginPage() {
    GoRouter.of(_context).go(LoginPageBody.createLocation(context: _context));
  }

  @override
  void openResetPasswordPage(String email) {
    GoRouter.of(_context).go(
      ResetPasswordPageBody.createLocation(context: _context, email: email),
    );
  }
}
