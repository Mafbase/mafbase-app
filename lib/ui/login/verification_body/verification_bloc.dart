import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/verification_interactor.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_events.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_state.dart';

class VerificationBloc
    extends CustomBloc<VerificationEvents, VerificationState> {
  final VerificationPageRouter router;
  final VerificationInteractor interactor;
  final int id;

  VerificationBloc(
    this.router,
    this.interactor,
    this.id, [
    BuildContext? context,
  ]) : super(const VerificationState(isLoading: false), context) {
    on<VerificationEventSubmit>(_onSubmit);
    on<OnSignUpButtonTapped>(onRegistrationButtonTapped);
    on<OnLoginButtonTapped>(onAuthButtonTapped);
  }

  Future _onSubmit(
    VerificationEventSubmit event,
    Emitter<VerificationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, hasError: false));
    final result = await interactor.run(id, event.token);
    switch (result) {
      case false:
        emit(state.copyWith(isLoading: false, hasError: true));
        break;
      case true:
        emit(state.copyWith(isLoading: false, hasError: false));
        router.openMainPage();
        break;
    }
  }

  Future onAuthButtonTapped(
    OnLoginButtonTapped event,
    Emitter<VerificationState> emit,
  ) async {
    router.openLoginPage();
  }

  Future onRegistrationButtonTapped(
    OnSignUpButtonTapped event,
    Emitter<VerificationState> emit,
  ) async {
    router.openSignUpPage();
  }

  @override
  void emitOnError(Emitter<VerificationState> emit) {
    emit(state.copyWith(isLoading: false));
  }
}

abstract class VerificationPageRouter {
  void openMainPage();

  void openLoginPage();

  void openSignUpPage();
}

class VerificationPageRouterImpl implements VerificationPageRouter {
  final BuildContext _context;

  const VerificationPageRouterImpl(this._context);

  @override
  void openLoginPage() {
    GoRouter.of(_context).go(AppRoutes.loginPageRoute);
  }

  @override
  void openMainPage() {
    GoRouter.of(_context).go('/');
  }

  @override
  void openSignUpPage() {
    GoRouter.of(_context).go(AppRoutes.signUpRoute);
  }
}

class VerificationPageRouterMock implements VerificationPageRouter {
  final _mainPageOpenedController = StreamController<bool>.broadcast();
  final _loginPageOpenedController = StreamController<bool>.broadcast();
  final _signUpPageOpenedController = StreamController<bool>.broadcast();

  Stream<bool> get signUpPageOpened => _signUpPageOpenedController.stream;

  Stream<bool> get mainPageOpened => _mainPageOpenedController.stream;

  Stream<bool> get loginPageOpened => _loginPageOpenedController.stream;

  @override
  void openLoginPage() {
    _loginPageOpenedController.add(true);
  }

  @override
  void openMainPage() {
    _mainPageOpenedController.add(true);
  }

  @override
  void openSignUpPage() {
    _signUpPageOpenedController.add(true);
  }
}
