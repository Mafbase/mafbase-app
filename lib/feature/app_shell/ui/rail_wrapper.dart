import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/feature/app_shell/ui/main_bloc.dart';
import 'package:seating_generator_web/feature/app_shell/ui/main_state.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

@RoutePage(name: 'RailWrapperRoute')
class RailWrapperPage extends StatelessWidget {
  const RailWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [TournamentsRoute(), ClubsRoute()],
      builder: (context, child) => RailWrapper(child: child),
    );
  }
}

class RailWrapper extends StatefulWidget {
  final Widget child;

  const RailWrapper({super.key, required this.child});

  @override
  State<RailWrapper> createState() => _RailWrapperState();
}

class _RailWrapperState extends CustomState<RailWrapper> {
  void onDestinationSelected(int index) => context.tabsRouter.setActiveIndex(index);

  @override
  Widget buildMobile(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: widget.child,
          bottomNavigationBar: BottomNavigationBar(
            useLegacyColorScheme: false,
            currentIndex: context.tabsRouter.activeIndex,
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
    return widget.child;
  }
}
