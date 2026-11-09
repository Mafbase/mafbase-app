import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/notification_coverage_model.dart';
import 'package:seating_generator_web/utils.dart';

/// «Получат оповещения: X из N» и разбивка по каналам. Push показан справочно: в X он не входит.
class NotificationCoverageSummary extends StatelessWidget {
  final NotificationCoverageModel coverage;

  const NotificationCoverageSummary({super.key, required this.coverage});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;
    final NotificationCoverageModel(:reachable, :total) = coverage;
    final titleStyle = theme.defaultTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w600);

    return Material(
      color: theme.background2,
      shadowColor: theme.cardShadowColor,
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: total == 0
            ? Text(locale.checklistNotifyCoverageTodo, style: titleStyle)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(locale.checklistCoverageSummary(reachable, total), style: titleStyle),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: reachable / total,
                      minHeight: 8,
                      color: reachable >= total ? theme.successColor : theme.statusBillingColor,
                      backgroundColor: theme.borderColor.withValues(alpha: 0.12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _ChannelRow(
                    icon: Icons.telegram,
                    title: locale.checklistCoverageTelegram,
                    hint: locale.checklistCoverageTelegramHint,
                    count: coverage.telegram,
                  ),
                  if (coverage.isFsm)
                    _ChannelRow(
                      icon: Icons.forum_outlined,
                      title: locale.checklistCoverageVk,
                      hint: locale.checklistCoverageVkHint,
                      count: coverage.vk,
                    ),
                  _ChannelRow(
                    icon: Icons.phone_iphone,
                    title: locale.checklistCoveragePush,
                    hint: locale.checklistCoveragePushHint,
                    count: coverage.push,
                  ),
                ],
              ),
      ),
    );
  }
}

class _ChannelRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String hint;
  final int count;

  const _ChannelRow({
    required this.icon,
    required this.title,
    required this.hint,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Icon(icon, size: 24, color: theme.darkGreyColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(hint, style: theme.defaultTextStyle.copyWith(fontSize: 12, color: theme.darkGreyColor)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text('$count', style: theme.defaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
