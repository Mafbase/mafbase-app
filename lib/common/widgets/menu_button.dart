import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class MenuButton extends StatefulWidget {
  final Widget icon;
  final Function onTap;
  final String? label;

  const MenuButton({
    super.key,
    this.label,
    required this.icon,
    required this.onTap,
  });

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
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (widget.label != null && hovered)
                Positioned(
                  left: constraints.maxWidth,
                  top: 0,
                  bottom: 0,
                  child: _BubbleHint(text: widget.label!),
                ),
              Positioned.fill(
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
                            : (hovered ? MyTheme.of(context).background2 : MyTheme.of(context).greyColor),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: widget.icon,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BubbleHint extends StatelessWidget {
  final String text;

  const _BubbleHint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(15, 0),
          child: SvgPicture.asset(AppAssets.bubbleArrowAsset),
        ),
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: MyTheme.of(context).greyColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: MyTheme.of(context).defaultTextStyle,
          ),
        ),
      ],
    );
  }
}
