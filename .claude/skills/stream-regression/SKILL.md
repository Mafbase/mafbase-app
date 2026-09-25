---
name: stream-regression
description: Регресс плагина mafbase_stream на Android-эмуляторе — сборка example, RTMP-приёмник на ffmpeg и автоматический прогон девяти lifecycle-сценариев (окно поверх, Home, выключенный экран, обрыв RTMP, остановка из нотификации, диалог закрытия). Использовать после любых изменений в mafbase_stream/android, перед релизом или когда пользователь просит «прогнать регресс стрима» / /stream-regression.
---

# Регресс mafbase_stream (Android)

Проверяет, что стрим и запись переживают всё, что случается с телефоном на штативе. Тест-кейсы и
история результатов — в `mafbase_stream/docs/dev/android_lifecycle_tests.md`.

## Что нужно

- Запущенный Android-эмулятор 1080x2400 (проверялось на API 36, `adb devices` показывает `emulator-5554`).
  Координаты тапов привязаны к вёрстке example-приложения на этом разрешении.
- `ffmpeg` в PATH (`brew install ffmpeg`) — приёмник RTMP, Docker не нужен.
- Собранный example: `cd mafbase_stream/example && fvm flutter build apk --debug`.

## Как запускать

1. Убедиться, что эмулятор виден: `adb devices`.
2. Собрать example (см. выше), если менялся Kotlin плагина.
3. Запустить прогон (5–6 минут):

```bash
.claude/skills/stream-regression/scripts/lifecycle_suite.sh
```

   Аргументы: `[apk] [serial]`. Переменные: `RTMP_URL` (адрес приёмника с точки зрения устройства),
   `STREAM_REGRESSION_DIR` (логи и принятые потоки, по умолчанию `/tmp/mafbase_stream_regression`),
   `SKIP_SCREEN_OFF=1` (устройство с PIN). Код возврата 0 — все проверки прошли.
4. Итог печатается построчно `PASS`/`FAIL` по сценариям T1–T9, лог — `suite_*.log` в рабочем каталоге,
   принятые потоки — `received_N.flv` (проверяются по росту размера), логи ffmpeg — `rtmp_ffmpeg_N.log`.

## Как читать сбои

- Сначала посмотреть `adb logcat -d | grep -E "StreamPipeline|CameraController|StreamingController|RecordingController|StreamForegroundService|ms\."`:
  пайплайн логирует переоткрытие камеры, реконнект ядра (`ms.writer`) и остановку из нотификации.
- `dumpsys activity services com.example.mafbase_stream_example` — foreground-статус сервиса;
  `dumpsys media.camera` — открытые камеры (текущая секция до `previous open session`);
  `dumpsys notification --noredact` — нотификация стрима.
- Сценарий T6 (чужое приложение с камерой) на эмуляторе информационный: эмулятор часто отдаёт
  приложению «Камера» другой сенсор, и потери не происходит. Реальная потеря и переоткрытие
  проверялись вручную, см. документ с тест-кейсами.
- Если скрипт не нашёл кнопку в шторке (T8), проверить, что нотификация в секции Silent и что
  `uiautomator dump` работает (`adb shell uiautomator dump /sdcard/ui.xml`).

## Реальное устройство

Тот же скрипт: `RTMP_URL=rtmp://<IP Mac в LAN>/live SKIP_SCREEN_OFF=1 scripts/lifecycle_suite.sh <apk> <serial>`.
Экран должен быть 1080x2400 (Pixel 6a подходит). Сценарии, которые нельзя автоматизировать и
которые стоит прогнать руками на телефоне: шторка Google Fast Pair поверх экрана, входящий звонок,
многочасовой стрим на зарядке с контролем `dumpsys thermalservice`.

## Что делать после прогона

Кратко перечислить пользователю FAIL-сценарии с выдержками из логов; при полном успехе — одну строку
с итогом и путём к логу. Зелёный прогон дописать в таблицу результатов
`mafbase_stream/docs/dev/android_lifecycle_tests.md` (дата, сборка, устройство, PASS/FAIL).
