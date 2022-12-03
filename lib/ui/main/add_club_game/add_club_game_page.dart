import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete.dart';
import 'package:seating_generator_web/common/widgets/role_picker.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_bloc.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_effect.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_event.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_state.dart';

class AddClubGamePage extends StatefulWidget {
  final bool readOnly;
  final bool editing;
  final int? gameId;

  const AddClubGamePage({
    Key? key,
    this.readOnly = false,
    this.gameId,
    this.editing = true,
  }) : super(key: key);

  @override
  State<AddClubGamePage> createState() => _AddClubGamePageState();

  static final GoRoute route = GoRoute(
    path: '/club/:id',
    builder: (_, __) => Container(),
    routes: [
      GoRoute(
        path: 'addGame',
        name: "addGame",
        builder: (context, state) {
          final id = int.parse(state.params["id"]!);
          return BlocProvider<AddClubGameBloc>(
            create: (context) => AddClubGameBloc(id, context),
            // TODO: REGISTER IN GET IT
            child: const AddClubGamePage(editing: true,),
          );
        },
      ),
      GoRoute(
        name: 'viewGame',
        path: "game/:gameId",
        builder: (context, state) {
          try {
            final clubId = int.parse(state.params["id"]!);
            final gameId = int.parse(state.params["gameId"]!);
            final edit = state.queryParams["edit"] == true.toString();
            debugPrint(state.location);
            return BlocProvider<AddClubGameBloc>(
              create: (context) => AddClubGameBloc(clubId, context),
              // TODO: REGISTER IN GET IT
              child: AddClubGamePage(
                readOnly: !edit,
                gameId: gameId,
                editing: edit,
              ),
            );
          } catch (i) {
            debugPrint(i.toString());
            rethrow;
          }
        },
      ),
    ],
  );

  static String createViewLocation(
    BuildContext context,
    int clubId,
    int gameId, {
    bool canEdit = false,
  }) {
    return context.namedLocation(
      "viewGame",
      params: {
        "id": clubId.toString(),
        "gameId": gameId.toString(),
      },
      queryParams: {"edit": canEdit.toString()},
    );
  }

  static String createLocation(BuildContext context, int clubId) {
    return context.namedLocation(
      "addGame",
      params: {
        "id": clubId.toString(),
      },
    );
  }
}

class _AddClubGamePageState extends State<AddClubGamePage>
    with
        EffectListener<AddClubGameEffect, AddClubGameState, AddClubGameBloc,
            AddClubGamePage> {
  final controllers = List.generate(10, (index) => TextEditingController());
  final addScoreControllers = List.generate(
    10,
    (index) => TextEditingController()..text = "0.0",
  );
  final refereeController = TextEditingController();
  final refereeFocusNode = FocusNode();
  final focusNodes = List.generate(10, (index) => FocusNode());
  final addScoreFocusNodes = List.generate(10, (index) => FocusNode());
  final winValue = ClubGameResult_GameWin.values;
  ClubGameResult_GameWin? winSelected;
  int firstDie = -1;
  ClubGameResult_BestMove? bestMove;
  List<PlayerRole> roles = List.generate(10, (index) => PlayerRole.citizen);
  DateTime date = DateTime.now();

  @override
  void dispose() {
    refereeController.dispose();
    for (final controller in controllers) {
      controller.dispose();
    }
    for (final focusNode in focusNodes) {
      focusNode.dispose();
    }
    for (final focusNode in addScoreFocusNodes) {
      focusNode.dispose();
    }
    for (final controller in addScoreControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    context
        .read<AddClubGameBloc>()
        .add(AddClubGameEvent.pageOpened(gameId: widget.gameId));
    super.initState();
  }

  @override
  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {
    on<AddClubGameEffectSetValues>(onSetValues);
  }

  void onSetValues(AddClubGameEffectSetValues effect) {
    for (int i = 0; i < 10; i++) {
      addScoreControllers[i].text = effect.addScore[i].toString();
      controllers[i].text = effect.players[i].toString();
    }
    refereeController.text = effect.referee;
    setState(() {
      winSelected = effect.win;
      bestMove = effect.bestMove;
      firstDie = effect.died;
      date = effect.date;
      roles = effect.roles.toList();
    });
  }

  @override
  void didUpdateWidget(covariant AddClubGamePage oldWidget) {
    if (oldWidget.gameId != widget.gameId) {
      context
          .read<AddClubGameBloc>()
          .add(AddClubGameEvent.pageOpened(gameId: widget.gameId));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddClubGameBloc, AddClubGameState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < 10; i++)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                NicknameField(
                                  readOnly: widget.readOnly,
                                  controller: controllers[i],
                                  focusNode: focusNodes[i],
                                  state: state,
                                  hint: "Игрок ${i + 1}",
                                  onSelected: () {
                                    if (i < 9) {
                                      focusNodes[i + 1].requestFocus();
                                    } else {
                                      refereeFocusNode.requestFocus();
                                    }
                                  },
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                RolePicker(
                                  readOnly: widget.readOnly,
                                  playerRole: roles[i],
                                  onChange: (role) {
                                    setState(() {
                                      roles[i] = role;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: CustomTextField(
                                    readOnly: widget.readOnly,
                                    controller: addScoreControllers[i],
                                    textInputType:
                                        const TextInputType.numberWithOptions(
                                      signed: true,
                                      decimal: true,
                                    ),
                                    hint: "0.0",
                                  ),
                                )
                              ],
                            ),
                          if (state.canEdit)
                            Container(
                              width: 400,
                              padding: const EdgeInsets.all(20),
                              child: CustomButton(
                                text:
                                    widget.readOnly ? "Изменить" : "Сохранить",
                                onTap: () => submit(state),
                                disabled: state.isLoading,
                              ),
                            ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          margin: const EdgeInsets.only(left: 30),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.red,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              NicknameField(
                                controller: refereeController,
                                focusNode: refereeFocusNode,
                                state: state,
                                readOnly: widget.readOnly,
                                hint: "Судья",
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Первый отстрел:",
                                    style: MyTheme.of(context).defaultTextStyle,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  DropdownButton<int>(
                                    value: firstDie,
                                    items: List.generate(
                                      11,
                                      (index) {
                                        return DropdownMenuItem(
                                          value: index - 1,
                                          child: Text(
                                            index == 0
                                                ? "Промах"
                                                : index.toString(),
                                            style: MyTheme.of(context)
                                                .defaultTextStyle,
                                          ),
                                        );
                                      },
                                    ),
                                    onChanged: widget.readOnly
                                        ? null
                                        : (value) {
                                            setState(() {
                                              firstDie = value ?? -1;
                                              if (firstDie == -1) {
                                                bestMove =
                                                    ClubGameResult_BestMove
                                                        .miss;
                                              }
                                            });
                                          },
                                  ),
                                  if (firstDie != -1) ...[
                                    Text(
                                      "Лучший ход:",
                                      style:
                                          MyTheme.of(context).defaultTextStyle,
                                    ),
                                    DropdownButton<ClubGameResult_BestMove>(
                                      value: bestMove,
                                      items: ClubGameResult_BestMove.values
                                          .map((bestMove) {
                                        final String text;
                                        switch (bestMove) {
                                          case ClubGameResult_BestMove.full:
                                            text = "Полный лучший ход";
                                            break;
                                          case ClubGameResult_BestMove.half:
                                            text = "Двойка черных";
                                            break;
                                          case ClubGameResult_BestMove.miss:
                                            text = "Мимо";
                                            break;
                                          default:
                                            text = "";
                                            break;
                                        }
                                        return DropdownMenuItem(
                                          value: bestMove,
                                          child: Text(
                                            text,
                                            style: MyTheme.of(context)
                                                .defaultTextStyle,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: widget.readOnly
                                          ? null
                                          : (value) {
                                              setState(() {
                                                bestMove = value;
                                              });
                                            },
                                    ),
                                  ],
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Результат:",
                                    style: MyTheme.of(context).defaultTextStyle,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  DropdownButton<ClubGameResult_GameWin>(
                                    value: winSelected,
                                    items: winValue.map((win) {
                                      final String text;
                                      switch (win) {
                                        case ClubGameResult_GameWin.city:
                                          text = "Победа города";
                                          break;
                                        case ClubGameResult_GameWin.draw:
                                          text = "Ничья";
                                          break;
                                        case ClubGameResult_GameWin.mafia:
                                          text = "Победа мафии";
                                          break;
                                        default:
                                          text = "";
                                          break;
                                      }
                                      return DropdownMenuItem(
                                        value: win,
                                        child: Text(
                                          text,
                                          style: MyTheme.of(context)
                                              .defaultTextStyle,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: widget.readOnly
                                        ? null
                                        : (value) {
                                            setState(() {
                                              winSelected = value;
                                            });
                                          },
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: widget.readOnly
                                    ? null
                                    : () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: date,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now(),
                                        ).then((value) async {
                                          if (!mounted) return null;
                                          if (value != null) {
                                            final timeOfDay =
                                                await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeOfDay.fromDateTime(date),
                                              initialEntryMode:
                                                  TimePickerEntryMode.input,
                                              builder: (context, child) =>
                                                  MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                  alwaysUse24HourFormat: true,
                                                ),
                                                child: child ?? Container(),
                                              ),
                                            );
                                            if (timeOfDay != null) {
                                              return DateTime(
                                                value.year,
                                                value.month,
                                                value.day,
                                                timeOfDay.hour,
                                                timeOfDay.minute,
                                              );
                                            }
                                          }
                                          return null;
                                        }).then((value) {
                                          setState(() {
                                            date = value ?? date;
                                          });
                                        });
                                      },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Дата:",
                                      style: MyTheme.of(context)
                                          .defaultTextStyle
                                          .copyWith(
                                            color: MyTheme.of(context)
                                                .darkGreyColor,
                                          ),
                                    ),
                                    const SizedBox(
                                      width: 80,
                                    ),
                                    Text(
                                      DateFormat("dd:MM:yyy HH:mm")
                                          .format(date),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.isLoading) const LoadingOverlayWidget(),
              ],
            ),
          );
        },
      ),
    );
  }

  submit(AddClubGameState state) {
    if (widget.readOnly) {
      context
          .read<AddClubGameBloc>()
          .add(AddClubGameEvent.edit(gameId: widget.gameId!));
      return;
    }
    if (winSelected == null ||
        roles.where((element) => element == PlayerRole.mafia).length != 2 ||
        roles.where((element) => element == PlayerRole.don).length != 1 ||
        roles.where((element) => element == PlayerRole.sheriff).length != 1 ||
        controllers
                .map(
                  (e) => state.players.firstWhereOrNull(
                    (element) => e.text == element.nickname,
                  ),
                )
                .whereNotNull()
                .length !=
            10) {
      return;
    }
    context.read<AddClubGameBloc>().add(
          AddClubGameEvent.submit(
            gameResult: ClubGameResult(
              date: date.toIso8601String(),
              addScore: addScoreControllers
                  .map((e) => (double.parse(e.text) * 100).floor()),
              players: controllers.map(
                (e) => state.players
                    .firstWhere((element) => e.text == element.nickname)
                    .id,
              ),
              mafia1: roles.indexOf(PlayerRole.mafia),
              mafia2: roles.lastIndexOf(PlayerRole.mafia),
              referee: state.players
                  .firstWhere(
                    (element) => refereeController.text == element.nickname,
                  )
                  .id,
              don: roles.indexOf(PlayerRole.don),
              sheriff: roles.indexOf(PlayerRole.sheriff),
              firstDie: firstDie,
              win: winSelected,
              bestMove: bestMove,
            ),
            gameId: widget.gameId,
          ),
        );
  }
}

class NicknameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final AddClubGameState state;
  final VoidCallback? onSelected;
  final bool readOnly;
  final String hint;

  const NicknameField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.state,
    required this.readOnly,
    this.onSelected,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: CustomAutoComplete(
        readOnly: readOnly,
        controller: controller,
        displayStringForOption: (model) => "${model.nickname} (${model.id})",
        focusNode: focusNode,
        availablePlayers: state.players,
        onSelected: (playerModel) {
          controller.text = playerModel.nickname;
          onSelected?.call();
        },
        onSubmit: () {},
        optionsBuilder: (value) => state.players
            .where(
              (element) => element.nickname
                  .toLowerCase()
                  .contains(value.text.toLowerCase()),
            )
            .sortedBy<num>(
              (element) => element.nickname.length,
            ),
        hint: hint,
      ),
    );
  }
}