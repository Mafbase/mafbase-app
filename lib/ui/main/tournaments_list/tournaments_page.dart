import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournament_item_row.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournament_status_widget.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_events.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_state.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage._({
    Key? key,
  }) : super(key: key);

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();

  static const String _name = 'tournaments';

  static String createLocation(BuildContext context) {
    return context.namedLocation(_name);
  }

  static final GoRoute route = GoRoute(
    path: '/tournament',
    name: _name,
    routes: [
      TournamentPage.createRoute(),
    ],
    pageBuilder: (context, state) => const NoTransitionPage(
      child: TournamentsPage._(),
    ),
  );
}

class _TournamentsPageState extends CustomState<TournamentsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TournamentsBloc>().add(const TournamentsEvent.opened());
  }

  @override
  Widget? buildMobile(BuildContext context) {
    return Container(
      color: context.theme.background2,
      child: Material(
        child: BlocBuilder<TournamentsBloc, TournamentsState>(
          builder: (context, state) {
            return ValueListenableBuilder(
              valueListenable: context.read<AuthNotifier>(),
              builder: (context, authModel, child) {
                return Stack(
                  children: [
                    child ?? Container(),
                    if (authModel is AuthNotifierAuthorizedModel)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: FloatingActionButton(
                          elevation: 10,
                          onPressed: () {
                            context
                                .read<TournamentsBloc>()
                                .add(const TournamentsEvent.create());
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (state.isLoading) const LoadingOverlayWidget(),
                  ],
                );
              },
              child: ListView.builder(
                itemCount: state.tournaments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: TournamentItemRow(
                      tournamentModel: state.tournaments[index],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return Container(
      color: context.theme.background2,
      child: Material(
        child: BlocBuilder<TournamentsBloc, TournamentsState>(
          builder: (context, state) {
            return ValueListenableBuilder(
              valueListenable: context.read<AuthNotifier>(),
              builder: (context, authModel, child) {
                return Stack(
                  children: [
                    child ?? Container(),
                    if (authModel is AuthNotifierAuthorizedModel)
                      Positioned(
                        bottom: 35,
                        right: 35,
                        child: FloatingActionButton.large(
                          elevation: 10,
                          onPressed: () {
                            context
                                .read<TournamentsBloc>()
                                .add(const TournamentsEvent.create());
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (state.isLoading) const LoadingOverlayWidget(),
                  ],
                );
              },
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 50),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .tournamentsListTitle,
                              style: MyTheme.of(context).headerTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: state.tournaments.length, (context, index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              context.read<MainBloc>().add(
                                    MainEvent.tournamentSelected(
                                      tournamentId: state.tournaments[index].id,
                                    ),
                                  );
                            },
                            child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 900,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 25,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: MyTheme.of(context)
                                    .greyColor
                                    .withOpacity(0.16),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(
                                      state.tournaments[index].dateStart,
                                    ),
                                    style: MyTheme.of(context).defaultTextStyle,
                                  ),
                                  const SizedBox(
                                    width: 35,
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.tournaments[index].name,
                                      style: MyTheme.of(context).defaultTextStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TournamentStatusWidget(
                                      status: state.tournaments[index].status,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
