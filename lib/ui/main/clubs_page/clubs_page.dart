import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/domain/interactors/get_clubs_interactor.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_router.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/club_page/club_page.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_bloc.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_event.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_state.dart';
import 'package:seating_generator_web/ui/main/clubs_page/widgets/single_club_row.dart';
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

  @override
  Widget? buildMobile(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: context.backOrGoToDefault),
          title: Text(context.locale.clubsHeader),
        ),
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
                  padding: EdgeInsets.all(16),
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
