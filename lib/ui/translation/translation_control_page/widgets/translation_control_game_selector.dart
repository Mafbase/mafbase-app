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

    return Container(
      height: 52,
      color: theme.background2,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<int>(
            value: game,
            dropdownColor: theme.background2,
            underline: const SizedBox.shrink(),
            style: theme.defaultTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            items: List.generate(
              totalGames,
              (i) => DropdownMenuItem<int>(
                value: i + 1,
                child: Text(
                  context.locale.translationControlGame(i + 1, totalGames),
                  style: theme.defaultTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
          ),
        ],
      ),
    );
  }
}
