import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/ui/login/login_events.dart';
import 'package:seating_generator_web/ui/login/login_state.dart';

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
  }

  Future _onForgotPasswordTapped(
    ForgotPasswordTapped event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState(hasError: false, isLoading: true));
    router.openForgotPasswordPage();
    emit(LoginState(hasError: false));
  }

  Future _onLoginButtonTapped(
    LoginButtonTapped event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState(hasError: false, isLoading: true));
    final result = await _loginInteractor.run(event.email, event.password);
    if (result is Success) {
      router.openMainPage();
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
