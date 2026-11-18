import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/utils/platform.dart';

/// История браузера в тестах: собирает адреса, которые приложение сообщает платформе, как это делает веб-движок.
class FakeBrowserHistory {
  final entries = <String>[];

  /// Адреса из всех сообщений по порядку, вместе с заменёнными.
  final reported = <String>[];

  String get url => entries.last;

  /// Включает веб-режим приложения и перехватывает сообщения роутера движку до конца теста.
  void attach(WidgetTester tester) {
    debugIsWebOverride = true;
    final messenger = tester.binding.defaultBinaryMessenger
      ..setMockMethodCallHandler(SystemChannels.navigation, (call) async {
        if (call.method == 'routeInformationUpdated') _onUpdated(call.arguments as Map);
        return null;
      });
    addTearDown(() {
      debugIsWebOverride = null;
      messenger.setMockMethodCallHandler(SystemChannels.navigation, null);
    });
  }

  void _onUpdated(Map arguments) {
    final uri = arguments['uri'] as String;
    reported.add(uri);
    if (arguments['replace'] == true && entries.isNotEmpty) {
      entries.last = uri;
    } else {
      entries.add(uri);
    }
  }
}
