import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/organizer_checklist_model.dart';
import 'package:seating_generator_web/utils.dart';

class OrganizerChecklistProgressHeader extends StatelessWidget {
  final ChecklistProgress progress;

  const OrganizerChecklistProgressHeader({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;
    final (:done, :total) = progress;

    return Material(
      color: theme.background2,
      shadowColor: theme.cardShadowColor,
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              locale.checklistProgress(done, total),
              style: theme.defaultTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: total == 0 ? 1 : done / total,
                minHeight: 8,
                color: theme.successColor,
                backgroundColor: theme.borderColor.withValues(alpha: 0.12),
              ),
            ),
            if (done == total) ...[
              const SizedBox(height: 8),
              Text(
                locale.checklistProgressComplete,
                style: theme.defaultTextStyle.copyWith(fontSize: 13, color: theme.darkGreyColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
