import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/main/profile_page/widgets/player_avatar_widget.dart';

class PlayerRow extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final PlayerModel player;
  final String? imageUrlOverride;
  final int index;

  const PlayerRow({
    super.key,
    required this.onTap,
    required this.index,
    required this.onDelete,
    required this.player,
    this.imageUrlOverride,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final displayPlayer = imageUrlOverride != null
        ? player.copyWith(imageUrl: imageUrlOverride)
        : player;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '${index + 1}',
                style: theme.defaultTextStyle.copyWith(
                  color: theme.darkGreyColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            PlayerAvatarWidget(
              player: displayPlayer,
              size: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                player.nickname,
                style: theme.defaultTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onDelete != null)
              IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete_outline,
                  size: 22,
                  color: theme.redColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
