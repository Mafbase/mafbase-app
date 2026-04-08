import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/domain/interactors/login_interactor.dart';
import 'package:seating_generator_web/domain/interactors/sign_up_interactor.dart';
import 'package:seating_generator_web/domain/models/login_model.dart';
import 'package:seating_generator_web/domain/models/sign_up_model.dart';
import 'package:seating_generator_web/ui/login/login_body/login_body.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_events.dart';
import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_state.dart';
import 'package:seating_generator_web/ui/login/verification_body/verification_page_body.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpState> {
  final SignUpInteractor _signUpInteractor;
  final LoginInteractor _loginInteractor;
  final SignUpPageRouter router;

  SignUpBloc(
    this._signUpInteractor,
    this._loginInteractor,
    this.router,
  ) : super(SignUpState()) {
    on<SignUpButtonTapped>(_onSignUpButtonTapped);
    on<BackButtonTapped>(_onBackButtonTapped);
  }

  Future _onSignUpButtonTapped(
    SignUpButtonTapped event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpState(isLoading: true, emailExist: false, weakPassword: false));
    try {
      final result = await _signUpInteractor.run(event.email, event.password);

      switch (result.error) {
        case ErrorEnum.needVerification:
          emit(state.copyWith(isLoading: false));
          router.openVerificationPage(result.id!);
          break;
        case ErrorEnum.emailExist:
          emit(
            state.copyWith(isLoading: false, emailExist: true),
          );
          break;
        case ErrorEnum.weakPassword:
          emit(state.copyWith(isLoading: false, weakPassword: true));
          break;
        default:
          // После успешной регистрации автоматически входим в аккаунт
          final loginResult = await _loginInteractor.run(
            event.email,
            event.password,
          );

          if (loginResult is Success) {
            emit(state.copyWith(isLoading: false));
            router.openMainPage();
          } else {
            // Если вход не удался, все равно переходим на главную
            emit(state.copyWith(isLoading: false));
            router.openMainPage();
          }
          break;
      }
    } finally {
      if (state.isLoading) emit(state.copyWith(isLoading: false));
    }
  }

  Future _onBackButtonTapped(
    BackButtonTapped event,
    Emitter<SignUpState> emit,
  ) async {
    router.openLoginPage();
  }
}

abstract class SignUpPageRouter {
  void openMainPage();

  void openLoginPage();

  void openVerificationPage(int id);
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
    GoRouter.of(_context).go(LoginPageBody.createLocation(context: _context));
  }

  @override
  void openVerificationPage(int id) {
    GoRouter.of(_context).go(VerificationPageBody.namedLocation(_context, id));
  }
}
