import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class MenuButton extends StatefulWidget {
  final Widget icon;
  final Function onTap;

  const MenuButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool tapped = false;
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxWidth,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) {
              setState(() {
                hovered = true;
              });
            },
            onExit: (_) {
              setState(() {
                hovered = false;
              });
            },
            child: GestureDetector(
              onTapDown: (_) {
                setState(() {
                  tapped = true;
                });
              },
              onTapUp: (_) {
                setState(() {
                  tapped = false;
                });
                widget.onTap();
              },
              onTapCancel: () {
                setState(() {
                  tapped = false;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: tapped
                      ? MyTheme.of(context).darkGreyColor
                      : (hovered
                          ? MyTheme.of(context).background2
                          : MyTheme.of(context).greyColor),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: widget.icon,
              ),
            ),
          ),
        );
      }
    );
  }
}
