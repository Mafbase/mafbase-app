import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

/// Заголовки и подписи пунктов чеклиста по ключу и статусу.
extension OrganizerChecklistTexts on AppLocalizations {
  String checklistGroupTitle(ChecklistGroup group) => switch (group) {
        ChecklistGroup.preparation => checklistGroupPreparation,
        ChecklistGroup.notifications => checklistGroupNotifications,
        ChecklistGroup.translation => checklistGroupTranslation,
      };

  String checklistStreamMethodName(ChecklistStreamMethod method) => switch (method) {
        ChecklistStreamMethod.obs => checklistStreamMethodObs,
        ChecklistStreamMethod.phone => checklistStreamMethodPhone,
      };

  String checklistStreamMethodSection(ChecklistStreamMethod method) => switch (method) {
        ChecklistStreamMethod.obs => checklistStreamMethodObsSection,
        ChecklistStreamMethod.phone => checklistStreamMethodPhoneSection,
      };

  String checklistItemTitle(ChecklistKey key) => switch (key) {
        ChecklistKey.gamesCount => checklistItemGamesCount,
        ChecklistKey.players => checklistItemPlayers,
        ChecklistKey.seating => checklistItemSeating,
        ChecklistKey.billing => checklistItemBilling,
        ChecklistKey.notifyCoverage => checklistItemNotifyCoverage,
        ChecklistKey.tableDescriptions => checklistItemTableDescriptions,
        ChecklistKey.streamMethod => checklistItemStreamMethod,
        ChecklistKey.translationBilling => checklistItemTranslationBilling,
        ChecklistKey.obsWidget => checklistItemObsWidget,
        ChecklistKey.obsScenes => checklistItemObsScenes,
        ChecklistKey.phoneStream => checklistItemPhoneStream,
        ChecklistKey.phoneOperator => checklistItemPhoneOperator,
      };

  /// «Не удалось проверить» важнее остального, затем блокировка, затем счётчик, затем подпись статуса.
  String checklistItemSubtitle(
    ChecklistItemModel item, {
    bool isFsm = false,
    ChecklistStreamMethod? streamMethod,
  }) {
    if (item.unavailable) return checklistStatusUnavailable;
    if (item.isLocked) {
      return item.key.group == ChecklistGroup.translation ? checklistStatusLockedTranslation : checklistStatusLocked;
    }

    final status = item.status;
    if (item.key == ChecklistKey.obsWidget && status == ChecklistStatus.warning) return checklistObsWidgetWarning;

    if ((item.current, item.total) case (final current?, final total?) when total > 0) {
      return _counter(item.key, current, total);
    }
    if (item.total == 0) {
      switch (item.key) {
        case ChecklistKey.seating:
          return checklistSeatingNoGames;
        case ChecklistKey.notifyCoverage:
          return checklistNotifyCoverageTodo;
        case ChecklistKey.phoneOperator:
          return checklistPhoneOperatorNoStreams;
        case ChecklistKey.tableDescriptions || ChecklistKey.obsWidget || ChecklistKey.phoneStream:
          return checklistNoTables;
        default:
          break;
      }
    }

    final done = status == ChecklistStatus.done;
    return switch (item.key) {
      ChecklistKey.gamesCount => done ? checklistGamesCountDone : checklistGamesCountTodo,
      ChecklistKey.players => switch (status) {
          ChecklistStatus.done => checklistPlayersCount(item.current ?? 0),
          ChecklistStatus.warning => checklistPlayersNotMultiple(item.current ?? 0),
          _ => checklistPlayersTooFew(item.current ?? 0),
        },
      ChecklistKey.seating when isFsm => done ? checklistSeatingDoneFsm : checklistSeatingTodoFsm,
      ChecklistKey.seating => done ? checklistStatusDone : checklistSeatingTodo,
      ChecklistKey.billing => done ? checklistBillingDone : checklistBillingTodo,
      ChecklistKey.notifyCoverage => done ? checklistStatusDone : checklistNotifyCoverageTodo,
      ChecklistKey.tableDescriptions => done ? checklistStatusDone : checklistTableDescriptionsTodo,
      ChecklistKey.streamMethod => switch (streamMethod) {
          final method? when done => checklistStreamMethodName(method),
          _ => done ? checklistStatusDone : checklistStreamMethodTodo,
        },
      ChecklistKey.translationBilling => done ? checklistStatusDone : checklistTranslationBillingTodo,
      ChecklistKey.obsWidget => done ? checklistStatusDone : checklistObsWidgetTodo,
      ChecklistKey.obsScenes => done ? checklistObsScenesDone : checklistObsScenesTodo,
      ChecklistKey.phoneStream => done ? checklistStatusDone : checklistPhoneStreamTodo,
      ChecklistKey.phoneOperator => done ? checklistStatusDone : checklistPhoneOperatorTodo,
    };
  }

  String _counter(ChecklistKey key, int current, int total) => switch (key) {
        ChecklistKey.seating => checklistSeatingCounter(current, total),
        ChecklistKey.notifyCoverage => checklistNotifyCoverageCounter(current, total),
        ChecklistKey.tableDescriptions => checklistTableDescriptionsCounter(current, total),
        ChecklistKey.obsWidget => checklistObsWidgetCounter(current, total),
        ChecklistKey.phoneStream => checklistPhoneStreamCounter(current, total),
        ChecklistKey.phoneOperator => checklistPhoneOperatorCounter(current, total),
        _ => checklistCounter(current, total),
      };
}
