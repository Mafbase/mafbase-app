import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/data/storages/token_storage.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/ui/login/login_events.dart';
import 'package:seating_generator_web/ui/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginInteractor _loginInteractor;
  final SignUpInteractor _signUpInteractor;
  @visibleForTesting
  final LoginPageRouter navigator;
  final TokenStorage _storage;

  LoginBloc(this._loginInteractor, this._signUpInteractor, this.navigator, this._storage)
      : super(LoginState.login(hasError: false)) {
    on<LoginButtonTapped>(_onLoginButtonTapped);
    on<ForgotPasswordTapped>(_onForgotPasswordTapped);
  }

  _onForgotPasswordTapped(
    ForgotPasswordTapped event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.login(hasError: false, isLoading: true));
    navigator.openForgotPasswordPage();
    emit(LoginState.login(hasError: false));
  }

  _onLoginButtonTapped(
    LoginButtonTapped event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.login(hasError: false, isLoading: true));
    final result = await _loginInteractor.run(event.email, event.password);
    result.when(
      success: () {
        navigator.openMainPage();
        emit(LoginState.login(hasError: false));
      },
      error: (message) {
        emit(LoginState.login(hasError: true));
      },
    );
  }
}

abstract class LoginPageRouter {
  void openMainPage();

  void openForgotPasswordPage();
}

class LoginPageRouterMock implements LoginPageRouter {
  final _mainPageOpenedController = StreamController<bool>();
  final _forgotPasswordOpenedController = StreamController<bool>();

  Stream<bool> get mainPageOpened => _mainPageOpenedController.stream;

  Stream<bool> get forgotPasswordPageOpened =>
      _forgotPasswordOpenedController.stream;

  @override
  void openMainPage() {
    _mainPageOpenedController.add(true);
  }

  @override
  void openForgotPasswordPage() {
    _forgotPasswordOpenedController.add(true);
  }
}

class LoginPageRouterImpl implements LoginPageRouter {
  final BuildContext _context;

  const LoginPageRouterImpl(this._context);

  @override
  void openMainPage() {
    GoRouter.of(_context).go('/');
  }

  @override
  void openForgotPasswordPage() {
    // TODO: implement openForgotPasswordPage
    throw UnimplementedError();
  }
}
