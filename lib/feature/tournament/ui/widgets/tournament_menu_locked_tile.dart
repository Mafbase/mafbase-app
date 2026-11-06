import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/tournament/ui/models/tournament_menu_models.dart';
import 'package:seating_generator_web/utils.dart';

/// Приглушённый пункт меню турнира с подписью и замком; шрифты задаёт меню, в котором он стоит.
class TournamentMenuLockedTile extends StatelessWidget {
  final TournamentMenuLockedItem item;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final double iconSize;
  final double minHeight;

  const TournamentMenuLockedTile({
    super.key,
    required this.item,
    required this.textStyle,
    required this.hintStyle,
    required this.iconSize,
    required this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final color = theme.sidebarSectionTitleColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: theme.sidebarActiveItemBgColor,
        child: Container(
          constraints: BoxConstraints(minHeight: minHeight),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              Icon(item.icon, color: color, size: iconSize),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.text,
                      style: textStyle.copyWith(color: color),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item.hint,
                      style: hintStyle.copyWith(color: color),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.lock_outline, color: color, size: iconSize - 4),
            ],
          ),
        ),
      ),
    );
  }
}
