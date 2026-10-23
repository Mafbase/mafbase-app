import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/widgets/translation_control_obs_block.dart';

const _dayRow = 0;
const _nightRow = 1;
const _breakRow = 2;

final _readyObs = ObsState(
  connected: true,
  controlLevel: 4,
  scenes: ['Стол', 'Ночной план', 'Заставка'],
  currentScene: 'Стол',
);

Widget _app(Widget child) => MaterialApp(
      theme: AppTheme.light(isMobile: false),
      locale: const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );

Future<void> _pumpBlock(
  WidgetTester tester, {
  required ObsState? obs,
  required ObsSceneMapping? mapping,
  ValueChanged<ObsSceneMapping>? onChanged,
}) async {
  await tester.pumpWidget(
    _app(TranslationControlObsBlock(obs: obs, mapping: mapping, onMappingChanged: onChanged ?? (_) {})),
  );
  await tester.pumpAndSettle();
}

Finder _dropdown(int row) => find.byType(DropdownButton<String>).at(row);

String? _selected(WidgetTester tester, int row) => tester.widget<DropdownButton<String>>(_dropdown(row)).value;

Future<void> _select(WidgetTester tester, {required int row, required String item}) async {
  await tester.tap(_dropdown(row));
  await tester.pumpAndSettle();
  // DropdownButton держит все пункты в IndexedStack кнопки, пункт открытого меню — последний в дереве.
  await tester.tap(find.text(item).last);
  await tester.pumpAndSettle();
}

Future<void> _toggle(WidgetTester tester) async {
  await tester.tap(find.text('OBS'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('sends the whole mapping with the changed phase', (tester) async {
    final sent = <ObsSceneMapping>[];
    await _pumpBlock(tester, obs: _readyObs, mapping: ObsSceneMapping(day: 'Стол'), onChanged: sent.add);
    await _toggle(tester);

    await _select(tester, row: _breakRow, item: 'Заставка');

    expect(sent, [ObsSceneMapping(day: 'Стол', breakPhase: 'Заставка')]);
  });

  testWidgets('"do not switch" clears the phase and keeps the others', (tester) async {
    final sent = <ObsSceneMapping>[];
    await _pumpBlock(
      tester,
      obs: _readyObs,
      mapping: ObsSceneMapping(day: 'Стол', night: 'Старая ночь'),
      onChanged: sent.add,
    );
    await _toggle(tester);

    await _select(tester, row: _dayRow, item: 'Не переключать');

    expect(sent.single.hasDay(), isFalse);
    expect(sent.single.night, 'Старая ночь');
    expect(sent.single.hasBreakPhase(), isFalse);
  });

  testWidgets('keeps a saved scene that is missing in OBS as a separate item', (tester) async {
    await _pumpBlock(tester, obs: _readyObs, mapping: ObsSceneMapping(night: 'Старая ночь'));
    await _toggle(tester);

    expect(_selected(tester, _nightRow), 'Старая ночь');
    expect(find.text('Старая ночь (нет в OBS)'), findsOneWidget);
  });

  testWidgets('is collapsed when configured and expands when OBS disconnects', (tester) async {
    final mapping = ObsSceneMapping(day: 'Стол');
    await _pumpBlock(tester, obs: _readyObs, mapping: mapping);
    expect(find.byType(DropdownButton<String>), findsNothing);

    await _pumpBlock(tester, obs: ObsState(connected: false), mapping: mapping);
    expect(find.text('Добавьте ссылку для встраивания в OBS как источник «Браузер»'), findsOneWidget);
    expect(_selected(tester, _dayRow), 'Стол');
  });

  testWidgets('is expanded when connected but nothing is selected', (tester) async {
    await _pumpBlock(tester, obs: _readyObs, mapping: null);

    expect(find.text('В эфире: Стол'), findsOneWidget);
    expect(_selected(tester, _dayRow), '');
  });

  testWidgets('shows the no-permission state below the advanced control level', (tester) async {
    await _pumpBlock(tester, obs: ObsState(connected: true, controlLevel: 3, scenes: ['Стол']), mapping: null);

    expect(find.text('Нет прав на переключение сцен'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsNothing);
  });

  testWidgets('reflects a mapping pushed from outside', (tester) async {
    await _pumpBlock(tester, obs: _readyObs, mapping: null);
    expect(_selected(tester, _nightRow), '');

    await _pumpBlock(tester, obs: _readyObs, mapping: ObsSceneMapping(night: 'Ночной план'));
    expect(_selected(tester, _nightRow), 'Ночной план');
  });
}
