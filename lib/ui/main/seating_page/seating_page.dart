import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_fix_dialog/seating_page_dialog.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_effect.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/gomafia_input_dialog.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/seating_list.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class SeatingPage extends StatefulWidget {
  final int tournamentId;

  const SeatingPage({super.key, required this.tournamentId});

  @override
  State<SeatingPage> createState() => _SeatingPageState();

  static const name = 'tournament_seating';
  static final RouteBase route = GoRoute(
    path: 'editSeating',
    name: name,
    builder: (context, state) => SeatingPage(
      tournamentId: int.parse(state.pathParameters['id'] ?? ''),
    ),
  );

  static String createLocation({
    required int tournamentId,
    required BuildContext context,
  }) {
    return context.namedLocation(
      name,
      pathParameters: {
        'id': tournamentId.toString(),
      },
    );
  }
}

class _SeatingPageState extends State<SeatingPage>
    with EffectListener<SeatingPageEffect, SeatingPageState, SeatingPageBloc, SeatingPage> {
  final seatingKey = GlobalKey();

  Widget buildActions() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltip(
            message: 'По игрокам',
            child: IconButton(
              splashRadius: 16,
              onPressed: () => context.read<SeatingPageBloc>().add(const SeatingPageEvent.getPlayersSeating()),
              icon: const Icon(Icons.person),
            ),
          ),
          Tooltip(
            message: 'По столам',
            child: IconButton(
              splashRadius: 16,
              onPressed: () => context.read<SeatingPageBloc>().add(const SeatingPageEvent.getTablesSeating()),
              icon: const Icon(Icons.table_bar_outlined),
            ),
          ),
          Tooltip(
            message: 'Статистика пересечений',
            child: IconButton(
              splashRadius: 16,
              onPressed: () => context.read<SeatingPageBloc>().add(const SeatingPageEvent.getCrossStats()),
              icon: const Icon(Icons.people),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) => BlocBuilder<TournamentPageBloc, TournamentPageState>(
        builder: (context, tournamentState) => Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: context.backOrGoToDefault),
            title: Text(
              tournamentState.isMyTournament ? context.locale.separateTitle : context.locale.seating,
            ),
            actions: [
              buildActions(),
              TournamentMenuAction(
                tournamentId: widget.tournamentId,
                openDrawer: () => Scaffold.of(context).openEndDrawer(),
              ),
            ],
          ),
          body: Container(
            color: MyTheme.of(context).background2,
            child: BlocBuilder<SeatingPageBloc, SeatingPageState>(
              builder: (context, state) => Stack(
                children: [
                  Column(
                    children: [
                      if (tournamentState.isMyTournament) ...[
                        Container(
                          constraints: const BoxConstraints(maxHeight: 100),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.cannotMeet.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                      state.cannotMeet[index].first,
                                      state.cannotMeet[index].second,
                                    ]
                                        .map<Widget>(
                                          (playerModel) => Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: MyTheme.of(context).borderColor,
                                                ),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    playerModel.nickname,
                                                    style: MyTheme.of(context).defaultTextStyle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList() +
                                    <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          final bloc = context.read<SeatingPageBloc>();
                                          showDialog<bool>(
                                            context: context,
                                            builder: (context) => const ConfirmDialog(),
                                          ).then(
                                            (value) {
                                              if (value == true) {
                                                bloc.add(
                                                  SeatingPageEvent.deletePair(
                                                    first: state.cannotMeet[index].first,
                                                    second: state.cannotMeet[index].second,
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: MyTheme.of(context).redColor,
                                        ),
                                      ),
                                    ],
                              );
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<SeatingPageBloc>().add(
                                  const SeatingPageEvent.addPair(),
                                );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              context.locale.addSeparationBtnText,
                            ),
                          ),
                        ),
                      ],
                      Expanded(
                        flex: 100,
                        child: SeatingList(
                          models: state.games,
                        ),
                      ),
                      if (tournamentState.isMyTournament)
                        if (context.isMobile)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TextButton(
                              key: seatingKey,
                              onPressed: () {
                                final button = (seatingKey.currentContext?.findRenderObject() as RenderBox);
                                final overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
                                const offset = Offset.zero;

                                final RelativeRect position = RelativeRect.fromRect(
                                  Rect.fromPoints(
                                    button.localToGlobal(
                                      offset,
                                      ancestor: overlay,
                                    ),
                                    button.localToGlobal(
                                      button.size.bottomRight(Offset.zero) + offset,
                                      ancestor: overlay,
                                    ),
                                  ),
                                  Offset.zero & overlay.size,
                                );

                                showMenu(
                                  context: context,
                                  position: position,
                                  items: actions(tournamentState, state)
                                      .map(
                                        (e) => PopupMenuItem(
                                          onTap: e.onTap,
                                          child: Text(e.title),
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                              child: Text(context.locale.seating),
                            ),
                          )
                        else
                          Wrap(
                            children: actions(tournamentState, state)
                                .map(
                                  (e) => TextButton(
                                    onPressed: e.onTap,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(e.title),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                    ],
                  ),
                  if (state.isLoading) const Positioned.fill(child: LoadingOverlayWidget()),
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> onSwissGameCreate(SeatingPageState state, bool next) async {
    context.read<SeatingPageBloc>().add(
          SeatingPageEvent.createSwissGame(
            game: state.games.length + (next ? 1 : 0),
          ),
        );
  }

  List<({VoidCallback onTap, String title})> actions(
    TournamentPageState tournamentState,
    SeatingPageState state,
  ) =>
      [
        if (tournamentState.settings.swissGames > 0)
          if (state.games.lastOrNull?.any((element) => element.gameWin != null) == true)
            (
              onTap: () {
                onSwissGameCreate(state, true);
              },
              title: 'Сгенерировать следующий полуфинальный тур',
            )
          else
            (
              onTap: () {
                ConfirmDialog.open(
                  context,
                  'Новая рассадка заменит старую',
                ).then((value) {
                  if (value == true) {
                    onSwissGameCreate(state, false);
                  }
                });
              },
              title: 'Перегенерировать текущий полуфинальный тур',
            ),
        if (tournamentState.finalPlayers.length == 10)
          (
            onTap: () {
              ConfirmDialog.open(
                context,
                'Новая рассадка заменит старую',
              ).then(
                (value) {
                  if (value == true && mounted) {
                    context.read<SeatingPageBloc>().add(
                          const SeatingPageEvent.createFinalSeating(),
                        );
                  }
                },
              );
            },
            title: 'Сгенерировать рассадку на финал',
          ),
        (
          onTap: () {
            ConfirmDialog.open(
              context,
              'Новая рассадка заменит старую',
            ).then((value) {
              if (value == true) {
                if (!mounted) return;
                context.read<SeatingPageBloc>().add(
                      const SeatingPageEvent.createSeating(),
                    );
              }
            });
          },
          title: 'Сгенерировать рассадку',
        ),
        (
          onTap: () {
            context.read<SeatingPageBloc>().add(
                  const SeatingPageEvent.fsmSeatingTapped(),
                );
          },
          title: 'Загрузить готовую рассадку',
        ),
        (
          onTap: () async {
            final id = await GomafiaInputDialog.show(
              context,
              tournamentState.gomafiaUrl,
            );

            if (id == null) return;
            if (!mounted) return;

            final completer = Completer();

            context.read<SeatingPageBloc>().add(
                  SeatingPageEvent.autoFsmSeating(id, completer: completer),
                );
            await completer.future;
            if (!mounted) return;

            context.read<TournamentPageBloc>()
              ..add(const TournamentPageEvent.pageOpened())
              ..add(const TournamentPageEvent.playersListOpened());
          },
          title: 'Загрузить с Gomafia',
        ),
      ];

  @override
  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {
    on<SeatingPageEffectFixPlayers>(fixPlayersEffect);
  }

  Future<void> fixPlayersEffect(SeatingPageEffectFixPlayers effect) async {
    final success = await SeatingPageDialog.show(
          context: context,
          players: effect.players,
        ) ??
        false;

    if (!mounted) return;
    if (!success) return;

    final completer = Completer();
    context.read<SeatingPageBloc>().add(
          SeatingPageEvent.autoFsmSeating(
            effect.gomafiaId,
            completer: completer,
          ),
        );

    await completer.future;
    if (!mounted) return;

    context.read<TournamentPageBloc>()
      ..add(const TournamentPageEvent.pageOpened())
      ..add(const TournamentPageEvent.playersListOpened());
  }
}
