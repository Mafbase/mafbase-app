import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/translation_panel.dart';
import 'package:seating_generator_web/utils.dart';

/// Панель плашек из меню внутри листа пункта; как и ей, нужен SeatingPageBloc в контексте.
class OrganizerChecklistObsLinks extends StatelessWidget {
  final int tournamentId;
  final int tablesCount;
  final VoidCallback onGoToSeating;

  const OrganizerChecklistObsLinks({
    super.key,
    required this.tournamentId,
    required this.tablesCount,
    required this.onGoToSeating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.theme.darkBlueColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TranslationPanel(
        tournamentId: tournamentId,
        tablesCount: tablesCount,
        onGoToSeating: () {
          Navigator.pop(context);
          onGoToSeating();
        },
      ),
    );
  }
}
