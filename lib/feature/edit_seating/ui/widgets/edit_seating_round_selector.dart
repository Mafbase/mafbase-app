import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

class EditSeatingRoundSelector extends StatelessWidget {
  final int roundCount;
  final int selectedRound;
  final ValueChanged<int> onSelected;

  const EditSeatingRoundSelector({
    super.key,
    required this.roundCount,
    required this.selectedRound,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: List.generate(roundCount, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text('${context.locale.round} ${index + 1}'),
              selected: selectedRound == index,
              onSelected: (_) => onSelected(index),
            ),
          );
        }),
      ),
    );
  }
}
