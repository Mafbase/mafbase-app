import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/di/storage_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/domain/interactors/logout_interactor.dart';
import 'package:seating_generator_web/feature/profile/domain/interactor/delete_profile_interactor.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_bloc.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';
import 'package:seating_generator_web/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage._();

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  static String createLocation(BuildContext context) =>
      context.namedLocation('profile');

  static final GoRoute route = GoRoute(
    path: '/profile',
    name: 'profile',
    pageBuilder: (context, state) => FadeTransitionPage(
      child: BlocProvider<ProfileBloc>(
        create: (context) {
          final logoutInteractor = LogoutInteractor(
            StorageFactory.of(context).tokenStorage,
            DependencyScope.of(context).authNotifier,
            StorageFactory.of(context).credentialStorage,
          );

          return ProfileBloc(
            logoutInteractor,
            StorageFactory.of(context).credentialStorage,
            DeleteProfileInteractor(
              logoutInteractor,
              RepositoryFactory.of(context).profileRepository,
            ),
            context,
          );
        },
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocSelector<ProfileBloc, ProfileState, String?>(
                selector: (state) => state.login,
                builder: (context, login) => Center(
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      style: MyTheme.of(context).fieldTextStyle,
                      children: [
                        const TextSpan(
                          text: 'Вы авторизованы как: ',
                        ),
                        TextSpan(
                          text: login ?? '',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    text: context.locale.logout,
                    onTap: () {
                      context
                          .read<ProfileBloc>()
                          .add(const ProfileEvent.onLogoutPressed());
                    },
                    isRed: true,
                    minimize: true,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _deleteAccount,
                    child: Text(
                      'Удалить аккаунт',
                      style: TextStyle(
                        color: MyTheme.of(context).greyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteAccount() async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Вы уверны?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Нет'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Да',
              style: TextStyle(
                color: MyTheme.of(context).redColor,
              ),
            ),
          ),
        ],
      ),
    );

    if (result != true) return;
    if (!mounted) return;

    context.read<ProfileBloc>().add(const ProfileEvent.deleteProfile());
  }
}
