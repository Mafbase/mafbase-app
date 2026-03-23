import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/club_avatar.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';

enum ClubRowStyle {
  mobile,
  desktop;
}

class SingleClubRow extends StatelessWidget {
  final ClubModel model;
  final VoidCallback onTap;
  final ClubRowStyle style;

  const SingleClubRow({
    super.key,
    required this.model,
    required this.onTap,
    this.style = ClubRowStyle.desktop,
  });

  static const _avatarColors = [
    Color(0xFF475264),
    Color(0xFFDF5650),
    Color(0xFFC8B75E),
    Color(0xFF6B8299),
    Color(0xFF1A2D42),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final isMobile = style == ClubRowStyle.mobile;
    final avatarSize = isMobile ? 52.0 : 56.0;
    final avatarColor = _avatarColors[model.id % _avatarColors.length];

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: theme.background2,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.cardShadowColor,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 20,
          vertical: isMobile ? 16 : 18,
        ),
        child: Row(
          children: [
            ClubAvatar(
              clubModel: model,
              size: avatarSize,
              borderRadius: BorderRadius.circular(8),
              placeholderColor: avatarColor,
            ),
            SizedBox(width: isMobile ? 14 : 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    model.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isMobile ? 3 : 4),
                  _buildMetaRow(theme, isMobile),
                  if (!isMobile && model.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      model.description!,
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.darkGreyColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              size: 22,
              color: theme.hintColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaRow(MyTheme theme, bool isMobile) {
    return Row(
      children: [
        if (model.city != null) ...[
          Icon(
            Icons.location_on_outlined,
            size: 14,
            color: theme.hintColor,
          ),
          const SizedBox(width: 3),
          Text(
            model.city!,
            style: TextStyle(
              fontSize: 13,
              color: theme.hintColor,
            ),
          ),
        ],
        if (model.city != null) const SizedBox(width: 12),
        Text(
          'ID: ${model.id}',
          style: TextStyle(
            fontSize: 12,
            color: theme.hintColor,
          ),
        ),
      ],
    );
  }
}
