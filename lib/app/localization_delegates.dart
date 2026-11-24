import 'package:material_ui/material_ui.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

/// Делегаты локализации приложения и тестов.
///
/// `AppLocalizations.localizationsDelegates` не подходит: gen-l10n кладёт туда делегаты устаревшего
/// `flutter_localizations`, а виджеты `material_ui` ищут свои `MaterialLocalizations`.
const appLocalizationsDelegates = <LocalizationsDelegate<dynamic>>[
  AppLocalizations.delegate,
  ...GlobalMaterialLocalizations.delegates,
];
