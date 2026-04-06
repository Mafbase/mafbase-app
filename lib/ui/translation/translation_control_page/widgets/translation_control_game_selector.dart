import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/utils.dart';

class TranslationControlGameSelector extends StatelessWidget {
  final int game;
  final int totalGames;
  final ValueChanged<int> onChanged;

  const TranslationControlGameSelector({
    super.key,
    required this.game,
    required this.totalGames,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final canGoPrev = game > 1;
    final canGoNext = game < totalGames;

    return Container(
      height: 52,
      color: theme.background2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: 28,
                color: canGoPrev ? theme.btnColor2 : theme.buttonDisabledColor,
              ),
              onPressed: canGoPrev ? () => onChanged(game - 1) : null,
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              context.locale.translationControlGame(game, totalGames),
              textAlign: TextAlign.center,
              style: theme.defaultTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 48,
            height: 48,
            child: IconButton(
              icon: Icon(
                Icons.chevron_right,
                size: 28,
                color: canGoNext ? theme.btnColor2 : theme.buttonDisabledColor,
              ),
              onPressed: canGoNext ? () => onChanged(game + 1) : null,
            ),
          ),
        ],
      ),
    );
  }
}
