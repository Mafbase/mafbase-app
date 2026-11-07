import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

/// Шапка мастера: номер шага, вопрос и крестик. Закрыть мастер — то же, что ответить «Пока не знаю».
class OrganizerSetupHeader extends StatelessWidget {
  static const stepsCount = 2;

  final String title;

  /// null — мастер пройден, номер шага не показывается.
  final int? step;

  const OrganizerSetupHeader({
    super.key,
    required this.title,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  switch (step) {
                    final step? => locale.checklistSetupStepCaption(step, stepsCount),
                    null => locale.checklistSetupCaption,
                  },
                  style: theme.defaultTextStyle.copyWith(fontSize: 12, color: theme.darkGreyColor),
                ),
                const SizedBox(height: 4),
                Text(title, style: theme.headerTextStyle),
              ],
            ),
          ),
        ),
        const CloseButton(),
      ],
    );
  }
}
