import 'package:flutter/foundation.dart';
import 'package:seating_generator_web/core/auth/auth_notifier_model.dart';

class AuthNotifier extends ValueNotifier<AuthNotifierModel> {
  AuthNotifier() : super(const AuthNotifierModel.loading());
}
