import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/notification_coverage_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/widgets/notification_coverage_fsm_note.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/widgets/notification_coverage_invite.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/widgets/notification_coverage_retry.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/widgets/notification_coverage_summary.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/widgets/notification_coverage_unreachable_section.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class NotificationCoverageView extends StatelessWidget {
  final NotificationCoverageModel coverage;
  final VoidCallback onRetry;

  const NotificationCoverageView({
    super.key,
    required this.coverage,
    required this.onRetry,
  });

  /// В ответе охвата у игрока нет фото, поэтому диалогу отдаём модель из списка участников, если она там есть.
  void _editPlayer(BuildContext context, PlayerModel player) {
    final tournamentBloc = context.read<TournamentPageBloc>();
    final participant = tournamentBloc.state.tournamentPlayers.firstWhereOrNull((item) => item.id == player.id);
    tournamentBloc.add(TournamentPageEvent.openProfileDialog(player: participant ?? player));
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              if (coverage.isFsm) const NotificationCoverageFsmNote(),
              if (coverage.unavailable)
                NotificationCoverageRetry(text: context.locale.checklistCoverageUnavailable, onRetry: onRetry)
              else
                NotificationCoverageSummary(coverage: coverage),
              const NotificationCoverageInvite(),
              if (!coverage.unavailable && coverage.total > 0)
                NotificationCoverageUnreachableSection(
                  isFsm: coverage.isFsm,
                  unreachable: coverage.unreachable,
                  onEditPlayer: (player) => _editPlayer(context, player),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
