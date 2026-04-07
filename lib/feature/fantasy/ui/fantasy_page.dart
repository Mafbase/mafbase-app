import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_bloc.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_event.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_state.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_notifications_banner.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_participants_bottom_sheet.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_prediction_section.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_rating_section.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

@RoutePage()
class FantasyPage extends StatelessWidget {
  final int tournamentId;

  const FantasyPage({
    super.key,
    @PathParam('id') required this.tournamentId,
  });

  @override
  Widget build(BuildContext context) {
    final isOwner = context.watch<TournamentPageBloc>().state.isMyTournament;
    final userId = context.read<AuthNotifier>().value.mapOrNull(
          authorized: (model) => model.userId,
        );

    return BlocProvider<FantasyBloc>(
      key: ValueKey('$tournamentId$isOwner'),
      create: (context) => FantasyBloc(const FantasyState(), RepositoryFactory.of(context).fantasyRepository)
        ..add(
          FantasyEventInit(
            tournamentId: tournamentId,
            isOwner: isOwner,
            userId: userId,
          ),
        ),
      child: _FantasyPageContent(tournamentId: tournamentId),
    );
  }
}

class _FantasyPageContent extends StatefulWidget {
  final int tournamentId;

  const _FantasyPageContent({required this.tournamentId});

  @override
  State<_FantasyPageContent> createState() => _FantasyPageContentState();
}

class _FantasyPageContentState extends CustomState<_FantasyPageContent> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<FantasyBloc>().add(
            FantasyEventRefresh(
              tournamentId: widget.tournamentId,
            ),
          );
    }
  }

  @override
  Widget? buildMobile(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: context.backOrGoToDefault(TournamentsPage.createLocation),
          ),
          title: Text(context.locale.fantasy),
          actions: [
            BlocBuilder<FantasyBloc, FantasyState>(
              builder: (context, state) {
                if (!state.isOwner) return const SizedBox.shrink();
                return IconButton(
                  onPressed: () => FantasyParticipantsBottomSheet.show(
                    context,
                    widget.tournamentId,
                  ),
                  icon: const Icon(Icons.people),
                  tooltip: context.locale.fantasyParticipants,
                );
              },
            ),
            TournamentMenuAction(
              tournamentId: widget.tournamentId,
              openDrawer: () => Scaffold.of(context).openEndDrawer(),
            ),
          ],
        ),
        body: BlocBuilder<FantasyBloc, FantasyState>(
          builder: (context, state) {
            if (state.isLoading && state.rating == null) {
              return const LoadingOverlayWidget();
            }

            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      final completer = Completer<void>();
                      context.read<FantasyBloc>().add(
                            FantasyEventRefresh(
                              tournamentId: widget.tournamentId,
                              completer: completer,
                            ),
                          );

                      await completer.future;
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const FantasyNotificationsBanner(),
                          FantasyPredictionSection(
                            state: state,
                            tournamentId: widget.tournamentId,
                          ),
                          const SizedBox(height: 16),
                          FantasyRatingSection(
                            state: state,
                            isMobile: true,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );

  @override
  Widget buildDesktop(BuildContext context) => BlocBuilder<FantasyBloc, FantasyState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: context.backOrGoToDefault(TournamentsPage.createLocation),
              ),
              title: Text(context.locale.fantasy),
              actions: [
                if (state.isOwner)
                  IconButton(
                    onPressed: () => FantasyParticipantsBottomSheet.show(
                      context,
                      widget.tournamentId,
                    ),
                    icon: const Icon(Icons.people),
                    tooltip: context.locale.fantasyParticipants,
                  ),
              ],
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: FantasyNotificationsBanner(),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          final completer = Completer<void>();
                          context.read<FantasyBloc>().add(
                                FantasyEventRefresh(
                                  tournamentId: widget.tournamentId,
                                  completer: completer,
                                ),
                              );
                          await completer.future;
                        },
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(width: 16),
                                  Expanded(
                                    flex: 3,
                                    child: FantasyRatingSection(state: state),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    flex: 1,
                                    child: FantasyPredictionSection(
                                      state: state,
                                      tournamentId: widget.tournamentId,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.isLoading && state.rating == null) const LoadingOverlayWidget(),
              ],
            ),
          );
        },
      );
}
