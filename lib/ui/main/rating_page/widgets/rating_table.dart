import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:seating_generator_web/domain/models/club_rating_row.dart';

class RatingTable extends StatefulWidget {
  final List<ClubRatingRowModel> rows;
  final int clubId;
  final Function(int gameId) openGame;

  const RatingTable({
    Key? key,
    required this.rows,
    required this.clubId,
    required this.openGame,
  }) : super(key: key);

  @override
  State<RatingTable> createState() => _RatingTableState();
}

class _RatingTableState extends State<RatingTable> {
  late LinkedScrollControllerGroup linkedScrollControllerGroup;
  final mainLinkedScrollControllerGroup = LinkedScrollControllerGroup();
  late List<ScrollController> controllers;
  late final List<ScrollController> mainControllers = List.generate(
    8,
    (index) => mainLinkedScrollControllerGroup.addAndGet(),
  );

  @override
  void initState() {
    linkedScrollControllerGroup = LinkedScrollControllerGroup();
    controllers = List.generate(
      (widget.rows.firstOrNull?.games.length ?? 0) + 1,
      (index) => linkedScrollControllerGroup.addAndGet(),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RatingTable oldWidget) {
    if (oldWidget.rows.length != widget.rows.length) {
      for (final controller in controllers) {
        controller.dispose();
      }
      linkedScrollControllerGroup = LinkedScrollControllerGroup();
      controllers = List.generate(
        widget.rows.length + 1,
        (index) => linkedScrollControllerGroup.addAndGet(),
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

  Widget get indexProtoype => wrap(Text(widget.rows.length.toString()));
  Widget indexWidgets(int index) => wrap(
        Text(
          (index + 1).toString(),
        ),
      );

  Widget get nicknamePrototype => wrap(
        Text(
          widget.rows
                  .map((e) => e.nickname)
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );
  Widget nicknames(int index) => wrap(
        Text(widget.rows[index].nickname),
        boldRight: true,
      );

  Widget get scorePrototype => wrap(
        Text(
          widget.rows
                  .map((e) => e.score.toString())
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );
  Widget scores(int index) => wrap(
        Text(
          widget.rows[index].score.toString(),
        ),
        boldLeft: true,
      );

  Widget get addScorePrototype => wrap(
        Text(
          widget.rows
                  .map((e) => e.addScore.toString())
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );
  Widget addScores(int index) => wrap(
        Text(
          widget.rows[index].addScore.toString(),
        ),
      );

  Widget get winPrototype => wrap(
        Text(
          widget.rows
                  .map((e) => e.wins.toString())
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );
  Widget wins(int index) => wrap(
        Text(
          widget.rows[index].wins.toString(),
        ),
      );

  Widget get roleWinPrototype => wrap(
        Text(
          widget.rows
                  .map((e) => e.roleWins.toString())
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );
  Widget roleWins(int index) => wrap(
        Text(
          widget.rows[index].roleWins.toString(),
        ),
      );

  Widget get diesProtorype => wrap(
        Text(
          widget.rows
                  .map((e) => e.died.toString())
                  .sortedBy<num>((element) => element.length)
                  .lastOrNull ??
              "",
        ),
      );
  Widget dies(int index) => wrap(
        Text(
          widget.rows[index].died.toString(),
        ),
      );

  Widget? gameHeader(double width, [bool expand = true]) => widget.rows.isEmpty
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
                    widget.rows.firstOrNull?.games.length ?? 0,
                    (index) => builder(context, index),
                  ),
                );
              }
              return ListView.builder(
                key: Key("GameHeader${widget.rows.length}/${widget.clubId}"),
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: controllers.first,
                itemCount: (widget.rows.firstOrNull?.games.length ?? 0),
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
              onTap: widget.rows[rowIndex].games[index].score == null
                  ? null
                  : () => widget
                      .openGame(widget.rows[rowIndex].games[index].gameId),
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
                    widget.rows[rowIndex].games[index].score?.toString() ?? "",
                  ),
                ),
              ),
            );
          }

          if (!expand) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.rows.firstOrNull?.games.length ?? 0,
                (index) => builder(context, index),
              ),
            );
          }
          return ListView.builder(
            key: Key("GameRow$rowIndex/${widget.rows.length}/${widget.clubId}"),
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: controllers[rowIndex + 1],
            itemCount: (widget.rows.firstOrNull?.games.length ?? 0),
            itemBuilder: builder,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        column(mainControllers[0],
            builder: indexWidgets,
            header: const Text("№"),
            prototype: indexProtoype),
        column(
          mainControllers[1],
          builder: nicknames,
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
              final gamesCount = widget.rows.firstOrNull?.games.length ?? 0;
              final expand = width * gamesCount > constraints.maxWidth;
              final header = gameHeader(width, expand);
              final listView = ListView.builder(
                physics: const ClampingScrollPhysics(),
                controller: mainControllers[2],
                itemCount: widget.rows.length,
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
          builder: scores,
          header: const Text("Очки"),
          boldLeft: true,
          prototype: scorePrototype,
        ),
        column(
          mainControllers[4],
          builder: addScores,
          header: const Text("+"),
          prototype: addScorePrototype,
        ),
        column(
          mainControllers[5],
          header: const Text("п"),
          prototype: winPrototype,
          builder: wins,
        ),
        column(
          mainControllers[6],
          header: const Text("дк"),
          prototype: roleWinPrototype,
          builder: roleWins,
        ),
        column(
          mainControllers[7],
          builder: dies,
          isLastColumn: true,
          header: const Text("по"),
          prototype: diesProtorype,
        ),
      ],
    );
  }

  Widget column(
    ScrollController controller, {
    List<Widget>? widgets,
    Widget Function(int index)? builder,
    Widget? prototype,
    bool isLastColumn = false,
    Widget? header,
    bool boldLeft = false,
    bool boldRight = false,
  }) {
    assert((widgets == null) != (builder == null));
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          if (prototype != null)
            IgnorePointer(
              child: Opacity(
                opacity: 0,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: prototype,
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
                      physics: const ClampingScrollPhysics(),
                      controller: controller,
                      itemCount: widget.rows.length,
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
    });
  }
}
