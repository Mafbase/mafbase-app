import 'package:flutter/material.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/notification_coverage_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/widgets/notification_coverage_unreachable_row.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_group_section.dart';
import 'package:seating_generator_web/utils.dart';

class NotificationCoverageUnreachableSection extends StatelessWidget {
  final bool isFsm;
  final List<UnreachablePlayerModel> unreachable;
  final ValueChanged<PlayerModel> onEditPlayer;

  const NotificationCoverageUnreachableSection({
    super.key,
    required this.isFsm,
    required this.unreachable,
    required this.onEditPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;

    if (unreachable.isEmpty) {
      return Row(
        children: [
          Icon(Icons.check_circle, color: theme.successColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              locale.checklistCoverageAllReachable,
              style: theme.defaultTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );
    }

    return OrganizerChecklistGroupSection(
      title: locale.checklistCoverageUnreachable(unreachable.length),
      children: [
        Material(
          color: theme.background2,
          shadowColor: theme.cardShadowColor,
          elevation: 1,
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (final (index, item) in unreachable.indexed) ...[
                if (index > 0) Divider(height: 1, color: theme.borderColor.withValues(alpha: 0.12)),
                NotificationCoverageUnreachableRow(
                  nickname: item.player.nickname,
                  reason: isFsm && !item.hasFsmNickname
                      ? locale.checklistCoverageNoFsmNickname
                      : locale.checklistCoverageNotSubscribed,
                  onSetFsmNickname: isFsm && !item.hasFsmNickname ? () => onEditPlayer(item.player) : null,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
