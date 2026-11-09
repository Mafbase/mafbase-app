import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';

part 'checklist_item_model.freezed.dart';

enum ChecklistStatus {
  todo(ChecklistItemStatus.checklistTodo),
  done(ChecklistItemStatus.checklistDone),
  warning(ChecklistItemStatus.checklistWarning),
  locked(ChecklistItemStatus.checklistLocked),
  dismissed(ChecklistItemStatus.checklistDismissed);

  const ChecklistStatus(this.proto);

  final ChecklistItemStatus proto;

  static ChecklistStatus fromProto(ChecklistItemStatus status) =>
      values.firstWhere((value) => value.proto == status, orElse: () => todo);
}

@freezed
abstract class ChecklistItemModel with _$ChecklistItemModel {
  const ChecklistItemModel._();

  const factory ChecklistItemModel({
    required ChecklistKey key,
    required ChecklistStatus status,
    int? current,
    int? total,
    @Default(false) bool unavailable,
  }) = _ChecklistItemModel;

  /// null — ключ из более новой версии backend, клиент его не знает.
  static ChecklistItemModel? fromProto(ChecklistItem proto) {
    final key = ChecklistKey.fromProto(proto.key);
    if (key == null) return null;

    return ChecklistItemModel(
      key: key,
      status: ChecklistStatus.fromProto(proto.status),
      current: proto.hasCurrent() ? proto.current : null,
      total: proto.hasTotal() ? proto.total : null,
      unavailable: proto.unavailable,
    );
  }

  bool get isDone => status == ChecklistStatus.done;

  bool get isDismissed => status == ChecklistStatus.dismissed;

  bool get isLocked => status == ChecklistStatus.locked;
}
