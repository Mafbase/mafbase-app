import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/utils.dart';

class ClubSubscriptionBadge extends StatelessWidget {
  final DateTime billedFor;

  const ClubSubscriptionBadge({super.key, required this.billedFor});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = billedFor.isAfter(DateTime.now());
    final color = isActive ? theme.positiveColor : theme.redColor;
    final text = isActive
        ? context.locale.clubSubscriptionUntil(
            DateFormat('dd.MM.yyyy').format(billedFor),
          )
        : context.locale.clubSubscriptionInactive;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w500 : FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
