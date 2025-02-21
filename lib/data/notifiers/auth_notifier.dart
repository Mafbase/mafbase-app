import 'package:flutter/cupertino.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';

class AuthNotifier extends ValueNotifier<AuthNotifierModel> {
  AuthNotifier() : super(const AuthNotifierModel.loading());
}
