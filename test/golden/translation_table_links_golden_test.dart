import 'golden_utils.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/domain/models/translation_key_model.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/translation_panel.dart';
import 'package:seating_generator_web/feature/translation_links/translation_table_links.dart';
import 'package:seating_generator_web/feature/translation_links/widgets/translation_table_links_row.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/utils.dart';

class _MockSeatingPageBloc extends MockBloc<SeatingPageEvent, SeatingPageState> implements SeatingPageBloc {}

class _FakeTranslationRepository implements TranslationRepository {
  @override
  Future<TranslationKeyModel> getKey({required int tournamentId}) => Future.value(
        const TranslationKeyModel(
          key: 'tournament-key',
          designs: [DesignModel(designKey: 'mafbase', title: 'Mafbase', preview: '')],
        ),
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeRepositoryFactory implements RepositoryFactory {
  @override
  final TranslationRepository translationRepository = _FakeTranslationRepository();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeDependencyScope implements DependencyScope {
  @override
  final RepositoryFactory repositoryFactory = _FakeRepositoryFactory();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const _dialogLight = Device(name: 'light', size: Size(560, 200));
const _dialogDark = Device(name: 'dark', size: Size(560, 200), brightness: Brightness.dark);
const _sidebarLight = Device(name: 'light', size: Size(300, 560));
const _sidebarDark = Device(name: 'dark', size: Size(300, 560), brightness: Brightness.dark);

/// Inter из google_fonts в тестах не грузится, поэтому панель получает загруженный Roboto тех же размеров.
TextStyle _testFont({double? fontSize, FontWeight? fontWeight, Color? color}) =>
    TextStyle(fontFamily: 'Roboto', fontSize: fontSize, fontWeight: fontWeight, color: color);

Widget _clubRows() => themedWidget(
      Builder(
        builder: (context) {
          final theme = context.theme;
          return ColoredBox(
            color: theme.background2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 8,
                children: [
                  for (var table = 1; table <= 2; table++)
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 4, 4, 4),
                      decoration: BoxDecoration(
                        color: theme.background1,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: theme.borderColor.withValues(alpha: 0.5)),
                      ),
                      child: TranslationTableLinksRow(
                        links: TranslationTableLinks.club(clubId: 7, table: table, key: 'club-key'),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );

Widget _sidebarPanel(SeatingPageBloc seatingBloc) => themedWidget(
      DependencyScopeWidget(
        scope: _FakeDependencyScope(),
        child: BlocProvider<SeatingPageBloc>.value(
          value: seatingBloc,
          child: Builder(
            builder: (context) => ColoredBox(
              color: context.theme.darkBlueColor,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: TranslationPanel(tournamentId: 1, tablesCount: 3, font: _testFont),
                ),
              ),
            ),
          ),
        ),
      ),
    );

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('Translation links golden tests', () {
    testGoldens('table rows in the club dialog', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: const [_dialogLight, _dialogDark])
        ..addScenario(widget: _clubRows(), name: 'club_rows');

      await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
      await screenMatchesGolden(tester, goldenName('translation_links/club_rows'), customPump: (t) => t.pump());
    });

    testGoldens('tournament panel without seating', (tester) async {
      final seatingBloc = _MockSeatingPageBloc();
      whenListen(
        seatingBloc,
        const Stream<SeatingPageState>.empty(),
        initialState: const SeatingPageState(isLoading: false),
      );
      addTearDown(seatingBloc.close);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: const [_sidebarLight, _sidebarDark])
        ..addScenario(widget: _sidebarPanel(seatingBloc), name: 'panel');

      await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
      await tester.pump();
      await screenMatchesGolden(tester, goldenName('translation_links/panel'), customPump: (t) => t.pump());
    });
  });
}
