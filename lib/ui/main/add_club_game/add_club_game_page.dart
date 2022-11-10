import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_bloc.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_event.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_state.dart';

class AddClubGamePage extends StatefulWidget {
  const AddClubGamePage({Key? key}) : super(key: key);

  @override
  State<AddClubGamePage> createState() => _AddClubGamePageState();

  static final GoRoute route = GoRoute(
    path: '/club/:id/addGame',
    name: "addPlayer",
    builder: (context, state) {
      final id = int.parse(state.params["id"]!);
      return BlocProvider<AddClubGameBloc>(
        create: (context) => AddClubGameBloc(id, context),
        // TODO: REGISTER IN GET IT
        child: const AddClubGamePage(),
      );
    },
  );

  static String createLocation(BuildContext context, int clubId) {
    return context.namedLocation(
      "addPlayer",
      params: {
        "id": clubId.toString(),
      },
    );
  }
}

class _AddClubGamePageState extends State<AddClubGamePage> {
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
  final List<PlayerRole> roles =
      List.generate(10, (index) => PlayerRole.citizen);
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
    context.read<AddClubGameBloc>().add(const AddClubGameEvent.pageOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddClubGameBloc, AddClubGameState>(
      builder: (context, state) {
        return Stack(
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
                              playerRole: roles[i],
                              onChange: (role) {
                                roles[i] = role;
                              },
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            SizedBox(
                              width: 100,
                              child: CustomTextField(
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
                      Container(
                        width: 400,
                        padding: const EdgeInsets.all(20),
                        child: CustomButton(
                          text: "Сохранить",
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
                          CustomTextField(
                            controller: refereeController,
                            focusNode: refereeFocusNode,
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
                                onChanged: (value) {
                                  setState(() {
                                    firstDie = value ?? -1;
                                    if (firstDie == -1) {
                                      bestMove = ClubGameResult_BestMove.miss;
                                    }
                                  });
                                },
                              ),
                              if (firstDie != -1) ...[
                                Text(
                                  "Лучший ход:",
                                  style: MyTheme.of(context).defaultTextStyle,
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
                                  onChanged: (value) {
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
                                      style:
                                          MyTheme.of(context).defaultTextStyle,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    winSelected = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
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
                                    initialTime: TimeOfDay.fromDateTime(date),
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
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Дата:",
                                  style: MyTheme.of(context)
                                      .defaultTextStyle
                                      .copyWith(
                                        color:
                                            MyTheme.of(context).darkGreyColor,
                                      ),
                                ),
                                const SizedBox(
                                  width: 80,
                                ),
                                Text(
                                  DateFormat("dd:MM:yyy HH:mm").format(date),
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
        );
      },
    );
  }

  submit(AddClubGameState state) {
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
              date: DateTime.now().toIso8601String(),
              don: roles.indexOf(PlayerRole.don),
              sheriff: roles.indexOf(PlayerRole.sheriff),
              firstDie: firstDie,
              win: winSelected,
              bestMove: bestMove,
            ),
          ),
        );
  }
}

class NicknameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final AddClubGameState state;
  final VoidCallback? onSelected;
  final String hint;

  const NicknameField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.state,
    this.onSelected,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: CustomAutoComplete(
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

class RolePicker extends StatefulWidget {
  final PlayerRole playerRole;
  final Function(PlayerRole role) onChange;

  const RolePicker({
    Key? key,
    required this.playerRole,
    required this.onChange,
  }) : super(key: key);

  @override
  State<RolePicker> createState() => _RolePickerState();
}

class _RolePickerState extends State<RolePicker> {
  late PlayerRole playerRole;
  final Duration duration = const Duration(milliseconds: 100);

  @override
  void didChangeDependencies() {
    playerRole = widget.playerRole;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => onChange(PlayerRole.mafia),
              child: AnimatedOpacity(
                opacity: playerRole == PlayerRole.mafia ? 1.0 : 0.3,
                duration: duration,
                child: SvgPicture.asset(
                  AppAssets.mafiaAsset(),
                  height: 40,
                ),
              ),
            ),
            Text(
              "М",
              style: MyTheme.of(context).defaultTextStyle,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => onChange(PlayerRole.don),
              child: AnimatedOpacity(
                opacity: playerRole == PlayerRole.don ? 1.0 : 0.3,
                duration: duration,
                child: SvgPicture.asset(
                  AppAssets.donAsset(),
                  height: 40,
                ),
              ),
            ),
            Text(
              "Д",
              style: MyTheme.of(context).defaultTextStyle,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => onChange(PlayerRole.sheriff),
              child: AnimatedOpacity(
                opacity: playerRole == PlayerRole.sheriff ? 1.0 : 0.3,
                duration: duration,
                child: SvgPicture.asset(
                  AppAssets.sheriffAsset(),
                  height: 40,
                ),
              ),
            ),
            Text(
              "Ш",
              style: MyTheme.of(context)
                  .defaultTextStyle
                  .copyWith(color: Colors.red),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => onChange(PlayerRole.citizen),
              child: AnimatedOpacity(
                opacity: playerRole == PlayerRole.citizen ? 1.0 : 0.3,
                duration: duration,
                child: SvgPicture.asset(
                  AppAssets.citizenAsset(),
                  height: 40,
                ),
              ),
            ),
            Text(
              "К",
              style: MyTheme.of(context)
                  .defaultTextStyle
                  .copyWith(color: Colors.red),
            ),
          ],
        ),
      ]
          .map(
            (child) => Container(
              padding: const EdgeInsets.all(4),
              child: child,
            ),
          )
          .toList(),
    );
  }

  onChange(PlayerRole role) {
    setState(() {
      playerRole = role;
    });
    widget.onChange(role);
  }
}
