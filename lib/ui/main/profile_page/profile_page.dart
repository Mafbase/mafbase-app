import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_bloc.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage._({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  static String createLocation(BuildContext context) =>
      context.namedLocation('profile');

  static final GoRoute route = GoRoute(
    path: '/profile',
    name: 'profile',
    pageBuilder: (context, state) => FadeTransitionPage(
      child: BlocProvider<ProfileBloc>(
        create: (context) => getIt<ProfileBloc>(param1: context),
        child: const ProfilePage._(),
      ),
    ),
  );
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(const ProfileEvent.onPageOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Placeholder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: CustomButton(
                text: context.locale.logout,
                onTap: () {
                  context
                      .read<ProfileBloc>()
                      .add(const ProfileEvent.onLogoutPressed());
                },
                isRed: true,
                minimize: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
