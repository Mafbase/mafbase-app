import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_effect.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_state.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/players_list_body.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/tournament_billing_dialog.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/tournament_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/tournament_settings_dialog.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class TournamentPage extends StatefulWidget {
  final Widget child;

  const TournamentPage({Key? key, required this.child}) : super(key: key);

  @override
  State<TournamentPage> createState() => _TournamentPageState();

  static String createLocation({
    required BuildContext context,
    required int tournamentId,
  }) {
    return context.namedLocation(
      "tournament_page",
      params: {
        "id": "$tournamentId",
      },
    );
  }

  static RouteBase createRoute() => ShellRoute(
        routes: [
          GoRoute(
            name: "tournament_page",
            path: ":id",
            routes: [
              SeatingPage.route,
              SeatingInsertingPage.route,
            ],
            builder: (context, state) {
              return PlayersListBody(
                tournamentId: int.parse(state.params["id"] ?? ""),
              );
            },
          )
        ],
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TournamentPageBloc>(
                key: const Key("TournamentPageBloc"),
                create: (context) => getIt<TournamentPageBloc>(
                  param1: context,
                  param2: int.parse(state.params["id"] ?? ""),
                ),
              ),
              BlocProvider<SeatingPageBloc>(
                key: const Key("SeatingPageBloc"),
                create: (context) => getIt<SeatingPageBloc>(
                  param1: context,
                ),
              ),
            ],
            child: TournamentPage(child: child),
          );
        },
      );
}

class _TournamentPageState extends CustomState<TournamentPage>
    with
        EffectListener<TournamentPageEffect, TournamentPageState,
            TournamentPageBloc, TournamentPage> {
  @override
  bool get expanded => true;

  @override
  void initState() {
    context
        .read<TournamentPageBloc>()
        .add(const TournamentPageEvent.pageOpened());
    super.initState();
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return Row(
      children: [
        Expanded(child: widget.child),
        BlocBuilder<TournamentPageBloc, TournamentPageState>(
          builder: (context, state) => TournamentMenu(
            items: [
              MenuItemModel(
                text: context.locale.tournamentPageListOfPlayers,
                onTap: () {
                  context
                      .read<TournamentPageBloc>()
                      .add(const TournamentPageEvent.playersListTapped());
                },
              ),
              MenuItemModel(
                text: AppLocalizations.of(context)!.addPlayer,
                onTap: () {
                  context.read<TournamentPageBloc>().add(
                        const TournamentPageEvent.addPlayerTapped(),
                      );
                },
              ),
              MenuItemModel(
                text: context.locale.seating,
                onTap: () {
                  context
                      .read<TournamentPageBloc>()
                      .add(const TournamentPageEvent.openSeatingPage());
                },
              ),
              MenuItemModel(
                text: context.locale.tournamentSettingsTitle,
                onTap: () async {
                  final oldSettings =
                      context.read<TournamentPageBloc>().state.settings;
                  final settings = await TournamentSettingsDialog.open(
                    context: context,
                    initValue: oldSettings,
                  );
                  if (mounted && settings != null && settings != oldSettings) {
                    context.read<TournamentPageBloc>().add(
                          TournamentPageEvent.updateSettings(
                            settings: settings,
                          ),
                        );
                  }
                },
              ),
              MenuItemModel(
                text: 'Оплата',
                onTap: () async {
                  final result = await TournamentBillingDialog.open(
                    context: context,
                    billedPlayers: state.billedPlayers,
                    hasTranslation: state.billedTranslation,
                  );
                  if (result != null && mounted) {
                    context.read<TournamentPageBloc>().add(
                          TournamentPageEvent.bill(
                            playersCount: result.billedPlayers,
                            billedTranlsation: result.billedTranslation,
                          ),
                        );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {
    on<TournamentPageEffectUpdateSettingsSuccess>(onShowSuccessUpdate);
    super.registerEffectHandlers(on);
  }

  onShowSuccessUpdate(TournamentPageEffectUpdateSettingsSuccess effect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.locale.tournamentSettingsUpdateSuccess),
      ),
    );
  }
}
