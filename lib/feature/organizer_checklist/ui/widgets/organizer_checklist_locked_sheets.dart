import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_info_sheet.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_billing_dialog.dart';
import 'package:seating_generator_web/utils.dart';

/// Пояснения к платным функциям, которые до оплаты стоят в меню турнира с замком.
class OrganizerChecklistLockedSheets {
  OrganizerChecklistLockedSheets._();

  /// Цена — доплата за плашки при текущем числе оплаченных участников, как её покажет диалог оплаты.
  static Future<void> showTranslation(
    BuildContext context, {
    required int billedPlayers,
    required VoidCallback onPay,
  }) {
    final locale = context.locale;
    final price = calculatePrice(billedPlayers, true) - calculatePrice(billedPlayers, false);

    return OrganizerChecklistInfoSheet.show(
      context,
      title: locale.translationDialogTitle,
      body: [
        Text(locale.checklistLockedTranslationAbout),
        Text(locale.checklistLockedTranslationWays),
        Text(locale.checklistLockedTranslationSeating),
        Text(locale.checklistLockedTranslationPrice(billedPlayers, price)),
      ],
      primaryAction: OrganizerChecklistInfoSheetAction(
        text: locale.checklistSheetPay,
        onTap: onPay,
      ),
    );
  }

  static Future<void> showNotifications(
    BuildContext context, {
    required VoidCallback onPay,
  }) {
    final locale = context.locale;

    return OrganizerChecklistInfoSheet.show(
      context,
      title: locale.tournamentMenuNotifications,
      body: [
        Text(locale.checklistLockedNotificationsAbout),
        Text(locale.checklistLockedNotificationsChannels),
        Text(locale.checklistLockedNotificationsBilling),
      ],
      primaryAction: OrganizerChecklistInfoSheetAction(
        text: locale.checklistSheetPay,
        onTap: onPay,
      ),
    );
  }
}
