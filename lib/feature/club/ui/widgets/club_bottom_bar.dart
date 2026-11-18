import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/utils.dart';

class ClubBottomBar extends StatelessWidget {
  final VoidCallback onOpenRating;

  const ClubBottomBar({
    super.key,
    required this.onOpenRating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: theme.greyColor.withValues(alpha: 0.3)),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: 12,
        ),
        child: CustomButton(
          text: context.locale.clubActionOpenRating,
          onTap: onOpenRating,
        ),
      ),
    );
  }
}
