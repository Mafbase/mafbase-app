import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/ui/login/login_events.dart';
import 'package:seating_generator_web/ui/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginInteractor _loginInteractor;
  @visibleForTesting
  final LoginPageRouter router;

  LoginBloc(
    this._loginInteractor,
    this.router,
  ) : super(LoginState(hasError: false)) {
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
    if (_nextPath != null && _nextPath!.isNotEmpty) {
      _context.router.navigatePath(_nextPath!);
    } else {
      _context.router.replaceAll([const ClubsRoute()]);
    }
  }

  @override
  void openForgotPasswordPage() {
    _context.router.push(const ForgotPasswordPageRoute());
  }

  @override
  void openSignUpPage() {
    _context.router.push(const SignUpPageRoute());
  }

  @override
  void openVerificationPage(int id) {
    _context.router.push(VerificationPageRoute(id: id));
  }
}
