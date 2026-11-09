import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_result.dart';
import 'package:seating_generator_web/utils.dart';

class OrganizerSetupDoneStep extends StatelessWidget {
  const OrganizerSetupDoneStep({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final isFsm = context.select((OrganizerSetupBloc bloc) => bloc.state.isGomafiaUrlSaved);

    void finish(OrganizerSetupResult result) => Navigator.pop(context, result);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(locale.checklistSetupDoneAbout),
        if (isFsm) ...[
          const SizedBox(height: 8),
          Text(locale.checklistSetupDoneFsm),
        ],
        const SizedBox(height: 20),
        if (isFsm) ...[
          CustomButton(
            text: locale.checklistSetupImportGomafia,
            onTap: () => finish(OrganizerSetupResult.importFromGomafia),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () => finish(OrganizerSetupResult.openChecklist),
            child: Text(locale.checklistSetupOpenChecklist),
          ),
        ] else
          CustomButton(
            text: locale.checklistSetupOpenChecklist,
            onTap: () => finish(OrganizerSetupResult.openChecklist),
          ),
      ],
    );
  }
}
