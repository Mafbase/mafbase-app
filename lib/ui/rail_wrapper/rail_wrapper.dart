import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/domain/interactors/create_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_tournaments_interactor.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_router.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_page.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class RailWrapper extends StatefulWidget {
  static final route = StatefulShellRoute.indexedStack(
    branches: [
      StatefulShellBranch(
        initialLocation: '/tournament',
        routes: [
          TournamentsPage.route,
        ],
      ),
      StatefulShellBranch(
        initialLocation: '/club',
        routes: [
          ClubsPage.route,
        ],
      ),
    ],
    builder: (context, state, shell) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<TournamentsBloc>(
            key: const Key('TournamentsBlocProvider'),
            create: (context) {
              final repos = RepositoryFactory.of(context);
              return TournamentsBloc(
                GetTournamentsInteractor(repos.tournamentsRepository),
                CreateTournamentInteractor(repos.tournamentsRepository),
                TournamentsRouterImpl(context),
              );
            },
          ),
        ],
        child: RailWrapper._(
          shell: shell,
        ),
      );
    },
  );
  final StatefulNavigationShell shell;

  const RailWrapper._({
    required this.shell,
  });

  @override
  State<RailWrapper> createState() => _RailWrapperState();
}

class _RailWrapperState extends CustomState<RailWrapper> {
  void onDestinationSelected(int index) => widget.shell.goBranch(
        index,
        initialLocation: widget.shell.currentIndex == index,
      );

  @override
  Widget buildMobile(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: widget.shell,
          bottomNavigationBar: BottomNavigationBar(
            useLegacyColorScheme: false,
            currentIndex: widget.shell.currentIndex,
            onTap: onDestinationSelected,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.table_chart_outlined),
                label: context.locale.tournamentsListTitle,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.people_alt_outlined),
                label: context.locale.clubsHeader,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return widget.shell;
  }
}
