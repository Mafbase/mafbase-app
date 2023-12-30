import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_page.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class RailWrapper extends StatefulWidget {
  static final ShellRoute route = ShellRoute(
    routes: [
      TournamentsPage.route,
      ClubsPage.route,
    ],
    builder: (context, state, child) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<TournamentsBloc>(
            key: const Key("TournamentsBlocProvider"),
            create: (context) => getIt<TournamentsBloc>(param1: context),
          ),
        ],
        child: RailWrapper._(
          child: child,
        ),
      );
    },
  );
  final Widget? child;

  const RailWrapper._({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  State<RailWrapper> createState() => _RailWrapperState();
}

class _RailWrapperState extends CustomState<RailWrapper> {
  double railWidth = 100;

  int selectedIndex(MainState state) =>
      state.selectedTab == MainPageTab.tournaments ? 0 : 1;

  void onDestinationSelected(int index) {
    MainPageTab? tab;
    switch (index) {
      case 0:
        tab = MainPageTab.tournaments;
        break;
      case 1:
        tab = MainPageTab.clubs;
        break;
    }
    if (tab != null) {
      context.read<MainBloc>().add(
            MainEvent.switchTab(
              tab: tab,
              hasBackButton: false,
            ),
          );
    }
  }

  @override
  Widget buildMobile(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: widget.child,
          bottomNavigationBar: BottomNavigationBar(
            useLegacyColorScheme: false,
            currentIndex: selectedIndex(state),
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
    return BlocBuilder<MainBloc, MainState>(
      builder: (BuildContext context, state) {
        return Stack(
          children: [
            Positioned(
              top: 0,
              left: railWidth,
              right: 0,
              bottom: 0,
              child: widget.child ?? Container(),
            ),
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              width: railWidth,
              child: NavigationRail(
                useIndicator: true,
                unselectedIconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                selectedIconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                indicatorColor: context.theme.darkBlueColor,
                backgroundColor: context.theme.darkGreyColor,
                labelType: NavigationRailLabelType.all,
                elevation: 5,
                onDestinationSelected: onDestinationSelected,
                destinations: [
                  NavigationRailDestination(
                    icon: const Icon(Icons.table_chart_outlined),
                    label: Text(
                      context.locale.tournamentsListTitle,
                      style: const TextStyle()
                          .copyWith(color: context.theme.background1),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(Icons.people_alt_outlined),
                    label: Text(
                      context.locale.clubsHeader,
                      style: const TextStyle()
                          .copyWith(color: context.theme.background1),
                    ),
                  ),
                ],
                selectedIndex: selectedIndex(state),
              ),
            ),
          ],
        );
      },
    );
  }
}
