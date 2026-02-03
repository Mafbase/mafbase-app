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
  abstract final TextStyle hintTextStyle;
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
  abstract final Color buttonDisabledColor;
  abstract final Color btnRedColor;
  abstract final Color btnRedColor1;
  abstract final Color diedPositiveColor;
  abstract final Color positiveColor;
  abstract final Color negativeColor;
  abstract final Color diedColor;

  MyTheme();

  static MyTheme of(BuildContext context) => context.watch();
  static MyTheme read(BuildContext context) => context.watch();

  factory MyTheme.light(bool isMobile) => _LightTheme._(isMobile);
}


class _LightTheme implements MyTheme {
  final bool _isMobile;
  final _defaultTextStyle = const TextStyle(
    fontFamily: "Open Sans",
    color: Colors.black,
  );

  _LightTheme._(this._isMobile);

  @override
  Color get background1 => const Color(0xFFF5F5F5);

  @override
  Color get background2 => Colors.white;

  @override
  Color get btnColor1 => darkGreyColor.withValues(alpha: 0.64);

  @override
  Color get btnColor2 => const Color(0xFF4E6B9B);

  @override
  late final btnTextColor = Colors.white;

  @override
  late final textColor = Colors.black;

  @override
  late final Color borderColor = const Color(0x3B1C2B40);

  @override
  late final TextStyle btnTextStyle = _defaultTextStyle.copyWith(
    fontSize: _isMobile ? 18 : 24,
    fontWeight: FontWeight.w600,
    color: btnTextColor,
  );

  @override
  late final TextStyle hintTextStyle = _defaultTextStyle.copyWith(
    fontSize: _isMobile ? 10 : 12,
    color: greyColor,
  );

  @override
  TextStyle get defaultTextStyle => _defaultTextStyle.copyWith(
        fontSize: _isMobile ? 12 : 16,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle get fieldTextStyle => defaultTextStyle;

  @override
  TextStyle get headerTextStyle => _defaultTextStyle.copyWith(
        fontSize: _isMobile ? 20 : 28,
        fontWeight: FontWeight.w600,
      );

  @override
  TextStyle get textBtnTextStyle => _defaultTextStyle.copyWith(
        color: blueForCard,
        fontSize: _isMobile ? 18 : 24,
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

  @override
  Color get buttonDisabledColor => const Color(0xFFB4B9BF);

  @override
  Color get btnRedColor => const Color(0xFFDF5650);

  @override
  Color get btnRedColor1 => btnRedColor.withValues(alpha: 0.7);

  @override
  Color get diedColor => darkGreyColor;

  @override
  Color get diedPositiveColor => const Color(0xFF47644A);

  @override
  Color get negativeColor => redColor;

  @override
  Color get positiveColor => const Color(0xFFC8B75E);
}
