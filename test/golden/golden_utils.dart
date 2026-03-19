import 'dart:io';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:seating_generator_web/common/theme/app_theme.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

// 4 device-варианта: light/dark × mobile/desktop
const lightDesktop = Device(name: 'light_desktop', size: Size(1280, 900));
const lightMobile = Device(name: 'light_mobile', size: Size(390, 844));
const darkDesktop = Device(
  name: 'dark_desktop',
  size: Size(1280, 900),
  brightness: Brightness.dark,
);
const darkMobile = Device(
  name: 'dark_mobile',
  size: Size(390, 844),
  brightness: Brightness.dark,
);

const appDevices = [lightDesktop, lightMobile, darkDesktop, darkMobile];

// Wrapper: MaterialApp с локализацией.
// Тема применяется через themedWidget() внутри каждого сценария —
// это нужно, т.к. DeviceBuilder ставит MediaQuery(brightness:) ВНУТРИ MaterialApp,
// а ThemeMode.system читает яркость ВЫШЕ MaterialApp.
WidgetWrapper appWrapper() => (child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(isMobile: false),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Material(child: child),
    );

/// Оборачивает [child] в Theme, который выбирает тему по platformBrightness.
/// Должен оборачивать виджет сценария, а не быть снаружи appWrapper().
Widget themedWidget(Widget child) => Builder(
      builder: (context) {
        final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
        return Theme(
          data: isDark ? AppTheme.dark(isMobile: false) : AppTheme.light(isMobile: false),
          child: child,
        );
      },
    );

// CI-friendly имя для screenMatchesGolden
String goldenName(String name) {
  final isCi = Platform.environment['CI'] == 'true';
  return 'goldens/$name${isCi ? '_ci' : ''}';
}
