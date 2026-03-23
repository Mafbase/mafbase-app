import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

class StatusPicker extends StatefulWidget {
  final PlayerStatus playerStatus;
  final Function(PlayerStatus role) onChange;
  final bool readOnly;

  const StatusPicker({
    super.key,
    required this.playerStatus,
    required this.onChange,
    required this.readOnly,
  });

  @override
  State<StatusPicker> createState() => _StatusPickerState();
}

class _StatusPickerState extends State<StatusPicker> {
  final Duration duration = const Duration(milliseconds: 100);

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
              onTap: widget.readOnly
                  ? null
                  : () => onChange(
                        widget.playerStatus == PlayerStatus.deleted ? PlayerStatus.alive : PlayerStatus.deleted,
                      ),
              child: AnimatedOpacity(
                opacity: widget.playerStatus == PlayerStatus.deleted ? 1.0 : 0.3,
                duration: duration,
                child: SvgPicture.asset(
                  AppAssets.deletedStatus,
                  height: 40,
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: widget.readOnly
                  ? null
                  : () => onChange(
                        widget.playerStatus == PlayerStatus.killed ? PlayerStatus.alive : PlayerStatus.killed,
                      ),
              child: AnimatedOpacity(
                opacity: widget.playerStatus == PlayerStatus.killed ? 1.0 : 0.3,
                duration: duration,
                child: SvgPicture.asset(
                  AppAssets.killedStatus,
                  height: 40,
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: widget.readOnly
                  ? null
                  : () => onChange(
                        widget.playerStatus == PlayerStatus.voted ? PlayerStatus.alive : PlayerStatus.voted,
                      ),
              child: AnimatedOpacity(
                opacity: widget.playerStatus == PlayerStatus.voted ? 1.0 : 0.3,
                duration: duration,
                child: SvgPicture.asset(
                  AppAssets.votedStatus,
                  height: 40,
                ),
              ),
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

  onChange(PlayerStatus status) {
    widget.onChange(status);
  }
}
