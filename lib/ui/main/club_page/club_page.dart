import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/domain/models/club_model.dart';
import 'package:seating_generator_web/feature/club_games/club_games_page.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/club_page/club_bloc.dart';
import 'package:seating_generator_web/ui/main/club_page/club_event.dart';
import 'package:seating_generator_web/ui/main/club_page/club_state.dart';
import 'package:seating_generator_web/ui/main/club_page/widgets/club_bill_dialog.dart';
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
      pathParameters: {"clubId": id.toString()},
      extra: cachedModel,
    );
  }

  static final route = GoRoute(
    name: 'club',
    path: ':clubId',
    builder: (context, state) => BlocProvider<ClubBloc>(
      create: (context) {
        final args = ClubBlocArgs(
          clubId: int.parse(state.pathParameters["clubId"]!),
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
      RatingPage.clubRoute,
      ClubGamesPage.route,
    ],
  );
}

class _ClubPageState extends CustomState<ClubPage> {
  @override
  void initState() {
    context.read<ClubBloc>().add(const ClubEvent.pageOpened());
    super.initState();
  }

  @override
  Widget? buildMobile(BuildContext context) => BlocBuilder<ClubBloc, ClubState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              if (state.model != null)
                ClubInfoWidget(
                  clubModel: state.model!,
                  isMobile: true,
                  onAddGame: state.isOwner ? _addNewGame : null,
                  billClub: state.isOwner ? _bill : null,
                  changeHideDate: state.isOwner ? _changeHideDate : null,
                ),
            ],
          );
        },
      );

  @override
  Widget buildDesktop(BuildContext context) {
    final showBill = !(context.watch<AuthNotifier>().value.mapOrNull(
              authorized: (model) => model.hideBilling,
            ) ??
        false);

    return BlocBuilder<ClubBloc, ClubState>(
      builder: (context, state) => state.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Row(
                  children: [
                    if (state.model != null)
                      Expanded(
                        child: ClubInfoWidget(
                          clubModel: state.model!,
                          onAddGame: state.isOwner ? _addNewGame : null,
                          billClub: state.isOwner ? _bill : null,
                          changeHideDate:
                              state.isOwner ? _changeHideDate : null,
                        ),
                      ),
                  ],
                ),
                if (state.isOwner && showBill)
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton.large(
                      backgroundColor: context.theme.redColor,
                      onPressed: _bill,
                      child: const Icon(Icons.monetization_on_outlined),
                    ),
                  ),
              ],
            ),
    );
  }

  void _addNewGame() => context.go(
        AddClubGamePage.createLocation(
          context,
          context.read<ClubBloc>().state.model!.id,
        ),
      );

  void _changeHideDate() async {
    final bloc = context.read<ClubBloc>();

    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      initialDate: bloc.state.hideDate,
    );

    if (date == null) return;

    bloc.add(ClubEvent.changeHideDate(dateTime: date));
  }

  void _bill() async {
    final bloc = context.read<ClubBloc>();
    final option = await ClubBillDialog.open(
      context: context,
      billedFor: bloc.state.model?.billedFor,
    );

    if (!context.mounted) return;
    if (option != null) {
      bloc.add(
        ClubEvent.billClub(
          days: option.days,
        ),
      );
    }
  }
}
