import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_translation_answer.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';

import 'organizer_checklist_fixtures.dart';

Matcher _selectsMethod(ChecklistStreamMethod method) =>
    isA<OrganizerChecklistEventSelectStreamMethod>().having((event) => event.method, 'method', method);

final _hidesTranslationGroup = isA<OrganizerChecklistEventSetDismissed>()
    .having((event) => event.keys, 'keys', ChecklistGroup.translation.keys)
    .having((event) => event.dismissed, 'dismissed', true);

void main() {
  late RecordingTournamentEditRepository repository;
  late RecordingTournamentPageBloc tournamentBloc;
  late RecordingOrganizerChecklistBloc checklistBloc;

  OrganizerSetupBloc buildBloc() => OrganizerSetupBloc(
        repository: repository,
        tournamentBloc: tournamentBloc,
        checklistBloc: checklistBloc,
        tournamentId: 1,
      );

  setUp(() {
    repository = RecordingTournamentEditRepository();
    tournamentBloc = RecordingTournamentPageBloc(ownerTournament);
    checklistBloc = RecordingOrganizerChecklistBloc(const OrganizerChecklistState());
  });

  tearDown(() async {
    await tournamentBloc.close();
    await checklistBloc.close();
  });

  group('GoMafia', () {
    blocTest<OrganizerSetupBloc, OrganizerSetupState>(
      '"yes" asks for the link, "no" goes straight to the streaming question',
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const OrganizerSetupEventFsmAnswered(isFsm: true));
        await Future<void>.delayed(Duration.zero);
        bloc.add(const OrganizerSetupEventBack());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const OrganizerSetupEventFsmAnswered(isFsm: false));
      },
      expect: () => const [
        OrganizerSetupState(step: OrganizerSetupStep.gomafiaUrl),
        OrganizerSetupState(),
        OrganizerSetupState(step: OrganizerSetupStep.translation),
      ],
      verify: (_) => expect(repository.savedGomafiaUrls, isEmpty),
    );

    blocTest<OrganizerSetupBloc, OrganizerSetupState>(
      'saves the link without the extra parts and reloads the tournament page for the FSM flag',
      build: buildBloc,
      seed: () => const OrganizerSetupState(step: OrganizerSetupStep.gomafiaUrl),
      act: (bloc) =>
          bloc.add(const OrganizerSetupEventGomafiaUrlSubmitted(' https://gomafia.pro/tournament/42/tables')),
      expect: () => const [
        OrganizerSetupState(step: OrganizerSetupStep.gomafiaUrl, isSaving: true),
        OrganizerSetupState(step: OrganizerSetupStep.translation, isSaving: true, isGomafiaUrlSaved: true),
        OrganizerSetupState(step: OrganizerSetupStep.translation, isGomafiaUrlSaved: true),
      ],
      verify: (_) {
        expect(repository.savedGomafiaUrls, ['https://gomafia.pro/tournament/42']);
        expect(tournamentBloc.added, [const TournamentPageEvent.pageOpened()]);
      },
    );

    blocTest<OrganizerSetupBloc, OrganizerSetupState>(
      'a link that is not a GoMafia tournament is not sent',
      build: buildBloc,
      seed: () => const OrganizerSetupState(step: OrganizerSetupStep.gomafiaUrl),
      act: (bloc) => bloc.add(const OrganizerSetupEventGomafiaUrlSubmitted('https://gomafia.pro/user/42')),
      expect: () => const <OrganizerSetupState>[],
      verify: (_) => expect(repository.savedGomafiaUrls, isEmpty),
    );

    blocTest<OrganizerSetupBloc, OrganizerSetupState>(
      'failed saving keeps the link step, the error goes to BlocObserver',
      setUp: () => repository.error = Exception('backend is down'),
      build: buildBloc,
      seed: () => const OrganizerSetupState(step: OrganizerSetupStep.gomafiaUrl),
      act: (bloc) => bloc.add(const OrganizerSetupEventGomafiaUrlSubmitted('https://gomafia.pro/tournament/42')),
      expect: () => const [
        OrganizerSetupState(step: OrganizerSetupStep.gomafiaUrl, isSaving: true),
        OrganizerSetupState(step: OrganizerSetupStep.gomafiaUrl),
      ],
      errors: () => [isA<Exception>()],
      verify: (_) => expect(tournamentBloc.added, isEmpty),
    );

    blocTest<OrganizerSetupBloc, OrganizerSetupState>(
      'a second tap while saving makes no second request',
      setUp: () => repository.pending = Completer<void>(),
      build: buildBloc,
      seed: () => const OrganizerSetupState(step: OrganizerSetupStep.gomafiaUrl),
      act: (bloc) async {
        bloc
          ..add(const OrganizerSetupEventGomafiaUrlSubmitted('https://gomafia.pro/tournament/42'))
          ..add(const OrganizerSetupEventGomafiaUrlSubmitted('https://gomafia.pro/tournament/42'));
        await Future<void>.delayed(Duration.zero);
        repository.pending!.complete();
      },
      verify: (_) => expect(repository.savedGomafiaUrls, hasLength(1)),
    );

    test('closing the wizard while saving still reloads the tournament page', () async {
      repository.pending = Completer<void>();
      final bloc = buildBloc()..add(const OrganizerSetupEventFsmAnswered(isFsm: true));
      await Future<void>.delayed(Duration.zero);
      bloc.add(const OrganizerSetupEventGomafiaUrlSubmitted('https://gomafia.pro/tournament/42'));
      await Future<void>.delayed(Duration.zero);

      final closed = bloc.close();
      repository.pending!.complete();
      await closed;

      expect(repository.savedGomafiaUrls, ['https://gomafia.pro/tournament/42']);
      expect(tournamentBloc.added, [const TournamentPageEvent.pageOpened()]);
    });
  });

  group('streaming', () {
    final cases = <OrganizerSetupTranslationAnswer, List<Matcher>>{
      OrganizerSetupTranslationAnswer.obs: [_selectsMethod(ChecklistStreamMethod.obs)],
      OrganizerSetupTranslationAnswer.phone: [_selectsMethod(ChecklistStreamMethod.phone)],
      OrganizerSetupTranslationAnswer.none: [_hidesTranslationGroup],
      OrganizerSetupTranslationAnswer.unknown: [],
    };

    for (final MapEntry(key: answer, value: events) in cases.entries) {
      blocTest<OrganizerSetupBloc, OrganizerSetupState>(
        '"${answer.name}" sends ${events.isEmpty ? 'nothing' : 'its event'} to the checklist and finishes',
        build: buildBloc,
        seed: () => const OrganizerSetupState(step: OrganizerSetupStep.translation),
        act: (bloc) => bloc.add(OrganizerSetupEventTranslationAnswered(answer)),
        expect: () => const [OrganizerSetupState(step: OrganizerSetupStep.done)],
        verify: (_) => expect(checklistBloc.added, events),
      );
    }

    test('"no" hides all six items of the streaming group', () {
      final event = OrganizerSetupTranslationAnswer.none.checklistEvent;

      expect(event, isA<OrganizerChecklistEventSetDismissed>());
      expect((event! as OrganizerChecklistEventSetDismissed).keys, [
        ChecklistKey.streamMethod,
        ChecklistKey.translationBilling,
        ChecklistKey.obsWidget,
        ChecklistKey.obsScenes,
        ChecklistKey.phoneStream,
        ChecklistKey.phoneOperator,
      ]);
    });
  });
}
