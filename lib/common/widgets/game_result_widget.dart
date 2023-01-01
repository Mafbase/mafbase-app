import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/domain/models/game_result_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

const BorderSide _side = BorderSide(
  color: Colors.black26,
  width: 1,
);

class GameResultWidget extends StatefulWidget {
  final GameResultModel model;

  const GameResultWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<GameResultWidget> createState() => _GameResultWidgetState();
}

class _GameResultWidgetState extends State<GameResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: const BoxDecoration(
        border: Border(left: _side, right: _side, top: _side, bottom: _side),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100,
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: _side,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "№",
                      style: MyTheme.of(context).defaultTextStyle.copyWith(
                            color: const Color(0xFF979A9D),
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${context.locale.table(widget.model.table)}\n${widget.model.referee}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: MyTheme.of(context).defaultTextStyle.copyWith(
                              color: const Color(0xFF979A9D),
                            ),
                      ),
                      _GameResultWidget(win: widget.model.gameWin),
                    ],
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < 10; i++)
            _PlayerRowWidget(
              nickname: widget.model.nicknames[i],
              place: i + 1,
              status: widget.model.statuses?[i],
              role: widget.model.roles?[i],
              score: widget.model.scores[i],
            )
        ],
      ),
    );
  }
}

class _PlayerRowWidget extends StatelessWidget {
  final PlayerRole? role;
  final PlayerResultStatus? status;
  final String nickname;
  final int place;
  final double score;

  const _PlayerRowWidget({
    Key? key,
    this.role,
    this.status,
    required this.score,
    required this.nickname,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
          border: Border(top: _side),
        ),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 60,
              decoration: const BoxDecoration(
                border: Border(right: _side),
              ),
              padding: const EdgeInsets.all(4),
              child: Text(
                "$place",
                style: context.theme.defaultTextStyle,
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(right: _side),
                ),
                padding: const EdgeInsets.all(4),
                child: Text(
                  nickname,
                  style: context.theme.defaultTextStyle,
                ),
              ),
            ),
            _RoleWidget(
              role: role,
              status: status,
            ),
            Container(
              width: 60,
              height: double.infinity,
              decoration: const BoxDecoration(
                border: Border(right: _side),
              ),
              padding: const EdgeInsets.all(4),
              child: Text(
                "$score",
                style: context.theme.defaultTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleWidget extends StatelessWidget {
  final PlayerRole? role;
  final PlayerResultStatus? status;

  const _RoleWidget({
    Key? key,
    this.role,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: role != null,
      child: Container(
        height: double.infinity,
        width: 130,
        decoration: BoxDecoration(
          border: const Border(right: _side),
          color: background(context),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle(context),
          ),
        ),
      ),
    );
  }

  Color? background(BuildContext context) {
    final theme = MyTheme.of(context);
    switch (status) {
      case PlayerResultStatus.negative:
        return theme.negativeColor;
      case PlayerResultStatus.positive:
        return theme.positiveColor;
      case PlayerResultStatus.died:
        return theme.diedColor;
      case PlayerResultStatus.diedPositive:
        return theme.diedPositiveColor;
      case null:
        return null;
    }
  }

  TextStyle textStyle(BuildContext context) {
    return status == null
        ? MyTheme.of(context).defaultTextStyle
        : MyTheme.of(context).btnTextStyle;
  }

  String get text {
    switch (role) {
      case PlayerRole.citizen:
        return "Мир";
      case PlayerRole.don:
        return "Дон";
      case PlayerRole.maf:
        return "Маф";
      case PlayerRole.sheriff:
        return "Шер";
    }
    return "";
  }
}

class _GameResultWidget extends StatelessWidget {
  final GameWin? win;

  const _GameResultWidget({
    Key? key,
    required this.win,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: win == null ? 0 : 1,
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        color: color(context),
        child: Center(
          child: Text(
            text(context),
            style: MyTheme.of(context).btnTextStyle.copyWith(),
          ),
        ),
      ),
    );
  }

  Color color(BuildContext context) {
    switch (win) {
      case GameWin.city:
        return context.theme.redColor;
      case GameWin.draw:
        return context.theme.diedPositiveColor;
      case GameWin.mafia:
        return context.theme.diedColor;
    }
    return const Color(0x00000000);
  }

  String text(BuildContext context) {
    switch (win) {
      case GameWin.city:
        return context.locale.cityWon;
      case GameWin.draw:
        return context.locale.draw;
      case GameWin.mafia:
        return context.locale.mafiaWon;
      default:
        return context.locale.draw;
    }
  }
}
