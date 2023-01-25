import 'dart:async';

import 'package:seating_generator_web/ui/login/sign_up_body/sign_up_bloc.dart';

class SignUpPageRouterMock implements SignUpPageRouter {
  final _mainPageOpenedController = StreamController<bool>.broadcast();
  final _loginPageOpenedController = StreamController<bool>.broadcast();
  final _verificationPageOpenedController = StreamController<bool>.broadcast();

  Stream<bool> get mainPageOpened => _mainPageOpenedController.stream;

  Stream<bool> get loginPageOpened => _loginPageOpenedController.stream;

  Stream<bool> get verificationPageOpened =>
      _verificationPageOpenedController.stream;

  @override
  void openMainPage() {
    _mainPageOpenedController.add(true);
  }

  @override
  void openLoginPage() {
    _loginPageOpenedController.add(true);
  }

  @override
  void openVerificationPage(int id) {
    _verificationPageOpenedController.add(true);
  }
}
