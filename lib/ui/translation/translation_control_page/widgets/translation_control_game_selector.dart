import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: CustomDropdown(
          mapToString: (game) => 'Игра $game',
          items: List.generate(
            totalGames,
            (i) => i + 1,
          ),
          initValue: game,
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ),
    );
  }
}
