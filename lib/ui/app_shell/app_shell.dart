import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/domain/interactors/add_photo_interactor.dart';
import 'package:seating_generator_web/domain/interactors/create_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/logout_interactor.dart';
import 'package:seating_generator_web/feature/profile/domain/interactor/delete_profile_interactor.dart';
import 'package:seating_generator_web/ui/app_shell/app_sidebar.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_bloc.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

@RoutePage()
class AppShellPage extends StatefulWidget {
  const AppShellPage({super.key});

  @override
  State<AppShellPage> createState() => _AppShellState();
}

class _AppShellState extends CustomState<AppShellPage> {
  @override
  Widget build(BuildContext context) {
    final scope = DependencyScope.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          key: const Key('MainBlocProvider'),
          create: (context) => MainBloc(MainPageRouterImpl(context)),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) {
            final logoutInteractor = LogoutInteractor(
              scope.storageFactory.tokenStorage,
              scope.authNotifier,
              scope.storageFactory.credentialStorage,
            );
            return ProfileBloc(
              logoutInteractor,
              DeleteProfileInteractor(
                logoutInteractor,
                scope.repositoryFactory.profileRepository,
              ),
              scope.repositoryFactory.profileRepository,
              CreatePlayerInteractor(scope.repositoryFactory.playersRepository),
              AddPhotoInteractor(scope.repositoryFactory.playersRepository),
              scope.authNotifier,
            );
          },
        ),
      ],
      child: super.build(context),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const AppSidebar(),
          const Expanded(child: AutoRouter()),
        ],
      ),
    );
  }

  @override
  Widget? buildMobile(BuildContext context) => const AutoRouter();
}
