import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MyTheme {
  final Color background;

  MyTheme(this.background);

  static MyTheme of(BuildContext context) => context.watch();

  factory MyTheme.light() => const _LightTheme._();
}

class _LightTheme implements MyTheme {

  const _LightTheme._();

  @override
  Color get background => const Color(0xFFF5F5F5);
}