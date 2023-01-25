import 'dart:async';

import 'package:seating_generator_web/ui/login/verification_body/verification_bloc.dart';

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
