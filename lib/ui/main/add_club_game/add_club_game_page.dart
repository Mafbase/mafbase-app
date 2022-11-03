import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
  final List<_Role> roles = List.generate(10, (index) => _Role.citizen);
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < 10; i++)
                    Row(
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomAutoComplete(
                                  controller: controllers[i],
                                  displayStringForOption: (model) =>
                                      "${model.nickname} (${model.id})",
                                  focusNode: focusNodes[i],
                                  availablePlayers: state.players,
                                  onSelected: (playerModel) {
                                    controllers[i].text = playerModel.nickname;
                                    if (i < 9) {
                                      focusNodes[i + 1].requestFocus();
                                    } else {
                                      refereeFocusNode.requestFocus();
                                    }
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
                                  hint: "Игрок ${i + 1}",
                                ),
                              ),
                              DropdownButton<_Role>(
                                value: roles[i],
                                items: _Role.values.map((role) {
                                  final String text;
                                  switch (role) {
                                    case _Role.mafia:
                                      text = "Мафия";
                                      break;
                                    case _Role.don:
                                      text = "Дон";
                                      break;
                                    case _Role.sheriff:
                                      text = "Шериф";
                                      break;
                                    case _Role.citizen:
                                      text = "Мирный житель";
                                      break;
                                    default:
                                      text = "";
                                      break;
                                  }
                                  return DropdownMenuItem(
                                    value: role,
                                    child: Text(
                                      text,
                                      style:
                                          MyTheme.of(context).defaultTextStyle,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    roles[i] = value ?? roles[i];
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: CustomTextField(
                            controller: addScoreControllers[i],
                            textInputType: const TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            hint: "0.0",
                          ),
                        )
                      ],
                    ),
                  CustomAutoComplete(
                    controller: refereeController,
                    displayStringForOption: (model) =>
                        "${model.nickname} (${model.id})",
                    focusNode: refereeFocusNode,
                    availablePlayers: state.players,
                    onSelected: (playerModel) {
                      refereeController.text = playerModel.nickname;
                      refereeFocusNode.unfocus();
                    },
                    onSubmit: () {},
                    optionsBuilder: (value) => state.players
                        .where(
                          (element) => element.nickname
                              .toLowerCase()
                              .contains(value.text.toLowerCase()),
                        )
                        .sortedBy<num>((element) => element.nickname.length),
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
                                index == 0 ? "Промах" : index.toString(),
                                style: MyTheme.of(context).defaultTextStyle,
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
                          items: ClubGameResult_BestMove.values.map((bestMove) {
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
                                style: MyTheme.of(context).defaultTextStyle,
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
                              style: MyTheme.of(context).defaultTextStyle,
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
                    child: Text(DateFormat("dd:MM:yyy HH:mm").format(date)),
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
                  ),
                  CustomButton(text: "Сохранить", onTap: () => submit(state)),
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
        roles.where((element) => element == _Role.mafia).length != 2 ||
        roles.where((element) => element == _Role.don).length != 1 ||
        roles.where((element) => element == _Role.sheriff).length != 1 ||
        controllers
                .map(
                  (e) => state.players.firstWhereOrNull(
                      (element) => e.text == element.nickname),
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
              mafia1: roles.indexOf(_Role.mafia),
              mafia2: roles.lastIndexOf(_Role.mafia),
              referee: state.players
                  .firstWhere(
                      (element) => refereeController.text == element.nickname)
                  .id,
              date: DateTime.now().toIso8601String(),
              don: roles.indexOf(_Role.don),
              sheriff: roles.indexOf(_Role.sheriff),
              firstDie: firstDie,
              win: winSelected,
              bestMove: bestMove,
            ),
          ),
        );
  }
}

enum _Role {
  mafia,
  don,
  sheriff,
  citizen;
}
