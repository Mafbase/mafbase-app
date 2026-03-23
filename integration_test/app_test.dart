import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/data/storages/credential_storage.dart';
import 'package:seating_generator_web/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('clubs page flow', (tester) async {
    final scope = DependencyScope(isIntegrationTest: true);
    await scope.storageFactory.credentialStorage.save(
      Credentials(
        'test@mail.ru',
        'testtest',
      ),
    );
    await tester.pumpWidget(
      MafbaseApp(
        scope: scope,
      ),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    final navClubIcon = find.byIcon(Icons.people_alt_outlined);
    expect(navClubIcon, findsOneWidget);
    await tester.tap(navClubIcon);
    await tester.pumpAndSettle();
    final clubRow = find.text('MASONS');
    expect(clubRow, findsOneWidget);
    await tester.tap(clubRow);
    await tester.pumpAndSettle();

    final openRatingButton = find.text('Открыть рейтинг клуба');
    expect(openRatingButton, findsOneWidget);
    await tester.tap(openRatingButton);
    await tester.pumpAndSettle();
  });
  testWidgets('tournament add and delete player flow', (tester) async {
    final scope = DependencyScope(isIntegrationTest: true);
    await scope.storageFactory.credentialStorage.save(
      Credentials(
        'test@mail.ru',
        'testtest',
      ),
    );
    await tester.pumpWidget(
      MafbaseApp(
        scope: scope,
      ),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    final tournament = find.text('Турнир');
    expect(tournament, findsOneWidget);
    await tester.tap(tournament);
    await tester.pumpAndSettle();
    expect(find.text('Домовой'), findsOneWidget);

    final addPlayer = find.text('Добавить участника');
    expect(addPlayer, findsOneWidget);
    await tester.tap(addPlayer, warnIfMissed: false);
    await tester.pumpAndSettle();
    final nicknameField = find.widgetWithText(CustomTextField, 'Никнейм');
    expect(nicknameField, findsOneWidget);
    await tester.enterText(nicknameField, 'Stre');
    await tester.pumpAndSettle();
    final strelasNickname = find.text('Strelas');
    await tester.ensureVisible(strelasNickname);
    expect(strelasNickname, findsOneWidget);
    await tester.tap(strelasNickname, warnIfMissed: false);
    await tester.pumpAndSettle();

    final addButton = find.text('Добавить');
    expect(addButton, findsOneWidget);
    await tester.tap(addButton, warnIfMissed: false);
    await tester.pumpAndSettle();

    final row = find.text('Strelas');
    expect(row, findsOneWidget);
    await tester.tap(row);
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(2, 2));
    await tester.pumpAndSettle();

    final delete = find.byIcon(Icons.delete).last;
    await tester.tap(delete, warnIfMissed: false);
    await tester.pumpAndSettle();

    final confirmButton = find.text('Да');
    expect(confirmButton, findsOneWidget);
    await tester.tap(confirmButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    final strelasRow = find.text('Strelas');
    expect(strelasRow, findsNothing);
  });
  testWidgets('login flow', (tester) async {
    await loginFlow(tester);
  });
}

Future loginFlow(WidgetTester tester) async {
  await tester.pumpWidget(
    MafbaseApp(
      initLocation: '/login',
      scope: DependencyScope(),
    ),
  );
  await tester.pump(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  final loginField =
      find.widgetWithText(CustomTextField, 'Ваша электронная почта');
  final passwordField = find.widgetWithText(CustomTextField, 'Пароль');
  expect(loginField, findsOneWidget);
  expect(passwordField, findsOneWidget);
  await tester.pump(const Duration(seconds: 1));
  await tester.enterText(loginField, 'test@mail.ru');
  await tester.pump(const Duration(seconds: 1));
  await tester.enterText(passwordField, 'testtest');
  await tester.pump(const Duration(seconds: 1));
  final button = find.text('Войти');
  expect(button, findsOneWidget);
  await tester.tap(button, warnIfMissed: false);
  await tester.pumpAndSettle();
  final title = find.text('Турниры');
  expect(title, findsAtLeastNWidgets(1));
}
