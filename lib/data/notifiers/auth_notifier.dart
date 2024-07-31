import 'package:flutter/cupertino.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AuthNotifier extends ValueNotifier<AuthNotifierModel> {
  AuthNotifier() : super(const AuthNotifierModel.loading());

  @override
  set value(AuthNotifierModel newValue) {
    Sentry.configureScope((p0) => p0.setUser(null));
    super.value = newValue;
  }
}
