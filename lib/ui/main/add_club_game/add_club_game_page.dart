import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete.dart';
import 'package:seating_generator_web/common/widgets/role_picker.dart';
import 'package:seating_generator_web/domain/models/ci_scheme_model.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_bloc.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_effect.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_event.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_state.dart';
import 'package:seating_generator_web/utils.dart';

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
    path: ':id',
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
            child: const AddClubGamePage(
              editing: true,
            ),
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
  GameWin? winSelected;
  int firstDie = 0;
  BestMove? bestMove = BestMove.miss;
  List<PlayerRole> roles = List.generate(10, (index) => PlayerRole.citizen);
  DateTime date = DateTime.now();
  CiSchemeModel? ciSchemeModel;

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
    context.read<AddClubGameBloc>().add(
          AddClubGameEvent.pageOpened(
            gameId: widget.gameId,
            viewOnly: widget.readOnly,
          ),
        );
    super.initState();
  }

  @override
  void registerEffectHandlers(Function<T>(EffectHandler<T> handler) on) {
    on<AddClubGameEffectSetValues>(onSetValues);
    on<AddClubGameEffectSetPlayer>(onSetPlayer);
  }

  void onSetPlayer(AddClubGameEffectSetPlayer effect) {
    if (effect.index == 10) {
      refereeController.text = effect.player.nickname;
    } else {
      controllers[effect.index].text = effect.player.nickname;
    }
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
      ciSchemeModel = effect.ciModel;
    });
  }

  @override
  void didUpdateWidget(covariant AddClubGamePage oldWidget) {
    if (oldWidget.gameId != widget.gameId) {
      context.read<AddClubGameBloc>().add(
            AddClubGameEvent.pageOpened(
              gameId: widget.gameId,
              viewOnly: widget.readOnly,
            ),
          );
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state.clubName,
                        style: MyTheme.of(context).headerTextStyle,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 0; i < 10; i++)
                                StatefulBuilder(
                                  builder: (context, setState) =>
                                      PlayerRowWidget(
                                    onRoleChanged: (role) {
                                      setState(() {
                                        roles[i] = role;
                                      });
                                    },
                                    addScoreFocusNode: addScoreFocusNodes[i],
                                    addScoreController: addScoreControllers[i],
                                    nicknameController: controllers[i],
                                    focusNode: focusNodes[i],
                                    readOnly: widget.readOnly,
                                    availablePlayers: state.players,
                                    hint: "Игрок ${i + 1}",
                                    onSelected: () {
                                      if (i < 9) {
                                        focusNodes[i + 1].requestFocus();
                                      } else {
                                        refereeFocusNode.requestFocus();
                                      }
                                    },
                                    role: roles[i],
                                    onNewPlayer: ({String? initValue}) async {
                                      context.read<AddClubGameBloc>().add(
                                            AddClubGameEvent.onNewPlayer(
                                              nickname: initValue ?? "",
                                              index: i,
                                            ),
                                          );
                                    },
                                  ),
                                ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
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
                                    availablePlayers: state.players,
                                    readOnly: widget.readOnly,
                                    hint: "Судья",
                                    onNewPlayer: ({String? initValue}) async {
                                      context.read<AddClubGameBloc>().add(
                                            AddClubGameEvent.onNewPlayer(
                                              nickname: initValue ?? "",
                                              index: 10,
                                            ),
                                          );
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Первый отстрел:",
                                        style: MyTheme.of(context)
                                            .defaultTextStyle,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      StatefulBuilder(
                                        builder: (context, setState) =>
                                            CustomDropdown<int>(
                                          initValue: firstDie,
                                          items: List.generate(
                                            11,
                                            (index) {
                                              return index - 1;
                                            },
                                          ),
                                          mapToString: (index) => index == -1
                                              ? "Промах"
                                              : ((index ?? 0) + 1).toString(),
                                          onChanged: widget.readOnly
                                              ? null
                                              : (value) {
                                                  setState(() {
                                                    firstDie = value ?? -1;
                                                    if (firstDie == -1) {
                                                      bestMove = BestMove.miss;
                                                    }
                                                  });
                                                },
                                        ),
                                      ),
                                      if (firstDie != -1) ...[
                                        Text(
                                          "Лучший ход:",
                                          style: MyTheme.of(context)
                                              .defaultTextStyle,
                                        ),
                                        CustomDropdown<BestMove>(
                                          initValue: bestMove ?? BestMove.miss,
                                          items: BestMove.values,
                                          mapToString: (bestMove) {
                                            final String text;
                                            switch (bestMove) {
                                              case BestMove.full:
                                                text = "Полный лучший ход";
                                                break;
                                              case BestMove.half:
                                                text = "Двойка черных";
                                                break;
                                              case BestMove.miss:
                                                text = "Мимо";
                                                break;
                                              default:
                                                text = "";
                                                break;
                                            }
                                            return text;
                                          },
                                          onChanged: widget.readOnly
                                              ? null
                                              : (value) => bestMove = value,
                                        ),
                                      ],
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Результат:",
                                        style: MyTheme.of(context)
                                            .defaultTextStyle,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      StatefulBuilder(
                                        builder: (context, setState) {
                                          return CustomDropdown<GameWin>(
                                            initValue: winSelected,
                                            mapToString: (win) {
                                              final String text;
                                              switch (win) {
                                                case GameWin.city:
                                                  text = "Победа города";
                                                  break;
                                                case GameWin.draw:
                                                  text = "Ничья";
                                                  break;
                                                case GameWin.mafia:
                                                  text = "Победа мафии";
                                                  break;
                                                default:
                                                  text = "";
                                                  break;
                                              }
                                              return text;
                                            },
                                            items: GameWin.values,
                                            onChanged: widget.readOnly
                                                ? null
                                                : (value) {
                                                    setState(() {
                                                      winSelected = value;
                                                    });
                                                  },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        context.locale.ci,
                                        style: MyTheme.of(context)
                                            .defaultTextStyle,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      StatefulBuilder(
                                        builder: (context, setState) {
                                          return CustomDropdown<CiSchemeModel>(
                                            initValue: ciSchemeModel,
                                            mapToString: (model) {
                                              return model?.name ??
                                                  context.locale.withoutCi;
                                            },
                                            items: List.generate(
                                              state.ciSchemes.length + 1,
                                              (index) {
                                                if (index == 0) {
                                                  return null;
                                                }
                                                return state
                                                    .ciSchemes[index - 1];
                                              },
                                            ),
                                            onChanged: widget.readOnly
                                                ? null
                                                : (value) {
                                                    setState(() {
                                                      ciSchemeModel = value;
                                                    });
                                                  },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  StatefulBuilder(
                                    builder: (context, setState) => InkWell(
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
                                                        TimeOfDay.fromDateTime(
                                                      date,
                                                    ),
                                                    initialEntryMode:
                                                        TimePickerEntryMode
                                                            .input,
                                                    builder: (context, child) =>
                                                        MediaQuery(
                                                      data:
                                                          MediaQuery.of(context)
                                                              .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true,
                                                      ),
                                                      child:
                                                          child ?? Container(),
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
                                      child: DefaultTextStyle(
                                        style: MyTheme.of(context)
                                            .defaultTextStyle
                                            .copyWith(
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text("Дата:"),
                                            const SizedBox(width: 80),
                                            Text(
                                              DateFormat("dd:MM:yyy HH:mm")
                                                  .format(date),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (state.canEdit) ...[
                                    Container(
                                      width: 400,
                                      padding: const EdgeInsets.all(20),
                                      child: CustomButton(
                                        text: widget.readOnly
                                            ? "Изменить"
                                            : "Сохранить",
                                        onTap: () => submit(state),
                                        disabled: state.isLoading,
                                      ),
                                    ),
                                    if (widget.readOnly)
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: TextButton(
                                          onPressed: () {
                                            context.read<AddClubGameBloc>().add(
                                                  const AddClubGameEvent
                                                      .newGame(),
                                                );
                                          },
                                          child: Text(
                                            context.locale.addGame,
                                            style: MyTheme.of(context)
                                                .textBtnTextStyle,
                                          ),
                                        ),
                                      ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
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
    if (roles.where((element) => element == PlayerRole.maf).length != 2 ||
        roles.where((element) => element == PlayerRole.don).length != 1 ||
        roles.where((element) => element == PlayerRole.sheriff).length != 1) {
      AppRouter.showErrorDialog(context, "Проверьте роли");
      return;
    }
    if (winSelected == null) {
      AppRouter.showErrorDialog(context, "Не выбран результат игры");
      return;
    }

    if (controllers.any(
      (e) =>
          state.players.firstWhereOrNull(
            (element) => e.text == element.nickname,
          ) ==
          null,
    )) {
      AppRouter.showErrorDialog(
        context,
        "Не найден игрок: ${controllers.firstWhere(
              (e) =>
                  state.players.firstWhereOrNull(
                    (element) => e.text == element.nickname,
                  ) ==
                  null,
            ).text}",
      );
      return;
    }

    if (state.players.firstWhereOrNull(
          (element) => refereeController.text == element.nickname,
        ) ==
        null) {
      AppRouter.showErrorDialog(
        context,
        "Не найден судья: ${refereeController.text}",
      );
      return;
    }

    if (firstDie != -1 && bestMove == null) {
      AppRouter.showErrorDialog(context, "Установите лучший ход");
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
              mafia1: roles.indexOf(PlayerRole.maf),
              mafia2: roles.lastIndexOf(PlayerRole.maf),
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
              ciId: ciSchemeModel?.id,
            ),
            gameId: widget.gameId,
          ),
        );
  }
}

class NicknameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<PlayerModel> availablePlayers;

  final VoidCallback? onSelected;
  final Function({String? initValue})? onNewPlayer;
  final bool readOnly;
  final String hint;

  const NicknameField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.availablePlayers,
    required this.readOnly,
    this.onNewPlayer,
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
        displayStringForOption: (model) =>
            model.id == -1 ? "+" : model.nickname,
        focusNode: focusNode,
        onSelected: (playerModel) async {
          if (playerModel.id == -1) {
            onNewPlayer?.call(initValue: playerModel.nickname);
          } else {
            controller.text = playerModel.nickname;
            onSelected?.call();
          }
        },
        onSubmit: () {},
        optionsBuilder: (value) {
          var players = availablePlayers
              .where(
                (element) => element.nickname
                    .toLowerCase()
                    .contains(value.text.toLowerCase()),
              )
              .sortedBy<num>(
                (element) => element.nickname.length,
              );

          players += availablePlayers
              .where(
                (element) => map(element.nickname)
                    .toLowerCase()
                    .contains(map(value.text.toLowerCase())),
              )
              .where((element) => !players.contains(element))
              .sortedBy<num>(
                (element) => element.nickname.length,
              );

          return players +
              [
                if (onNewPlayer != null)
                  PlayerModel(id: -1, nickname: value.text),
              ];
        },
        hint: hint,
      ),
    );
  }

  String map(String value) {
    final map = {
      "q": "й",
      "w": "ц",
      "e": "у",
      "r": "к",
      "t": "е",
      "y": "н",
      "u": "г",
      "i": "ш",
      "o": "щ",
      "p": "з",
      "[": "х",
      "]": "ъ",
      "a": "ф",
      "s": "ы",
      "d": "в",
      "f": "а",
      "g": "п",
      "h": "р",
      "j": "о",
      "k": "л",
      "l": "д",
      ";": "ж",
      "'": "э",
      "\\": "й",
      "z": "я",
      "x": "ч",
      "c": "с",
      "v": "м",
      "b": "и",
      "n": "т",
      "m": "ь",
      ",": "б",
      ".": "ю",
    };
    return value.characters.map((e) {
      return map[e.toLowerCase()] ?? e.toLowerCase();
    }).fold("", (value, element) => value + element);
  }
}

class PlayerRowWidget extends StatelessWidget {
  final void Function(PlayerRole role) onRoleChanged;
  final TextEditingController addScoreController;
  final TextEditingController nicknameController;
  final VoidCallback onSelected;
  final FocusNode focusNode;
  final FocusNode addScoreFocusNode;
  final bool readOnly;
  final List<PlayerModel> availablePlayers;
  final String hint;
  final PlayerRole role;
  final Function({String? initValue}) onNewPlayer;

  const PlayerRowWidget({
    Key? key,
    required this.onRoleChanged,
    required this.addScoreController,
    required this.nicknameController,
    required this.focusNode,
    required this.readOnly,
    required this.availablePlayers,
    required this.hint,
    required this.onSelected,
    required this.role,
    required this.onNewPlayer,
    required this.addScoreFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        NicknameField(
          readOnly: readOnly,
          controller: nicknameController,
          focusNode: focusNode,
          availablePlayers: availablePlayers,
          hint: hint,
          onNewPlayer: onNewPlayer,
          onSelected: onSelected,
        ),
        const SizedBox(
          width: 40,
        ),
        RolePicker(
          readOnly: readOnly,
          playerRole: role,
          onChange: onRoleChanged,
        ),
        const SizedBox(
          width: 40,
        ),
        SizedBox(
          width: 100,
          child: CustomTextField(
            focusNode: addScoreFocusNode,
            readOnly: readOnly,
            controller: addScoreController,
            textInputType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            hint: "0.0",
            label: "Доп балл",
          ),
        )
      ],
    );
  }
}
