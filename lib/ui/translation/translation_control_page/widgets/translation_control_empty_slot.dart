import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/utils.dart';

class TranslationControlEmptySlot extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<PlayerModel> onPlayerSelected;
  final void Function({required String initValue})? onNewPlayer;

  const TranslationControlEmptySlot({
    super.key,
    required this.index,
    required this.controller,
    required this.focusNode,
    required this.onPlayerSelected,
    this.onNewPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      constraints: const BoxConstraints(minHeight: 100),
      decoration: BoxDecoration(
        color: theme.background1,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.borderColor.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '${index + 1}',
                textAlign: TextAlign.center,
                style: theme.defaultTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.darkGreyColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.person_add_outlined, size: 20, color: theme.hintColor),
            const SizedBox(width: 8),
            Expanded(
              child: PlayerAutoComplete(
                controller: controller,
                focusNode: focusNode,
                hint: context.locale.translationControlPickPlayer,
                onSelected: onPlayerSelected,
                onNewPlayer: onNewPlayer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
