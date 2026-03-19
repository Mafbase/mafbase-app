import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

class ClubDesktopHeader extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback? onSettings;

  const ClubDesktopHeader({
    super.key,
    required this.onBack,
    this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      height: 77,
      decoration: BoxDecoration(
        color: theme.background2,
        border: const Border(
          bottom: BorderSide(),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          _HeaderButton(
            icon: Icons.arrow_back,
            onTap: onBack,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              context.locale.clubPageTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: theme.darkBlueColor,
              ),
            ),
          ),
          if (onSettings != null)
            _HeaderButton(
              icon: Icons.settings_outlined,
              onTap: onSettings!,
            ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: theme.background1,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: theme.darkBlueColor),
      ),
    );
  }
}
