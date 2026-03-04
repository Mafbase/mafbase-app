import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:seating_generator_web/domain/models/club_rating_row.dart';
import 'package:seating_generator_web/utils.dart';

enum RatingTableStyle {
  full,
  stats,
  score,
  custom;
}

enum RatingSort {
  score,
  winRate,
  citizenWinRate,
  mafiaWinRate,
  donWinRate,
  sheriffWinRate,
  scorePerGame,
  addScorePerGame,
  citizenAddScorePerGame,
  mafiaAddScorePerGame,
  donAddScorePerGame,
  sheriffAddScorePerGame,
  dies,
  customColumn;
}

class RatingTable extends StatefulWidget {
  final List<ClubRatingRowModel> rows;
  final int? clubId;
  final int? tournamentId;
  final bool isMobile;
  final Function(int gameId) openGame;
  final Function(RatingSort sort, {int? customSortColumnIndex}) changeSort;
  final RatingTableStyle style;
  final RatingSort sort;
  final List<ClubRatingRowModel> sortedRows;
  final int gameFilter;
  final bool isTournament;
  final bool pinNicknames;
  final int customSortColumnIndex;
  final void Function(int playerId)? onPlayerTap;

  RatingTable({
    super.key,
    required this.rows,
    required this.clubId,
    required this.tournamentId,
    required this.openGame,
    RatingTableStyle? style,
    this.isMobile = false,
    RatingSort? sort,
    int? gameFilter,
    required this.changeSort,
    required this.isTournament,
    this.pinNicknames = false,
    this.customSortColumnIndex = 0,
    this.onPlayerTap,
  })  : style = style ?? RatingTableStyle.full,
        sort = sort ?? RatingSort.score,
        gameFilter = gameFilter ?? 0,
        sortedRows = createSortedRows(
          rows,
          sort ?? RatingSort.score,
          isTournament,
          customSortColumnIndex: customSortColumnIndex,
        )
            .where(
              (element) => element.gamesCount >= (gameFilter ?? 0),
            )
            .toList();

  static List<ClubRatingRowModel> createSortedRows(
    List<ClubRatingRowModel> rows,
    RatingSort sort,
    bool isTournament, {
    int customSortColumnIndex = 0,
  }) {
    switch (sort) {
      case RatingSort.score:
        return rows;
      case RatingSort.winRate:
        return rows.sortedBy<num>(
          (element) => -(element.gamesCount == 0 ? 0 : element.wins / element.gamesCount),
        );
      case RatingSort.citizenWinRate:
        return rows.sortedBy<num>(
          (element) => -(element.citizenGamesCount == 0 ? 0 : element.citizenWinsCount / element.citizenGamesCount),
        );
      case RatingSort.mafiaWinRate:
        return rows.sortedBy<num>(
          (element) => -(element.mafiaGamesCount == 0 ? 0 : element.mafiaWinsCount / element.mafiaGamesCount),
        );
      case RatingSort.donWinRate:
        return rows.sortedBy<num>(
          (element) => -(element.donsGamesCount == 0 ? 0 : element.donsWinsCount / element.donsGamesCount),
        );
      case RatingSort.sheriffWinRate:
        return rows.sortedBy<num>(
          (element) => -(element.sheriffGamesCount == 0 ? 0 : element.sheriffWinsCount / element.sheriffGamesCount),
        );
      case RatingSort.dies:
        return rows.sortedBy<num>(
          (element) => -((element.sheriffGamesCount + element.citizenGamesCount) == 0
              ? 0
              : element.died / (element.sheriffGamesCount + element.citizenGamesCount)),
        );
      case RatingSort.citizenAddScorePerGame:
        return rows.sortedBy<num>(
          (element) => isTournament
              ? -element.citizenAddScore
              : -customDivide(
                  element.citizenAddScore,
                  element.citizenGamesCount,
                ),
        );
      case RatingSort.mafiaAddScorePerGame:
        return rows.sortedBy<num>(
          (element) => isTournament
              ? -element.mafiaAddScore
              : -customDivide(
                  element.mafiaAddScore,
                  element.mafiaGamesCount,
                ),
        );
      case RatingSort.donAddScorePerGame:
        return rows.sortedBy<num>(
          (element) => isTournament
              ? -element.donAddScore
              : -customDivide(
                  element.donAddScore,
                  element.donsGamesCount,
                ),
        );
      case RatingSort.sheriffAddScorePerGame:
        return rows.sortedBy<num>(
          (element) => isTournament
              ? -element.sheriffAddScore
              : -customDivide(
                  element.sheriffAddScore,
                  element.sheriffGamesCount,
                ),
        );
      case RatingSort.scorePerGame:
        return rows.sortedBy<num>(
          (element) => -customDivide(
            element.score,
            element.gamesCount,
          ),
        );
      case RatingSort.addScorePerGame:
        return rows.sortedBy<num>(
          (element) => -customDivide(
            element.addScore,
            element.gamesCount,
          ),
        );
      case RatingSort.customColumn:
        return rows.sortedBy<num>(
          (element) {
            if (customSortColumnIndex < element.customColumns.length) {
              return -(element.customColumns[customSortColumnIndex].value ?? 0);
            }
            return 0;
          },
        );
    }
  }

  @override
  State<RatingTable> createState() => _RatingTableState();
}

class _RatingTableState extends State<RatingTable> {
  late LinkedScrollControllerGroup linkedScrollControllerGroup;
  late LinkedScrollControllerGroup mainLinkedScrollControllerGroup;
  late List<ScrollController> controllers;
  late List<ScrollController> mainControllers;

  int get mainControllersSize {
    if (widget.style == RatingTableStyle.full) return 10;
    if (widget.style == RatingTableStyle.custom) {
      final customCount = widget.rows.firstOrNull?.customColumns.length ?? 0;
      return 2 + customCount;
    }
    return 8;
  }

  @override
  void initState() {
    linkedScrollControllerGroup = LinkedScrollControllerGroup();
    mainLinkedScrollControllerGroup = LinkedScrollControllerGroup();
    mainControllers = List.generate(
      mainControllersSize,
      (index) => mainLinkedScrollControllerGroup.addAndGet(),
    );
    controllers = List.generate(
      (widget.sortedRows.firstOrNull?.games.length ?? 0) + 1,
      (index) => linkedScrollControllerGroup.addAndGet(),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RatingTable oldWidget) {
    if (oldWidget.sortedRows.length != widget.sortedRows.length) {
      for (final controller in controllers) {
        controller.dispose();
      }
      linkedScrollControllerGroup = LinkedScrollControllerGroup();
      controllers = List.generate(
        widget.sortedRows.length + 1,
        (index) => linkedScrollControllerGroup.addAndGet(),
      );
    }
    if (oldWidget.style != widget.style) {
      for (final controller in mainControllers) {
        controller.dispose();
      }
      mainLinkedScrollControllerGroup = LinkedScrollControllerGroup();
      mainControllers = List.generate(
        mainControllersSize,
        (index) => mainLinkedScrollControllerGroup.addAndGet(),
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    for (final controller in controllers + mainControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget wrap(
    Widget child, {
    bool boldRight = false,
    bool boldLeft = false,
    bool center = false,
  }) {
    return Container(
      height: 50,
      padding: center ? EdgeInsets.zero : const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black.withValues(alpha: 0.2),
            width: boldLeft ? 2.5 : 0.5,
          ),
          right: BorderSide(
            color: Colors.black.withValues(alpha: 0.2),
            width: boldRight ? 2.5 : 0.5,
          ),
          top: BorderSide(
            color: Colors.black.withValues(alpha: 0.2),
            width: 0.5,
          ),
          bottom: BorderSide(
            color: Colors.black.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
      child: center ? Center(child: child) : child,
    );
  }

  Widget get indexProtoype => wrap(Text(widget.sortedRows.length.toString()));

  Widget indexWidgets(int index) => wrap(
        Text(
          (index + 1).toString(),
        ),
      );

  Widget get nicknamePrototype => wrap(
        Text(
          widget.sortedRows.map((e) => e.nickname).sortedBy<num>((element) => element.length).lastOrNull ?? "",
        ),
      );

  Widget nicknames(int index, {bool? boldRight}) => wrap(
        widget.onPlayerTap != null
            ? InkWell(
                onTap: () => widget.onPlayerTap!(widget.sortedRows[index].playerId),
                child: Text(
                  widget.sortedRows[index].nickname,
                ),
              )
            : Text(widget.sortedRows[index].nickname),
        boldRight: boldRight ?? false,
      );

  Widget get scorePrototype => wrap(
        Text(
          widget.sortedRows.map((e) => e.score.toString()).sortedBy<num>((element) => element.length).lastOrNull ?? "",
        ),
      );

  Widget scores(int index) => wrap(
        Text(
          widget.sortedRows[index].score.toString(),
        ),
      );

  Widget get addScorePrototype => wrap(
        Text(
          widget.sortedRows.map((e) => e.addScore.toString()).sortedBy<num>((element) => element.length).lastOrNull ??
              "",
        ),
      );

  Widget addScores(int index) => wrap(
        Text(
          widget.sortedRows[index].addScore.toString(),
        ),
        boldRight: true,
      );

  Widget get winPrototype => wrap(
        Text(
          widget.sortedRows.map((e) => e.wins.toString()).sortedBy<num>((element) => element.length).lastOrNull ?? "",
        ),
      );

  Widget wins(int index) => wrap(
        Text(
          widget.sortedRows[index].wins.toString(),
        ),
      );

  Widget get roleWinPrototype => wrap(
        Text(
          widget.sortedRows.map((e) => e.roleWins.toString()).sortedBy<num>((element) => element.length).lastOrNull ??
              "",
        ),
      );

  Widget roleWins(int index) => wrap(
        Text(
          widget.sortedRows[index].roleWins.toString(),
        ),
      );

  Widget get ciPrototype => wrap(
        Text(
          widget.sortedRows.map((e) => e.ci.toString()).sortedBy<num>((element) => element.length).lastOrNull ?? "",
        ),
      );

  Widget ciWidget(int index) => wrap(
        Text(
          (widget.sortedRows[index].ci / 100).toString(),
          maxLines: 1,
          overflow: TextOverflow.visible,
        ),
        boldLeft: true,
        center: true,
      );

  Widget totalGamesWidget(int index) => wrap(
        Text(
          widget.sortedRows[index].gamesCount.toString(),
        ),
      );

  Widget get diesPrototype => wrap(
        Text(
          widget.sortedRows.map((e) => e.died.toString()).sortedBy<num>((element) => element.length).lastOrNull ?? "",
        ),
      );

  Widget dies(int index) => wrap(
        Text(
          widget.sortedRows[index].died.toString(),
        ),
      );

  Widget? gameHeader(double width, [bool expand = true]) => widget.sortedRows.isEmpty
      ? null
      : SizedBox(
          height: 50,
          child: Builder(
            builder: (context) {
              builder(BuildContext context, int index) {
                return Container(
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.2),
                      width: 0.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                    ),
                  ),
                );
              }

              if (!expand) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    widget.sortedRows.firstOrNull?.games.length ?? 0,
                    (index) => builder(context, index),
                  ),
                );
              }
              return ListView.builder(
                key: Key(
                  "GameHeader${widget.sortedRows.length}/${widget.clubId}/${widget.tournamentId}",
                ),
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: controllers.first,
                itemCount: (widget.sortedRows.firstOrNull?.games.length ?? 0),
                itemBuilder: builder,
              );
            },
          ),
        );

  Widget games(double width, int rowIndex, [bool expand = true]) {
    return SizedBox(
      height: 50,
      child: Builder(
        builder: (context) {
          builder(BuildContext context, int index) {
            if (widget.sortedRows[rowIndex].games.length <= index) {
              return const SizedBox.shrink();
            }

            return InkWell(
              onTap: widget.sortedRows[rowIndex].games[index].score == null
                  ? null
                  : () => widget.openGame(
                        widget.sortedRows[rowIndex].games[index].gameId,
                      ),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.2),
                    width: 0.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.sortedRows[rowIndex].games[index].score?.toString() ?? "",
                  ),
                ),
              ),
            );
          }

          if (!expand) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.sortedRows.firstOrNull?.games.length ?? 0,
                (index) => builder(context, index),
              ),
            );
          }
          return ListView.builder(
            key: Key(
              "GameRow$rowIndex/${widget.sortedRows.length}/${widget.clubId}/${widget.tournamentId}",
            ),
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: controllers[rowIndex + 1],
            itemCount: (widget.sortedRows.firstOrNull?.games.length ?? 0),
            itemBuilder: builder,
          );
        },
      ),
    );
  }

  Widget winRatePrototype() {
    final element = widget.sortedRows
        .sortedBy<num>(
          (element) => element.gamesCount.toString().length + element.wins.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return winRateFromModel(element);
  }

  Widget winRateFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${(customDivideForPercents(model.wins, model.gamesCount)).round()}% (${model.wins}/${model.gamesCount})",
        ),
      );

  Widget winRate(int index) => winRateFromModel(widget.sortedRows[index]);

  Widget citizenWinRatePrototype() {
    final element = widget.sortedRows
        .sortedBy<num>(
          (element) => element.citizenGamesCount.toString().length + element.citizenWinsCount.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return citizenWinRateFromModel(element);
  }

  Widget citizenWinRateFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${customDivideForPercents(
            model.citizenWinsCount,
            model.citizenGamesCount,
          ).round()}% (${model.citizenWinsCount}/${model.citizenGamesCount})",
        ),
      );

  Widget citizenWinRate(int index) => citizenWinRateFromModel(widget.sortedRows[index]);

  Widget donWinRatePrototype() {
    final element = widget.sortedRows
        .sortedBy<num>(
          (element) => element.donsGamesCount.toString().length + element.donsWinsCount.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return donWinRateFromModel(element);
  }

  Widget donWinRateFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${customDivideForPercents(
            model.donsWinsCount,
            model.donsGamesCount,
          ).round()}% (${model.donsWinsCount}/${model.donsGamesCount})",
        ),
      );

  Widget donWinRate(int index) => donWinRateFromModel(widget.sortedRows[index]);

  Widget sheriffWinRatePrototype() {
    final element = widget.sortedRows
        .sortedBy<num>(
          (element) => element.sheriffGamesCount.toString().length + element.sheriffWinsCount.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return sheriffWinRateFromModel(element);
  }

  Widget sheriffWinRateFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${customDivideForPercents(
            model.sheriffWinsCount,
            model.sheriffGamesCount,
          ).round()}% (${model.sheriffWinsCount}/${model.sheriffGamesCount})",
        ),
      );

  Widget sheriffWinRate(int index) => sheriffWinRateFromModel(widget.sortedRows[index]);

  Widget mafiaWinRatePrototype() {
    final element = widget.sortedRows
        .sortedBy<num>(
          (element) => element.mafiaGamesCount.toString().length + element.mafiaWinsCount.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return mafiaWinRateFromModel(element);
  }

  Widget mafiaWinRateFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${customDivideForPercents(
            model.mafiaWinsCount,
            model.mafiaGamesCount,
          ).round()}% (${model.mafiaWinsCount}/${model.mafiaGamesCount})",
        ),
      );

  Widget mafiaWinRate(int index) => mafiaWinRateFromModel(widget.sortedRows[index]);

  Widget diesStatPrototype() {
    final element = widget.sortedRows
        .sortedBy<num>(
          (element) =>
              (element.citizenGamesCount + element.sheriffGamesCount).toString().length +
              element.died.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return diesStatFromModel(element);
  }

  Widget diesStatFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${customDivideForPercents(
            model.died,
            model.citizenGamesCount + model.sheriffGamesCount,
          ).round()}% (${model.died}/${model.citizenGamesCount + model.sheriffGamesCount})",
        ),
      );

  Widget diesStat(int index) => diesStatFromModel(widget.sortedRows[index]);

  Widget scorePerGame(int index) => wrap(
        Text("${customDivide(
          widget.sortedRows[index].score,
          widget.sortedRows[index].gamesCount,
        )}"),
      );

  Widget addScorePerGame(int index) => wrap(
        Text("${customDivide(
          widget.sortedRows[index].addScore,
          widget.sortedRows[index].gamesCount,
        )}"),
      );

  Widget citizenAddScorePerGame(int index) => wrap(
        Text("${widget.isTournament ? widget.sortedRows[index].citizenAddScore : customDivide(
            widget.sortedRows[index].citizenAddScore,
            widget.sortedRows[index].citizenGamesCount,
          )}"),
      );

  Widget sheriffAddScorePerGame(int index) => wrap(
        Text("${widget.isTournament ? widget.sortedRows[index].sheriffAddScore : customDivide(
            widget.sortedRows[index].sheriffAddScore,
            widget.sortedRows[index].sheriffGamesCount,
          )}"),
      );

  Widget donAddScorePerGame(int index) => wrap(
        Text("${widget.isTournament ? widget.sortedRows[index].donAddScore : customDivide(
            widget.sortedRows[index].donAddScore,
            widget.sortedRows[index].donsGamesCount,
          )}"),
      );

  Widget mafiaAddScorePerGame(int index) => wrap(
        Text("${widget.isTournament ? widget.sortedRows[index].mafiaAddScore : customDivide(
            widget.sortedRows[index].mafiaAddScore,
            widget.sortedRows[index].mafiaGamesCount,
          )}"),
      );

  @override
  Widget build(BuildContext context) {
    final columns = this.columns(widget.isMobile && widget.pinNicknames);

    return Material(
      color: Colors.transparent,
      child: widget.isMobile
          ? widget.pinNicknames
              ? Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...columns.take(2),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(right: 16),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: columns.skip(2).toList(),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: columns,
                  ),
                )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: columns,
            ),
    );
  }

  List<Widget> columns([withoutFlex = false]) {
    switch (widget.style) {
      case RatingTableStyle.full:
        return fullColumns(withoutFlex);
      case RatingTableStyle.stats:
        return statsColumn;
      case RatingTableStyle.score:
        return scoreColumns;
      case RatingTableStyle.custom:
        return customColumns;
    }
  }

  List<Widget> get scoreColumns => [
        column(
          mainControllers[0],
          key: const Key("scoreColumn0"),
          builder: indexWidgets,
          header: Text(context.locale.ratingNumber),
          prototype: indexProtoype,
        ),
        column(
          mainControllers[1],
          key: const Key("scoreColumn1"),
          builder: nicknames,
          header: Text(context.locale.ratingPlayer),
          prototype: nicknamePrototype,
        ),
        column(
          mainControllers[2],
          key: const Key("scoreColumn2"),
          builder: scorePerGame,
          header: InkWell(
            onTap: () {
              widget.changeSort(RatingSort.scorePerGame);
            },
            child: Text(context.locale.ratingScorePerGame),
          ),
        ),
        column(
          mainControllers[3],
          key: const Key("scoreColumn3"),
          builder: addScorePerGame,
          header: InkWell(
            onTap: () {
              widget.changeSort(RatingSort.addScorePerGame);
            },
            child: Text(context.locale.ratingMvp),
          ),
        ),
        column(
          mainControllers[4],
          key: const Key("scoreColumn4"),
          builder: citizenAddScorePerGame,
          header: InkWell(
            onTap: () {
              widget.changeSort(RatingSort.citizenAddScorePerGame);
            },
            child: Text(context.locale.ratingMvpCitizen),
          ),
        ),
        column(
          mainControllers[5],
          key: const Key("scoreColumn5"),
          builder: sheriffAddScorePerGame,
          header: InkWell(
            onTap: () {
              widget.changeSort(RatingSort.sheriffAddScorePerGame);
            },
            child: Text(context.locale.ratingMvpSheriff),
          ),
        ),
        column(
          mainControllers[6],
          key: const Key("scoreColumn6"),
          builder: donAddScorePerGame,
          header: InkWell(
            onTap: () {
              widget.changeSort(RatingSort.donAddScorePerGame);
            },
            child: Text(context.locale.ratingMvpDon),
          ),
        ),
        column(
          mainControllers[7],
          key: const Key("scoreColumn7"),
          builder: mafiaAddScorePerGame,
          header: InkWell(
            onTap: () {
              widget.changeSort(RatingSort.mafiaAddScorePerGame);
            },
            child: Text(context.locale.ratingMvpMafia),
          ),
        ),
      ];

  List<Widget> get customColumns {
    final customColumnDefs = widget.rows.firstOrNull?.customColumns ?? [];
    return [
      column(
        mainControllers[0],
        key: const Key("customColumn0"),
        builder: indexWidgets,
        header: Text(context.locale.ratingNumber),
        prototype: indexProtoype,
      ),
      column(
        mainControllers[1],
        key: const Key("customColumn1"),
        builder: nicknames,
        header: Text(context.locale.ratingPlayer),
        prototype: nicknamePrototype,
      ),
      for (int i = 0; i < customColumnDefs.length; i++)
        column(
          mainControllers[2 + i],
          key: Key("customColumn${2 + i}"),
          builder: (index) => wrap(
            Text(
              widget.sortedRows[index].customColumns.length > i
                  ? widget.sortedRows[index].customColumns[i].value?.toString() ?? "—"
                  : "—",
            ),
          ),
          header: InkWell(
            onTap: () {
              widget.changeSort(
                RatingSort.customColumn,
                customSortColumnIndex: i,
              );
            },
            child: Text(customColumnDefs[i].title),
          ),
          isLastColumn: i == customColumnDefs.length - 1,
        ),
    ];
  }

  List<Widget> get statsColumn => [
        column(
          mainControllers[0],
          key: const Key("statsColumn0"),
          builder: indexWidgets,
          header: Text(context.locale.ratingNumber),
          prototype: indexProtoype,
        ),
        column(
          mainControllers[1],
          key: const Key("statsColumn0"),
          builder: nicknames,
          header: Text(context.locale.ratingPlayer),
          prototype: nicknamePrototype,
        ),
        column(
          mainControllers[2],
          key: const Key("statsColumn2"),
          builder: winRate,
          header: InkWell(
            onTap: () {
              widget.changeSort(RatingSort.winRate);
            },
            child: Text(context.locale.ratingWinRate),
          ),
          prototype: winRatePrototype(),
        ),
        column(
          mainControllers[3],
          key: const Key("statsColumn3"),
          builder: citizenWinRate,
          header: InkWell(
            onTap: () {
              widget.changeSort(RatingSort.citizenWinRate);
            },
            child: Text(context.locale.ratingWinRateCitizen),
          ),
          prototype: citizenWinRatePrototype(),
        ),
        column(
          mainControllers[4],
          key: const Key("statsColumn4"),
          builder: sheriffWinRate,
          header: InkWell(
            onTap: () {
              widget.changeSort(RatingSort.sheriffWinRate);
            },
            child: Text(context.locale.ratingWinRateSheriff),
          ),
          prototype: sheriffWinRatePrototype(),
        ),
        column(
          mainControllers[5],
          key: const Key("statsColumn5"),
          builder: mafiaWinRate,
          header: InkWell(
            onTap: () {
              widget.changeSort(RatingSort.mafiaWinRate);
            },
            child: Text(context.locale.ratingWinRateMafia),
          ),
          prototype: mafiaWinRatePrototype(),
        ),
        column(
          mainControllers[6],
          key: const Key("statsColumn6"),
          builder: donWinRate,
          header: InkWell(
            onTap: () {
              widget.changeSort(RatingSort.donWinRate);
            },
            child: Text(context.locale.ratingWinRateDon),
          ),
          prototype: donWinRatePrototype(),
        ),
        column(
          mainControllers[7],
          key: const Key("statsColumn7"),
          builder: diesStat,
          header: InkWell(
            child: Text(context.locale.ratingKillPercentage),
            onTap: () {
              widget.changeSort(RatingSort.dies);
            },
          ),
          isLastColumn: true,
          prototype: diesStatPrototype(),
        ),
      ];

  List<Widget> fullColumns([bool withoutFlex = false]) {
    final gamesColumn = LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite ? constraints.maxWidth / (constraints.maxWidth / 60).floor() : 60.0;
        final gamesCount = widget.sortedRows.firstOrNull?.games.length ?? 0;
        final expand = width * gamesCount > constraints.maxWidth && !widget.isMobile;
        final header = gameHeader(width, expand);
        final listView = ListView.builder(
          key: const Key("fullColumns2"),
          physics: const ClampingScrollPhysics(),
          controller: mainControllers[2],
          itemCount: widget.sortedRows.length,
          shrinkWrap: widget.isMobile,
          itemBuilder: (context, index) => games(width, index, expand),
        );
        return Column(
          children: [
            if (header != null) header,
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: expand
                    ? listView
                    : Stack(
                        children: [
                          IgnorePointer(
                            child: Opacity(
                              opacity: 0,
                              child: games(width, 0, expand),
                            ),
                          ),
                          Positioned.fill(child: listView),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
    return [
      column(
        mainControllers[0],
        key: const Key("fullColumns0"),
        builder: indexWidgets,
        header: const Text("№"),
        prototype: indexProtoype,
      ),
      column(
        mainControllers[1],
        key: const Key("fullColumns1"),
        builder: (index) => nicknames(index),
        header: Text(context.locale.ratingPlayer),
        prototype: nicknamePrototype,
      ),
      column(
        mainControllers[3],
        key: const Key("fullColumns3"),
        builder: scores,
        header: InkWell(
          onTap: () {
            widget.changeSort(RatingSort.score);
          },
          child: Text(context.locale.ratingPoints),
        ),
        prototype: scorePrototype,
      ),
      column(
        mainControllers[4],
        key: const Key("fullColumns4"),
        builder: addScores,
        header: Text(context.locale.ratingPlus),
        prototype: addScorePrototype,
        boldRight: true,
      ),
      withoutFlex
          ? gamesColumn
          : Flexible(
              fit: FlexFit.loose,
              child: gamesColumn,
            ),
      column(
        mainControllers[5],
        key: const Key("fullColumns5"),
        header: Text(context.locale.ratingCi),
        prototype: ciPrototype,
        builder: ciWidget,
        boldLeft: true,
      ),
      column(
        mainControllers[6],
        key: const Key("fullColumns6"),
        header: Text(context.locale.ratingWin),
        prototype: winPrototype,
        builder: wins,
      ),
      column(
        key: const Key("fullColumns7"),
        mainControllers[7],
        header: Text(context.locale.ratingRoleWin),
        prototype: roleWinPrototype,
        builder: roleWins,
      ),
      column(
        mainControllers[8],
        key: const Key("fullColumns8"),
        builder: dies,
        header: Text(context.locale.ratingDies),
        prototype: diesPrototype,
      ),
      column(
        mainControllers[9],
        key: const Key("fullColumns9"),
        builder: totalGamesWidget,
        isLastColumn: true,
        header: Text(context.locale.ratingGames),
      ),
    ];
  }

  Widget column(
    ScrollController controller, {
    required Key key,
    List<Widget>? widgets,
    Widget Function(int index)? builder,
    Widget? prototype,
    bool isLastColumn = false,
    Widget? header,
    bool boldLeft = false,
    bool boldRight = false,
  }) {
    assert((widgets == null) != (builder == null));
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            if (prototype != null)
              ...[wrap(header ?? Container()), prototype].map(
                (e) => IgnorePointer(
                  child: Opacity(
                    opacity: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: e,
                    ),
                  ),
                ),
              )
            else
              ...[
                wrap(header ?? Container()),
                ...widgets ?? List.generate(widget.sortedRows.length, builder!),
              ].map(
                (e) => IgnorePointer(
                  child: Opacity(
                    opacity: 0,
                    child: e,
                  ),
                ),
              ),
            const SizedBox(
              height: double.infinity,
            ),
            Positioned.fill(
              child: Column(
                children: [
                  if (header != null)
                    wrap(
                      Center(
                        child: header,
                      ),
                      boldLeft: boldLeft,
                      boldRight: boldRight,
                    ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: isLastColumn),
                      child: ListView.builder(
                        key: key,
                        physics: const ClampingScrollPhysics(),
                        controller: controller,
                        itemCount: widget.sortedRows.length,
                        itemBuilder: (context, index) => builder != null ? builder(index) : widgets![index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

num customDivideForPercents(num a, num b) => b == 0 ? 0 : (a * 100) / b.toDouble();

num customDivide(num a, num b) => ((b == 0 ? 0 : a / b.toDouble()) * 10000).round() / 10000;
