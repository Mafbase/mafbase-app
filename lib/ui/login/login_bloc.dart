import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/ui/login/login_events.dart';
import 'package:seating_generator_web/ui/login/login_state.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_page_body.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_page_body.dart';

class LoginBloc extends CustomBloc<LoginEvent, LoginState> {
  final LoginInteractor _loginInteractor;
  @visibleForTesting
  final LoginPageRouter router;

  LoginBloc(
    this._loginInteractor,
    this.router, [
    BuildContext? context,
  ]) : super(LoginState(hasError: false), context) {
    on<LoginButtonTapped>(_onLoginButtonTapped);
    on<ForgotPasswordTapped>(_onForgotPasswordTapped);
    on<SignUpButtonTapped>(_onSignUpButtonTapped);
  }

  Future _onForgotPasswordTapped(
    ForgotPasswordTapped event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState(hasError: false, isLoading: true));
    router.openForgotPasswordPage();
    emit(LoginState(hasError: false));
  }

  Future _onSignUpButtonTapped(
    SignUpButtonTapped event,
    Emitter<LoginState> emit,
  ) async {
    router.openSignUpPage();
  }

  Future _onLoginButtonTapped(
    LoginButtonTapped event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState(hasError: false, isLoading: true));

    final result = await _loginInteractor.run(
      event.email,
      event.password,
      rememberMe: event.rememberMe,
    );
    if (result is Success) {
      router.openMainPage();
      emit(LoginState(hasError: false));
    } else if (result is NeedVerification) {
      router.openVerificationPage(result.id);
      emit(LoginState(hasError: false));
    } else {
      emit(LoginState(hasError: true));
    }
  }

  @override
  void emitOnError(Emitter<LoginState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}

abstract class LoginPageRouter {
  void openMainPage();

  void openForgotPasswordPage();

  void openVerificationPage(int id);

  void openSignUpPage();
}

class LoginPageRouterImpl implements LoginPageRouter {
  final BuildContext _context;
  final String? _nextPath;

  const LoginPageRouterImpl(this._context, [this._nextPath]);

  @override
  void openMainPage() {
    GoRouter.of(_context).go(_nextPath ?? '/');
  }

  @override
  void openForgotPasswordPage() {
    // TODO: implement openForgotPasswordPage
    throw UnimplementedError();
  }

  @override
  void openSignUpPage() {
    SignUpPageBody.open(context: _context);
  }

  @override
  void openVerificationPage(int id) {
    _context.go(VerificationPageBody.namedLocation(_context, id));
  }
}
