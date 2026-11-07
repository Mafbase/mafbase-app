import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/link_actions.dart';

const mafbaseNotificationBotUrl = 'https://t.me/mafbase_notification_bot';

/// Текст для чата турнира: как подписаться на бота по ФСМ-нику или командой /pair.
String notificationCoverageInviteText(AppLocalizations locale) =>
    locale.checklistCoverageInviteText(mafbaseNotificationBotUrl);

class NotificationCoverageInvite extends StatelessWidget {
  const NotificationCoverageInvite({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;
    final invite = notificationCoverageInviteText(locale);

    return Material(
      color: theme.background2,
      shadowColor: theme.cardShadowColor,
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            Text(
              locale.checklistCoverageInviteTitle,
              style: theme.defaultTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              locale.checklistCoverageInviteAbout,
              style: theme.defaultTextStyle.copyWith(fontSize: 14, color: theme.darkGreyColor),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.background1,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.borderColor.withValues(alpha: 0.5)),
              ),
              child: SelectableText(invite, style: theme.defaultTextStyle.copyWith(fontSize: 13, height: 1.4)),
            ),
            CustomButton(
              text: locale.checklistCoverageInviteCopy,
              minimize: true,
              onTap: () => copyLink(context, invite, message: locale.checklistCoverageInviteCopied),
            ),
          ],
        ),
      ),
    );
  }
}
