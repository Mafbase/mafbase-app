import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'organizer_checklist_model.freezed.dart';

typedef ChecklistProgress = ({int done, int total});

/// Статусы и порядок пунктов задаёт backend.
@freezed
abstract class OrganizerChecklistModel with _$OrganizerChecklistModel {
  const OrganizerChecklistModel._();

  const factory OrganizerChecklistModel({
    required List<ChecklistItemModel> items,
    required bool isFsm,
  }) = _OrganizerChecklistModel;

  factory OrganizerChecklistModel.fromProto(TournamentChecklistOut proto) => OrganizerChecklistModel(
        items: proto.items.map(ChecklistItemModel.fromProto).nonNulls.toList(),
        isFsm: proto.isFsm,
      );

  List<ChecklistItemModel> get visibleItems => items.where((item) => !item.isDismissed).toList();

  List<ChecklistItemModel> get dismissedItems => items.where((item) => item.isDismissed).toList();

  /// «A/B»: B — нескрытые пункты, A — те из них, что в статусе DONE.
  ChecklistProgress get progress {
    final visible = visibleItems;
    return (done: visible.where((item) => item.isDone).length, total: visible.length);
  }

  bool get isComplete {
    final (:done, :total) = progress;
    return done == total;
  }

  ChecklistItemModel? get next => visibleItems.firstWhereOrNull((item) => !item.isDone);

  ChecklistItemModel? item(ChecklistKey key) => items.firstWhereOrNull((item) => item.key == key);

  bool isDismissed(ChecklistKey key) => item(key)?.isDismissed ?? false;

  bool get isStreamMethodChosen => item(ChecklistKey.streamMethod)?.isDone ?? false;

  ChecklistStreamMethod? get streamMethod {
    bool allDismissed(ChecklistStreamMethod method) => method.keys.every(isDismissed);

    return ChecklistStreamMethod.values.firstWhereOrNull(
      (method) => allDismissed(method.other) && !allDismissed(method),
    );
  }
}
