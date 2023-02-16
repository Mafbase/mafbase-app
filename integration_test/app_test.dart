import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('login flow', (tester) async {
    registerGetIt();
    await tester.pumpWidget(const App());
    await tester.pump(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
    final loginField = find.text('Ваша электронная почта');
    final passwordField = find.text('Пароль');
    expect(loginField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    await tester.tap(loginField, warnIfMissed: false);
    tester.testTextInput.enterText('test@mail.ru');
    await tester.pump();
    await tester.tap(passwordField, warnIfMissed: false);
    tester.testTextInput.enterText('testtest');
    await tester.pump();
    final button = find.text('Войти');
    expect(button, findsOneWidget);
    await tester.tap(button, warnIfMissed: false);
    await tester.pumpAndSettle();
    final title = find.text('Турниры');
    expect(title, findsAtLeastNWidgets(1));

    final tournament = find.text('Турнир');
    expect(tournament, findsOneWidget);
    await tester.tap(tournament);
  });
}
