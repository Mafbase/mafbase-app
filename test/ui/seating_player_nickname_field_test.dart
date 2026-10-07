import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/domain/repositories/players_repository.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/widgets/seating_player_nickname_field.dart';

class _SearchRequest {
  final String query;
  final result = Completer<List<PlayerModel>>();

  _SearchRequest(this.query);
}

class _PlayersRepository extends Fake implements PlayersRepository {
  final requests = <_SearchRequest>[];
  final created = <PlayerModel>[];
  final edited = <PlayerModel>[];

  @override
  Future<List<PlayerModel>> searchPlayers(String search, {int limit = 5, int offset = 0}) {
    final request = _SearchRequest(search);
    requests.add(request);
    return request.result.future;
  }

  @override
  Future<int> createPlayer(PlayerModel player) async {
    created.add(player);
    return 42;
  }

  @override
  Future<void> editPlayer(PlayerModel player) async => edited.add(player);
}

class _RepositoryFactory extends Fake implements RepositoryFactory {
  @override
  final PlayersRepository playersRepository;

  _RepositoryFactory(this.playersRepository);
}

class _DependencyScope extends DependencyScope {
  final RepositoryFactory _repositoryFactory;

  _DependencyScope(PlayersRepository repository) : _repositoryFactory = _RepositoryFactory(repository);

  @override
  RepositoryFactory get repositoryFactory => _repositoryFactory;
}

Widget _app(PlayersRepository repository, Widget child) => DependencyScopeWidget(
      scope: _DependencyScope(repository),
      child: MaterialApp(
        locale: const Locale('ru'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.light(isMobile: false),
        home: Scaffold(body: Center(child: child)),
      ),
    );

IconButton _createButton(WidgetTester tester) => tester.widget<IconButton>(find.widgetWithIcon(IconButton, Icons.add));

Future<void> _startSearch(WidgetTester tester) async {
  await tester.tap(find.byType(TextFormField));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

Future<void> _disposeWidget(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  late _PlayersRepository repository;
  late TextEditingController controller;
  late FocusNode focusNode;
  late List<String> createdNicknames;
  late List<PlayerModel> selectedPlayers;

  setUp(() {
    repository = _PlayersRepository();
    controller = TextEditingController(text: 'Игрок');
    focusNode = FocusNode();
    createdNicknames = [];
    selectedPlayers = [];
  });

  tearDown(() {
    controller.dispose();
    focusNode.dispose();
  });

  Future<void> pumpField(WidgetTester tester) => tester.pumpWidget(
        _app(
          repository,
          SeatingPlayerNicknameField(
            controller: controller,
            focusNode: focusNode,
            onSelected: selectedPlayers.add,
            onNewPlayer: createdNicknames.add,
            onChanged: () {},
          ),
        ),
      );

  testWidgets('creation requires a completed search, including an empty result', (tester) async {
    await pumpField(tester);
    expect(_createButton(tester).onPressed, isNull);
    expect(repository.requests, isEmpty);

    await _startSearch(tester);
    expect(repository.requests.single.query, 'Игрок');
    expect(_createButton(tester).onPressed, isNull);

    repository.requests.single.result.complete([]);
    await tester.pumpAndSettle();
    expect(_createButton(tester).onPressed, isNotNull);
    await tester.tap(find.widgetWithIcon(IconButton, Icons.add));
    expect(createdNicknames, ['Игрок']);

    await tester.enterText(find.byType(TextFormField), 'Другой');
    await tester.pump();
    expect(_createButton(tester).onPressed, isNull);
    await _disposeWidget(tester);
  });

  testWidgets('an ordinary nickname match blocks creation and allows selection', (tester) async {
    controller.text = ' игрок ';
    await pumpField(tester);
    await _startSearch(tester);
    const player = PlayerModel(id: 1, nickname: 'Игрок');
    repository.requests.single.result.complete([player]);
    await tester.pumpAndSettle();

    expect(_createButton(tester).onPressed, isNull);
    expect(find.textContaining('Измените никнейм или выберите игрока из списка'), findsOneWidget);
    await tester.tap(find.text('Игрок'));
    await tester.pump();
    expect(selectedPlayers, [player]);
    expect(createdNicknames, isEmpty);
  });

  testWidgets('a Gomafia nickname match alone does not block creation', (tester) async {
    await pumpField(tester);
    await _startSearch(tester);
    repository.requests.single.result.complete([
      const PlayerModel(id: 1, nickname: 'Другой', fsmNickaname: 'Игрок'),
    ]);
    await tester.pumpAndSettle();
    expect(_createButton(tester).onPressed, isNotNull);
  });

  testWidgets('a failed search keeps creation disabled until another successful search', (tester) async {
    await pumpField(tester);
    await _startSearch(tester);
    repository.requests.single.result.completeError(StateError('Search failed'));
    await tester.pumpAndSettle();
    expect(_createButton(tester).onPressed, isNull);
    expect(find.textContaining('Не удалось проверить никнейм'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Другой');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    repository.requests.last.result.complete([]);
    await tester.pumpAndSettle();
    expect(_createButton(tester).onPressed, isNotNull);
  });

  testWidgets('an old response cannot validate the current nickname or replace its results', (tester) async {
    await pumpField(tester);
    await _startSearch(tester);
    final oldRequest = repository.requests.single;
    await tester.enterText(find.byType(TextFormField), 'Новый');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    final newRequest = repository.requests.last;

    oldRequest.result.complete([]);
    await tester.pump();
    expect(_createButton(tester).onPressed, isNull);

    newRequest.result.complete([const PlayerModel(id: 2, nickname: 'Новый')]);
    await tester.pumpAndSettle();
    expect(_createButton(tester).onPressed, isNull);
    expect(find.text('Новый'), findsWidgets);
  });

  testWidgets('an empty or whitespace nickname cannot be created', (tester) async {
    controller.clear();
    await pumpField(tester);
    await _startSearch(tester);
    expect(repository.requests, isEmpty);
    expect(_createButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextFormField), '   ');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    repository.requests.single.result.complete([]);
    await tester.pumpAndSettle();
    expect(_createButton(tester).onPressed, isNull);
  });

  testWidgets('a late old response cannot replace a completed current search', (tester) async {
    await pumpField(tester);
    await _startSearch(tester);
    final oldRequest = repository.requests.single;
    await tester.enterText(find.byType(TextFormField), 'Новый');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    repository.requests.last.result.complete([]);
    await tester.pumpAndSettle();
    expect(_createButton(tester).onPressed, isNotNull);

    oldRequest.result.complete([const PlayerModel(id: 1, nickname: 'Новый')]);
    await tester.pumpAndSettle();
    expect(_createButton(tester).onPressed, isNotNull);
    expect(find.textContaining('Измените никнейм или выберите игрока из списка'), findsNothing);
  });

  testWidgets('the duplicate warning fits a mobile dialog', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(_app(repository, SeatingPageDialog.create(['Игрок'])));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    repository.requests.single.result.complete([const PlayerModel(id: 1, nickname: 'Игрок')]);
    await tester.pumpAndSettle();

    expect(_createButton(tester).onPressed, isNull);
    expect(find.textContaining('Измените никнейм или выберите игрока из списка'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('creation retains the imported nickname and checks the next missing player', (tester) async {
    await tester.pumpWidget(_app(repository, SeatingPageDialog.create(['Игрок', 'Следующий'])));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    repository.requests.single.result.complete([]);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), 'Новое имя');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    repository.requests.last.result.complete([]);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithIcon(IconButton, Icons.add));
    await tester.pump();
    await tester.pump();

    expect(repository.created.single.nickname, 'Новое имя');
    expect(repository.created.single.fsmNickaname, 'Игрок');
    expect(find.textContaining('Следующий', findRichText: true), findsWidgets);
    expect(_createButton(tester).onPressed, isNull);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);
    await _disposeWidget(tester);
  });

  testWidgets('editing the field clears a selected player, including after advancing', (tester) async {
    await tester.pumpWidget(_app(repository, SeatingPageDialog.create(['Игрок', 'Следующий'])));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    repository.requests.single.result.complete([const PlayerModel(id: 1, nickname: 'Игрок')]);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(InkWell, 'Игрок'));
    await tester.pump();
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNotNull);

    await tester.enterText(find.byType(TextFormField), 'Другое имя');
    await tester.pump();
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);

    await tester.enterText(find.byType(TextFormField), 'Игрок');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    repository.requests.last.result.complete([const PlayerModel(id: 1, nickname: 'Игрок')]);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(InkWell, 'Игрок'));
    await tester.pump();
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNotNull);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    await tester.pump();

    expect(repository.edited.single.id, 1);
    expect(repository.edited.single.fsmNickaname, 'Игрок');
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed, isNull);
    expect(_createButton(tester).onPressed, isNull);
    await _disposeWidget(tester);
  });
}
