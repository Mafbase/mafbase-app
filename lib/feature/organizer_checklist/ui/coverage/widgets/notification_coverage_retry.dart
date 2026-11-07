import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/utils.dart';

class NotificationCoverageRetry extends StatelessWidget {
  final String text;
  final VoidCallback onRetry;

  const NotificationCoverageRetry({
    super.key,
    required this.text,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Material(
      color: theme.background2,
      shadowColor: theme.cardShadowColor,
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_outlined, size: 48, color: theme.greyColor),
            const SizedBox(height: 12),
            Text(
              text,
              textAlign: TextAlign.center,
              style: theme.defaultTextStyle.copyWith(fontSize: 16, color: theme.darkGreyColor),
            ),
            const SizedBox(height: 16),
            CustomButton(text: context.locale.checklistRetry, expand: false, minimize: true, onTap: onRetry),
          ],
        ),
      ),
    );
  }
}
