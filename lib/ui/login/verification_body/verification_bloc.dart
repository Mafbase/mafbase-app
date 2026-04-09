import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/verification_interactor.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_events.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvents, VerificationState> {
  @visibleForTesting
  final VerificationPageRouter router;
  final VerificationInteractor _interactor;
  final int _id;

  VerificationBloc(
    this.router,
    this._interactor,
    this._id,
  ) : super(const VerificationState(isLoading: false)) {
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
    _context.router.push(LoginPageRoute());
  }

  @override
  void openMainPage() {
    _context.router.replaceAll([const ClubsRoute()]);
  }

  @override
  void openSignUpPage() {
    _context.router.push(const SignUpPageRoute());
  }
}
