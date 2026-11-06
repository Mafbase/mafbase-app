import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/feature/organizer_checklist/data/checklist_banner_storage.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/notification_coverage_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_repository.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_state.dart';

const _tournamentId = 7;
const _afterDebounce = Duration(milliseconds: 400);

OrganizerChecklistModel _checklist({Set<ChecklistKey> dismissed = const {}, Set<ChecklistKey> done = const {}}) =>
    OrganizerChecklistModel(
      isFsm: false,
      items: [
        for (final key in ChecklistKey.values)
          ChecklistItemModel(
            key: key,
            status: dismissed.contains(key)
                ? ChecklistStatus.dismissed
                : done.contains(key)
                    ? ChecklistStatus.done
                    : ChecklistStatus.todo,
          ),
      ],
    );

final _initial = _checklist();
final _withGamesCount = _checklist(done: {ChecklistKey.gamesCount});
final _billingHidden = _checklist(dismissed: {ChecklistKey.billing});
final _phoneHidden = _checklist(dismissed: {ChecklistKey.phoneStream, ChecklistKey.phoneOperator});
final _obsChosen = _checklist(
  dismissed: {ChecklistKey.phoneStream, ChecklistKey.phoneOperator},
  done: {ChecklistKey.streamMethod},
);
final _bothMethodsHidden = _checklist(
  dismissed: {ChecklistKey.obsWidget, ChecklistKey.obsScenes, ChecklistKey.phoneStream, ChecklistKey.phoneOperator},
  done: {ChecklistKey.streamMethod},
);
final _phoneChosen = _checklist(
  dismissed: {ChecklistKey.obsWidget, ChecklistKey.obsScenes},
  done: {ChecklistKey.streamMethod},
);

class _FakeRepository implements OrganizerChecklistRepository {
  final loads = <Future<OrganizerChecklistModel> Function()>[];
  final dismissResults = <OrganizerChecklistModel>[];
  final dismissCalls = <String>[];
  var loadCalls = 0;

  @override
  Future<OrganizerChecklistModel> getChecklist(int tournamentId) {
    expect(tournamentId, _tournamentId);
    loadCalls++;
    return loads.removeAt(0)();
  }

  @override
  Future<OrganizerChecklistModel> setDismissed(
    int tournamentId, {
    required List<ChecklistKey> keys,
    required bool dismissed,
  }) async {
    expect(tournamentId, _tournamentId);
    dismissCalls.add('${keys.map((key) => key.name).join(', ')}: $dismissed');
    return dismissResults.removeAt(0);
  }

  @override
  Future<NotificationCoverageModel> getNotificationCoverage(int tournamentId) => throw UnimplementedError();
}

class _FakeBannerStorage implements ChecklistBannerStorage {
  final hidden = <int>{};

  @override
  Future<bool> isHidden(int tournamentId) async => hidden.contains(tournamentId);

  @override
  Future<void> hide(int tournamentId) async => hidden.add(tournamentId);
}

class _RecordingObserver extends BlocObserver {
  final errors = <Object>[];

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    errors.add(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  late _FakeRepository repository;
  late _FakeBannerStorage storage;
  late _RecordingObserver observer;
  late BlocObserver previousObserver;

  OrganizerChecklistBloc buildBloc() => OrganizerChecklistBloc(
        repository: repository,
        bannerStorage: storage,
        tournamentId: _tournamentId,
      );

  setUp(() {
    repository = _FakeRepository();
    storage = _FakeBannerStorage();
    observer = _RecordingObserver();
    previousObserver = Bloc.observer;
    Bloc.observer = observer;
  });

  tearDown(() => Bloc.observer = previousObserver);

  group('load', () {
    blocTest<OrganizerChecklistBloc, OrganizerChecklistState>(
      'shows the checklist from backend',
      setUp: () => repository.loads.add(() async => _initial),
      build: buildBloc,
      act: (bloc) => bloc.add(const OrganizerChecklistEventLoad()),
      wait: _afterDebounce,
      expect: () => [OrganizerChecklistState(checklist: _initial)],
    );

    blocTest<OrganizerChecklistBloc, OrganizerChecklistState>(
      'error only sets the flag and never reaches BlocObserver, so no dialog is shown',
      setUp: () => repository.loads.add(() async => throw Exception('backend is down')),
      build: buildBloc,
      act: (bloc) => bloc.add(const OrganizerChecklistEventLoad()),
      wait: _afterDebounce,
      expect: () => [const OrganizerChecklistState(hasError: true)],
      verify: (_) => expect(observer.errors, isEmpty),
    );

    blocTest<OrganizerChecklistBloc, OrganizerChecklistState>(
      'failed reload hides the previously loaded checklist',
      setUp: () => repository.loads.add(() async => throw Exception('backend is down')),
      build: buildBloc,
      seed: () => OrganizerChecklistState(checklist: _initial),
      act: (bloc) => bloc.add(const OrganizerChecklistEventLoad()),
      wait: _afterDebounce,
      expect: () => [const OrganizerChecklistState(hasError: true)],
      verify: (_) => expect(observer.errors, isEmpty),
    );

    blocTest<OrganizerChecklistBloc, OrganizerChecklistState>(
      'reload replaces the checklist and clears the error',
      setUp: () => repository.loads.addAll([() async => _initial, () async => _withGamesCount]),
      build: buildBloc,
      seed: () => const OrganizerChecklistState(hasError: true),
      act: (bloc) async {
        bloc.add(const OrganizerChecklistEventLoad());
        await Future<void>.delayed(_afterDebounce);
        bloc.add(const OrganizerChecklistEventLoad());
      },
      wait: _afterDebounce,
      expect: () => [
        OrganizerChecklistState(checklist: _initial),
        OrganizerChecklistState(checklist: _withGamesCount),
      ],
    );

    blocTest<OrganizerChecklistBloc, OrganizerChecklistState>(
      'a burst of reloads makes a single request',
      setUp: () => repository.loads.add(() async => _initial),
      build: buildBloc,
      act: (bloc) => bloc
        ..add(const OrganizerChecklistEventLoad())
        ..add(const OrganizerChecklistEventLoad())
        ..add(const OrganizerChecklistEventLoad()),
      wait: _afterDebounce,
      expect: () => [OrganizerChecklistState(checklist: _initial)],
      verify: (_) => expect(repository.loadCalls, 1),
    );
  });

  group('dismiss', () {
    blocTest<OrganizerChecklistBloc, OrganizerChecklistState>(
      'hiding an item shows the recalculated checklist from the response',
      setUp: () => repository.dismissResults.add(_billingHidden),
      build: buildBloc,
      seed: () => OrganizerChecklistState(checklist: _initial),
      act: (bloc) => bloc.add(
        const OrganizerChecklistEventSetDismissed(keys: [ChecklistKey.billing], dismissed: true),
      ),
      expect: () => [
        OrganizerChecklistState(checklist: _initial, isUpdating: true),
        OrganizerChecklistState(checklist: _billingHidden, isUpdating: true),
        OrganizerChecklistState(checklist: _billingHidden),
      ],
      verify: (_) => expect(repository.dismissCalls, ['billing: true']),
    );

    blocTest<OrganizerChecklistBloc, OrganizerChecklistState>(
      'restoring an item returns it to its group',
      setUp: () => repository.dismissResults.add(_initial),
      build: buildBloc,
      seed: () => OrganizerChecklistState(checklist: _billingHidden),
      act: (bloc) => bloc.add(
        const OrganizerChecklistEventSetDismissed(keys: [ChecklistKey.billing], dismissed: false),
      ),
      expect: () => [
        OrganizerChecklistState(checklist: _billingHidden, isUpdating: true),
        OrganizerChecklistState(checklist: _initial, isUpdating: true),
        OrganizerChecklistState(checklist: _initial),
      ],
      verify: (_) => expect(repository.dismissCalls, ['billing: false']),
    );

    blocTest<OrganizerChecklistBloc, OrganizerChecklistState>(
      'choosing OBS hides the phone items, then returns the OBS items',
      setUp: () => repository.dismissResults.addAll([_phoneHidden, _obsChosen]),
      build: buildBloc,
      seed: () => OrganizerChecklistState(checklist: _initial),
      act: (bloc) => bloc.add(const OrganizerChecklistEventSelectStreamMethod(ChecklistStreamMethod.obs)),
      expect: () => [
        OrganizerChecklistState(checklist: _initial, isUpdating: true),
        OrganizerChecklistState(checklist: _phoneHidden, isUpdating: true),
        OrganizerChecklistState(checklist: _obsChosen, isUpdating: true),
        OrganizerChecklistState(checklist: _obsChosen),
      ],
      verify: (_) =>
          expect(repository.dismissCalls, ['phoneStream, phoneOperator: true', 'obsWidget, obsScenes: false']),
    );

    blocTest<OrganizerChecklistBloc, OrganizerChecklistState>(
      'switching to the phone returns the phone items that the OBS choice hid',
      setUp: () => repository.dismissResults.addAll([_bothMethodsHidden, _phoneChosen]),
      build: buildBloc,
      seed: () => OrganizerChecklistState(checklist: _obsChosen),
      act: (bloc) => bloc.add(const OrganizerChecklistEventSelectStreamMethod(ChecklistStreamMethod.phone)),
      expect: () => [
        OrganizerChecklistState(checklist: _obsChosen, isUpdating: true),
        OrganizerChecklistState(checklist: _bothMethodsHidden, isUpdating: true),
        OrganizerChecklistState(checklist: _phoneChosen, isUpdating: true),
        OrganizerChecklistState(checklist: _phoneChosen),
      ],
      verify: (_) =>
          expect(repository.dismissCalls, ['obsWidget, obsScenes: true', 'phoneStream, phoneOperator: false']),
    );

    test('a load that started before a change does not overwrite its result', () async {
      final staleLoad = Completer<OrganizerChecklistModel>();
      repository.loads.add(() => staleLoad.future);
      repository.dismissResults.add(_billingHidden);
      final bloc = buildBloc();
      addTearDown(bloc.close);

      bloc.add(const OrganizerChecklistEventLoad());
      await Future<void>.delayed(_afterDebounce);
      expect(repository.loadCalls, 1);

      bloc.add(const OrganizerChecklistEventSetDismissed(keys: [ChecklistKey.billing], dismissed: true));
      await Future<void>.delayed(Duration.zero);
      staleLoad.complete(_initial);
      await Future<void>.delayed(Duration.zero);

      expect(bloc.state, OrganizerChecklistState(checklist: _billingHidden));
    });
  });

  group('banner', () {
    blocTest<OrganizerChecklistBloc, OrganizerChecklistState>(
      'closing the banner remembers it for this tournament',
      build: buildBloc,
      act: (bloc) => bloc.add(const OrganizerChecklistEventHideBanner()),
      expect: () => [const OrganizerChecklistState(isBannerHidden: true)],
      verify: (_) => expect(storage.hidden, {_tournamentId}),
    );

    blocTest<OrganizerChecklistBloc, OrganizerChecklistState>(
      'the flag closed earlier comes with the first load',
      setUp: () {
        storage.hidden.add(_tournamentId);
        repository.loads.add(() async => _initial);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const OrganizerChecklistEventLoad()),
      wait: _afterDebounce,
      expect: () => [OrganizerChecklistState(checklist: _initial, isBannerHidden: true)],
    );
  });
}
