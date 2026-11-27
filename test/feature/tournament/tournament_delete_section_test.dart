@Timeout(Duration(seconds: 10))
library;

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/app/localization_delegates.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_delete_section.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

class _RecordingTournamentPageBloc extends MockBloc<TournamentPageEvent, TournamentPageState>
    implements TournamentPageBloc {
  final added = <TournamentPageEvent>[];

  @override
  void add(TournamentPageEvent event) => added.add(event);
}

const _deleteButton = 'Удалить турнир';
const _confirmText = 'Турнир «Кубок города» будет удалён без возможности восстановления. '
    'Вместе с ним пропадут участники, рассадки, игры и результаты.';

Future<_RecordingTournamentPageBloc> _pumpSection(WidgetTester tester, TournamentPageState state) async {
  final bloc = _RecordingTournamentPageBloc();
  whenListen(bloc, const Stream<TournamentPageState>.empty(), initialState: state);
  addTearDown(bloc.close);

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(isMobile: false),
      locale: const Locale('ru'),
      localizationsDelegates: appLocalizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<TournamentPageBloc>.value(
        value: bloc,
        child: const Scaffold(body: TournamentDeleteSection()),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return bloc;
}

void main() {
  testWidgets('no delete button when the backend did not allow deletion', (tester) async {
    await _pumpSection(tester, const TournamentPageState(isMyTournament: true, tournamentName: 'Кубок города'));

    expect(find.text(_deleteButton), findsNothing);
  });

  testWidgets('confirmed deletion names the tournament and sends the delete event', (tester) async {
    final bloc = await _pumpSection(
      tester,
      const TournamentPageState(isMyTournament: true, canDeleteTournament: true, tournamentName: 'Кубок города'),
    );

    await tester.tap(find.text(_deleteButton));
    await tester.pumpAndSettle();
    expect(find.text(_confirmText), findsOneWidget);

    await tester.tap(find.text('Да'));
    await tester.pumpAndSettle();

    expect(bloc.added, [const TournamentPageEvent.deleteTournament()]);
  });

  testWidgets('declined confirmation deletes nothing', (tester) async {
    final bloc = await _pumpSection(
      tester,
      const TournamentPageState(isMyTournament: true, canDeleteTournament: true, tournamentName: 'Кубок города'),
    );

    await tester.tap(find.text(_deleteButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Нет'));
    await tester.pumpAndSettle();

    expect(find.text(_confirmText), findsNothing);
    expect(bloc.added, isEmpty);
  });
}
