import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/club_page/club_bloc.dart';
import 'package:seating_generator_web/ui/main/club_page/club_event.dart';
import 'package:seating_generator_web/ui/main/club_page/club_state.dart';
import 'package:seating_generator_web/ui/main/club_page/widgets/club_info_widget.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class ClubPage extends StatefulWidget {
  const ClubPage._({Key? key}) : super(key: key);

  @override
  State<ClubPage> createState() => _ClubPageState();

  static void open({
    required BuildContext context,
    required int id,
    ClubModel? cachedModel,
  }) {
    context.goNamed(
      'club',
      params: {"clubId": id.toString()},
      extra: cachedModel,
    );
  }

  static final route = GoRoute(
    name: 'club',
    path: ':clubId',
    builder: (context, state) => BlocProvider<ClubBloc>(
      create: (context) {
        final args = ClubBlocArgs(
          clubId: int.parse(state.params["clubId"]!),
          cachedModel: state.extra as ClubModel?,
        );
        return getIt(param1: context, param2: args);
      },
      child: Container(
        color: context.theme.background1,
        child: const ClubPage._(),
      ),
    ),
    routes: [
      ...AddClubGamePage.routes,
      RatingPage.route,
    ],
  );
}

class _ClubPageState extends CustomState<ClubPage> {
  @override
  bool get expanded => true;

  @override
  void initState() {
    context.read<ClubBloc>().add(const ClubEvent.pageOpened());
    super.initState();
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return BlocBuilder<ClubBloc, ClubState>(
      builder: (context, state) {
        return Row(
          children: [
            if (state.model != null)
              Expanded(
                child: ClubInfoWidget(
                  clubModel: state.model!,
                ),
              ),
          ],
        );
      },
    );
  }
}
