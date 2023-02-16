import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('login flow', (tester) async {
    registerGetIt();
    await tester.pumpWidget(
      const App(
        initLocation: '/login',
      ),
    );
    await tester.pump(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
    final loginField =
        find.widgetWithText(CustomTextField, 'Ваша электронная почта');
    final passwordField = find.widgetWithText(CustomTextField, 'Пароль');
    expect(loginField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    await tester.enterText(loginField, 'test@mail.ru');
    await tester.enterText(passwordField, 'testtest');
    await tester.pump(const Duration(seconds: 1));
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
