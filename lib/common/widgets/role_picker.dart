import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

class RolePicker extends StatefulWidget {
  final PlayerRole playerRole;
  final Function(PlayerRole role) onChange;
  final bool readOnly;
  final bool hideText;

  const RolePicker({
    Key? key,
    required this.playerRole,
    required this.onChange,
    required this.readOnly,
    this.hideText = false,
  }) : super(key: key);

  @override
  State<RolePicker> createState() => _RolePickerState();
}

class _RolePickerState extends State<RolePicker> {
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
              onTap: widget.readOnly ? null : () => onChange(PlayerRole.maf),
              child: AnimatedOpacity(
                opacity: widget.playerRole == PlayerRole.maf ? 1.0 : 0.3,
                duration: duration,
                child: SvgPicture.asset(
                  AppAssets.mafiaAsset(),
                  height: 40,
                ),
              ),
            ),
            if (!widget.hideText) Text(
              "М",
              style: MyTheme.of(context).defaultTextStyle,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: widget.readOnly ? null : () => onChange(PlayerRole.don),
              child: AnimatedOpacity(
                opacity: widget.playerRole == PlayerRole.don ? 1.0 : 0.3,
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
              onTap:
              widget.readOnly ? null : () => onChange(PlayerRole.sheriff),
              child: AnimatedOpacity(
                opacity: widget.playerRole == PlayerRole.sheriff ? 1.0 : 0.3,
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
              onTap:
              widget.readOnly ? null : () => onChange(PlayerRole.citizen),
              child: AnimatedOpacity(
                opacity: widget.playerRole == PlayerRole.citizen ? 1.0 : 0.3,
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
    widget.onChange(role);
  }
}
