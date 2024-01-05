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
import 'package:seating_generator_web/utils/widget_extensions.dart';

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
  final seatingKey = GlobalKey();

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
              Column(
                children: [
                  Text(
                    tournamentState.isMyTournament
                        ? context.locale.separateTitle
                        : context.locale.seating,
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
                    if (context.isMobile)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextButton(
                          key: seatingKey,
                          onPressed: () {
                            final button = (seatingKey.currentContext
                                ?.findRenderObject() as RenderBox);
                            final overlay = Navigator.of(context)
                                .overlay!
                                .context
                                .findRenderObject()! as RenderBox;
                            const offset = Offset.zero;

                            final RelativeRect position = RelativeRect.fromRect(
                              Rect.fromPoints(
                                button.localToGlobal(offset, ancestor: overlay),
                                button.localToGlobal(
                                    button.size.bottomRight(Offset.zero) +
                                        offset,
                                    ancestor: overlay),
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

  List<({VoidCallback onTap, String title})> actions(
    TournamentPageState tournamentState,
    SeatingPageState state,
  ) =>
      [
        if (state.games.lastOrNull?.any((element) => element.gameWin != null) ==
            true)
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
                "Новая рассадка заменит старую",
              ).then((value) {
                if (value == true) {
                  onSwissGameCreate(state, false);
                }
              });
            },
            title: 'Новая рассадка заменит старую',
          ),
        if (tournamentState.finalPlayers.length == 10)
          (
            onTap: () {
              ConfirmDialog.open(
                context,
                "Новая рассадка заменит старую",
              ).then(
                (value) {
                  if (value == true && context.mounted) {
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
      ];
}
