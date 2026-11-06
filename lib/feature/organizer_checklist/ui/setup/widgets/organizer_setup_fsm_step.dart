import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/widgets/organizer_setup_option.dart';
import 'package:seating_generator_web/utils.dart';

class OrganizerSetupFsmStep extends StatelessWidget {
  const OrganizerSetupFsmStep({super.key});

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
          child: Text(locale.checklistSetupFsmAbout),
        ),
        OrganizerSetupOption(
          icon: Icons.link,
          title: locale.checklistSetupFsmYes,
          hint: locale.checklistSetupFsmYesHint,
          onTap: () => bloc.add(const OrganizerSetupEventFsmAnswered(isFsm: true)),
        ),
        OrganizerSetupOption(
          icon: Icons.person_add_alt_outlined,
          title: locale.checklistSetupFsmNo,
          hint: locale.checklistSetupFsmNoHint,
          onTap: () => bloc.add(const OrganizerSetupEventFsmAnswered(isFsm: false)),
        ),
      ],
    );
  }
}
