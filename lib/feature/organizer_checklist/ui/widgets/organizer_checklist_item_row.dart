import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_status_icon.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class OrganizerChecklistItemRow extends StatelessWidget {
  final ChecklistStatus status;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const OrganizerChecklistItemRow({
    super.key,
    required this.status,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isMobile = context.isMobile;

    return Material(
      color: theme.background2,
      shadowColor: theme.cardShadowColor,
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        hoverColor: theme.hoverColor,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 20,
            vertical: isMobile ? 12 : 14,
          ),
          child: Row(
            children: [
              OrganizerChecklistStatusIcon(status: status, size: isMobile ? 40 : 44),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.defaultTextStyle.copyWith(fontSize: 12, color: theme.darkGreyColor),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 22, color: theme.hintColor),
            ],
          ),
        ),
      ),
    );
  }
}
