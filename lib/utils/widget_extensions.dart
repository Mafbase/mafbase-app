import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

abstract class CustomState<W extends StatefulWidget> extends State<W> {
  bool get expanded => false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Widget child;
    final mobile = buildMobile(context);
    final desktop = buildDesktop(context);
    if (screenWidth < 500) {
      child = mobile ?? desktop;
    } else {
      child = desktop;
    }

    Widget resultChild = child;
    if (expanded) {
      resultChild = LayoutBuilder(
        builder: (context, constraints) {
          final height = max(constraints.maxHeight, 720.0);
          final width = max(constraints.maxWidth, 1280.0);
          debugPrint("test25: $constraints");
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
