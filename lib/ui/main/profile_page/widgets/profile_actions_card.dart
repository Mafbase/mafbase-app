import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/utils.dart';

class ProfileActionsCard extends StatelessWidget {
  final VoidCallback onPhotoThemes;
  final VoidCallback onLogout;
  final VoidCallback onDeleteAccount;

  const ProfileActionsCard({
    super.key,
    required this.onPhotoThemes,
    required this.onLogout,
    required this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    return Material(
      clipBehavior: Clip.hardEdge,
      color: theme.background2,
      borderRadius: BorderRadius.circular(12),
      shadowColor: theme.cardShadowColor,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            _ActionTile(
              icon: Icons.photo_library_outlined,
              iconBgColor: theme.background1,
              label: locale.photoThemesTitle,
              onTap: onPhotoThemes,
              trailing: Icon(
                Icons.chevron_right,
                color: theme.darkGreyColor,
                size: 20,
              ),
            ),
            const Divider(height: 1),
            _ActionTile(
              icon: Icons.logout,
              iconBgColor: theme.redColor.withValues(alpha: 0.08),
              iconColor: theme.redColor,
              label: locale.logout,
              labelColor: theme.redColor,
              onTap: onLogout,
            ),
            const Divider(height: 1),
            _ActionTile(
              icon: Icons.delete_outline,
              iconBgColor: theme.background1,
              label: locale.profileDeleteAccount,
              labelColor: theme.greyColor,
              labelFontSize: 12,
              onTap: onDeleteAccount,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color? iconColor;
  final String label;
  final Color? labelColor;
  final double? labelFontSize;
  final VoidCallback onTap;
  final Widget? trailing;

  const _ActionTile({
    required this.icon,
    required this.iconBgColor,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
    this.labelFontSize,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 18,
                  color: iconColor ?? theme.darkGreyColor,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: theme.defaultTextStyle.copyWith(
                  color: labelColor,
                  fontSize: labelFontSize ?? 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
