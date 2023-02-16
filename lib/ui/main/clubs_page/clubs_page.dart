import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/club_page/club_page.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_bloc.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_event.dart';
import 'package:seating_generator_web/ui/main/clubs_page/clubs_state.dart';
import 'package:seating_generator_web/ui/main/clubs_page/widgets/single_club_row.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({Key? key}) : super(key: key);

  @override
  State<ClubsPage> createState() => _ClubsPageState();

  static String createLocation(BuildContext context) {
    return context.namedLocation('clubs');
  }

  static final GoRoute route = GoRoute(
    path: 'club',
    name: 'clubs',
    builder: (context, state) => BlocProvider<ClubsBloc>(
      create: (context) => getIt(param1: context),
      child: const ClubsPage(),
    ),
    routes: [
      ClubPage.route,
    ],
  );
}

class _ClubsPageState extends CustomState<ClubsPage> {
  @override
  bool get expanded => true;
  @override
  void initState() {
    context.read<ClubsBloc>().add(const ClubsEvent.pageOpened());
    super.initState();
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return Container(
      color: context.theme.background2,
      child: BlocBuilder<ClubsBloc, ClubsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingOverlayWidget();
          }
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Center(
                      child: Text(
                        context.locale.clubsHeader,
                        style: context.theme.headerTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
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
            ],
          );
        },
      ),
    );
  }
}
