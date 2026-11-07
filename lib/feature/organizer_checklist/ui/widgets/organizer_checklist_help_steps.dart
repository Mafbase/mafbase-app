import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/widgets/organizer_checklist_help_image.dart';
import 'package:seating_generator_web/utils.dart';

/// Шаг справки. Под текстом — скриншот [image] из `assets/checklist/` или [child], например кнопки.
class OrganizerChecklistHelpStep {
  final String text;
  final String? image;
  final Widget? child;

  const OrganizerChecklistHelpStep(this.text, {this.image, this.child});
}

/// Нумерованные шаги справки.
class OrganizerChecklistHelpSteps extends StatelessWidget {
  final List<OrganizerChecklistHelpStep> steps;

  const OrganizerChecklistHelpSteps(this.steps, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        for (final (index, step) in steps.indexed) _HelpStepRow(number: index + 1, step: step),
      ],
    );
  }
}

class _HelpStepRow extends StatelessWidget {
  final int number;
  final OrganizerChecklistHelpStep step;

  const _HelpStepRow({required this.number, required this.step});

  static const _badgeSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = DefaultTextStyle.of(context).style;
    final lineHeight = (style.fontSize ?? 14) * (style.height ?? 1.2);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: math.max(0, (lineHeight - _badgeSize) / 2)),
          child: Container(
            width: _badgeSize,
            height: _badgeSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: theme.btnColor2, shape: BoxShape.circle),
            child: Text(
              '$number',
              style: TextStyle(color: theme.btnTextColor, fontSize: 11, fontWeight: FontWeight.w600, height: 1),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: math.max(0, (_badgeSize - lineHeight) / 2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [
                Text(step.text),
                if (step.image case final image?) OrganizerChecklistHelpImage(asset: image),
                if (step.child case final child?) child,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
