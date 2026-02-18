import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_bloc.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_event.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_state.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_header.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_notifications_banner.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_participants_bottom_sheet.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_prediction_section.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_rating_section.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class FantasyPage extends StatefulWidget {
  final int tournamentId;
  final bool isOwner;

  const FantasyPage({
    super.key,
    required this.tournamentId,
    required this.isOwner,
  });

  @override
  State<FantasyPage> createState() => _FantasyPageState();

  static String createTournamentLocation({
    required int tournamentId,
    required BuildContext context,
  }) {
    return context.namedLocation(
      _tournamentName,
      pathParameters: {
        "id": tournamentId.toString(),
      },
    );
  }

  static const _tournamentName = 'tournament_fantasy';

  static final GoRoute tournamentRoute = GoRoute(
    path: 'fantasy',
    name: _tournamentName,
    builder: (context, state) {
      final tournamentId = int.parse(state.pathParameters["id"]!);
      final isOwner = context.watch<TournamentPageBloc>().state.isMyTournament;
      final userId = context.read<AuthNotifier>().value.mapOrNull(
            authorized: (model) => model.userId,
          );

      return BlocProvider<FantasyBloc>(
        key: ValueKey("$tournamentId$isOwner"),
        create: (context) => getIt<FantasyBloc>(param1: context)
          ..add(
            FantasyEventInit(
              tournamentId: tournamentId,
              isOwner: isOwner,
              userId: userId,
            ),
          ),
        child: FantasyPage(
          tournamentId: tournamentId,
          isOwner: isOwner,
        ),
      );
    },
  );
}

class _FantasyPageState extends CustomState<FantasyPage> with WidgetsBindingObserver {
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
  Widget? buildMobile(BuildContext context) => BlocBuilder<FantasyBloc, FantasyState>(
        builder: (context, state) {
          if (state.isLoading && state.rating == null) {
            return const LoadingOverlayWidget();
          }

          return Column(
            children: [
              FantasyHeader(
                state: state,
                onParticipantsPressed: state.isOwner
                    ? () => FantasyParticipantsBottomSheet.show(
                          context,
                          widget.tournamentId,
                        )
                    : null,
              ),
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
                        FantasyNotificationsBanner(),
                        ValueListenableBuilder(
                          valueListenable: context.read<AuthNotifier>(),
                          builder: (context, state, child) =>
                              state.mapOrNull(
                                authorized: (_) => child,
                              ) ??
                              const SizedBox.shrink(),
                          child: FantasyPredictionSection(
                            state: state,
                            tournamentId: widget.tournamentId,
                          ),
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
      );

  @override
  Widget buildDesktop(BuildContext context) => BlocBuilder<FantasyBloc, FantasyState>(
        builder: (context, state) {
          if (state.isLoading && state.rating == null) {
            return const LoadingOverlayWidget();
          }
          return Column(
            children: [
              const SizedBox(height: 8),
              FantasyHeader(
                state: state,
                onParticipantsPressed: state.isOwner
                    ? () => FantasyParticipantsBottomSheet.show(
                          context,
                          widget.tournamentId,
                        )
                    : null,
              ),
              const SizedBox(height: 8),
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
          );
        },
      );
}
