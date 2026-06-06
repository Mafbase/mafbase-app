import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';
import 'package:seating_generator_web/utils.dart';

/// Переключатель текущей фазы трансляции (день / ночь / перерыв).
///
/// Стрим-плагин ([MafbaseStream]) подписан на тот же `broadcastPhase` через
/// `seatingContent` сокет: на `night` и `break_phase` отрубается микрофон,
/// на `break_phase` дополнительно показывается картинка-заглушка вместо кадра.
class TranslationControlPhaseSelector extends StatelessWidget {
  final BroadcastPhase phase;
  final ValueChanged<BroadcastPhase> onChanged;

  const TranslationControlPhaseSelector({super.key, required this.phase, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    String label(BroadcastPhase phase) {
      switch (phase) {
        case BroadcastPhase.night:
          return locale.translationControlPhaseNight;
        case BroadcastPhase.break_phase:
          return locale.translationControlPhaseBreak;
        case BroadcastPhase.day:
        default:
          return locale.translationControlPhaseDay;
      }
    }

    return Container(
      height: 52,
      color: theme.background2,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              locale.translationControlPhaseLabel,
              style: theme.defaultTextStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: CustomDropdown<BroadcastPhase>(
                mapToString: (p) => label(p ?? BroadcastPhase.day),
                items: const [BroadcastPhase.day, BroadcastPhase.night, BroadcastPhase.break_phase],
                initValue: phase,
                onChanged: (value) {
                  if (value != null && value != phase) onChanged(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
