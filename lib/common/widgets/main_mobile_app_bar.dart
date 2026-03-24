import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/utils.dart';

class MainMobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainMobileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return AppBar(
      title: InkWell(
        onTap: () => context.go('/'),
        child: Text(
          'Mafbase',
          style: GoogleFonts.balooBhai2(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      actions: [
        ValueListenableBuilder(
          valueListenable: context.read<AuthNotifier>(),
          builder: (context, model, child) => model.map(
            unauthorized: (_) => TextButton(
              onPressed: () {
                context.read<MainBloc>().add(const MainEvent.onEnterPressed());
              },
              child: Text(
                context.locale.loginIn,
                style: TextStyle(color: IconTheme.of(context).color),
              ),
            ),
            loading: (_) => Container(),
            authorized: (_) => IconButton(
              tooltip: context.locale.profile,
              onPressed: () {
                context.read<MainBloc>().add(const MainEvent.onProfilePressed());
              },
              hoverColor: theme.background1.withValues(alpha: 0.2),
              icon: const Icon(Icons.person),
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
      ],
    );
  }
}
