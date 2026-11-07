import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_result.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/organizer_setup_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/widgets/organizer_setup_done_step.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/widgets/organizer_setup_fsm_step.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/widgets/organizer_setup_gomafia_step.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/widgets/organizer_setup_header.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/setup/widgets/organizer_setup_translation_step.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/utils.dart';

/// Мастер из двух вопросов после создания турнира: проходит ли он на GoMafia и нужны ли плашки.
class OrganizerSetupSheet extends StatelessWidget {
  const OrganizerSetupSheet({super.key});

  /// [context] должен видеть блоки страницы турнира. null — мастер закрыли, не дойдя до конца.
  static Future<OrganizerSetupResult?> show(BuildContext context, {required int tournamentId}) {
    final tournamentBloc = context.read<TournamentPageBloc>();
    final checklistBloc = context.read<OrganizerChecklistBloc>();
    final repository = RepositoryFactory.of(context).tournamentEditRepository;

    return showWithBloc(
      context,
      (_) => OrganizerSetupBloc(
        repository: repository,
        tournamentBloc: tournamentBloc,
        checklistBloc: checklistBloc,
        tournamentId: tournamentId,
      ),
    );
  }

  /// Блок создаётся вместе с листом и закрывается вместе с ним.
  @visibleForTesting
  static Future<OrganizerSetupResult?> showWithBloc(
    BuildContext context,
    OrganizerSetupBloc Function(BuildContext context) createBloc,
  ) {
    return showModalBottomSheet<OrganizerSetupResult>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 640),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => BlocProvider(create: createBloc, child: const OrganizerSetupSheet()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;
    final step = context.select((OrganizerSetupBloc bloc) => bloc.state.step);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 12, 24),
          child: DefaultTextStyle.merge(
            style: theme.defaultTextStyle.copyWith(height: 1.4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OrganizerSetupHeader(title: step.title(locale), step: step.number),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: switch (step) {
                    OrganizerSetupStep.fsm => const OrganizerSetupFsmStep(),
                    OrganizerSetupStep.gomafiaUrl => const OrganizerSetupGomafiaStep(),
                    OrganizerSetupStep.translation => const OrganizerSetupTranslationStep(),
                    OrganizerSetupStep.done => const OrganizerSetupDoneStep(),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on OrganizerSetupStep {
  int? get number => switch (this) {
        OrganizerSetupStep.fsm || OrganizerSetupStep.gomafiaUrl => 1,
        OrganizerSetupStep.translation => 2,
        OrganizerSetupStep.done => null,
      };

  String title(AppLocalizations locale) => switch (this) {
        OrganizerSetupStep.fsm => locale.checklistSetupFsmQuestion,
        OrganizerSetupStep.gomafiaUrl => locale.checklistSetupGomafiaTitle,
        OrganizerSetupStep.translation => locale.checklistSetupTranslationQuestion,
        OrganizerSetupStep.done => locale.checklistSetupDoneTitle,
      };
}
