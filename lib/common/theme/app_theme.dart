import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class AppTheme {
  static ThemeData light({required bool isMobile}) {
    final myTheme = MyTheme.light(isMobile: isMobile);
    return ThemeData.light(useMaterial3: true).copyWith(
      extensions: [myTheme],
      scaffoldBackgroundColor: myTheme.background1,
      chipTheme: ChipThemeData(
        backgroundColor: myTheme.background2,
        selectedColor: myTheme.darkBlueColor,
        checkmarkColor: myTheme.background1,
        secondaryLabelStyle: TextStyle(color: myTheme.background1),
        labelStyle: TextStyle(color: myTheme.textColor),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: myTheme.darkBlueColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 24,
          fontFamily: 'Roboto',
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(foregroundColor: Colors.white),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFCAC4D0),
        thickness: 1,
        space: 0,
        indent: 0,
        endIndent: 0,
      ),
      cardTheme: CardThemeData(color: myTheme.background2),
      colorScheme: ThemeData.light(useMaterial3: true).colorScheme.copyWith(
            primary: myTheme.darkGreyColor,
            primaryContainer: myTheme.darkBlueColor,
            secondary: myTheme.redColor,
            secondaryContainer: myTheme.redColor,
          ),
      timePickerTheme: TimePickerThemeData(
        hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return myTheme.background1;
          }
          return myTheme.textColor;
        }),
      ),
      datePickerTheme: DatePickerThemeData(
        rangeSelectionBackgroundColor: myTheme.darkBlueColor.withValues(alpha: .15),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: myTheme.darkGreyColor,
        elevation: 5,
        backgroundColor: myTheme.darkBlueColor,
        selectedLabelStyle: const TextStyle().copyWith(color: Colors.white),
        unselectedLabelStyle: const TextStyle().copyWith(color: Colors.white),
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: const IconThemeData(color: Colors.white60),
      ),
      iconTheme: IconThemeData(color: myTheme.darkGreyColor),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return myTheme.btnTextStyle.copyWith(
                  color: myTheme.btnTextColor.withValues(alpha: 0.5),
                );
              }
              return myTheme.btnTextStyle;
            },
          ),
        ),
      ),
    );
  }

  static ThemeData dark({required bool isMobile}) {
    final myTheme = MyTheme.dark(isMobile: isMobile);
    return ThemeData.dark(useMaterial3: true).copyWith(
      extensions: [myTheme],
      scaffoldBackgroundColor: myTheme.background1,
      appBarTheme: AppBarTheme(
        backgroundColor: myTheme.darkBlueColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 24,
          fontFamily: 'Roboto',
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(foregroundColor: Colors.white),
      dividerTheme: DividerThemeData(color: myTheme.borderColor, thickness: 1, space: 0),
      cardTheme: CardThemeData(color: myTheme.background2),
      colorScheme: ThemeData.dark(useMaterial3: true).colorScheme.copyWith(
            primary: myTheme.darkGreyColor,
            primaryContainer: myTheme.darkBlueColor,
            secondary: myTheme.redColor,
            secondaryContainer: myTheme.redColor,
          ),
      timePickerTheme: TimePickerThemeData(
        hourMinuteTextColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.selected) ? myTheme.background1 : myTheme.textColor,
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        rangeSelectionBackgroundColor: myTheme.darkBlueColor.withValues(alpha: .65),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: myTheme.darkGreyColor,
        elevation: 5,
        backgroundColor: myTheme.darkBlueColor,
        selectedLabelStyle: const TextStyle().copyWith(color: Colors.white),
        unselectedLabelStyle: const TextStyle().copyWith(color: Colors.white),
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: const IconThemeData(color: Colors.white60),
      ),
      iconTheme: IconThemeData(color: myTheme.darkGreyColor),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return myTheme.btnTextStyle.copyWith(
                  color: myTheme.btnTextColor.withValues(alpha: 0.5),
                );
              }
              return myTheme.btnTextStyle;
            },
          ),
        ),
      ),
    );
  }
}
