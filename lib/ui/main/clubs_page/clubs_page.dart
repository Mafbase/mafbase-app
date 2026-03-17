import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/domain/interactors/get_clubs_interactor.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_router.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_bloc.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_event.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_state.dart';
import 'package:seating_generator_web/ui/main/clubs_page/widgets/single_club_row.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({super.key});

  @override
  State<ClubsPage> createState() => _ClubsPageState();

  static String createLocation(BuildContext context) {
    return context.namedLocation('clubs');
  }

  static final GoRoute route = GoRoute(
    path: '/club',
    name: 'clubs',
    builder: (context, state) => BlocProvider<ClubsBloc>(
      create: (context) {
        final repos = RepositoryFactory.of(context);
        return ClubsBloc(
          getClubsInteractor: GetClubsInteractor(repos.clubRepository),
          router: ClubsRouterImpl(context),
        );
      },
      child: const ClubsPage(),
    ),
  );
}

class _ClubsPageState extends CustomState<ClubsPage> {
  @override
  void initState() {
    context.read<ClubsBloc>().add(const ClubsEvent.pageOpened());
    super.initState();
  }

  AppBar _buildMobileAppBar(BuildContext context) {
    final theme = context.theme;
    return AppBar(
      leading: BackButton(onPressed: context.backOrGoToDefault),
      title: InkWell(
        onTap: () => context.go('/'),
        child: Text(
          'Mafbase',
          style: GoogleFonts.balooBhai2(
            color: Colors.white,
            fontSize: 48,
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
                style: theme.defaultTextStyle.copyWith(
                  color: theme.background1,
                ),
              ),
            ),
            loading: (_) => Container(),
            authorized: (_) => IconButton(
              tooltip: context.locale.profile,
              onPressed: () {
                context.read<MainBloc>().add(const MainEvent.onProfilePressed());
              },
              hoverColor: theme.background1.withValues(alpha: 0.2),
              icon: Icon(
                Icons.person,
                color: theme.background1,
              ),
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

  @override
  Widget? buildMobile(BuildContext context) => Scaffold(
        appBar: _buildMobileAppBar(context),
        body: BlocBuilder<ClubsBloc, ClubsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const LoadingOverlayWidget();
            }

            return RefreshIndicator(
              onRefresh: () {
                final completer = Completer();
                context.read<ClubsBloc>().add(
                      ClubsEvent.pageOpened(completer: completer),
                    );

                return completer.future;
              },
              child: ListView.builder(
                itemCount: state.clubs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: SingleClubRow(
                      style: ClubRowStyle.mobile,
                      model: state.clubs[index],
                      onTap: () {
                        context.read<ClubsBloc>().add(
                              ClubsEvent.clubSelected(
                                clubModel: state.clubs[index],
                              ),
                            );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      );

  @override
  Widget buildDesktop(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(context.locale.clubsHeader),
        ),
        body: BlocBuilder<ClubsBloc, ClubsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const LoadingOverlayWidget();
            }
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.clubs.length,
                      (context, index) {
                        return Center(
                          child: SingleClubRow(
                            model: state.clubs[index],
                            onTap: () {
                              context.read<ClubsBloc>().add(
                                    ClubsEvent.clubSelected(
                                      clubModel: state.clubs[index],
                                    ),
                                  );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
}
