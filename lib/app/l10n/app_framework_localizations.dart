import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_custom.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/app/l10n/app_date_localizations_data.dart';

/// Делегаты локализаций Flutter только для ru и en, без данных остальных языков SDK.
abstract final class AppFrameworkLocalizations {
  static const LocalizationsDelegate<MaterialLocalizations> materialDelegate = _MaterialLocalizationsDelegate();
  static const LocalizationsDelegate<CupertinoLocalizations> cupertinoDelegate = _CupertinoLocalizationsDelegate();
  static const LocalizationsDelegate<WidgetsLocalizations> widgetsDelegate = _WidgetsLocalizationsDelegate();
}

const _supportedLanguageCodes = {'ru', 'en'};

bool _isSupported(Locale locale) => _supportedLanguageCodes.contains(locale.languageCode);

bool _dateFormattingInitialized = false;

/// Первый вызов `initializeDateFormattingCustom` убирает встроенный в intl en_US, а это локаль DateFormat без
/// явной локали, поэтому en_US лежит в [appDateSymbols] вместе с ru и en.
void _initializeDateFormatting() {
  if (_dateFormattingInitialized) return;
  appDateSymbols.forEach((locale, symbols) {
    initializeDateFormattingCustom(locale: locale, symbols: symbols, patterns: appDatePatterns[locale]);
  });
  _dateFormattingInitialized = true;
}

String _intlLocale(Locale locale, bool Function(String) localeExists) {
  final localeName = Intl.canonicalizedLocale(locale.toString());
  return localeExists(localeName) ? localeName : locale.languageCode;
}

class _MaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _MaterialLocalizationsDelegate();

  static final Map<Locale, Future<MaterialLocalizations>> _loaded = {};

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    assert(isSupported(locale));
    return _loaded.putIfAbsent(locale, () {
      _initializeDateFormatting();
      final dateLocale = _intlLocale(locale, DateFormat.localeExists);
      final numberLocale = _intlLocale(locale, NumberFormat.localeExists);
      final create = switch (locale.languageCode) {
        'ru' => MaterialLocalizationRu.new,
        _ => MaterialLocalizationEn.new,
      };
      return SynchronousFuture<MaterialLocalizations>(
        create(
          fullYearFormat: DateFormat.y(dateLocale),
          compactDateFormat: DateFormat.yMd(dateLocale),
          shortDateFormat: DateFormat.yMMMd(dateLocale),
          mediumDateFormat: DateFormat.MMMEd(dateLocale),
          longDateFormat: DateFormat.yMMMMEEEEd(dateLocale),
          yearMonthFormat: DateFormat.yMMMM(dateLocale),
          shortMonthDayFormat: DateFormat.MMMd(dateLocale),
          decimalFormat: NumberFormat.decimalPattern(numberLocale),
          twoDigitZeroPaddedFormat: NumberFormat('00', numberLocale),
        ),
      );
    });
  }

  @override
  bool shouldReload(_MaterialLocalizationsDelegate old) => false;
}

class _CupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const _CupertinoLocalizationsDelegate();

  static final Map<Locale, Future<CupertinoLocalizations>> _loaded = {};

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    assert(isSupported(locale));
    return _loaded.putIfAbsent(locale, () {
      _initializeDateFormatting();
      final dateLocale = _intlLocale(locale, DateFormat.localeExists);
      final create = switch (locale.languageCode) {
        'ru' => CupertinoLocalizationRu.new,
        _ => CupertinoLocalizationEn.new,
      };
      return SynchronousFuture<CupertinoLocalizations>(
        create(
          fullYearFormat: DateFormat.y(dateLocale),
          dayFormat: DateFormat.d(dateLocale),
          weekdayFormat: DateFormat.E(dateLocale),
          mediumDateFormat: DateFormat.MMMEd(dateLocale),
          singleDigitHourFormat: DateFormat('HH', dateLocale),
          singleDigitMinuteFormat: DateFormat.m(dateLocale),
          doubleDigitMinuteFormat: DateFormat('mm', dateLocale),
          singleDigitSecondFormat: DateFormat.s(dateLocale),
          decimalFormat: NumberFormat.decimalPattern(dateLocale),
        ),
      );
    });
  }

  @override
  bool shouldReload(_CupertinoLocalizationsDelegate old) => false;
}

class _WidgetsLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const _WidgetsLocalizationsDelegate();

  static final Map<Locale, Future<WidgetsLocalizations>> _loaded = {};

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    assert(isSupported(locale));
    return _loaded.putIfAbsent(locale, () {
      return SynchronousFuture<WidgetsLocalizations>(
        switch (locale.languageCode) {
          'ru' => const WidgetsLocalizationRu(),
          _ => const WidgetsLocalizationEn(),
        },
      );
    });
  }

  @override
  bool shouldReload(_WidgetsLocalizationsDelegate old) => false;
}
