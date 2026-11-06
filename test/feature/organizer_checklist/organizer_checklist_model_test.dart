import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

ChecklistItemModel _item(ChecklistKey key, ChecklistStatus status) => ChecklistItemModel(key: key, status: status);

OrganizerChecklistModel _withDismissed(Set<ChecklistKey> dismissed) => OrganizerChecklistModel(
      isFsm: false,
      items: [
        for (final key in ChecklistKey.values)
          _item(key, dismissed.contains(key) ? ChecklistStatus.dismissed : ChecklistStatus.todo),
      ],
    );

void main() {
  group('fromProto', () {
    test('maps statuses and optional counters and skips unknown keys', () {
      final model = OrganizerChecklistModel.fromProto(
        TournamentChecklistOut(
          isFsm: true,
          items: [
            ChecklistItem(
              key: ChecklistItemKey.checklistPlayers,
              status: ChecklistItemStatus.checklistWarning,
              current: 23,
            ),
            ChecklistItem(
              key: ChecklistItemKey.checklistNotifyCoverage,
              status: ChecklistItemStatus.checklistLocked,
              unavailable: true,
            ),
            ChecklistItem(key: ChecklistItemKey.unknownChecklistItemKey, status: ChecklistItemStatus.checklistTodo),
            ChecklistItem(
              key: ChecklistItemKey.checklistObsWidget,
              status: ChecklistItemStatus.checklistTodo,
              current: 0,
              total: 3,
            ),
            ChecklistItem(
              key: ChecklistItemKey.checklistObsScenes,
              status: ChecklistItemStatus.unknownChecklistItemStatus,
            ),
          ],
        ),
      );

      expect(model.isFsm, isTrue);
      expect(model.items, const [
        ChecklistItemModel(key: ChecklistKey.players, status: ChecklistStatus.warning, current: 23),
        ChecklistItemModel(key: ChecklistKey.notifyCoverage, status: ChecklistStatus.locked, unavailable: true),
        ChecklistItemModel(key: ChecklistKey.obsWidget, status: ChecklistStatus.todo, current: 0, total: 3),
        ChecklistItemModel(key: ChecklistKey.obsScenes, status: ChecklistStatus.todo),
      ]);
    });

    test('every proto key except unknown has a client key', () {
      final known = ChecklistItemKey.values.where((key) => key != ChecklistItemKey.unknownChecklistItemKey);
      expect(known.map(ChecklistKey.fromProto), everyElement(isNotNull));
      expect(ChecklistKey.values.map((key) => key.proto).toSet(), known.toSet());
    });
  });

  group('keys', () {
    test('groups, stream methods and own dismiss button follow the BRD', () {
      expect(ChecklistGroup.preparation.keys, [
        ChecklistKey.gamesCount,
        ChecklistKey.players,
        ChecklistKey.seating,
        ChecklistKey.billing,
      ]);
      expect(ChecklistGroup.notifications.keys, [ChecklistKey.notifyCoverage, ChecklistKey.tableDescriptions]);
      expect(ChecklistGroup.translation.keys, hasLength(6));
      expect(ChecklistStreamMethod.obs.keys, [ChecklistKey.obsWidget, ChecklistKey.obsScenes]);
      expect(ChecklistStreamMethod.phone.keys, [ChecklistKey.phoneStream, ChecklistKey.phoneOperator]);
      expect(ChecklistKey.values.where((key) => key.canDismiss), [
        ChecklistKey.billing,
        ChecklistKey.notifyCoverage,
        ChecklistKey.tableDescriptions,
        ChecklistKey.obsScenes,
      ]);
    });
  });

  group('progress and next', () {
    test('hidden items are out of B, only DONE items count in A', () {
      final model = OrganizerChecklistModel(
        isFsm: false,
        items: [
          _item(ChecklistKey.gamesCount, ChecklistStatus.done),
          _item(ChecklistKey.players, ChecklistStatus.warning),
          _item(ChecklistKey.seating, ChecklistStatus.todo),
          _item(ChecklistKey.billing, ChecklistStatus.dismissed),
          _item(ChecklistKey.notifyCoverage, ChecklistStatus.locked),
        ],
      );

      expect(model.progress, (done: 1, total: 4));
      expect(model.isComplete, isFalse);
      expect(model.next?.key, ChecklistKey.players);
      expect(model.dismissedItems.map((item) => item.key), [ChecklistKey.billing]);
    });

    test('next skips hidden items and is null when everything visible is done', () {
      final model = OrganizerChecklistModel(
        isFsm: false,
        items: [
          _item(ChecklistKey.gamesCount, ChecklistStatus.done),
          _item(ChecklistKey.billing, ChecklistStatus.dismissed),
          _item(ChecklistKey.notifyCoverage, ChecklistStatus.done),
        ],
      );

      expect(model.progress, (done: 2, total: 2));
      expect(model.isComplete, isTrue);
      expect(model.next, isNull);
    });
  });

  group('stream method', () {
    test('is the method whose items stay while the other method is hidden', () {
      expect(_withDismissed({}).streamMethod, isNull);
      expect(_withDismissed({ChecklistKey.phoneStream}).streamMethod, isNull);
      expect(
        _withDismissed({ChecklistKey.phoneStream, ChecklistKey.phoneOperator}).streamMethod,
        ChecklistStreamMethod.obs,
      );
      expect(
        _withDismissed({ChecklistKey.obsWidget, ChecklistKey.obsScenes}).streamMethod,
        ChecklistStreamMethod.phone,
      );
      expect(
        _withDismissed({
          ChecklistKey.obsWidget,
          ChecklistKey.obsScenes,
          ChecklistKey.phoneStream,
          ChecklistKey.phoneOperator,
        }).streamMethod,
        isNull,
      );
    });

    test('is chosen when backend marks the method item as done', () {
      final model = OrganizerChecklistModel(
        isFsm: false,
        items: [_item(ChecklistKey.streamMethod, ChecklistStatus.done)],
      );

      expect(model.isStreamMethodChosen, isTrue);
      expect(_withDismissed({}).isStreamMethodChosen, isFalse);
    });
  });
}
