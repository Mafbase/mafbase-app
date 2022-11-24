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

  List<Widget> get indexWidgets => List.generate(
        widget.rows.length,
        (index) => wrap(
          Text(
            (index + 1).toString(),
          ),
        ),
      );

  List<Widget> get nicknames => List.generate(
        widget.rows.length,
        (index) => wrap(
          Text(widget.rows[index].nickname),
          boldRight: true,
        ),
      );

  List<Widget> get scores => List.generate(
        widget.rows.length,
        (index) => wrap(
          Text(
            widget.rows[index].score.toString(),
          ),
          boldLeft: true,
        ),
      );

  List<Widget> get addScores => List.generate(
        widget.rows.length,
        (index) => wrap(
          Text(
            widget.rows[index].addScore.toString(),
          ),
        ),
      );

  List<Widget> get wins => List.generate(
        widget.rows.length,
        (index) => wrap(
          Text(
            widget.rows[index].wins.toString(),
          ),
        ),
      );

  List<Widget> get roleWins => List.generate(
        widget.rows.length,
        (index) => wrap(
          Text(
            widget.rows[index].roleWins.toString(),
          ),
        ),
      );

  List<Widget> get dies => List.generate(
        widget.rows.length,
        (index) => wrap(
          Text(
            widget.rows[index].died.toString(),
          ),
        ),
      );

  Widget? gameHeader(double width, [bool expand = true]) => widget.rows.isEmpty
      ? null
      : SizedBox(
          height: 50,
          child: Builder(builder: (context) {
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
          }),
        );

  List<Widget> games(double width, [bool expand = true]) {
    return List.generate(
      widget.rows.length,
      (rowIndex) {
        return SizedBox(
          height: 50,
          child: Builder(builder: (context) {
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
                      widget.rows[rowIndex].games[index].score?.toString() ??
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
                  widget.rows.firstOrNull?.games.length ?? 0,
                  (index) => builder(context, index),
                ),
              );
            }
            return ListView.builder(
              key: Key(
                  "GameRow$rowIndex/${widget.rows.length}/${widget.clubId}"),
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: controllers[rowIndex + 1],
              itemCount: (widget.rows.firstOrNull?.games.length ?? 0),
              itemBuilder: builder,
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        column(indexWidgets, mainControllers[0], header: const Text("№")),
        column(
          nicknames,
          mainControllers[1],
          header: const Text("Игрок"),
          boldRight: true,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width =
                  constraints.maxWidth / (constraints.maxWidth / 60).floor();
              final gamesCount = widget.rows.firstOrNull?.games.length ?? 0;
              final expand = width * gamesCount > constraints.maxWidth;
              final children = games(width, expand);
              final header = gameHeader(width, expand);
              final listView = ListView.builder(
                physics: const ClampingScrollPhysics(),
                controller: mainControllers[2],
                itemCount: children.length,
                itemBuilder: (context, index) => children[index],
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
                                ...children.map(
                                  (child) => IgnorePointer(
                                    child: Opacity(
                                      opacity: 0,
                                      child: child,
                                    ),
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
          scores,
          mainControllers[3],
          header: const Text("Очки"),
          boldLeft: true,
        ),
        column(addScores, mainControllers[4], header: const Text("+")),
        column(wins, mainControllers[5], header: const Text("п")),
        column(roleWins, mainControllers[6], header: const Text("дк")),
        column(
          dies,
          mainControllers[7],
          isLastColumn: true,
          header: const Text("по"),
        ),
      ],
    );
  }

  Widget column(
    List<Widget> widgets,
    ScrollController controller, {
    bool isLastColumn = false,
    Widget? header,
    bool boldLeft = false,
    bool boldRight = false,
  }) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          ...[header, ...widgets].map(
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
                      itemCount: widgets.length,
                      itemBuilder: (context, index) => widgets[index],
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
