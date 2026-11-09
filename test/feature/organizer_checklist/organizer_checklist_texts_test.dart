import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_item_model.dart';
import 'package:seating_generator_web/feature/organizer_checklist/domain/checklist_key.dart';
import 'package:seating_generator_web/feature/organizer_checklist/ui/organizer_checklist_texts.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

void main() {
  final locale = lookupAppLocalizations(const Locale('ru'));

  String subtitle(
    ChecklistKey key,
    ChecklistStatus status, {
    int? current,
    int? total,
    bool unavailable = false,
    bool isFsm = false,
    ChecklistStreamMethod? method,
  }) =>
      locale.checklistItemSubtitle(
        ChecklistItemModel(key: key, status: status, current: current, total: total, unavailable: unavailable),
        isFsm: isFsm,
        streamMethod: method,
      );

  test('the unavailable flag wins over the lock and the status, the lock over the counter', () {
    expect(
      subtitle(ChecklistKey.notifyCoverage, ChecklistStatus.locked, unavailable: true),
      'Не удалось проверить',
    );
    expect(subtitle(ChecklistKey.tableDescriptions, ChecklistStatus.todo, unavailable: true), 'Не удалось проверить');
    expect(subtitle(ChecklistKey.notifyCoverage, ChecklistStatus.locked), 'Доступно после оплаты');
    expect(
      subtitle(ChecklistKey.obsWidget, ChecklistStatus.locked, current: 0, total: 3),
      'Доступно после оплаты плашек',
    );
  });

  test('counters use the item wording and are skipped when there is nothing to count', () {
    expect(subtitle(ChecklistKey.notifyCoverage, ChecklistStatus.warning, current: 18, total: 20), 'Получат 18 из 20');
    expect(subtitle(ChecklistKey.seating, ChecklistStatus.warning, current: 3, total: 5), 'Игр с рассадкой: 3 из 5');
    expect(subtitle(ChecklistKey.obsWidget, ChecklistStatus.done, current: 1, total: 3), 'Столов с OBS: 1 из 3');
  });

  test('0 of 0 is replaced with what is missing', () {
    expect(
      subtitle(ChecklistKey.notifyCoverage, ChecklistStatus.todo, current: 0, total: 0),
      'В турнире пока нет участников',
    );
    expect(
      subtitle(ChecklistKey.seating, ChecklistStatus.todo, current: 0, total: 0),
      'Сначала укажите количество игр',
    );
    expect(subtitle(ChecklistKey.tableDescriptions, ChecklistStatus.todo, current: 0, total: 0), 'Столов пока нет');
    expect(subtitle(ChecklistKey.obsWidget, ChecklistStatus.todo, current: 0, total: 0), 'Столов пока нет');
    expect(subtitle(ChecklistKey.phoneStream, ChecklistStatus.todo, current: 0, total: 0), 'Столов пока нет');
    expect(
      subtitle(ChecklistKey.phoneOperator, ChecklistStatus.todo, current: 0, total: 0),
      'Сначала настройте трансляцию с телефона',
    );
  });

  test('statuses without counters explain the item', () {
    expect(
      subtitle(ChecklistKey.players, ChecklistStatus.warning, current: 23),
      'Участников: 23 — не кратно 10. Рассадка сгенерируется, когда участников станет кратно 10',
    );
    expect(subtitle(ChecklistKey.players, ChecklistStatus.todo, current: 6), 'Участников: 6 — нужно не меньше 10');
    expect(subtitle(ChecklistKey.seating, ChecklistStatus.todo, isFsm: true), 'Загрузите рассадку с GoMafia');
    expect(
      subtitle(ChecklistKey.obsWidget, ChecklistStatus.warning, current: 1, total: 2),
      'Для смены сцен нужен «Продвинутый доступ к OBS»',
    );
    expect(
      subtitle(ChecklistKey.streamMethod, ChecklistStatus.done, method: ChecklistStreamMethod.phone),
      'С телефона через приложение Mafbase',
    );
    expect(subtitle(ChecklistKey.streamMethod, ChecklistStatus.todo), 'OBS на компьютере или телефон');
  });
}
