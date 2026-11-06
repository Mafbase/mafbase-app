import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/streams/ui/widgets/streams_guide_step.dart';
import 'package:seating_generator_web/utils.dart';

/// Как вести трансляцию с телефона: три шага от создания трансляции стола до «Стрим» у оператора.
class StreamsPhoneGuide extends StatelessWidget {
  final bool initiallyExpanded;

  const StreamsPhoneGuide({
    super.key,
    required this.initiallyExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final theme = MyTheme.of(context);
    final steps = [
      locale.streamsPhoneGuideStepCreate,
      locale.streamsPhoneGuideStepSend,
      locale.streamsPhoneGuideStepStart,
    ];

    return Card(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        shape: const Border(),
        collapsedShape: const Border(),
        leading: Icon(Icons.smartphone, color: theme.darkGreyColor),
        title: Text(
          locale.streamsPhoneGuideTitle,
          style: theme.defaultTextStyle.copyWith(fontWeight: FontWeight.w600),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: [
          for (final (index, step) in steps.indexed) StreamsGuideStep(number: index + 1, text: step),
        ],
      ),
    );
  }
}
