import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

class NotificationCoverageFsmNote extends StatelessWidget {
  const NotificationCoverageFsmNote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final accent = theme.btnColor2;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: accent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.locale.checklistCoverageFsmNote,
              style: theme.defaultTextStyle.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
