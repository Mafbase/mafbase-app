import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_drawer.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_router.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_router.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_effect.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_builder.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

@RoutePage()
class TournamentPage extends StatelessWidget {
  final int tournamentId;

  const TournamentPage({
    super.key,
    @PathParam('id') required this.tournamentId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TournamentPageBloc>(
          key: const Key('TournamentPageBloc'),
          create: (context) {
            final repos = RepositoryFactory.of(context);
            return TournamentPageBloc(
              repos: repos,
              router: TournamentPageRouterImpl(context),
              tournamentId: tournamentId,
              context: context,
            )
              ..add(const TournamentPageEvent.pageOpened())
              ..add(const TournamentPageEvent.playersListOpened());
          },
        ),
        BlocProvider<SeatingPageBloc>(
          key: const Key('SeatingPageBloc'),
          create: (context) {
            final repos = RepositoryFactory.of(context);
            return SeatingPageBloc(
              repos: repos,
              router: SeatingPageRouterImpl(context),
            )..add(
                SeatingPageEvent.pageOpened(
                  tournamentId: tournamentId,
                ),
              );
          },
        ),
      ],
      child: _TournamentPageContent(tournamentId: tournamentId),
    );
  }
}

class _TournamentPageContent extends StatefulWidget {
  final int tournamentId;

  const _TournamentPageContent({required this.tournamentId});

  @override
  State<_TournamentPageContent> createState() => _TournamentPageContentState();
}

class _TournamentPageContentState extends CustomState<_TournamentPageContent>
    with EffectListener<TournamentPageEffect, TournamentPageState, TournamentPageBloc, _TournamentPageContent> {
  @override
  Widget? buildMobile(BuildContext context) {
    return Scaffold(
      endDrawer: TournamentMenuDrawer(tournamentId: widget.tournamentId),
      body: const AutoRouter(),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: AutoRouter()),
        BlocSelector<SeatingPageBloc, SeatingPageState, bool>(
          selector: (state) => state.isLoading,
          builder: (context, seatingLoading) {
            return BlocBuilder<TournamentPageBloc, TournamentPageState>(
              builder: (context, state) {
                final showBill = context.read<AuthNotifier>().value.mapOrNull(
                          authorized: (model) => !model.hideBilling,
                        ) ??
                    true;
                final sections = TournamentMenuBuilder.buildSections(
                  context,
                  state,
                  widget.tournamentId,
                  showBill: showBill,
                  seatingLoading: seatingLoading,
                );
                return TournamentMenu(
                  sections: sections,
                  tournamentId: widget.tournamentId,
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {
    on<TournamentPageEffectUpdateSettingsSuccess>(onShowSuccessUpdate);
    on<TournamentPageEffectNotificationSentSuccess>(onShowNotificationSentSuccess);
    super.registerEffectHandlers(on);
  }

  void onShowSuccessUpdate(TournamentPageEffectUpdateSettingsSuccess effect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.locale.tournamentSettingsUpdateSuccess),
      ),
    );
  }

  void onShowNotificationSentSuccess(TournamentPageEffectNotificationSentSuccess effect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.locale.notificationSentSuccess),
      ),
    );
  }
}
