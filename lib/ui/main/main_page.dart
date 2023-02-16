import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';
import 'package:seating_generator_web/ui/main/widgets/custom_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seating_generator_web/utils.dart';

class MainPage extends StatefulWidget {
  final bool hasBackButton;
  final Widget? child;

  const MainPage({Key? key, this.hasBackButton = false, this.child})
      : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    context.read<MainBloc>().add(const MainEvent.onPageOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double railWidth = 72;
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        int selectedIndex =
            state.selectedTab == MainPageTab.tournaments ? 0 : 1;
        debugPrint(state.toString());
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IgnorePointer(
              ignoring: !state.hasBackButton,
              child: Opacity(
                opacity: state.hasBackButton ? 1 : 0,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                ),
              ),
            ),
            backgroundColor: context.theme.darkBlueColor,
            title: Row(
              children: [
                InkWell(
                  onTap: () {
                    context
                        .read<MainBloc>()
                        .add(const MainEvent.onTitleTapped());
                  },
                  child: Text(
                    "mafbase",
                    style: GoogleFonts.balooBhai2(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          body: Stack(
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
                  labelType: NavigationRailLabelType.all,
                  elevation: 5,
                  backgroundColor: context.theme.darkGreyColor,
                  onDestinationSelected: (index) {
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
                  },
                  destinations: [
                    NavigationRailDestination(
                      icon: const Icon(Icons.table_chart_outlined),
                      label: Text(
                        "Турниры",
                        style: const TextStyle()
                            .copyWith(color: context.theme.background1),
                      ),
                    ),
                    NavigationRailDestination(
                      icon: const Icon(Icons.people_alt_outlined),
                      label: Text(
                        "Клубы",
                        style: const TextStyle()
                            .copyWith(color: context.theme.background1),
                      ),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
