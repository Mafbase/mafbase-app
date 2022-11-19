import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/domain/models/sign_up_model.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_events.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_state.dart';

import '../../../domain/models/login_model.dart';

class SignUpBloc extends CustomBloc<SignUpEvents, SignUpState> {
  final SignUpInteractor _signUpInteractor;
  final SignUpPageRouter router;

  SignUpBloc(this._signUpInteractor, this.router, [BuildContext? context])
      : super(SignUpState(), context) {
    on<SignUpButtonTapped>(_onSignUpButtonTapped);
    on<BackButtonTapped>(_onBackButtonTapped);
  }

  Future _onSignUpButtonTapped(
      SignUpButtonTapped event, Emitter<SignUpState> emit) async {
    emit(SignUpState(isLoading: true, emailExist: false, weakPassword: false));
    final result = await _signUpInteractor.run(event.email, event.password);
    debugPrint(result.toString());
    switch (result.error) {
      case ErrorEnum.needVerification:
        emit(state.copyWith(isLoading: false));
        router.openVerificationPage();
        break;
      case ErrorEnum.emailExist:
        emit(state.copyWith(isLoading: false, emailExist: true),);
        break;
      case ErrorEnum.weakPassword:
        emit(state.copyWith(isLoading: false, weakPassword: true));
        break;
      default:
        router.openMainPage();
        break;
    }
  }

  Future _onBackButtonTapped(
    BackButtonTapped event,
    Emitter<SignUpState> emit,
  ) async {
    router.openLoginPage();
  }

  @override
  void emitOnError(Emitter<SignUpState> emit) {
    // TODO: implement emitOnError
  }
}

abstract class SignUpPageRouter {
  void openMainPage();

  void openLoginPage();

  void openVerificationPage();
}

class SignUpPageRouterImpl implements SignUpPageRouter {
  final BuildContext _context;

  const SignUpPageRouterImpl(this._context);

  @override
  void openMainPage() {
    GoRouter.of(_context).go('/');
  }

  @override
  void openLoginPage() {
    GoRouter.of(_context).go(AppRoutes.loginPageRoute);
  }

  @override
  void openVerificationPage() {
    GoRouter.of(_context).go(AppRoutes.verificationPage);
  }
}

class SignUpPageRouterMock implements SignUpPageRouter {
  final _mainPageOpenedController = StreamController<bool>.broadcast();
  final _loginPageOpenedController = StreamController<bool>.broadcast();
  final _verificationPageOpenedController = StreamController<bool>.broadcast();

  Stream<bool> get mainPageOpened => _mainPageOpenedController.stream;

  Stream<bool> get loginPageOpened => _loginPageOpenedController.stream;

  Stream<bool> get verificationPageOpened => _verificationPageOpenedController.stream;

  @override
  void openMainPage() {
    _mainPageOpenedController.add(true);
  }

  @override
  void openLoginPage() {
    _loginPageOpenedController.add(true);
  }

  @override
  void openVerificationPage() {
    _verificationPageOpenedController.add(true);
  }
}
