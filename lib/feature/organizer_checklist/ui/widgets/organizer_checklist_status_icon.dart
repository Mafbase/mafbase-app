import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/utils.dart';

class OrganizerChecklistStatusIcon extends StatelessWidget {
  final ChecklistStatus status;
  final double size;

  const OrganizerChecklistStatusIcon({
    super.key,
    required this.status,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final (icon, color) = switch (status) {
      ChecklistStatus.done => (Icons.check_circle, theme.successColor),
      ChecklistStatus.warning => (Icons.error_outline, theme.statusBillingColor),
      ChecklistStatus.locked => (Icons.lock_outline, theme.hintColor),
      ChecklistStatus.todo || ChecklistStatus.dismissed => (Icons.radio_button_unchecked, theme.darkGreyColor),
    };

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(size / 4),
      ),
      child: Icon(icon, size: size / 2, color: color),
    );
  }
}
