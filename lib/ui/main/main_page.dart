import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
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

  const MainPage({super.key, this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends CustomState<MainPage> {
  final titleProvider = TitleProvider("");

  void listener() {
    setState(() {});
  }

  void routeListener() => Future.delayed(
        const Duration(milliseconds: 16),
        listener,
      );

  @override
  void initState() {
    titleProvider.addListener(listener);
    GoRouter.of(context).routeInformationProvider.addListener(routeListener);
    super.initState();
  }

  @override
  void dispose() {
    titleProvider.removeListener(listener);
    GoRouter.of(context).routeInformationProvider.removeListener(routeListener);
    super.dispose();
  }

  @override
  Widget buildDesktop(BuildContext context) {
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
  }) =>
      AppBar(
        leading: IconTheme(
          data: IconTheme.of(context).copyWith(
            color: MyTheme.of(context).btnTextColor,
          ),
          child: ListenableBuilder(
            listenable: GoRouter.of(context).routeInformationProvider,
            builder: (context, child) {
              return context.canPop()
                  ? BackButton(onPressed: context.pop)
                  : Navigator.canPop(context)
                      ? BackButton(onPressed: () => Navigator.pop(context))
                      : const SizedBox.shrink();
            },
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
          tooltip: context.locale.profile,
          onPressed: () {
            context.read<MainBloc>().add(const MainEvent.onProfilePressed());
          },
          hoverColor: context.theme.background1.withValues(alpha: 0.2),
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
