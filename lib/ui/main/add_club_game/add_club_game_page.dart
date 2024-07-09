import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class AddClubGamePage extends StatefulWidget {
  final bool readOnly;
  final int? gameId;
  final DateTime? initDateTime;

  const AddClubGamePage({
    Key? key,
    this.readOnly = false,
    this.gameId,
    this.initDateTime,
  }) : super(key: key);

  @override
  State<AddClubGamePage> createState() => _AddClubGamePageState();

  static String createTournamentEditLocation({
    required BuildContext context,
    required int tournamentId,
    required int gameId,
    required bool edit,
  }) {
    return context.namedLocation(
      'editTournamentGame',
      params: {
        'id': tournamentId.toString(),
        'gameId': gameId.toString(),
      },
      queryParams: {
        'edit': edit.toString(),
      },
    );
  }

  static final GoRoute tournamentEditRoute = GoRoute(
    path: 'editGame/:gameId',
    name: 'editTournamentGame',
    builder: (context, state) {
      final gameId = int.parse(state.params["gameId"]!);
      final tournamentId = int.parse(state.params["id"]!);
      final edit = bool.tryParse(state.queryParams['edit'] ?? '') ?? true;
      return BlocProvider<AddClubGameBloc>(
        create: (context) => AddClubGameBloc(
          context: context,
          tournamentId: tournamentId,
        ),
        child: AddClubGamePage(
          readOnly: !edit,
          gameId: gameId,
        ),
      );
    },
  );

  static final List<GoRoute> routes = [
    GoRoute(
      path: 'addGame',
      name: "addGame",
      builder: (context, state) {
        final clubId = int.parse(state.params["clubId"]!);
        final initDateTime = state.extra as DateTime?;
        return BlocProvider<AddClubGameBloc>(
          create: (context) => AddClubGameBloc(
            clubId: clubId,
            context: context,
          ),
          // TODO: REGISTER IN GET IT
          child: AddClubGamePage(
            initDateTime: initDateTime,
          ),
        );
      },
    ),
    GoRoute(
      name: 'viewGame',
      path: "game/:gameId",
      builder: (context, state) {
        try {
          final clubId = int.parse(state.params["clubId"]!);
          final gameId = int.parse(state.params["gameId"]!);
          final edit = state.queryParams["edit"] == true.toString();
          return BlocProvider<AddClubGameBloc>(
            create: (context) => AddClubGameBloc(
              clubId: clubId,
              context: context,
            ),
            // TODO: REGISTER IN GET IT
            child: AddClubGamePage(
              readOnly: !edit,
              gameId: gameId,
            ),
          );
        } catch (i) {
          debugPrint(i.toString());
          rethrow;
        }
      },
    ),
  ];

  static String createViewLocation(
    BuildContext context,
    int clubId,
    int gameId, {
    bool canEdit = false,
  }) {
    return context.namedLocation(
      "viewGame",
      params: {
        "clubId": clubId.toString(),
        "gameId": gameId.toString(),
      },
      queryParams: {"edit": canEdit.toString()},
    );
  }

  static String createLocation(
    BuildContext context,
    int clubId,
  ) {
    return context.namedLocation(
      "addGame",
      params: {
        "clubId": clubId.toString(),
      },
    );
  }
}

class _AddClubGamePageState extends CustomState<AddClubGamePage>
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
  int? firstDie;
  BestMove? bestMove = BestMove.miss;
  List<PlayerRole> roles = List.generate(10, (index) => PlayerRole.citizen);
  late DateTime date = widget.initDateTime ?? DateTime.now();
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
      if (effect.addScore.length > i) {
        addScoreControllers[i].text = effect.addScore[i].toString();
      }
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
  Widget? buildMobile(BuildContext context) => SingleChildScrollView(
        child: BlocBuilder<AddClubGameBloc, AddClubGameState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state.clubName,
                        style: MyTheme.of(context).headerTextStyle,
                      ),
                      Column(
                        children: [
                          ...buildPlayersRow(state),
                          buildGameInfoWidget(state),
                        ],
                      ),
                    ],
                  ),
                  if (state.isLoading) const LoadingOverlayWidget(),
                ],
              ),
            );
          },
        ),
      );

  @override
  Widget buildDesktop(BuildContext context) =>
      BlocBuilder<AddClubGameBloc, AddClubGameState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      state.clubName,
                      style: MyTheme.of(context).headerTextStyle,
                    ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) =>
                            SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.spaceAround,
                            runSpacing: 20,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: buildPlayersRow(state)
                                        .map(
                                          (e) => e,
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                              buildGameInfoWidget(state),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.isLoading) const LoadingOverlayWidget(),
              ],
            ),
          );
        },
      );

  Widget buildGameInfoWidget(AddClubGameState state) => Container(
        padding: context.isMobile
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 30),
        decoration: context.isMobile
            ? null
            : const BoxDecoration(
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
              down: true,
              controller: refereeController,
              focusNode: refereeFocusNode,
              availablePlayers: state.players,
              readOnly: widget.readOnly || state.isTournament,
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
            Wrap(
              children: [
                Text(
                  "Первый отстрел:",
                  style: MyTheme.of(context).defaultTextStyle,
                ),
                const SizedBox(
                  width: 8,
                ),
                CustomDropdown<int>(
                  readOnly: widget.readOnly,
                  initValue: firstDie,
                  items: List.generate(
                    11,
                    (index) {
                      return index - 1;
                    },
                  ),
                  mapToString: (index) => index == null
                      ? 'Не указан'
                      : index == -1
                          ? "Промах"
                          : (index + 1).toString(),
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
              ],
            ),
            if (firstDie != null && firstDie != -1)
              Wrap(
                key: const Key("best_move_row"),
                children: [
                  Text(
                    "Лучший ход:",
                    style: MyTheme.of(context).defaultTextStyle,
                  ),
                  CustomDropdown<BestMove>(
                    readOnly: widget.readOnly,
                    initValue: bestMove ?? BestMove.miss,
                    items: const [
                      BestMove.miss,
                      BestMove.one,
                      BestMove.half,
                      BestMove.full,
                    ],
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
                        case BestMove.one:
                          text = "Один маф";
                          break;
                        default:
                          text = "";
                          break;
                      }
                      return text;
                    },
                    onChanged:
                        widget.readOnly ? null : (value) => bestMove = value,
                  ),
                ],
              ),
            Wrap(
              key: const Key("result_row"),
              children: [
                Text(
                  "Результат:",
                  style: MyTheme.of(context).defaultTextStyle,
                ),
                const SizedBox(
                  width: 8,
                ),
                StatefulBuilder(
                  builder: (context, setState) {
                    return CustomDropdown<GameWin>(
                      readOnly: widget.readOnly,
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
            Wrap(
              children: [
                Text(
                  context.locale.ci,
                  style: MyTheme.of(context).defaultTextStyle,
                ),
                const SizedBox(
                  width: 8,
                ),
                StatefulBuilder(
                  builder: (context, setState) {
                    return CustomDropdown<CiSchemeModel>(
                      readOnly: widget.readOnly || state.isTournament,
                      initValue: ciSchemeModel,
                      mapToString: (model) {
                        return model?.name ?? context.locale.withoutCi;
                      },
                      items: List.generate(
                        state.ciSchemes.length + 1,
                        (index) {
                          if (index == 0) {
                            return null;
                          }
                          return state.ciSchemes[index - 1];
                        },
                      ),
                      onChanged: (value) {
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
                onTap: widget.readOnly || state.isTournament
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
                            final timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                date,
                              ),
                              initialEntryMode: TimePickerEntryMode.input,
                              builder: (context, child) => MediaQuery(
                                data: MediaQuery.of(context).copyWith(
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
                child: DefaultTextStyle(
                  style: MyTheme.of(context).defaultTextStyle.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                  child: Wrap(
                    children: [
                      const Text("Дата:"),
                      const SizedBox(width: 80),
                      Text(
                        DateFormat("dd:MM:yyy HH:mm").format(date),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (state.canEdit)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 400,
                    padding: const EdgeInsets.all(20),
                    child: CustomButton(
                      text: widget.readOnly ? "Изменить" : "Сохранить",
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
                                AddClubGameEvent.newGame(
                                  dateTime: date,
                                ),
                              );
                        },
                        child: Text(
                          context.locale.addGame,
                          style: MyTheme.of(context).textBtnTextStyle,
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      );

  List<Widget> buildPlayersRow(AddClubGameState state) => [
        for (int i = 0; i < 10; i++)
          StatefulBuilder(
            builder: (context, setState) => PlayerRowWidget(
              down: i < 5,
              onRoleChanged: (role) {
                setState(() {
                  roles[i] = role;
                });
              },
              isTournament: state.isTournament,
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
      ];

  bool get canEdit {
    if (context.watch<AddClubGameBloc>().tournamentId == null) return true;

    return context.watch<TournamentPageBloc>().state.isMyTournament;
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
            null &&
        !state.isTournament) {
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

    if (firstDie == null) {
      AppRouter.showErrorDialog(context, 'Не указан первый отстрел');
      return;
    }

    context.read<AddClubGameBloc>().add(
          AddClubGameEvent.submit(
            gameResult: ClubGameResult(
              date: date.toIso8601String(),
              addScore: addScoreControllers.map(
                (e) =>
                    (double.parse(e.text.replaceAll(",", ".")) * 100).floor(),
              ),
              players: controllers.map(
                (e) => state.players
                    .firstWhere((element) => e.text == element.nickname)
                    .id,
              ),
              mafia1: roles.indexOf(PlayerRole.maf),
              mafia2: roles.lastIndexOf(PlayerRole.maf),
              referee: state.players
                  .firstWhereOrNull(
                    (element) => refereeController.text == element.nickname,
                  )
                  ?.id,
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
  final bool down;

  const NicknameField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.availablePlayers,
    required this.readOnly,
    this.onNewPlayer,
    this.onSelected,
    required this.hint,
    required this.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: CustomAutoComplete(
        readOnly: readOnly,
        openDirection:
            down ? OptionsViewOpenDirection.down : OptionsViewOpenDirection.up,
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

class PlayerRowWidget extends StatefulWidget {
  final void Function(PlayerRole role) onRoleChanged;
  final TextEditingController addScoreController;
  final TextEditingController nicknameController;
  final VoidCallback onSelected;
  final FocusNode focusNode;
  final FocusNode addScoreFocusNode;
  final bool readOnly;
  final bool isTournament;
  final List<PlayerModel> availablePlayers;
  final String hint;
  final PlayerRole role;
  final Function({String? initValue}) onNewPlayer;
  final bool down;

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
    required this.isTournament,
    required this.down,
  }) : super(key: key);

  @override
  State<PlayerRowWidget> createState() => _PlayerRowWidgetState();
}

class _PlayerRowWidgetState extends CustomState<PlayerRowWidget> {
  @override
  Widget? buildMobile(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildNicknameField(),
          Row(
            children: [
              RolePicker(
                readOnly: widget.readOnly,
                playerRole: widget.role,
                onChange: widget.onRoleChanged,
              ),
              const Spacer(),
              buildAddScoreField(),
            ],
          ),
        ],
      );

  @override
  Widget buildDesktop(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildNicknameField(),
        const SizedBox(width: 40),
        RolePicker(
          readOnly: widget.readOnly,
          playerRole: widget.role,
          onChange: widget.onRoleChanged,
        ),
        const SizedBox(width: 40),
        buildAddScoreField(),
      ],
    );
  }

  Widget buildAddScoreField() => SizedBox(
        width: 100,
        child: CustomTextField(
          focusNode: widget.addScoreFocusNode,
          readOnly: widget.readOnly,
          controller: widget.addScoreController,
          hint: "0.0",
          label: "Доп балл",
        ),
      );

  Widget buildNicknameField() => NicknameField(
        down: widget.down,
        readOnly: widget.readOnly || widget.isTournament,
        controller: widget.nicknameController,
        focusNode: widget.focusNode,
        availablePlayers: widget.availablePlayers,
        hint: widget.hint,
        onNewPlayer: widget.onNewPlayer,
        onSelected: widget.onSelected,
      );
}
