# Задача 04: Android — нативный экран и превью камеры

## Цель

Из Dart открывать полноэкранную нативную `Activity`, в которой работает `Camera2`-превью (landscape, основная камера). Это первая «видимая» Android-веха.

## Связь с BRD

- §7.1: «Android: Kotlin + Camera2 + ... Запускает отдельную нативную Activity для экрана стрима».
- §4.2 F2.1: «Захват видео с основной камеры устройства в горизонтальной ориентации».
- §5.3 NF3.1: Android API 26+.

## Содержание

1. В `android/` плагина: `StreamActivity` (Kotlin), запускаемая через MethodChannel из Dart.
2. Запрос разрешений `CAMERA` и `RECORD_AUDIO` (если нет — диалог системного запроса).
3. Camera2-превью на `SurfaceView` с фиксированным landscape-ориентированием, корректным вращением для backlit-камеры.
4. На экране — оверлейная кнопка «Закрыть», которая закрывает `Activity` и через MethodChannel шлёт в Dart событие `closed`.
5. Dart API: `MafbaseStream.openStreamScreen()` возвращает `Future<void>`, разрешающийся при закрытии.
6. На экране примера в `example/` — кнопка «Открыть стрим (Android)», которая вызывает API.

## Критерий приёмки

- На реальном Android-устройстве (API 26+): нажатие кнопки в `example` открывает полноэкранное превью камеры в landscape.
- Кнопка «Закрыть» закрывает экран, Dart-future разрешается.
- При первом запуске показывается системный диалог запроса разрешений; при отказе — экран не открывается, в Dart возвращается ошибка.
- `fvm flutter analyze` без ошибок.

## Артефакты

- `android/src/main/kotlin/.../StreamActivity.kt`.
- `android/src/main/AndroidManifest.xml` с регистрацией Activity и permissions.
- Обновлённый `lib/mafbase_stream.dart` с методом `openStreamScreen`.
