import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_translation_answer.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/widgets/organizer_setup_option.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/utils.dart';

class OrganizerSetupTranslationStep extends StatelessWidget {
  const OrganizerSetupTranslationStep({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final bloc = context.read<OrganizerSetupBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(locale.checklistSetupTranslationAbout),
        ),
        for (final answer in OrganizerSetupTranslationAnswer.values)
          OrganizerSetupOption(
            icon: answer.icon,
            title: answer.title(locale),
            hint: answer.hint(locale),
            onTap: () => bloc.add(OrganizerSetupEventTranslationAnswered(answer)),
          ),
      ],
    );
  }
}

extension on OrganizerSetupTranslationAnswer {
  IconData get icon => switch (this) {
        OrganizerSetupTranslationAnswer.obs => Icons.desktop_windows_outlined,
        OrganizerSetupTranslationAnswer.phone => Icons.smartphone,
        OrganizerSetupTranslationAnswer.none => Icons.videocam_off_outlined,
        OrganizerSetupTranslationAnswer.unknown => Icons.help_outline,
      };

  String title(AppLocalizations locale) => switch (this) {
        OrganizerSetupTranslationAnswer.obs => locale.checklistSetupTranslationObs,
        OrganizerSetupTranslationAnswer.phone => locale.checklistSetupTranslationPhone,
        OrganizerSetupTranslationAnswer.none => locale.checklistSetupTranslationNone,
        OrganizerSetupTranslationAnswer.unknown => locale.checklistSetupTranslationUnknown,
      };

  String hint(AppLocalizations locale) => switch (this) {
        OrganizerSetupTranslationAnswer.obs => locale.checklistSheetStreamMethodObsHint,
        OrganizerSetupTranslationAnswer.phone => locale.checklistSheetStreamMethodPhoneHint,
        OrganizerSetupTranslationAnswer.none => locale.checklistSetupTranslationNoneHint,
        OrganizerSetupTranslationAnswer.unknown => locale.checklistSetupTranslationUnknownHint,
      };
}
