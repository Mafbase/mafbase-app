import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

class ClubSubscriptionBadge extends StatelessWidget {
  final String dateText;

  const ClubSubscriptionBadge({super.key, required this.dateText});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.positiveColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 14, color: theme.positiveColor),
          const SizedBox(width: 6),
          Text(
            context.locale.clubSubscriptionUntil(dateText),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: theme.positiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
