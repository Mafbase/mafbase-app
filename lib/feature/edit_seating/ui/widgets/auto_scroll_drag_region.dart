import 'dart:async';

import 'package:flutter/material.dart';

/// Wraps a scrollable area and auto-scrolls when a pointer (drag) is near
/// the top or bottom edges.
class AutoScrollDragRegion extends StatefulWidget {
  final ScrollController scrollController;
  final Widget child;
  final double edgeThreshold;
  final double scrollSpeed;

  const AutoScrollDragRegion({
    super.key,
    required this.scrollController,
    required this.child,
    this.edgeThreshold = 60,
    this.scrollSpeed = 8,
  });

  @override
  State<AutoScrollDragRegion> createState() => _AutoScrollDragRegionState();
}

class _AutoScrollDragRegionState extends State<AutoScrollDragRegion> {
  Timer? _scrollTimer;
  double _scrollDirection = 0; // -1 = up, 1 = down, 0 = none

  @override
  void dispose() {
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _onPointerMove(PointerMoveEvent event) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final localY = box.globalToLocal(event.position).dy;
    final height = box.size.height;

    if (localY < widget.edgeThreshold) {
      final intensity = 1.0 - (localY / widget.edgeThreshold);
      _startScrolling(-intensity);
    } else if (localY > height - widget.edgeThreshold) {
      final intensity = 1.0 - ((height - localY) / widget.edgeThreshold);
      _startScrolling(intensity);
    } else {
      _stopScrolling();
    }
  }

  void _onPointerUp(PointerUpEvent event) => _stopScrolling();

  void _onPointerCancel(PointerCancelEvent event) => _stopScrolling();

  void _startScrolling(double direction) {
    if (_scrollDirection == direction && _scrollTimer != null) return;
    _scrollDirection = direction;
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      final controller = widget.scrollController;
      if (!controller.hasClients) return;

      final offset = controller.offset + widget.scrollSpeed * _scrollDirection;
      controller.jumpTo(
        offset.clamp(0, controller.position.maxScrollExtent),
      );
    });
  }

  void _stopScrolling() {
    _scrollDirection = 0;
    _scrollTimer?.cancel();
    _scrollTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: widget.child,
    );
  }
}
