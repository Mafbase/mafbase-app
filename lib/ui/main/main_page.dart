import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
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

  const MainPage({Key? key, this.child}) : super(key: key);

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
            appBar: buildAppBar(
              context: context,
              state: state,
            ),
            body: widget.child,
          );
        },
      ),
    );
  }

  AppBar buildAppBar({
    required BuildContext context,
    required MainState state,
  }) {
    return AppBar(
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
      actions: getProfileAction(context.watch<AuthNotifier>().value),
      title: Text(
        titleProvider.value.isEmpty ? "mafbase" : titleProvider.value,
        style: GoogleFonts.balooBhai2(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  List<Widget> getProfileAction(AuthNotifierModel model) {
    final theme = context.theme;
    return [
      model.map(
        unauthorized: (_) => TextButton(
          onPressed: () {
            context.read<MainBloc>().add(const MainEvent.onEnterPressed());
          },
          child: Text(
            context.locale.loginIn,
            style: context.theme.defaultTextStyle.copyWith(
              color: context.theme.background1,
            ),
          ),
        ),
        loading: (_) => Container(),
        authorized: (_) => IconButton(
          onPressed: () {
            context.read<MainBloc>().add(const MainEvent.onProfilePressed());
          },
          hoverColor: context.theme.background1.withOpacity(0.2),
          icon: Icon(
            Icons.person,
            color: context.theme.background1,
          ),
        ),
      ),
      const SizedBox(width: 8),
      PopupMenuButton(
        splashRadius: 24,
        color: theme.darkBlueColor,
        child: Icon(
          Icons.more_vert_outlined,
          color: context.theme.btnTextColor,
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
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(
                    Icons.contact_support_outlined,
                    color: theme.btnTextColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    context.locale.aboutApp,
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
  Widget? buildMobile(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: titleProvider,
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(
              context: context,
              state: state,
            ),
            body: widget.child,
          );
        },
      ),
    );
  }
}
