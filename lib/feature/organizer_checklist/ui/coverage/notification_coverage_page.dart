import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_bloc.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_event.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/notification_coverage_state.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/widgets/notification_coverage_retry.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/coverage/widgets/notification_coverage_view.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/utils.dart';

/// Охват оповещений берёт блоки со страницы турнира, поэтому открывается только её дочерним маршрутом.
@RoutePage()
class NotificationCoveragePage extends StatelessWidget {
  final int tournamentId;

  const NotificationCoveragePage({
    super.key,
    @PathParam('id') required this.tournamentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationCoverageBloc>(
      create: (context) => NotificationCoverageBloc(
        repository: RepositoryFactory.of(context).organizerChecklistRepository,
        tournamentId: tournamentId,
      )..add(const NotificationCoverageEventLoad()),
      child: NotificationCoverageContent(tournamentId: tournamentId),
    );
  }
}

class NotificationCoverageContent extends StatelessWidget {
  final int tournamentId;

  const NotificationCoverageContent({super.key, required this.tournamentId});

  void _reload(BuildContext context) =>
      context.read<NotificationCoverageBloc>().add(const NotificationCoverageEventLoad());

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: context.backOrGoToDefault((c) => '/tournament/$tournamentId'),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(locale.checklistCoverageTitle),
        ),
        actions: [
          TournamentMenuAction(
            openDrawer: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      // После правки в диалоге профиля игрока TournamentPageBloc перезагружает участников турнира.
      body: BlocListener<TournamentPageBloc, TournamentPageState>(
        listenWhen: (previous, current) => previous.tournamentPlayers != current.tournamentPlayers,
        listener: (context, _) => _reload(context),
        child: BlocBuilder<NotificationCoverageBloc, NotificationCoverageState>(
          builder: (context, state) {
            if (state.coverage case final coverage?) {
              return Stack(
                children: [
                  NotificationCoverageView(coverage: coverage, onRetry: () => _reload(context)),
                  if (state.isLoading) const LinearProgressIndicator(),
                ],
              );
            }
            if (state.isLoading) return const Center(child: CircularProgressIndicator());

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: NotificationCoverageRetry(
                    text: locale.checklistCoverageLoadError,
                    onRetry: () => _reload(context),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
