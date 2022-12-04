import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MyTheme {
  abstract final Color background1;
  abstract final Color background2;
  abstract final Color btnColor1;
  abstract final Color btnColor2;
  abstract final Color btnTextColor;
  abstract final Color textColor;
  abstract final Color borderColor;
  abstract final TextStyle defaultTextStyle;
  abstract final TextStyle fieldTextStyle;
  abstract final TextStyle btnTextStyle;
  abstract final TextStyle textBtnTextStyle;
  abstract final TextStyle headerTextStyle;
  abstract final Color darkBlueColor;
  abstract final Color redColor;
  abstract final Color greyColor;
  abstract final Color darkGreyColor;
  abstract final Color redForCard;
  abstract final Color greenForCard;
  abstract final Color blueForCard;

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
  Color get background1 => const Color(0xFFF5F5F5);

  @override
  Color get background2 => Colors.white;

  @override
  Color get btnColor1 => darkGreyColor.withOpacity(0.64);

  @override
  Color get btnColor2 => const Color(0xFF4E6B9B);

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
        color: btnTextColor,
      );

  @override
  TextStyle get defaultTextStyle => _defaultTextStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle get fieldTextStyle => defaultTextStyle;

  @override
  TextStyle get headerTextStyle => _defaultTextStyle.copyWith(
        fontSize: 40,
        fontWeight: FontWeight.w600,
      );

  @override
  TextStyle get textBtnTextStyle => _defaultTextStyle.copyWith(
        color: blueForCard,
      );

  @override
  Color get darkBlueColor => const Color(0xFF1A2D42);

  @override
  Color get redColor => const Color(0xFFDF5650);

  @override
  Color get greyColor => const Color(0xFFCBCED3);

  @override
  Color get darkGreyColor => const Color(0xFF475264);

  @override
  Color get blueForCard => const Color(0xCC182D42);

  @override
  Color get greenForCard => const Color(0xCC285927);

  @override
  Color get redForCard => const Color(0xCC81332C);
}
