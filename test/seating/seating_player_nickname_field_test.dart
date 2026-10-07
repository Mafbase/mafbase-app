import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/widgets/seating_player_nickname_field.dart';

void main() {
  for (final failSearch in [false, true]) {
    testWidgets('Search shows a spinner instead of + and clears it on ${failSearch ? 'failure' : 'success'}',
        (tester) async {
      final repository = _PlayersRepository();
      final controller = TextEditingController();
      final focusNode = FocusNode();
      final created = <String>[];
      addTearDown(controller.dispose);
      addTearDown(focusNode.dispose);
      await tester.pumpWidget(
        DependencyScopeWidget(
          scope: _Scope(repository),
          child: MaterialApp(
            theme: AppTheme.light(isMobile: false),
            locale: const Locale('ru'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: SeatingPlayerNicknameField(
                controller: controller,
                focusNode: focusNode,
                onSelected: (_) {},
                onNewPlayer: created.add,
                onChanged: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), 'First');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.add), findsNothing);
      expect(find.text('Создать игрока можно после завершения поиска по никнейму.'), findsNothing);
      expect(tester.widget<IconButton>(find.byType(IconButton)).onPressed, isNull);

      // Editing while a request is pending must keep the spinner visible.
      await tester.enterText(find.byType(TextFormField), 'Nick');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(tester.widget<IconButton>(find.byType(IconButton)).onPressed, isNull);

      if (failSearch) {
        repository.search.completeError(StateError('Search failed'));
      } else {
        repository.search.complete([const PlayerModel(id: 1, nickname: 'Nick2')]);
      }
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byIcon(Icons.add), findsOneWidget);
      final button = tester.widget<IconButton>(find.byType(IconButton));
      if (failSearch) {
        expect(button.onPressed, isNull);
        expect(find.text('Не удалось проверить никнейм. Измените его, чтобы повторить поиск.'), findsOneWidget);
      } else {
        expect(button.onPressed, isNotNull);
        await tester.tap(find.byIcon(Icons.add));
        expect(created, ['Nick']);
        await tester.tap(find.text('Nick2'));
        await tester.pumpAndSettle();
        expect(controller.text, 'Nick2');
        expect(find.byType(CircularProgressIndicator), findsNothing);
      }

      await tester.pumpWidget(const SizedBox());
    });
  }
}

class _PlayersRepository extends Fake implements PlayersRepository {
  final search = Completer<List<PlayerModel>>();

  @override
  Future<List<PlayerModel>> searchPlayers(String search, {int limit = 5, int offset = 0}) => this.search.future;
}

class _Repositories extends Fake implements RepositoryFactory {
  _Repositories(this.playersRepository);

  @override
  final PlayersRepository playersRepository;
}

class _Scope extends Fake implements DependencyScope {
  _Scope(PlayersRepository repository) : repositoryFactory = _Repositories(repository);

  @override
  final RepositoryFactory repositoryFactory;
}
