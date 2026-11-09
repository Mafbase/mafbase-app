import 'package:collection/collection.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

enum ChecklistGroup {
  preparation,
  notifications,
  translation;

  List<ChecklistKey> get keys => [
        for (final key in ChecklistKey.values)
          if (key.group == this) key,
      ];
}

/// Способ трансляции с плашками: выбрать способ — значит скрыть пункты другого.
enum ChecklistStreamMethod {
  obs,
  phone;

  List<ChecklistKey> get keys => [
        for (final key in ChecklistKey.values)
          if (key.method == this) key,
      ];

  ChecklistStreamMethod get other => this == obs ? phone : obs;
}

/// [canDismiss] — у пункта своя кнопка «Не нужно»; остальные скрываются группой или выбором способа трансляции.
enum ChecklistKey {
  gamesCount(ChecklistItemKey.checklistGamesCount, ChecklistGroup.preparation),
  players(ChecklistItemKey.checklistPlayers, ChecklistGroup.preparation),
  seating(ChecklistItemKey.checklistSeating, ChecklistGroup.preparation),
  billing(ChecklistItemKey.checklistBilling, ChecklistGroup.preparation, canDismiss: true),
  notifyCoverage(ChecklistItemKey.checklistNotifyCoverage, ChecklistGroup.notifications, canDismiss: true),
  tableDescriptions(ChecklistItemKey.checklistTableDescriptions, ChecklistGroup.notifications, canDismiss: true),
  streamMethod(ChecklistItemKey.checklistStreamMethod, ChecklistGroup.translation),
  translationBilling(ChecklistItemKey.checklistTranslationBilling, ChecklistGroup.translation),
  obsWidget(
    ChecklistItemKey.checklistObsWidget,
    ChecklistGroup.translation,
    method: ChecklistStreamMethod.obs,
  ),
  obsScenes(
    ChecklistItemKey.checklistObsScenes,
    ChecklistGroup.translation,
    canDismiss: true,
    method: ChecklistStreamMethod.obs,
  ),
  phoneStream(
    ChecklistItemKey.checklistPhoneStream,
    ChecklistGroup.translation,
    method: ChecklistStreamMethod.phone,
  ),
  phoneOperator(
    ChecklistItemKey.checklistPhoneOperator,
    ChecklistGroup.translation,
    method: ChecklistStreamMethod.phone,
  );

  const ChecklistKey(
    this.proto,
    this.group, {
    this.canDismiss = false,
    this.method,
  });

  final ChecklistItemKey proto;
  final ChecklistGroup group;
  final bool canDismiss;
  final ChecklistStreamMethod? method;

  static ChecklistKey? fromProto(ChecklistItemKey key) => values.firstWhereOrNull((value) => value.proto == key);
}
