import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_event.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/gomafia_tournament_url.dart';

/// Ссылка на турнир GoMafia с той же проверкой, что в диалоге импорта рассадки.
class OrganizerSetupGomafiaStep extends StatefulWidget {
  const OrganizerSetupGomafiaStep({super.key});

  @override
  State<OrganizerSetupGomafiaStep> createState() => _OrganizerSetupGomafiaStepState();
}

class _OrganizerSetupGomafiaStepState extends State<OrganizerSetupGomafiaStep> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValid => isGomafiaTournamentUrl(_controller.text);

  void _save() {
    if (_isValid) context.read<OrganizerSetupBloc>().add(OrganizerSetupEventGomafiaUrlSubmitted(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final isSaving = context.select((OrganizerSetupBloc bloc) => bloc.state.isSaving);

    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(locale.checklistSetupGomafiaAbout),
          const SizedBox(height: 12),
          CustomTextField(
            controller: _controller,
            hint: gomafiaTournamentUrlExample,
            textInputType: TextInputType.url,
            textInputAction: TextInputAction.done,
            readOnly: isSaving,
            errorText: _controller.text.isEmpty || _isValid
                ? null
                : locale.checklistSetupGomafiaInvalid(gomafiaTournamentUrlExample),
            onSubmit: (_) => _save(),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: locale.checklistSetupSave,
            disabled: !_isValid,
            isLoading: isSaving,
            onTap: _save,
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: isSaving ? null : () => context.read<OrganizerSetupBloc>().add(const OrganizerSetupEventBack()),
            child: Text(locale.checklistSetupBack),
          ),
        ],
      ),
    );
  }
}
