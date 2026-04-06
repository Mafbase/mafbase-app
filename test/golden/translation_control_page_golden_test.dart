import 'golden_utils.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_event.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_page.dart';

class MockTranslationControlBloc
    extends MockBloc<TranslationControlEvent, TranslationContentState>
    implements TranslationControlBloc {}

const _roles = [
  PlayerRole.citizen,
  PlayerRole.maf,
  PlayerRole.don,
  PlayerRole.sheriff,
  PlayerRole.citizen,
  PlayerRole.maf,
  PlayerRole.citizen,
  PlayerRole.citizen,
  PlayerRole.citizen,
  PlayerRole.citizen,
];

const _statuses = [
  PlayerStatus.alive,
  PlayerStatus.killed,
  PlayerStatus.alive,
  PlayerStatus.voted,
  PlayerStatus.alive,
  PlayerStatus.deleted,
  PlayerStatus.alive,
  PlayerStatus.alive,
  PlayerStatus.alive,
  PlayerStatus.alive,
];

const _nicknames = [
  'Белый Волк',
  'Тень',
  'Рыцарь',
  'Ангел',
  'Феникс',
  'Гром',
  'Вороной',
  'Клинок',
  'Шторм',
  'Алмаз',
];

const _images = ['', '', '', '', '', '', '', '', '', ''];

const _dataState = TranslationContentState(
  roles: _roles,
  statuses: _statuses,
  images: _images,
  nicknames: _nicknames,
  game: 2,
  totalGames: 5,
);

MockTranslationControlBloc _createMockBloc(TranslationContentState state) {
  final bloc = MockTranslationControlBloc();
  whenListen(
    bloc,
    const Stream<TranslationContentState>.empty(),
    initialState: state,
  );
  return bloc;
}

Widget _pageWidget(TranslationControlBloc bloc) => themedWidget(
      BlocProvider<TranslationControlBloc>.value(
        value: bloc,
        child: const TranslationControlPage(),
      ),
    );

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('TranslationControlPage golden tests', () {
    testGoldens('empty state', (tester) async {
      final bloc = _createMockBloc(const TranslationContentState());
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'empty');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('translation_control/empty'),
        customPump: (t) => t.pump(),
      );
    });

    testGoldens('data state with mixed statuses', (tester) async {
      final bloc = _createMockBloc(_dataState);
      addTearDown(bloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: appDevices)
        ..addScenario(widget: _pageWidget(bloc), name: 'data');

      await tester.pumpDeviceBuilder(builder, wrapper: appWrapper());
      await screenMatchesGolden(
        tester,
        goldenName('translation_control/data'),
        customPump: (t) => t.pump(),
      );
    });
  });
}
