import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:seating_generator_web/domain/models/club_rating_row.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_bloc.dart';
import 'package:seating_generator_web/ui/main/rating_page/rating_event.dart';

enum RatingTableStyle {
  full,
  stats;
}

enum RatingSort {
  score,
  winRate,
  citizenWinRate,
  mafiaWinRate,
  donWinRate,
  sheriffWinRate,
  dies;
}

class RatingTable extends StatefulWidget {
  final List<ClubRatingRowModel> rows;
  final int clubId;
  final Function(int gameId) openGame;
  final Function(RatingSort sort) changeSort;
  final RatingTableStyle style;
  final RatingSort sort;
  final List<ClubRatingRowModel> sortedRows;

  RatingTable({
    Key? key,
    required this.rows,
    required this.clubId,
    required this.openGame,
    RatingTableStyle? style,
    RatingSort? sort,
    required this.changeSort,
  })  : style = style ?? RatingTableStyle.full,
        sort = sort ?? RatingSort.score,
        sortedRows = createSortedRows(rows, sort ?? RatingSort.score),
        super(key: key);

  static List<ClubRatingRowModel> createSortedRows(
      List<ClubRatingRowModel> rows, RatingSort sort) {
    switch (sort) {
      case RatingSort.score:
        return rows;
      case RatingSort.winRate:
        return rows.sortedBy<num>(
          (element) => -(element.gamesCount == 0
              ? 0
              : element.wins / element.gamesCount),
        );
      case RatingSort.citizenWinRate:
        return rows.sortedBy<num>(
          (element) => -(element.citizenGamesCount == 0
              ? 0
              : element.citizenWinsCount / element.citizenGamesCount),
        );
      case RatingSort.mafiaWinRate:
        return rows.sortedBy<num>(
          (element) => -(element.mafiaGamesCount == 0
              ? 0
              : element.mafiaWinsCount / element.mafiaGamesCount),
        );
      case RatingSort.donWinRate:
        return rows.sortedBy<num>(
          (element) => -(element.donsGamesCount == 0
              ? 0
              : element.donsWinsCount / element.donsGamesCount),
        );
      case RatingSort.sheriffWinRate:
        return rows.sortedBy<num>(
          (element) => -(element.sheriffGamesCount == 0
              ? 0
              : element.sheriffWinsCount / element.sheriffGamesCount),
        );
      case RatingSort.dies:
        return rows.sortedBy<num>(
          (element) =>
              -((element.sheriffGamesCount + element.citizenGamesCount) == 0
                  ? 0
                  : element.died /
                      (element.sheriffGamesCount + element.citizenGamesCount)),
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

  int get mainControllersSize => widget.style == RatingTableStyle.full ? 9 : 8;

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

  Widget wrap(Widget child, {bool boldRight = false, bool boldLeft = false}) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: boldLeft ? 2.5 : 0.5,
          ),
          right: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: boldRight ? 2.5 : 0.5,
          ),
          top: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 0.5,
          ),
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: child,
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
          widget.sortedRows
                  .map((e) => e.nickname)
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );

  Widget nicknames(int index, {bool? boldRight}) => wrap(
        Text(widget.sortedRows[index].nickname),
        boldRight: boldRight ?? false,
      );

  Widget get scorePrototype => wrap(
        Text(
          widget.sortedRows
                  .map((e) => e.score.toString())
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );

  Widget scores(int index) => wrap(
        Text(
          widget.sortedRows[index].score.toString(),
        ),
        boldLeft: true,
      );

  Widget get addScorePrototype => wrap(
        Text(
          widget.sortedRows
                  .map((e) => e.addScore.toString())
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );

  Widget addScores(int index) => wrap(
        Text(
          widget.sortedRows[index].addScore.toString(),
        ),
      );

  Widget get winPrototype => wrap(
        Text(
          widget.sortedRows
                  .map((e) => e.wins.toString())
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );

  Widget wins(int index) => wrap(
        Text(
          widget.sortedRows[index].wins.toString(),
        ),
      );

  Widget get roleWinPrototype => wrap(
        Text(
          widget.sortedRows
                  .map((e) => e.roleWins.toString())
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
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
          widget.sortedRows
                  .map((e) => e.ci.toString())
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );

  Widget ciWidget(int index) => wrap(
        Text((widget.sortedRows[index].ci / 100).toString()),
      );

  Widget get diesPrototype => wrap(
        Text(
          widget.sortedRows
                  .map((e) => e.died.toString())
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );

  Widget dies(int index) => wrap(
        Text(
          widget.sortedRows[index].died.toString(),
        ),
      );

  Widget? gameHeader(double width, [bool expand = true]) =>
      widget.sortedRows.isEmpty
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
                          color: Colors.black.withOpacity(0.2),
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
                        "GameHeader${widget.sortedRows.length}/${widget.clubId}"),
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: controllers.first,
                    itemCount:
                        (widget.sortedRows.firstOrNull?.games.length ?? 0),
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
            return InkWell(
              onTap: widget.sortedRows[rowIndex].games[index].score == null
                  ? null
                  : () => widget.openGame(
                      widget.sortedRows[rowIndex].games[index].gameId),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.sortedRows[rowIndex].games[index].score
                            ?.toString() ??
                        "",
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
                "GameRow$rowIndex/${widget.sortedRows.length}/${widget.clubId}"),
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
          (element) =>
              element.gamesCount.toString().length +
              element.wins.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return winRateFromModel(element);
  }

  Widget winRateFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${(customDivide(model.wins, model.gamesCount)).round()}% (${model.wins}/${model.gamesCount})",
        ),
      );

  Widget winRate(int index) => winRateFromModel(widget.sortedRows[index]);

  Widget citizenWinRatePrototype() {
    final element = widget.sortedRows
        .sortedBy<num>(
          (element) =>
              element.citizenGamesCount.toString().length +
              element.citizenWinsCount.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return citizenWinRateFromModel(element);
  }

  Widget citizenWinRateFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${(customDivide(model.citizenWinsCount, model.citizenGamesCount)).round()}% (${model.citizenWinsCount}/${model.citizenGamesCount})",
        ),
      );

  Widget citizenWinRate(int index) =>
      citizenWinRateFromModel(widget.sortedRows[index]);

  Widget donWinRatePrototype() {
    final element = widget.sortedRows
        .sortedBy<num>(
          (element) =>
              element.donsGamesCount.toString().length +
              element.donsWinsCount.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return donWinRateFromModel(element);
  }

  Widget donWinRateFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${(customDivide(model.donsWinsCount, model.donsGamesCount)).round()}% (${model.donsWinsCount}/${model.donsGamesCount})",
        ),
      );

  Widget donWinRate(int index) => donWinRateFromModel(widget.sortedRows[index]);

  Widget sheriffWinRatePrototype() {
    final element = widget.sortedRows
        .sortedBy<num>(
          (element) =>
              element.sheriffGamesCount.toString().length +
              element.sheriffWinsCount.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return sheriffWinRateFromModel(element);
  }

  Widget sheriffWinRateFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${(customDivide(model.sheriffWinsCount, model.sheriffGamesCount)).round()}% (${model.sheriffWinsCount}/${model.sheriffGamesCount})",
        ),
      );

  Widget sheriffWinRate(int index) =>
      sheriffWinRateFromModel(widget.sortedRows[index]);

  Widget mafiaWinRatePrototype() {
    final element = widget.sortedRows
        .sortedBy<num>(
          (element) =>
              element.mafiaGamesCount.toString().length +
              element.mafiaWinsCount.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return mafiaWinRateFromModel(element);
  }

  Widget mafiaWinRateFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${(customDivide(model.mafiaWinsCount, model.mafiaGamesCount)).round()}% (${model.mafiaWinsCount}/${model.mafiaGamesCount})",
        ),
      );

  Widget mafiaWinRate(int index) =>
      mafiaWinRateFromModel(widget.sortedRows[index]);

  Widget diesStatPrototype() {
    final element = widget.sortedRows
        .sortedBy<num>(
          (element) =>
              (element.citizenGamesCount + element.sheriffGamesCount)
                  .toString()
                  .length +
              element.died.toString().length,
        )
        .lastOrNull;
    if (element == null) return Container();
    return diesStatFromModel(element);
  }

  Widget diesStatFromModel(ClubRatingRowModel model) => wrap(
        Text(
          "${(customDivide(model.died, model.citizenGamesCount + model.sheriffGamesCount)).round()}% (${model.died}/${model.citizenGamesCount + model.sheriffGamesCount})",
        ),
      );

  Widget diesStat(int index) => diesStatFromModel(widget.sortedRows[index]);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children:
          widget.style == RatingTableStyle.full ? fullColumns : statsColumn,
    );
  }

  List<Widget> get statsColumn => [
        column(
          mainControllers[0],
          key: const Key("statsColumn0"),
          builder: indexWidgets,
          header: const Text("№"),
          prototype: indexProtoype,
        ),
        column(
          mainControllers[1],
          key: const Key("statsColumn0"),
          builder: nicknames,
          header: const Text("Игрок"),
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
            child: const Text("Винрейт"),
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
            child: const Text("Винрейт за мирного"),
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
            child: const Text("Винрейт за шерифа"),
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
            child: const Text("Винрейт за мафию"),
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
            child: const Text("Винрейт за дона"),
          ),
          prototype: donWinRatePrototype(),
        ),
        column(
          mainControllers[7],
          key: const Key("statsColumn7"),
          builder: diesStat,
          header: InkWell(
            child: const Text("Процент убийств"),
            onTap: () {
              widget.changeSort(RatingSort.dies);
            },
          ),
          isLastColumn: true,
          prototype: diesStatPrototype(),
        ),
      ];

  List<Widget> get fullColumns => [
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
          builder: (index) => nicknames(index, boldRight: true),
          header: const Text("Игрок"),
          boldRight: true,
          prototype: nicknamePrototype,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width =
                  constraints.maxWidth / (constraints.maxWidth / 60).floor();
              final gamesCount =
                  widget.sortedRows.firstOrNull?.games.length ?? 0;
              final expand = width * gamesCount > constraints.maxWidth;
              final header = gameHeader(width, expand);
              final listView = ListView.builder(
                key: const Key("fullColumns2"),
                physics: const ClampingScrollPhysics(),
                controller: mainControllers[2],
                itemCount: widget.sortedRows.length,
                itemBuilder: (context, index) => games(width, index, expand),
              );
              return Column(
                children: [
                  if (header != null) header,
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
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
          ),
        ),
        column(
          mainControllers[3],
          key: const Key("fullColumns3"),
          builder: scores,
          header: const Text("Очки"),
          boldLeft: true,
          prototype: scorePrototype,
        ),
        column(
          mainControllers[4],
          key: const Key("fullColumns4"),
          builder: addScores,
          header: const Text("+"),
          prototype: addScorePrototype,
        ),
        column(
          mainControllers[5],
          key: const Key("fullColumns5"),
          header: const Text("Ci"),
          prototype: ciPrototype,
          builder: ciWidget,
        ),
        column(
          mainControllers[6],
          key: const Key("fullColumns6"),
          header: const Text("п"),
          prototype: winPrototype,
          builder: wins,
        ),
        column(
          key: const Key("fullColumns7"),
          mainControllers[7],
          header: const Text("дк"),
          prototype: roleWinPrototype,
          builder: roleWins,
        ),
        column(
          mainControllers[8],
          key: const Key("fullColumns8"),
          builder: dies,
          isLastColumn: true,
          header: const Text("по"),
          prototype: diesPrototype,
        ),
      ];

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
              ...[header, ...widgets!].map(
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
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: isLastColumn),
                      child: ListView.builder(
                        key: key,
                        physics: const ClampingScrollPhysics(),
                        controller: controller,
                        itemCount: widget.sortedRows.length,
                        itemBuilder: (context, index) =>
                            builder != null ? builder(index) : widgets![index],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

num customDivide(num a, num b) => b == 0 ? 0 : (a * 100) / b.toDouble();
