import 'package:flutter/material.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/feature/administration_page/administration_page.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_page.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_effect.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_event.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_state.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/custom_text_info_dialog.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/final_players_dialog.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/players_list_body.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/start_game_info_dialog.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/tournament_billing_dialog.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/tournament_menu.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/tournament_settings_dialog.dart';
import 'package:seating_generator_web/ui/main/tournament_page/widgets/translation_dialog.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class TournamentPage extends StatefulWidget {
  final Widget child;
  final int tournamentId;

  const TournamentPage({
    super.key,
    required this.child,
    required this.tournamentId,
  });

  @override
  State<TournamentPage> createState() => _TournamentPageState();

  static String createLocation({
    required BuildContext context,
    required int tournamentId,
  }) {
    return context.namedLocation(
      "tournament_page",
      pathParameters: {
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
              AddClubGamePage.tournamentEditRoute,
              RatingPage.tournamentRoute,
              AdministrationPage.tournamentRoute,
            ],
            builder: (context, state) {
              return PlayersListBody(
                tournamentId: int.parse(state.pathParameters["id"] ?? ""),
              );
            },
          ),
        ],
        builder: (context, state, child) {
          final tournamentId = int.parse(state.pathParameters["id"] ?? "");
          return MultiBlocProvider(
            providers: [
              BlocProvider<TournamentPageBloc>(
                key: const Key("TournamentPageBloc"),
                create: (context) => getIt<TournamentPageBloc>(
                  param1: context,
                  param2: tournamentId,
                )..add(const TournamentPageEvent.pageOpened()),
              ),
              BlocProvider<SeatingPageBloc>(
                key: const Key("SeatingPageBloc"),
                create: (context) => getIt<SeatingPageBloc>(
                  param1: context,
                )..add(
                    SeatingPageEvent.pageOpened(
                      tournamentId: tournamentId,
                    ),
                  ),
              ),
            ],
            child: TournamentPage(
              tournamentId: int.parse(state.pathParameters["id"] ?? ""),
              child: child,
            ),
          );
        },
      );
}

class _TournamentPageState extends CustomState<TournamentPage>
    with EffectListener<TournamentPageEffect, TournamentPageState, TournamentPageBloc, TournamentPage> {
  void openFinalPlayersDialog(TournamentPageState state) {
    FinalPlayersDialog.open(
      context: context,
      initValue: state.finalPlayers,
      players: state.tournamentPlayers,
    ).then((value) {
      if (value != null && mounted) {
        context.read<TournamentPageBloc>().add(
              TournamentPageEvent.setFinalPlayers(
                players: value,
              ),
            );
      }
    });
  }

  @override
  Widget? buildMobile(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: widget.child),
        if (!context.watch<TournamentPageBloc>().state.isLoading && !context.watch<SeatingPageBloc>().state.isLoading)
          Positioned(
            bottom: 8,
            right: 8,
            child: BlocBuilder<TournamentPageBloc, TournamentPageState>(
              builder: (context, state) => PopupMenuButton<MenuItemModel>(
                itemBuilder: (_) => menuItems(state, listen: false)
                    .map<PopupMenuEntry<MenuItemModel>>(
                      (e) => PopupMenuItem<MenuItemModel>(
                        value: e,
                        onTap: e.onTap,
                        child: Text(e.text),
                      ),
                    )
                    .toList(),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.theme.darkBlueColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return Row(
      children: [
        Expanded(child: widget.child),
        BlocBuilder<TournamentPageBloc, TournamentPageState>(
          builder: (context, state) => TournamentMenu(
            items: menuItems(state, listen: true),
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

  List<MenuItemModel> menuItems(
    TournamentPageState state, {
    required bool listen,
  }) {
    final showBill = context.read<AuthNotifier>().value.mapOrNull(
              authorized: (model) => !model.hideBilling,
            ) ??
        true;

    if (listen) {
      context.watch<SeatingPageBloc>();
      context.watch<TournamentPageBloc>();
    }

    return [
      MenuItemModel(
        text: context.locale.tournamentPageListOfPlayers,
        onTap: () {
          context.read<TournamentPageBloc>().add(const TournamentPageEvent.playersListTapped());
        },
      ),
      if (state.isMyTournament)
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
          context.read<TournamentPageBloc>().add(const TournamentPageEvent.openSeatingPage());
        },
      ),
      if (state.isMyTournament && !state.isLoading)
        MenuItemModel(
          text: context.locale.tournamentSettingsTitle,
          onTap: () async {
            final oldSettings = context.read<TournamentPageBloc>().state.settings;
            final settings = await TournamentSettingsDialog.open(
              context: context,
              initValue: oldSettings,
              onFinalPlayersTapped: () => openFinalPlayersDialog(state),
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
        text: 'Таблица',
        onTap: () {
          context.read<TournamentPageBloc>().add(const TournamentPageEvent.openRating());
        },
      ),
      if (state.billedTranslation && state.isMyTournament && !state.isLoading)
        MenuItemModel(
          text: context.locale.translationDialogTitle,
          onTap: () {
            TranslationDialog.open(
              context: context,
              tournamentId: widget.tournamentId,
              tablesCount: (state.tournamentPlayers.length / 10).floor(),
            );
          },
        ),
      if (state.isMyTournament && showBill && !state.isLoading)
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
      if (state.isMyTournament)
        MenuItemModel(
          text: 'Администраторы',
          onTap: () {
            context.go(
              AdministrationPage.createTournamentLocation(
                tournamentId: context.read<TournamentPageBloc>().tournamentId,
                context: context,
              ),
            );
          },
        ),
      if (context.read<SeatingPageBloc>().state.games.length case int games)
        if (state.isMyTournament && state.notificationEnabled && !context.read<SeatingPageBloc>().state.isLoading) ...[
          MenuItemModel(
            text: 'Оповещение об игре',
            onTap: () {
              StartGameInfoDialog.show(context: context, maxGame: games, tournamentId: widget.tournamentId.toString())
                  .then((result) {
                if (result == null || !mounted) {
                  return;
                }

                context.read<TournamentPageBloc>().add(
                      TournamentPageEvent.startGameInfo(
                        game: result.$1,
                        time: result.$2,
                      ),
                    );
              });
            },
          ),
          MenuItemModel(
            text: 'Текстовое оповещение',
            onTap: () {
              CustomTextInfoDialog.show(context: context).then((text) {
                if (text == null || !mounted) {
                  return;
                }

                context.read<TournamentPageBloc>().add(TournamentPageEvent.customTextInfo(text: text));
              });
            },
          ),
        ],
    ];
  }
}
