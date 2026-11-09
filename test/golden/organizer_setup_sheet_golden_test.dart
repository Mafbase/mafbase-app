import 'golden_utils.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_sheet.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_state.dart';

class _MockOrganizerSetupBloc extends MockBloc<OrganizerSetupEvent, OrganizerSetupState>
    implements OrganizerSetupBloc {}

/// Свой Navigator у каждого сценария держит модальный лист внутри рамки устройства.
Widget _sheetScenario(OrganizerSetupState state) {
  final bloc = _MockOrganizerSetupBloc();
  whenListen(bloc, const Stream<OrganizerSetupState>.empty(), initialState: state);
  addTearDown(bloc.close);

  return adaptiveThemedWidget(
    Navigator(
      onGenerateRoute: (_) => MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          body: _SheetOpener(open: (context) => OrganizerSetupSheet.showWithBloc(context, (_) => bloc)),
        ),
      ),
    ),
  );
}

class _SheetOpener extends StatefulWidget {
  final void Function(BuildContext context) open;

  const _SheetOpener({required this.open});

  @override
  State<_SheetOpener> createState() => _SheetOpenerState();
}

class _SheetOpenerState extends State<_SheetOpener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.open(context));
  }

  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}

Future<void> _matchGolden(WidgetTester tester, OrganizerSetupState state, String name) async {
  final builder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: appDevices)
    ..addScenario(widget: _sheetScenario(state), name: name);

  await tester.pumpDeviceBuilder(builder, wrapper: ruAppWrapper());
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  await screenMatchesGolden(
    tester,
    goldenName('organizer_checklist/$name'),
    customPump: (t) => t.pump(),
  );
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('OrganizerSetupSheet golden tests', () {
    testGoldens('step 1: is the tournament on GoMafia', (tester) async {
      await _matchGolden(tester, const OrganizerSetupState(), 'setup_fsm');
    });

    testGoldens('step 1: link to the GoMafia tournament', (tester) async {
      await _matchGolden(tester, const OrganizerSetupState(step: OrganizerSetupStep.gomafiaUrl), 'setup_gomafia_url');
    });

    testGoldens('step 2: streaming with overlays', (tester) async {
      await _matchGolden(
        tester,
        const OrganizerSetupState(step: OrganizerSetupStep.translation, isGomafiaUrlSaved: true),
        'setup_translation',
      );
    });

    testGoldens('end of an FSM tournament: import from GoMafia', (tester) async {
      await _matchGolden(
        tester,
        const OrganizerSetupState(step: OrganizerSetupStep.done, isGomafiaUrlSaved: true),
        'setup_done_fsm',
      );
    });

    testGoldens('end without GoMafia: open the checklist', (tester) async {
      await _matchGolden(tester, const OrganizerSetupState(step: OrganizerSetupStep.done), 'setup_done');
    });
  });
}
