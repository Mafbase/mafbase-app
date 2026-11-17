import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/app/l10n/app_framework_localizations.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

final _date = DateTime(2026, 3, 8, 14, 5, 9);

/// Снимок строк и форматов после загрузки делегатов для ru и en.
Future<Map<String, String>> _snapshot({required bool appDelegates}) async {
  final materialDelegate =
      appDelegates ? AppFrameworkLocalizations.materialDelegate : GlobalMaterialLocalizations.delegate;
  final cupertinoDelegate =
      appDelegates ? AppFrameworkLocalizations.cupertinoDelegate : GlobalCupertinoLocalizations.delegate;
  final widgetsDelegate =
      appDelegates ? AppFrameworkLocalizations.widgetsDelegate : GlobalWidgetsLocalizations.delegate;

  final result = <String, String>{};
  for (final code in ['ru', 'en']) {
    final locale = Locale(code);
    final material = await materialDelegate.load(locale);
    final cupertino = await cupertinoDelegate.load(locale);
    final widgets = await widgetsDelegate.load(locale);
    result.addAll({
      '$code material type': material.runtimeType.toString(),
      '$code okButtonLabel': material.okButtonLabel,
      '$code cancelButtonLabel': material.cancelButtonLabel,
      '$code formatMediumDate': material.formatMediumDate(_date),
      '$code formatFullDate': material.formatFullDate(_date),
      '$code formatShortDate': material.formatShortDate(_date),
      '$code formatCompactDate': material.formatCompactDate(_date),
      '$code formatMonthYear': material.formatMonthYear(_date),
      '$code formatShortMonthDay': material.formatShortMonthDay(_date),
      '$code formatYear': material.formatYear(_date),
      '$code formatDecimal': material.formatDecimal(1234567),
      '$code formatTimeOfDay': material.formatTimeOfDay(const TimeOfDay(hour: 14, minute: 5)),
      '$code firstDayOfWeekIndex': material.firstDayOfWeekIndex.toString(),
      '$code narrowWeekdays': material.narrowWeekdays.join(','),
      '$code cupertino type': cupertino.runtimeType.toString(),
      '$code datePickerMonth': cupertino.datePickerMonth(3),
      '$code datePickerStandaloneMonth': cupertino.datePickerStandaloneMonth(3),
      '$code datePickerMediumDate': cupertino.datePickerMediumDate(_date),
      '$code datePickerYear': cupertino.datePickerYear(2026),
      '$code datePickerDayOfMonth': cupertino.datePickerDayOfMonth(8, 7),
      '$code datePickerHour': cupertino.datePickerHour(14),
      '$code datePickerMinute': cupertino.datePickerMinute(5),
      '$code timerPickerSecond': cupertino.timerPickerSecond(9),
      '$code widgets type': widgets.runtimeType.toString(),
      '$code reorderItemUp': widgets.reorderItemUp,
    });
  }
  result.addAll({
    "DateFormat('dd MMMM yyyy', 'ru')": DateFormat('dd MMMM yyyy', 'ru').format(_date),
    "DateFormat('dd MMMM yyyy', 'en')": DateFormat('dd MMMM yyyy', 'en').format(_date),
    "DateFormat('d MMM', 'ru')": DateFormat('d MMM', 'ru').format(_date),
    "DateFormat('d MMM', 'en')": DateFormat('d MMM', 'en').format(_date),
    "DateFormat.yMMMMd('ru')": DateFormat.yMMMMd('ru').format(_date),
    "DateFormat('dd.MM.yyyy')": DateFormat('dd.MM.yyyy').format(_date),
    "DateFormat('dd.MM.yyyy').locale": DateFormat('dd.MM.yyyy').locale,
    "DateFormat('yyyy-MM-dd')": DateFormat('yyyy-MM-dd').format(_date),
    "DateFormat('dd:MM:yyy HH:mm')": DateFormat('dd:MM:yyy HH:mm').format(_date),
    "DateFormat('dd MMMM yyyy')": DateFormat('dd MMMM yyyy').format(_date),
  });
  return result;
}

void main() {
  test('isSupported only for ru and en', () {
    final delegates = <LocalizationsDelegate<Object?>>[
      AppFrameworkLocalizations.materialDelegate,
      AppFrameworkLocalizations.cupertinoDelegate,
      AppFrameworkLocalizations.widgetsDelegate,
    ];
    for (final delegate in delegates) {
      expect(delegate.isSupported(const Locale('ru')), isTrue);
      expect(delegate.isSupported(const Locale('en')), isTrue);
      expect(delegate.isSupported(const Locale('de')), isFalse);
      expect(delegate.isSupported(const Locale('uk')), isFalse);
    }
  });

  // intl хранит данные дат глобально в изоляте, поэтому каждый вариант считается в отдельном изоляте.
  test('strings and date formats match the global Flutter delegates', () async {
    final actual = await Isolate.run(() => _snapshot(appDelegates: true));
    final expected = await Isolate.run(() => _snapshot(appDelegates: false));

    expect(actual, expected);
    expect(actual['ru okButtonLabel'], 'ОК');
    expect(actual["DateFormat('dd MMMM yyyy', 'ru')"], '08 марта 2026');
  });

  test('registers date data only for en, en_US and ru', () async {
    final locales = await Isolate.run(() async {
      await AppFrameworkLocalizations.materialDelegate.load(const Locale('ru'));
      return DateFormat.allLocalesWithSymbols();
    });

    expect(locales, unorderedEquals(['en', 'en_US', 'ru']));
  });

  test('DateFormat without locale created before loading keeps working', () async {
    final formatted = await Isolate.run(() async {
      final early = DateFormat('dd.MM.yyyy');
      await AppFrameworkLocalizations.cupertinoDelegate.load(const Locale('en'));
      return early.format(_date);
    });

    expect(formatted, '08.03.2026');
  });

  final expectedTypes = {
    'ru': (MaterialLocalizationRu, CupertinoLocalizationRu, WidgetsLocalizationRu),
    'en': (MaterialLocalizationEn, CupertinoLocalizationEn, WidgetsLocalizationEn),
  };
  for (final MapEntry(key: code, value: types) in expectedTypes.entries) {
    testWidgets('MaterialApp loads $code localizations', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale(code),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppFrameworkLocalizations.materialDelegate,
            AppFrameworkLocalizations.widgetsDelegate,
            AppFrameworkLocalizations.cupertinoDelegate,
          ],
          home: Builder(
            builder: (builderContext) {
              context = builderContext;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(MaterialLocalizations.of(context).runtimeType, types.$1);
      expect(CupertinoLocalizations.of(context).runtimeType, types.$2);
      expect(WidgetsLocalizations.of(context).runtimeType, types.$3);
    });
  }
}
