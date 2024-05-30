import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

abstract class CustomState<W extends StatefulWidget> extends State<W> {

  @override
  Widget build(BuildContext context) {
    Widget child;
    bool expanded = true;
    final mobile = buildMobile(context);
    final desktop = buildDesktop(context);
    if (context.isMobile) {
      child = mobile ?? desktop;
      if (mobile != null) {
        expanded = false;
      }
    } else {
      child = desktop;
      expanded = false;
    }

    Widget resultChild = child;
    if (expanded) {
      resultChild = LayoutBuilder(
        builder: (context, constraints) {
          final height = max(constraints.maxHeight, 720.0);
          final width = max(constraints.maxWidth, 1280.0);
          final mainChild = Container(
            constraints: BoxConstraints(
              maxWidth: width,
              maxHeight: height,
            ),
            child: child,
          );
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: mainChild,
            ),
          );
        },
      );
    }

    return resultChild;
  }

  Widget buildDesktop(BuildContext context);

  Widget? buildMobile(BuildContext context) => null;
}

extension BuildContextIsMobileExt on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 500;
}
