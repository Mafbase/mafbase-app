import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier_model.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_bloc.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_effect.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';
import 'package:seating_generator_web/ui/main/profile_page/widgets/profile_actions_card.dart';
import 'package:seating_generator_web/ui/main/profile_page/widgets/profile_loading_skeletons.dart';
import 'package:seating_generator_web/ui/main/profile_page/widgets/profile_player_card.dart';
import 'package:seating_generator_web/ui/main/profile_page/widgets/tournament_subscription_section.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/add_player_dialog.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:seating_generator_web/feature/webview/web_view_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage._();

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  static String createLocation(BuildContext context) => context.namedLocation('profile');

  static final GoRoute route = GoRoute(
    path: '/profile',
    name: 'profile',
    builder: (context, state) => const ProfilePage._(),
  );
}

class _ProfilePageState extends State<ProfilePage>
    with EffectListener<ProfileEffect, ProfileState, ProfileBloc, ProfilePage> {
  @override
  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {
    on<ProfileEffectNavigateBack>((effect) {
      if (mounted) context.go('/');
    });
    on<ProfileEffectOpenBillingUrl>((effect) {
      if (!mounted) return;
      final url = effect.url;
      final uri = Uri.parse(url);
      if (kIsWeb) {
        launchUrl(uri, webOnlyWindowName: '_self');
      } else {
        context.push(
          WebViewScreen.createLocation(
            url: url,
            title: context.locale.profilePaymentTitle,
            context: context,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final isMobile = context.isMobile;
    final showBillingSection = !(context.watch<AuthNotifier>().value.mapOrNull(
              authorized: (model) => model.hideBilling,
            ) ??
        false);

    return Scaffold(
      backgroundColor: theme.background1,
      appBar: AppBar(
        leading: BackButton(onPressed: context.backOrGoToDefault()),
        title: Text(context.locale.profile),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.isLoading && state.playerProfile == null) {
            return const ProfileLoadingSkeletons();
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfilePlayerCard(
                      player: state.playerProfile,
                      isMobile: isMobile,
                      onChangePlayer: () => _selectPlayerProfile(context),
                      onLinkPlayer: () => _selectPlayerProfile(context),
                    ),
                    const SizedBox(height: 12),
                    if (showBillingSection) ...[
                      const TournamentSubscriptionSection(),
                      const SizedBox(height: 12),
                    ],
                    ProfileActionsCard(
                      onPhotoThemes: () => context.go('/photo-themes'),
                      onLogout: () => context.read<ProfileBloc>().add(const ProfileEvent.onLogoutPressed()),
                      onDeleteAccount: _deleteAccount,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectPlayerProfile(BuildContext context) async {
    final bloc = context.read<ProfileBloc>();

    final selectedPlayer = await AddPlayerDialog.open(
      context: context,
      player: bloc.state.playerProfile,
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
              context.locale.yes,
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
