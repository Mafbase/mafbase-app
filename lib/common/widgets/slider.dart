import 'package:flutter/material.dart';

/// To start animation children should have different keys */
class SliderWidget extends StatefulWidget {
  final Widget child;
  final bool forward;
  final Duration duration;
  final Curve curve;

  const SliderWidget({
    Key? key,
    required this.child,
    this.forward = true,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.ease,
  }) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: widget.duration,
    value: 1,
  );
  Widget? oldChild;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final previousWidget = oldChild;
            return Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                if (previousWidget != null)
                  Positioned(
                    top: 0,
                    left: constraints.maxWidth *
                        widget.curve.transform(controller.value) *
                        (widget.forward ? 1 : -1),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: previousWidget,
                  ),
                Positioned(
                  top: 0,
                  left: constraints.maxWidth * (widget.forward ? -1 : 1) -
                      constraints.maxWidth *
                          widget.curve.transform(controller.value) *
                          (widget.forward ? -1 : 1),
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: widget.child,
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant SliderWidget oldWidget) {
    oldChild = oldWidget.child;
    if (oldWidget.child.key != widget.child.key) {
      controller.reset();
      controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }
}
