import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';

class RolePicker extends StatefulWidget {
  final PlayerRole playerRole;
  final Function(PlayerRole role) onChange;
  final bool readOnly;

  const RolePicker({
    Key? key,
    required this.playerRole,
    required this.onChange,
    required this.readOnly,
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
        Tooltip(
          message: "Mафия",
          child: InkWell(
            borderRadius: BorderRadius.circular(500),
            onTap: widget.readOnly ? null : () => onChange(PlayerRole.maf),
            child: AnimatedOpacity(
              opacity: widget.playerRole == PlayerRole.maf ? 1.0 : 0.3,
              duration: duration,
              child: Image.asset(
                AppAssets.mafiaAsset(),
                height: 40,
              ),
            ),
          ),
        ),
        Tooltip(
          message: "Дон",
          child: InkWell(
            borderRadius: BorderRadius.circular(500),
            onTap: widget.readOnly ? null : () => onChange(PlayerRole.don),
            child: AnimatedOpacity(
              opacity: widget.playerRole == PlayerRole.don ? 1.0 : 0.3,
              duration: duration,
              child: Image.asset(
                AppAssets.donAsset(),
                height: 40,
              ),
            ),
          ),
        ),
        Tooltip(
          message: "Шериф",
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(500),
                onTap:
                    widget.readOnly ? null : () => onChange(PlayerRole.sheriff),
                child: AnimatedOpacity(
                  opacity: widget.playerRole == PlayerRole.sheriff ? 1.0 : 0.3,
                  duration: duration,
                  child: Image.asset(
                    AppAssets.sheriffAsset(),
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
        Tooltip(
          message: "Мирный житель",
          child: InkWell(
            borderRadius: BorderRadius.circular(500),
            onTap: widget.readOnly ? null : () => onChange(PlayerRole.citizen),
            child: AnimatedOpacity(
              opacity: widget.playerRole == PlayerRole.citizen ? 1.0 : 0.3,
              duration: duration,
              child: Image.asset(
                AppAssets.citizenAsset(),
                height: 40,
              ),
            ),
          ),
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
