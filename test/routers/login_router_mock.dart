import 'dart:async';

import 'package:seating_generator_web/ui/login/login_bloc.dart';

class LoginPageRouterMock implements LoginPageRouter {
  final _mainPageOpenedController = StreamController<bool>();
  final _forgotPasswordOpenedController = StreamController<bool>();
  final _signUpPageOpenedController = StreamController<bool>();

  Stream<bool> get mainPageOpened => _mainPageOpenedController.stream;

  Stream<bool> get forgotPasswordPageOpened =>
      _forgotPasswordOpenedController.stream;

  Stream<bool> get signUpPageOpened => _signUpPageOpenedController.stream;

  @override
  void openMainPage() {
    _mainPageOpenedController.add(true);
  }

  @override
  void openForgotPasswordPage() {
    _forgotPasswordOpenedController.add(true);
  }

  @override
  void openSignUpPage() {
    _signUpPageOpenedController.add(true);
  }

  @override
  void openVerificationPage(int id) {
    // TODO: implement openVerificationPage
  }
}