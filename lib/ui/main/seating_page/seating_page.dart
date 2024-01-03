import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/ui/main/seating_page/widgets/seating_list.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_state.dart';
import 'package:seating_generator_web/utils.dart';

class SeatingPage extends StatefulWidget {
  final int tournamentId;

  const SeatingPage({Key? key, required this.tournamentId}) : super(key: key);

  @override
  State<SeatingPage> createState() => _SeatingPageState();

  static const name = 'tournament_seating';
  static final RouteBase route = GoRoute(
    path: 'editSeating',
    name: name,
    builder: (context, state) => SeatingPage(
      tournamentId: int.parse(state.params["id"] ?? ""),
    ),
  );

  static String createLocation({
    required int tournamentId,
    required BuildContext context,
  }) {
    return context.namedLocation(name, params: {"id": tournamentId.toString()});
  }
}

class _SeatingPageState extends State<SeatingPage> {
  @override
  void initState() {
    context.read<SeatingPageBloc>().add(
          SeatingPageEvent.pageOpened(
            tournamentId: widget.tournamentId,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentPageBloc, TournamentPageState>(
      builder: (context, tournamentState) =>
          BlocBuilder<SeatingPageBloc, SeatingPageState>(
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      context.locale.separateTitle,
                      style: MyTheme.of(context).headerTextStyle,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
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
                                                color: MyTheme.of(context)
                                                    .borderColor,
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  playerModel.nickname,
                                                  style: MyTheme.of(context)
                                                      .defaultTextStyle,
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
                                        final bloc =
                                            context.read<SeatingPageBloc>();
                                        showDialog<bool>(
                                          context: context,
                                          builder: (context) =>
                                              const ConfirmDialog(),
                                        ).then(
                                          (value) {
                                            if (value == true) {
                                              bloc.add(
                                                SeatingPageEvent.deletePair(
                                                  first: state
                                                      .cannotMeet[index].first,
                                                  second: state
                                                      .cannotMeet[index].second,
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
                      Wrap(
                        children: [
                          if (state.games.lastOrNull
                                  ?.any((element) => element.gameWin != null) ==
                              true)
                            TextButton(
                              onPressed: () {
                                onSwissGameCreate(state, true);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Сгенерировать следующий полуфинальный тур',
                                ),
                              ),
                            )
                          else
                            TextButton(
                              onPressed: () {
                                ConfirmDialog.open(
                                  context,
                                  "Новая рассадка заменит старую",
                                ).then((value) {
                                  if (value == true) {
                                    onSwissGameCreate(state, false);
                                  }
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Перегенерировать текущий полуфинальный тур',
                                ),
                              ),
                            ),
                          if (tournamentState.finalPlayers.length == 10)
                            TextButton(
                              onPressed: () {
                                ConfirmDialog.open(
                                  context,
                                  "Новая рассадка заменит старую",
                                ).then(
                                  (value) {
                                    if (value == true && context.mounted) {
                                      context.read<SeatingPageBloc>().add(
                                            const SeatingPageEvent
                                                .createFinalSeating(),
                                          );
                                    }
                                  },
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Сгенерировать рассадку на финал",
                                ),
                              ),
                            ),
                          TextButton(
                            onPressed: () {
                              ConfirmDialog.open(
                                context,
                                "Новая рассадка заменит старую",
                              ).then((value) {
                                if (value == true) {
                                  if (!mounted) return;
                                  context.read<SeatingPageBloc>().add(
                                        const SeatingPageEvent.createSeating(),
                                      );
                                }
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Сгенерировать рассадку",
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<SeatingPageBloc>().add(
                                    const SeatingPageEvent.fsmSeatingTapped(),
                                  );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Загрузить готовую рассадку",
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              if (state.isLoading)
                const Positioned.fill(child: LoadingOverlayWidget()),
            ],
          );
        },
      ),
    );
  }

  Future<void> onSwissGameCreate(SeatingPageState state, bool next) async {
    context.read<SeatingPageBloc>().add(
          SeatingPageEvent.createSwissGame(
            game: state.games.length + (next ? 1 : 0),
          ),
        );
  }
}
