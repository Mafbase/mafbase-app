import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/domain/interactors/create_tournament_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_my_tournaments_interactor.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_router.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_page.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
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
                GetMyTournamentsInteractor(repos.tournamentsRepository),
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
          appBar: _buildMobileAppBar(context),
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

  AppBar _buildMobileAppBar(BuildContext context) {
    return AppBar(
      leading: BackButton(onPressed: context.backOrGoToDefault),
      title: InkWell(
        onTap: () => context.go('/'),
        child: Text(
          'Mafbase',
          style: GoogleFonts.balooBhai2(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      actions: _buildMobileActions(context),
    );
  }

  List<Widget> _buildMobileActions(BuildContext context) {
    final theme = context.theme;
    return [
      ValueListenableBuilder(
        valueListenable: context.read<AuthNotifier>(),
        builder: (context, model, child) => model.map(
          unauthorized: (_) => TextButton(
            onPressed: () {
              context.read<MainBloc>().add(const MainEvent.onEnterPressed());
            },
            child: Text(
              context.locale.loginIn,
              style: theme.defaultTextStyle.copyWith(
                color: theme.background1,
              ),
            ),
          ),
          loading: (_) => Container(),
          authorized: (_) => IconButton(
            tooltip: context.locale.profile,
            onPressed: () {
              context.read<MainBloc>().add(const MainEvent.onProfilePressed());
            },
            hoverColor: theme.background1.withValues(alpha: 0.2),
            icon: Icon(
              Icons.person,
              color: theme.background1,
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      PopupMenuButton(
        splashRadius: 24,
        color: theme.darkBlueColor,
        child: Icon(
          Icons.more_vert_outlined,
          color: theme.btnTextColor,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () {
                context.read<MainBloc>().add(const MainEvent.openContacts());
              },
              child: Row(
                children: [
                  Icon(
                    Icons.contacts_outlined,
                    color: theme.btnTextColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    context.locale.contacts,
                    style: theme.btnTextStyle.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
      const SizedBox(width: 8),
    ];
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return widget.shell;
  }
}
