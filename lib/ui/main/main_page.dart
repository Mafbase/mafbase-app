import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/main_state.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class TitleProvider extends ValueNotifier<String> {
  TitleProvider(super.value);

  static void update({
    required BuildContext context,
    required String title,
  }) {
    context.read<TitleProvider>().value = title;
  }
}

class MainPage extends StatefulWidget {
  final Widget? child;

  const MainPage({Key? key, this.child})
      : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends CustomState<MainPage> {
  final titleProvider = TitleProvider("");

  void listener() {
    setState(() {});
  }

  @override
  void initState() {
    context.read<MainBloc>().add(const MainEvent.onPageOpened());
    titleProvider.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    titleProvider.removeListener(listener);
    super.dispose();
  }

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

  int selectedIndex(MainState state) =>
      state.selectedTab == MainPageTab.tournaments ? 0 : 1;

  @override
  Widget buildDesktop(BuildContext context) {
    const double railWidth = 100;
    return ChangeNotifierProvider.value(
      value: titleProvider,
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
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
            body: widget.child,
          );
        },
      ),
    );
  }

  @override
  Widget? buildMobile(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: titleProvider,
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Scaffold(
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
              title: Text(
                titleProvider.value.isEmpty ? "mafbase" : titleProvider.value,
                style: GoogleFonts.balooBhai2(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: widget.child,
          );
        },
      ),
    );
  }
}
