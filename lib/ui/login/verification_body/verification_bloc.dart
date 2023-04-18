import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/verification_interactor.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_page_body.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_events.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_state.dart';

class VerificationBloc
    extends CustomBloc<VerificationEvents, VerificationState> {
  @visibleForTesting
  final VerificationPageRouter router;
  final VerificationInteractor _interactor;
  final int _id;

  VerificationBloc(
    this.router,
    this._interactor,
    this._id, [
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
    final result = await _interactor.run(_id, event.token.trim());
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
    LoginPageBody.open(context: _context);
  }

  @override
  void openMainPage() {
    GoRouter.of(_context).go('/');
  }

  @override
  void openSignUpPage() {
    SignUpPageBody.open(context: _context);
  }
}
