import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/notification_coverage_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_repository.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_state.dart';

import 'notification_coverage_fixtures.dart';

const _tournamentId = 7;

class _FakeRepository implements OrganizerChecklistRepository {
  final loads = <Future<NotificationCoverageModel> Function()>[];

  @override
  Future<NotificationCoverageModel> getNotificationCoverage(int tournamentId) {
    expect(tournamentId, _tournamentId);
    return loads.removeAt(0)();
  }

  @override
  Future<OrganizerChecklistModel> getChecklist(int tournamentId) => throw UnimplementedError();

  @override
  Future<OrganizerChecklistModel> setDismissed(
    int tournamentId, {
    required List<ChecklistKey> keys,
    required bool dismissed,
  }) =>
      throw UnimplementedError();
}

void main() {
  late _FakeRepository repository;

  NotificationCoverageBloc buildBloc() => NotificationCoverageBloc(repository: repository, tournamentId: _tournamentId);

  setUp(() => repository = _FakeRepository());

  blocTest<NotificationCoverageBloc, NotificationCoverageState>(
    'shows the coverage from backend',
    setUp: () => repository.loads.add(() async => fsmCoverage()),
    build: buildBloc,
    act: (bloc) => bloc.add(const NotificationCoverageEventLoad()),
    expect: () => [
      const NotificationCoverageState(),
      NotificationCoverageState(coverage: fsmCoverage()),
      NotificationCoverageState(coverage: fsmCoverage(), isLoading: false),
    ],
  );

  blocTest<NotificationCoverageBloc, NotificationCoverageState>(
    'a failed load stops the spinner and leaves the error to BlocObserver',
    setUp: () => repository.loads.add(() async => throw Exception('backend is down')),
    build: buildBloc,
    act: (bloc) => bloc.add(const NotificationCoverageEventLoad()),
    expect: () => [const NotificationCoverageState(), const NotificationCoverageState(isLoading: false)],
    errors: () => [isA<Exception>()],
  );

  blocTest<NotificationCoverageBloc, NotificationCoverageState>(
    'a reload keeps the shown coverage until the new one arrives',
    setUp: () => repository.loads
      ..add(() async => notFsmCoverage())
      ..add(() async => fsmCoverage()),
    build: buildBloc,
    act: (bloc) async {
      bloc.add(const NotificationCoverageEventLoad());
      await Future<void>.delayed(Duration.zero);
      bloc.add(const NotificationCoverageEventLoad());
    },
    expect: () => [
      const NotificationCoverageState(),
      NotificationCoverageState(coverage: notFsmCoverage()),
      NotificationCoverageState(coverage: notFsmCoverage(), isLoading: false),
      NotificationCoverageState(coverage: notFsmCoverage()),
      NotificationCoverageState(coverage: fsmCoverage()),
      NotificationCoverageState(coverage: fsmCoverage(), isLoading: false),
    ],
  );

  blocTest<NotificationCoverageBloc, NotificationCoverageState>(
    'the answer of an outdated load is dropped',
    setUp: () {
      final outdated = Completer<NotificationCoverageModel>();
      repository.loads
        ..add(() => outdated.future)
        ..add(() async {
          outdated.complete(notFsmCoverage());
          return fsmCoverage();
        });
    },
    build: buildBloc,
    act: (bloc) async {
      bloc.add(const NotificationCoverageEventLoad());
      await Future<void>.delayed(Duration.zero);
      bloc.add(const NotificationCoverageEventLoad());
    },
    expect: () => [
      const NotificationCoverageState(),
      NotificationCoverageState(coverage: fsmCoverage()),
      NotificationCoverageState(coverage: fsmCoverage(), isLoading: false),
    ],
  );
}
