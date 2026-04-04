import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/common/widgets/player_autocomplete/player_autocomplete.dart';
import 'package:seating_generator_web/common/widgets/role_picker.dart';
import 'package:seating_generator_web/domain/models/ci_scheme_model.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_bloc.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_router.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_effect.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_event.dart';
import 'package:seating_generator_web/ui/main/add_club_game/add_club_game_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_page.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class AddClubGamePage extends StatefulWidget {
  final bool readOnly;
  final int? gameId;
  final DateTime? initDateTime;

  const AddClubGamePage({
    super.key,
    this.readOnly = false,
    this.gameId,
    this.initDateTime,
  });

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
      pathParameters: {
        'id': tournamentId.toString(),
        'gameId': gameId.toString(),
      },
      queryParameters: {
        'edit': edit.toString(),
      },
    );
  }

  static final GoRoute tournamentEditRoute = GoRoute(
    path: 'editGame/:gameId',
    name: 'editTournamentGame',
    builder: (context, state) {
      final gameId = int.parse(state.pathParameters['gameId']!);
      final tournamentId = int.parse(state.pathParameters['id']!);
      final edit = bool.tryParse(state.uri.queryParameters['edit'] ?? '') ?? true;
      return BlocProvider<AddClubGameBloc>(
        create: (context) => AddClubGameBloc(
          context: context,
          tournamentId: tournamentId,
          repos: RepositoryFactory.of(context),
          router: AddClubGameRouterImpl(context),
        ),
        child: AddClubGamePage(
          key: ValueKey(gameId),
          readOnly: !edit,
          gameId: gameId,
        ),
      );
    },
  );

  static final List<GoRoute> routes = [
    GoRoute(
      path: 'addGame',
      name: 'addGame',
      builder: (context, state) {
        final clubId = int.parse(state.pathParameters['clubId']!);
        final initDateTime = state.extra as DateTime?;
        return BlocProvider<AddClubGameBloc>(
          create: (context) => AddClubGameBloc(
            clubId: clubId,
            context: context,
            repos: RepositoryFactory.of(context),
            router: AddClubGameRouterImpl(context),
          ),
          child: AddClubGamePage(
            key: const ValueKey(null),
            initDateTime: initDateTime,
          ),
        );
      },
    ),
    GoRoute(
      name: 'viewGame',
      path: 'game/:gameId',
      builder: (context, state) {
        final clubId = int.parse(state.pathParameters['clubId']!);
        final gameId = int.parse(state.pathParameters['gameId']!);
        final edit = state.uri.queryParameters['edit'] == true.toString();
        return BlocProvider<AddClubGameBloc>(
          create: (context) => AddClubGameBloc(
            clubId: clubId,
            context: context,
            repos: RepositoryFactory.of(context),
            router: AddClubGameRouterImpl(context),
          ),
          child: AddClubGamePage(
            key: ValueKey(gameId),
            readOnly: !edit,
            gameId: gameId,
          ),
        );
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
      'viewGame',
      pathParameters: {
        'clubId': clubId.toString(),
        'gameId': gameId.toString(),
      },
      queryParameters: {'edit': canEdit.toString()},
    );
  }

  static String createLocation(
    BuildContext context,
    int clubId,
  ) {
    return context.namedLocation(
      'addGame',
      pathParameters: {
        'clubId': clubId.toString(),
      },
    );
  }
}

class _AddClubGamePageState extends CustomState<AddClubGamePage>
    with EffectListener<AddClubGameEffect, AddClubGameState, AddClubGameBloc, AddClubGamePage> {
  final controllers = List.generate(10, (index) => TextEditingController());
  final addScoreControllers = List.generate(
    10,
    (index) => TextEditingController()..text = '0.0',
  );
  final minusScoreControllers = List.generate(
    10,
    (index) => TextEditingController()..text = '0.0',
  );
  final refereeController = TextEditingController();
  final refereeFocusNode = FocusNode();
  final focusNodes = List.generate(10, (index) => FocusNode());
  final addScoreFocusNodes = List.generate(10, (index) => FocusNode());
  final minusScoreFocusNodes = List.generate(10, (index) => FocusNode());
  GameWin? winSelected;
  int? firstDie;
  BestMove? bestMove;
  List<PlayerRole> roles = List.generate(10, (index) => PlayerRole.citizen);
  late DateTime date = widget.initDateTime ?? DateTime.now();
  CiSchemeModel? ciSchemeModel;
  RatingScheme? ratingScheme;
  final Set<PlayerModel> players = {};

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
    for (final focusNode in minusScoreFocusNodes) {
      focusNode.dispose();
    }
    for (final controller in addScoreControllers) {
      controller.dispose();
    }
    for (final controller in minusScoreControllers) {
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

    if (context.read<AddClubGameBloc>().state.isTournament) {
      ciSchemeModel = CiSchemeModel.empty;
    }

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
      // Обрабатываем minusScore если он есть
      switch (effect.minusScore) {
        case List<double> minusScore when minusScore.length == 10:
          minusScoreControllers[i].text = minusScore[i].toString();
        default:
          minusScoreControllers[i].text = '0.0';
      }

      // Обрабатываем addScore
      switch (effect.addScore) {
        case List<double> addScore when addScore.length == 10:
          addScoreControllers[i].text = addScore[i].toString();
        default:
          addScoreControllers[i].text = '0.0';
      }

      if (effect.players case final players?) {
        this.players.add(players[i]);
        controllers[i].text = players[i].nickname;
      }
    }

    if (effect.referee case final referee?) refereeController.text = referee;
    if (effect.refereePlayer case final refereePlayer?) players.add(refereePlayer);

    setState(() {
      winSelected = effect.win;
      bestMove = effect.bestMove;
      firstDie = effect.died;
      if (effect.date case final selectedDate?) date = selectedDate;
      if (effect.roles case final selectedRoles?) {
        roles = selectedRoles.toList();
      }
      ciSchemeModel = effect.ciModel;
      ratingScheme = effect.ratingsSchema ?? RatingScheme.oldFSM;
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
  Widget? buildMobile(BuildContext context) => BlocBuilder<AddClubGameBloc, AddClubGameState>(
        builder: (context, state) => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  onPressed: context.backOrGoToDefault((c) {
                    final bloc = c.read<AddClubGameBloc>();
                    return bloc.clubId != null
                        ? RatingPage.createClubLocation(clubId: bloc.clubId!, context: c)
                        : TournamentPage.createLocation(context: c, tournamentId: bloc.tournamentId!);
                  }),
                ),
                title: Text(state.clubName),
              ),
              body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Stack(
                      children: [
                        Column(
                          spacing: 8,
                          children: [
                            ...buildPlayersRow(state),
                            buildGameInfoWidget(state),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state.isLoading) const LoadingOverlayWidget(),
          ],
        ),
      );

  @override
  Widget buildDesktop(BuildContext context) => BlocBuilder<AddClubGameBloc, AddClubGameState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: context.backOrGoToDefault((c) {
                  final bloc = c.read<AddClubGameBloc>();
                  return bloc.clubId != null
                      ? RatingPage.createClubLocation(clubId: bloc.clubId!, context: c)
                      : TournamentPage.createLocation(context: c, tournamentId: bloc.tournamentId!);
                }),
              ),
              title: Text(state.clubName),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
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
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  if (state.isLoading) const LoadingOverlayWidget(),
                ],
              ),
            ),
          );
        },
      );

  Widget buildGameInfoWidget(AddClubGameState state) => Container(
        padding: context.isMobile ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 30),
        margin: const EdgeInsets.only(left: 8),
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
        child: SizedBox(
          width: context.isMobile ? null : 250,
          child: Column(
            crossAxisAlignment: context.isMobile ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              NicknameField(
                down: true,
                controller: refereeController,
                focusNode: refereeFocusNode,
                onSelected: (player) => players.add(player),
                readOnly: widget.readOnly || state.isTournament,
                label: 'Судья',
                onNewPlayer: ({String? initValue}) async {
                  context.read<AddClubGameBloc>().add(
                        AddClubGameEvent.onNewPlayer(
                          nickname: initValue ?? '',
                          index: 10,
                        ),
                      );
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Первый отстрел:',
                style: MyTheme.of(context).defaultTextStyle,
              ),
              const SizedBox(height: 4),
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
                        ? 'Промах'
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
              const SizedBox(height: 8),
              if (firstDie != null && firstDie != -1) ...[
                Text(
                  'Лучший ход:',
                  style: MyTheme.of(context).defaultTextStyle,
                ),
                const SizedBox(height: 4),
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
                        text = 'Полный лучший ход';
                        break;
                      case BestMove.half:
                        text = 'Двойка черных';
                        break;
                      case BestMove.miss:
                        text = 'Мимо';
                        break;
                      case BestMove.one:
                        text = 'Один маф';
                        break;
                      default:
                        text = '';
                        break;
                    }
                    return text;
                  },
                  onChanged: widget.readOnly ? null : (value) => bestMove = value,
                ),
                const SizedBox(height: 8),
              ],
              Text(
                'Результат:',
                style: MyTheme.of(context).defaultTextStyle,
              ),
              const SizedBox(height: 4),
              StatefulBuilder(
                builder: (context, setState) {
                  return CustomDropdown<GameWin>(
                    readOnly: widget.readOnly,
                    initValue: winSelected,
                    mapToString: (win) {
                      final String text;
                      switch (win) {
                        case GameWin.city:
                          text = 'Победа города';
                          break;
                        case GameWin.draw:
                          text = 'Ничья';
                          break;
                        case GameWin.mafia:
                          text = 'Победа мафии';
                          break;
                        default:
                          text = '';
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
              const SizedBox(height: 8),
              if (!state.isTournament) ...[
                Text(
                  context.locale.ci,
                  style: MyTheme.of(context).defaultTextStyle,
                ),
                const SizedBox(height: 4),
                StatefulBuilder(
                  builder: (context, setState) {
                    return CustomDropdown<CiSchemeModel>(
                      readOnly: widget.readOnly || state.isTournament,
                      initValue: ciSchemeModel,
                      mapToString: (model) {
                        return model?.name ?? context.locale.withoutCi;
                      },
                      items: [
                        CiSchemeModel.empty,
                        ...state.ciSchemes,
                      ],
                      onChanged: (value) {
                        setState(() {
                          ciSchemeModel = value;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 8),
              ],
              if (!state.isTournament) ...[
                Text(
                  context.locale.rating_schema,
                  style: MyTheme.of(context).defaultTextStyle,
                ),
                const SizedBox(height: 4),
                StatefulBuilder(
                  builder: (context, setState) {
                    return CustomDropdown<RatingScheme>(
                      readOnly: widget.readOnly,
                      initValue: ratingScheme,
                      mapToString: (model) {
                        switch (model) {
                          case RatingScheme.minusFSM:
                            return context.locale.minus_fsm_schema;
                          default:
                            return context.locale.old_fsm_schema;
                        }
                      },
                      items: [
                        RatingScheme.oldFSM,
                        RatingScheme.minusFSM,
                      ],
                      onChanged: (value) {
                        setState(() {
                          ratingScheme = value;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 8),
              ],
              StatefulBuilder(
                builder: (context, setState) => InkWell(
                  customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onTap: widget.readOnly || state.isTournament
                      ? null
                      : () {
                          showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          ).then((value) async {
                            if (!context.mounted) return null;
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
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Text(context.locale.date),
                          const Spacer(),
                          Text(
                            DateFormat('dd:MM:yyy HH:mm').format(date),
                          ),
                        ],
                      ),
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
                        text: widget.readOnly ? 'Изменить' : 'Сохранить',
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
                          child: Text(context.locale.addGame),
                        ),
                      ),
                    if (widget.readOnly && widget.gameId != null && !state.isTournament && state.canEdit)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextButton(
                          onPressed: () async {
                            final confirm = await ConfirmDialog.open(context);
                            if (!mounted || confirm != true) return;

                            context.read<AddClubGameBloc>().add(
                                  AddClubGameEvent.deleteGame(
                                    gameId: widget.gameId!,
                                  ),
                                );
                          },
                          child: Text(
                            context.locale.deleteGame,
                            style: MyTheme.of(context).textBtnTextStyle.copyWith(
                                  color: MyTheme.of(context).btnRedColor,
                                ),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
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
              minusScoreFocusNode: minusScoreFocusNodes[i],
              minusScoreController: minusScoreControllers[i],
              nicknameController: controllers[i],
              focusNode: focusNodes[i],
              readOnly: widget.readOnly,
              label: 'Игрок ${i + 1}',
              onSelected: (player) {
                players.add(player);
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
                        nickname: initValue ?? '',
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
      context.read<AddClubGameBloc>().add(AddClubGameEvent.edit(gameId: widget.gameId!));
      return;
    }
    if (roles.where((element) => element == PlayerRole.maf).length != 2 ||
        roles.where((element) => element == PlayerRole.don).length != 1 ||
        roles.where((element) => element == PlayerRole.sheriff).length != 1) {
      AppRouter.showErrorDialog(context, 'Проверьте роли');
      return;
    }
    if (winSelected == null) {
      AppRouter.showErrorDialog(context, 'Не выбран результат игры');
      return;
    }

    if (controllers.any(
      (e) =>
          players.firstWhereOrNull(
            (element) => e.text == element.nickname,
          ) ==
          null,
    )) {
      AppRouter.showErrorDialog(
        context,
        'Не найден игрок: ${controllers.firstWhere(
              (e) =>
                  players.firstWhereOrNull(
                    (element) => e.text == element.nickname,
                  ) ==
                  null,
            ).text}',
      );
      return;
    }

    if (players.firstWhereOrNull(
              (element) => refereeController.text == element.nickname,
            ) ==
            null &&
        !state.isTournament) {
      AppRouter.showErrorDialog(
        context,
        'Не найден судья: ${refereeController.text}',
      );
      return;
    }

    if (firstDie != -1 && bestMove == null) {
      AppRouter.showErrorDialog(context, 'Установите лучший ход');
      return;
    }

    if (firstDie == null) {
      AppRouter.showErrorDialog(context, 'Не указан первый отстрел');
      return;
    }
    if (ciSchemeModel == null) {
      AppRouter.showErrorDialog(context, 'Не указана схема компенсации');
      return;
    }

    // Проверка что все значения addScore неотрицательные
    final addScores = addScoreControllers
        .map(
          (e) => double.parse(e.text.replaceAll(',', '.')),
        )
        .toList();
    if (addScores.any((score) => score < 0)) {
      AppRouter.showErrorDialog(
        context,
        'Положительные баллы не могут быть отрицательными',
      );
      return;
    }

    // Проверка что все значения minusScore неотрицательные
    final minusScores = minusScoreControllers
        .map(
          (e) => double.parse(e.text.replaceAll(',', '.')),
        )
        .toList();
    if (minusScores.any((score) => score < 0)) {
      AppRouter.showErrorDialog(
        context,
        'Отрицательные баллы не могут быть отрицательными (используйте положительное значение)',
      );
      return;
    }

    context.read<AddClubGameBloc>().add(
          AddClubGameEvent.submit(
            gameResult: ClubGameResult(
              date: date.toIso8601String(),
              addScore: addScores.map((e) => (e * 100).floor()).toList(),
              minusScore: minusScores.map((e) => (e * 100).floor()).toList(),
              players: controllers.map(
                (e) => players.firstWhere((element) => e.text == element.nickname).id,
              ),
              mafia1: roles.indexOf(PlayerRole.maf),
              mafia2: roles.lastIndexOf(PlayerRole.maf),
              referee: players
                  .firstWhereOrNull(
                    (element) => refereeController.text == element.nickname,
                  )
                  ?.id,
              don: roles.indexOf(PlayerRole.don),
              sheriff: roles.indexOf(PlayerRole.sheriff),
              firstDie: firstDie,
              win: winSelected,
              bestMove: bestMove,
              ciId: ciSchemeModel == CiSchemeModel.empty ? null : ciSchemeModel?.id,
              ratingScheme: ratingScheme,
            ),
            gameId: widget.gameId,
          ),
        );
  }
}

class NicknameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  final Function(PlayerModel player)? onSelected;
  final Function({String? initValue})? onNewPlayer;
  final bool readOnly;
  final String label;
  final bool down;
  final List<PlayerModel>? availablePlayers;

  const NicknameField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.readOnly,
    this.onNewPlayer,
    this.onSelected,
    required this.label,
    required this.down,
    this.availablePlayers,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: PlayerAutoComplete(
        readOnly: readOnly,
        openDirection: down ? OptionsViewOpenDirection.down : OptionsViewOpenDirection.up,
        controller: controller,
        focusNode: focusNode,
        availablePlayers: availablePlayers,
        onSelected: (playerModel) {
          controller.text = playerModel.nickname;
          onSelected?.call(playerModel);
        },
        onNewPlayer:
            onNewPlayer != null ? ({required String initValue}) => onNewPlayer?.call(initValue: initValue) : null,
        label: label,
      ),
    );
  }
}

class PlayerRowWidget extends StatefulWidget {
  final void Function(PlayerRole role) onRoleChanged;
  final TextEditingController addScoreController;
  final TextEditingController minusScoreController;
  final TextEditingController nicknameController;
  final Function(PlayerModel) onSelected;
  final FocusNode focusNode;
  final FocusNode addScoreFocusNode;
  final FocusNode minusScoreFocusNode;
  final bool readOnly;
  final bool isTournament;
  final String label;
  final PlayerRole role;
  final Function({String? initValue}) onNewPlayer;
  final bool down;

  const PlayerRowWidget({
    super.key,
    required this.onRoleChanged,
    required this.addScoreController,
    required this.minusScoreController,
    required this.nicknameController,
    required this.focusNode,
    required this.readOnly,
    required this.label,
    required this.onSelected,
    required this.role,
    required this.onNewPlayer,
    required this.addScoreFocusNode,
    required this.minusScoreFocusNode,
    required this.isTournament,
    required this.down,
  });

  @override
  State<PlayerRowWidget> createState() => _PlayerRowWidgetState();
}

class _PlayerRowWidgetState extends CustomState<PlayerRowWidget> {
  @override
  Widget? buildMobile(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildNicknameField(),
          const SizedBox(height: 4),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              RolePicker(
                readOnly: widget.readOnly,
                playerRole: widget.role,
                onChange: widget.onRoleChanged,
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildAddScoreField(),
                  const SizedBox(width: 8),
                  buildMinusScoreField(),
                ],
              ),
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
        const SizedBox(width: 8),
        buildMinusScoreField(),
      ],
    );
  }

  Widget buildAddScoreField() => SizedBox(
        width: context.isMobile ? 60 : 64,
        child: CustomTextField(
          focusNode: widget.addScoreFocusNode,
          readOnly: widget.readOnly,
          controller: widget.addScoreController,
          hint: '0.0',
          label: '+',
        ),
      );

  Widget buildMinusScoreField() => SizedBox(
        width: context.isMobile ? 60 : 64,
        child: CustomTextField(
          focusNode: widget.minusScoreFocusNode,
          readOnly: widget.readOnly,
          controller: widget.minusScoreController,
          hint: '0.0',
          label: '-',
        ),
      );

  Widget buildNicknameField() => NicknameField(
        down: widget.down,
        readOnly: widget.readOnly || widget.isTournament,
        controller: widget.nicknameController,
        focusNode: widget.focusNode,
        label: widget.label,
        onNewPlayer: widget.onNewPlayer,
        onSelected: widget.onSelected,
      );
}
