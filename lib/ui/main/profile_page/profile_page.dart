import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/app/di/dependency_scope.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/di/storage_factory.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/fade_transition_page.dart';
import 'package:seating_generator_web/domain/interactors/create_player_interactor.dart';
import 'package:seating_generator_web/domain/interactors/get_all_players_interactor.dart';
import 'package:seating_generator_web/domain/interactors/logout_interactor.dart';
import 'package:seating_generator_web/feature/profile/domain/interactor/delete_profile_interactor.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_bloc.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/add_player_dialog.dart';
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
            RepositoryFactory.of(context).profileRepository,
            getIt<CreatePlayerInteractor>(),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocSelector<ProfileBloc, ProfileState, String?>(
                    selector: (state) => state.login,
                    builder: (context, login) => Text.rich(
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
                  const SizedBox(height: 24),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (state.playerProfile != null) ...[
                            Text(
                              'Связанный профиль игрока:',
                              style: MyTheme.of(context).fieldTextStyle,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: state.playerProfile!.imageUrl == null
                                        ? Image.asset(
                                            AppAssets.playerPhoto,
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: state.playerProfile!.imageUrl!,
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Image.asset(
                                              AppAssets.playerPhoto,
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget: (context, url, error) => Image.asset(
                                              AppAssets.playerPhoto,
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.playerProfile!.nickname,
                                        style: MyTheme.of(context)
                                            .fieldTextStyle
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      if (state.playerProfile!.fsmNickaname != null)
                                        Text(
                                          'ФСМ: ${state.playerProfile!.fsmNickaname}',
                                          style: MyTheme.of(context).fieldTextStyle.copyWith(
                                                fontSize: 12,
                                                color: Colors.grey.shade600,
                                              ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ] else ...[
                            Text(
                              'Профиль игрока не выбран',
                              style: MyTheme.of(context).fieldTextStyle,
                            ),
                            const SizedBox(height: 16),
                          ],
                          TextButton(
                            onPressed: () => _selectPlayerProfile(context),
                            child: Text(
                              state.playerProfile != null
                                  ? 'Изменить профиль игрока'
                                  : 'Выбрать профиль игрока',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
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

  Future<void> _selectPlayerProfile(BuildContext context) async {
    final bloc = context.read<ProfileBloc>();
    final getAllPlayersInteractor = getIt<GetAllPlayersInteractor>();
    final availablePlayers = await getAllPlayersInteractor.run();

    if (!context.mounted) return;

    final selectedPlayer = await AddPlayerDialog.open(
      context: context,
      availablePlayers: availablePlayers,
    );

    if (!context.mounted) return;

    if (selectedPlayer != null) {
      bloc.add(ProfileEvent.setUserProfile(selectedPlayer));
    }
  }

  void _deleteAccount() async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.locale.confirmText),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.locale.no),
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
