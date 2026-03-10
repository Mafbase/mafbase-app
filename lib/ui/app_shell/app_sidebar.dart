import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_bloc.dart';
import 'package:seating_generator_web/ui/main/profile_page/profile_state.dart';
import 'package:seating_generator_web/utils.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  static const double width = 240;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final uri = GoRouterState.of(context).uri;
    final currentPath = uri.path;

    return Container(
      width: width,
      color: theme.darkBlueColor,
      child: Column(
        children: [
          _buildHeader(theme),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNavSection(context, currentPath, theme),
                  _buildAdditionalSection(context, currentPath, theme),
                ],
              ),
            ),
          ),
          _buildFooter(context, theme),
        ],
      ),
    );
  }

  Widget _buildHeader(MyTheme theme) {
    return Container(
      height: 89,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.sidebarDividerColor),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/logo.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 12),
          Text(
            'Mafbase',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavSection(
    BuildContext context,
    String currentPath,
    MyTheme theme,
  ) {
    final isTournaments = currentPath.startsWith('/tournament');
    final isClubs = currentPath.startsWith('/club');

    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Text(
              context.locale.sidebarNavigation,
              style: GoogleFonts.inter(
                color: theme.sidebarSectionTitleColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          _SidebarItem(
            icon: Icons.table_chart_outlined,
            label: context.locale.tournamentsListTitle,
            isActive: isTournaments,
            onTap: () {
              context.read<MainBloc>().add(
                    MainEvent.switchTab(
                      tab: MainPageTab.tournaments,
                    ),
                  );
            },
          ),
          _SidebarItem(
            icon: Icons.people_alt_outlined,
            label: context.locale.clubsHeader,
            isActive: isClubs,
            onTap: () {
              context.read<MainBloc>().add(
                    MainEvent.switchTab(
                      tab: MainPageTab.clubs,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalSection(
    BuildContext context,
    String currentPath,
    MyTheme theme,
  ) {
    final isContacts = currentPath.startsWith('/contacts');

    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Text(
              context.locale.sidebarAdditional,
              style: GoogleFonts.inter(
                color: theme.sidebarSectionTitleColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          _SidebarItem(
            icon: Icons.contacts_outlined,
            label: context.locale.contacts,
            isActive: isContacts,
            onTap: () {
              context.read<MainBloc>().add(const MainEvent.openContacts());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, MyTheme theme) => Container(
        height: 85,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: theme.sidebarDividerColor),
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: context.read<AuthNotifier>(),
          builder: (context, model, _) => model.map(
            loading: (_) => const SizedBox.shrink(),
            unauthorized: (_) => _buildLoginButton(context, theme),
            authorized: (_) => _buildUserInfo(context, theme),
          ),
        ),
      );

  Widget _buildLoginButton(BuildContext context, MyTheme theme) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            context.read<MainBloc>().add(const MainEvent.onEnterPressed());
          },
          style: TextButton.styleFrom(
            backgroundColor: theme.sidebarActiveItemBgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            context.locale.loginIn,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, MyTheme theme) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        final player = profileState.playerProfile;
        return InkWell(
          onTap: () {
            context.read<MainBloc>().add(const MainEvent.onProfilePressed());
          },
          borderRadius: BorderRadius.circular(8),
          child: Row(
            children: [
              _buildAvatar(player?.imageUrl, theme),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  player?.nickname ?? context.locale.profile,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.settings_outlined,
                color: theme.sidebarSectionTitleColor,
                size: 20,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar(String? imageUrl, MyTheme theme) {
    if (imageUrl != null) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 36,
          height: 36,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildDefaultAvatar(theme),
          errorWidget: (context, url, error) => _buildDefaultAvatar(theme),
        ),
      );
    }
    return _buildDefaultAvatar(theme);
  }

  Widget _buildDefaultAvatar(MyTheme theme) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: theme.darkGreyColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: theme.sidebarActiveItemBgColor,
        child: Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isActive ? theme.sidebarActiveItemBgColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : theme.sidebarInactiveTextColor,
                size: 22,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isActive ? Colors.white : theme.sidebarInactiveTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
