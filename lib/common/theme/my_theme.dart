import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MyTheme {
  abstract final Color background;
  abstract final Color btnColor1;
  abstract final Color btnColor2;
  abstract final Color btnColor3;
  abstract final Color btnTextColor;
  abstract final Color textColor;
  abstract final Color borderColor;
  abstract final TextStyle defaultTextStyle;
  abstract final TextStyle fieldTextStyle;
  abstract final TextStyle btnTextStyle;
  abstract final TextStyle headerTextStyle;

  MyTheme();

  static MyTheme of(BuildContext context) => context.watch();

  factory MyTheme.light() => const _LightTheme._();
}

class _LightTheme implements MyTheme {
  final _defaultTextStyle = const TextStyle(
    fontFamily: "Open Sans",
    color: Colors.black,
  );

  const _LightTheme._();

  @override
  Color get background => const Color(0xFFF5F5F5);

  @override
  Color get btnColor1 => const Color(0xFF475264);

  @override
  Color get btnColor2 => btnColor1.withOpacity(0.64);

  @override
  Color get btnColor3 => const Color(0xFF4E6B9B);

  @override
  Color get btnTextColor => Colors.white;

  @override
  Color get textColor => Colors.black;

  @override
  Color get borderColor => const Color(0x3B1C2B40);

  @override
  TextStyle get btnTextStyle => _defaultTextStyle.copyWith(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        height: 34,
      );

  @override
  TextStyle get defaultTextStyle => _defaultTextStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 30,
      );

  @override
  TextStyle get fieldTextStyle => defaultTextStyle;

  @override
  TextStyle get headerTextStyle => _defaultTextStyle.copyWith(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        height: 54,
      );
}
