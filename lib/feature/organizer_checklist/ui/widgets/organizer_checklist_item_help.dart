import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_help_steps.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

/// Справка пункта чеклиста: абзацы, шаги и скриншоты. Кнопки и панели между абзацами передаёт лист пункта.
class OrganizerChecklistItemHelp {
  final AppLocalizations locale;
  final ChecklistItemModel item;

  /// Лист открыт со страницы чеклиста, а не из подсказки на другом экране.
  final bool fromChecklist;

  const OrganizerChecklistItemHelp(
    this.locale, {
    required this.item,
    required this.fromChecklist,
  });

  List<Widget> gamesCount() => [
        Text(locale.checklistHelpGamesCountAbout),
        Text(locale.checklistHelpGamesCountHow),
        Text(locale.checklistHelpGamesCountOptional),
      ];

  List<Widget> players({required bool isFsm, required bool showBilling}) => [
        Text(locale.checklistHelpPlayersMultiple),
        if (isFsm) ...[
          Text(locale.checklistHelpPlayersGomafia),
          Text(locale.checklistHelpPlayersFsmNickname),
          Text(locale.checklistHelpPlayersFsmNicknameEdit),
        ] else ...[
          Text(locale.checklistHelpPlayersManual),
          Text(locale.checklistHelpPlayersGomafia),
        ],
        if (showBilling) Text(locale.checklistHelpPlayersLimit),
      ];

  List<Widget> seating({required bool isFsm}) => [
        Text(locale.checklistHelpSeatingAbout),
        if (!isFsm) Text(locale.checklistHelpSeatingGenerate),
        Text(locale.checklistHelpSeatingGomafia),
        Text(locale.checklistHelpSeatingMatching),
        if (isFsm) Text(locale.checklistHelpSeatingFsmRounds),
      ];

  List<Widget> billing({String? price}) => [
        Text(locale.checklistHelpBillingFree),
        Text(locale.checklistHelpBillingGives),
        Text(locale.checklistHelpBillingNotifications),
        if (price != null) Text(price),
      ];

  List<Widget> notifyCoverage() => [
        Text(locale.checklistHelpNotifyCoverageAbout),
        if (item.unavailable && !item.isLocked)
          Text(locale.checklistSheetUnavailable)
        else if (_coverageCount case final count?)
          Text(count),
        Text(locale.checklistHelpNotifyCoverageTelegram),
        Text(locale.checklistHelpNotifyCoverageVk),
        Text(locale.checklistHelpNotifyCoveragePush),
        if (item.isLocked)
          Text(locale.checklistHelpBillingNotifications)
        else if (!item.isDone)
          Text(locale.checklistHelpNotifyCoverageInvite),
      ];

  String? get _coverageCount => switch ((item.current, item.total)) {
        (final current?, final total?) when total > 0 && !item.isLocked =>
          locale.checklistSheetNotifyCoverageCount(current, total),
        _ => null,
      };

  List<Widget> tableDescriptions() => [
        Text(locale.checklistHelpTableDescriptionsAbout),
        if (item.isLocked)
          Text(locale.checklistHelpBillingNotifications)
        else if (item.unavailable)
          Text(locale.checklistSheetUnavailable),
        Text(locale.checklistHelpTableDescriptionsHow),
        if (fromChecklist && !item.isDone) Text(locale.checklistHelpTableDescriptionsOptional),
      ];

  List<Widget> streamMethod({required Widget options}) => [
        Text(locale.checklistHelpStreamMethodAbout),
        Text(locale.checklistHelpStreamMethodObs),
        Text(locale.checklistHelpStreamMethodPhone),
        Text(locale.checklistHelpStreamMethodControl),
        options,
        Text(locale.checklistHelpStreamMethodBoth),
      ];

  List<Widget> translationBilling({String? price, required bool enablesNotifications}) => [
        Text(locale.checklistHelpTranslationBillingAbout),
        Text(locale.checklistHelpTranslationBillingManual),
        Text(locale.checklistHelpTranslationBillingAuto),
        Text(locale.checklistHelpTranslationBillingWays),
        Text(locale.checklistHelpTranslationBillingSeating),
        if (price != null) Text(price),
        if (enablesNotifications) Text(locale.checklistHelpTranslationBillingNotifications),
      ];

  /// [links] — ссылки для OBS по столам; у неоплаченных плашек их нет.
  List<Widget> obsWidget({Widget? links}) => [
        if (item.status == ChecklistStatus.warning) Text(locale.checklistHelpObsWidgetWarning),
        Text(locale.checklistHelpObsWidgetAbout),
        if (item.isLocked) Text(locale.checklistHelpObsWidgetLocked),
        if (links != null) ...[
          links,
          Text(locale.checklistHelpObsWidgetDesign),
        ],
        OrganizerChecklistHelpSteps([
          OrganizerChecklistHelpStep(
            locale.checklistHelpObsWidgetStepSource,
            image: 'assets/checklist/obs_add_browser_source.png',
          ),
          OrganizerChecklistHelpStep(
            locale.checklistHelpObsWidgetStepLink,
            image: 'assets/checklist/obs_browser_source_size.png',
          ),
          OrganizerChecklistHelpStep(
            locale.checklistHelpObsWidgetStepPermissions,
            image: 'assets/checklist/obs_browser_source_permissions.png',
          ),
          OrganizerChecklistHelpStep(
            locale.checklistHelpObsWidgetStepShutdown,
            image: 'assets/checklist/obs_browser_source_shutdown.png',
          ),
        ]),
        if (!item.isDone) Text(locale.checklistHelpObsWidgetDone),
      ];

  List<Widget> obsScenes() => [
        Text(locale.checklistHelpObsScenesAbout),
        if (item.isLocked) Text(locale.checklistHelpObsWidgetLocked),
        Text(locale.checklistHelpObsScenesRights),
        OrganizerChecklistHelpSteps([
          OrganizerChecklistHelpStep(locale.checklistHelpObsScenesStepOpen),
          OrganizerChecklistHelpStep(
            locale.checklistHelpObsScenesStepChoose,
            image: 'assets/checklist/translation_control_obs_panel.png',
          ),
        ]),
        Text(locale.checklistHelpObsScenesWhen),
        Text(locale.checklistHelpObsScenesMissing),
        if (!item.isLocked) Text(locale.checklistHelpObsScenesOtherTables),
        if (!item.isDone) Text(locale.checklistHelpObsScenesDone),
      ];

  List<Widget> phoneStream({required bool overlaysPaid}) => [
        Text(locale.checklistHelpPhoneStreamAbout),
        OrganizerChecklistHelpSteps([
          OrganizerChecklistHelpStep(locale.checklistHelpPhoneStreamStepService),
          OrganizerChecklistHelpStep(locale.checklistHelpPhoneStreamStepAdd),
          OrganizerChecklistHelpStep(locale.checklistHelpPhoneStreamStepFields),
        ]),
        Text(locale.checklistHelpPhoneStreamOperatorLink),
        if (!overlaysPaid) Text(locale.checklistHelpPhoneStreamWithoutBilling),
        if (!item.isDone) Text(locale.checklistHelpPhoneStreamDone),
      ];

  List<Widget> phoneOperator({required Widget stores}) => [
        Text(locale.checklistHelpPhoneOperatorAbout),
        OrganizerChecklistHelpSteps([
          OrganizerChecklistHelpStep(locale.checklistHelpPhoneOperatorStepApp, child: stores),
          OrganizerChecklistHelpStep(locale.checklistHelpPhoneOperatorStepSend),
          OrganizerChecklistHelpStep(locale.checklistHelpPhoneOperatorStepOpen),
          OrganizerChecklistHelpStep(locale.checklistHelpPhoneOperatorStepStream),
        ]),
        Text(locale.checklistHelpPhoneOperatorRecord),
        Text(locale.checklistHelpPhoneOperatorTips),
        Text(locale.checklistHelpPhoneOperatorIos),
        Text(locale.checklistHelpPhoneOperatorSelf),
        Text(locale.checklistHelpPhoneOperatorReissue),
        Text(locale.checklistHelpPhoneOperatorBrowser),
        if (fromChecklist && !item.isDone) Text(locale.checklistHelpPhoneOperatorDone),
      ];
}
