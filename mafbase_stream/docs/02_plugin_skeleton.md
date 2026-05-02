# Задача 02: Скелет плагина и example

## Цель

Получить рабочий пустой Flutter-плагин `mafbase_stream` с собственным `example/` приложением, в котором уже подключён MethodChannel, и можно из Dart дёрнуть нативную заглушку на Android и iOS.

## Связь с BRD

- §7.1 «Архитектура»: фича — Flutter-плагин с тонкой Dart-обёрткой.

## Содержание

1. `flutter create --template=plugin --platforms=android,ios mafbase_stream` (или довести уже сгенерированный скелет).
2. В Dart API объявить минимальный класс `MafbaseStream` с одним методом `Future<String> getPlatformVersion()`.
3. Реализовать на Android (Kotlin) и iOS (Swift) обработчик MethodChannel, возвращающий версию ОС.
4. В `example/` приложении на главном экране — кнопка «Ping native», вызывающая метод и показывающая результат на экране.
5. Прогнать форматтер и анализатор: `fvm dart format --line-length 120 .`, `fvm flutter analyze`.

## Критерий приёмки

- `fvm flutter run` в `mafbase_stream/example` — приложение запускается на Android и iOS.
- Кнопка «Ping native» показывает строку с версией ОС.
- `fvm flutter analyze` — без ошибок.

## Артефакты

- Структура плагина: `lib/`, `android/`, `ios/`, `example/`, `test/`.
- `lib/mafbase_stream.dart` — публичный Dart API.
- `lib/mafbase_stream_method_channel.dart` — обёртка над MethodChannel.
