import 'dart:math' as math;
import 'package:flutter/material.dart';

class FlipWidget extends StatefulWidget {
  final Widget child;

  const FlipWidget({super.key, required this.child});

  @override
  State<FlipWidget> createState() => _FlipWidgetState();
}

class _FlipWidgetState extends State<FlipWidget> with TickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  Widget? previousWidget;

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          previousWidget = null;
          animationController.reset();
        });
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animationController.value * math.pi),
          child: frontImage,
        );
      },
    );
  }

  Widget get frontImage {
    if (animationController.value < 0.5) {
      return previousWidget ?? widget.child;
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: widget.child,
      );
    }
  }

  @override
  void didUpdateWidget(FlipWidget oldWidget) {
    if (oldWidget.child.key != widget.child.key) {
      previousWidget = oldWidget.child;
      animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }
}
