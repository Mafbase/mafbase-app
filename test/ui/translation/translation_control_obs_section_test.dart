@Timeout(Duration(seconds: 10))
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/widgets/translation_control_obs_section.dart';

const _dayRow = 0;
const _nightRow = 1;
const _breakRow = 2;

const _disconnectedHint = 'Добавьте ссылку для встраивания в OBS как источник «Браузер»';

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

Future<void> _pumpSection(
  WidgetTester tester, {
  required ObsState? obs,
  required ObsSceneMapping? mapping,
  ValueChanged<ObsSceneMapping>? onChanged,
}) async {
  await tester.pumpWidget(
    _app(
      TranslationControlObsSection(
        obs: obs,
        mapping: mapping,
        onMappingChanged: onChanged ?? (_) {},
        rowBuilder: (obsHeader) => Row(children: [const Expanded(child: SizedBox(height: 52)), obsHeader]),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _toggle(WidgetTester tester) async {
  await tester.tap(find.text('OBS'));
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

void main() {
  testWidgets('is collapsed by default in every OBS state', (tester) async {
    final cases = <(ObsState?, ObsSceneMapping?)>[
      (null, null),
      (ObsState(connected: false), ObsSceneMapping(day: 'Стол')),
      (ObsState(connected: true, controlLevel: 2, scenes: ['Стол']), null),
      (_readyObs, null),
      (_readyObs, ObsSceneMapping(day: 'Стол')),
    ];
    for (final (obs, mapping) in cases) {
      await tester.pumpWidget(const SizedBox());
      await _pumpSection(tester, obs: obs, mapping: mapping);

      expect(find.text('OBS'), findsOneWidget);
      expect(find.byType(DropdownButton<String>), findsNothing);
      expect(find.text(_disconnectedHint), findsNothing);
    }
  });

  testWidgets('keeps the panel open while the OBS status changes', (tester) async {
    await _pumpSection(tester, obs: _readyObs, mapping: null);
    await _toggle(tester);
    expect(find.text('В эфире: Стол'), findsOneWidget);

    await _pumpSection(tester, obs: ObsState(connected: false), mapping: ObsSceneMapping(day: 'Стол'));
    expect(find.text(_disconnectedHint), findsOneWidget);
    expect(_selected(tester, _dayRow), 'Стол');

    await _toggle(tester);
    expect(find.text(_disconnectedHint), findsNothing);
  });

  testWidgets('sends the whole mapping with the changed phase', (tester) async {
    final sent = <ObsSceneMapping>[];
    await _pumpSection(tester, obs: _readyObs, mapping: ObsSceneMapping(day: 'Стол'), onChanged: sent.add);
    await _toggle(tester);

    await _select(tester, row: _breakRow, item: 'Заставка');

    expect(sent, [ObsSceneMapping(day: 'Стол', breakPhase: 'Заставка')]);
  });

  testWidgets('"do not switch" clears the phase and keeps the others', (tester) async {
    final sent = <ObsSceneMapping>[];
    await _pumpSection(
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
    await _pumpSection(tester, obs: _readyObs, mapping: ObsSceneMapping(night: 'Старая ночь'));
    await _toggle(tester);

    expect(_selected(tester, _nightRow), 'Старая ночь');
    expect(find.text('Старая ночь (нет в OBS)'), findsOneWidget);
  });

  testWidgets('shows the permission hint below the advanced control level', (tester) async {
    await _pumpSection(tester, obs: ObsState(connected: true, controlLevel: 3, scenes: ['Стол']), mapping: null);
    await _toggle(tester);

    expect(find.textContaining('расширенный или полный доступ к OBS'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsNothing);
  });

  testWidgets('reflects a mapping pushed from outside', (tester) async {
    await _pumpSection(tester, obs: _readyObs, mapping: null);
    await _toggle(tester);
    expect(_selected(tester, _nightRow), '');

    await _pumpSection(tester, obs: _readyObs, mapping: ObsSceneMapping(night: 'Ночной план'));
    expect(_selected(tester, _nightRow), 'Ночной план');
  });

  testWidgets('shows the status text in the header only on wide screens', (tester) async {
    addTearDown(tester.view.reset);
    tester.view.devicePixelRatio = 1;

    tester.view.physicalSize = const Size(390, 844);
    await _pumpSection(tester, obs: _readyObs, mapping: null);
    expect(find.text('Подключён'), findsNothing);

    tester.view.physicalSize = const Size(1280, 900);
    await _pumpSection(tester, obs: _readyObs, mapping: null);
    expect(find.text('Подключён'), findsOneWidget);
  });
}
