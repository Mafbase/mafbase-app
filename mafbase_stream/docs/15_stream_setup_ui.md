# Задача 15: UI настройки стрима в Mafbase

## Цель

В основном приложении Mafbase (а не только в `example` плагина) появляется flow настройки стрима: ввод RTMP URL и stream key, выбор preset качества, чекбокс локальной записи. Stream key хранится в защищённом хранилище.

## Связь с BRD

- §4.1 F1.1–F1.5: запуск трансляции из экрана активного турнира.
- §4.1 F1.3: запоминание последних настроек, безопасное хранение stream key.
- §5.4 NF4.1: Android Keystore / iOS Keychain.

## Содержание

1. Маршрут в Mafbase (`router.dart`): `tournament/:id/stream`.
2. На экране активного турнира — кнопка «Запустить трансляцию» (см. задачу 17 для paywall-ветки).
3. Экран настройки (Bloc):
   - поля «RTMP URL» (TextField с валидацией `rtmp://` или `rtmps://`);
   - «Stream key» (obscured TextField);
   - выбор preset через `CustomDropdown` (High/Medium/Low — см. таблицу §4.2 F2.6);
   - чекбокс «Записывать локальную копию»;
   - кнопка «Проверить подключение» — выполняет F1.4 (тестовый connect к RTMP);
   - кнопка «Начать стрим».
4. Хранение:
   - RTMP URL и preset — в обычных настройках турнира;
   - stream key — через `flutter_secure_storage` (Android Keystore, iOS Keychain);
   - last-used значения подставляются при следующем заходе.
5. Локализация: `app_ru.arb` + `fvm flutter gen-l10n`.
6. Кнопки — через `CustomButton`, дропдаун — через `CustomDropdown` (см. CLAUDE.md).

## Критерий приёмки

- На реальном турнире в Mafbase: тап «Запустить трансляцию» → экран настройки.
- Ввод значений → «Проверить подключение» показывает успех/ошибку.
- Закрыть и снова открыть приложение → последние URL/preset подставлены, stream key подставлен из защищённого хранилища.
- На неоплаченном турнире — поведение из задачи 17 (пока заглушка).
- `fvm flutter analyze`, `fvm flutter test` — зелёные. Golden-тест экрана настройки.

## Артефакты

- `lib/features/stream_setup/` (bloc/page/widgets) в основном приложении.
- Запись в `lib/router.dart`.
- Строки в `app_ru.arb`.
- Адаптер `StreamSettingsRepository` (с использованием `flutter_secure_storage`).
