---
name: project-stream-drop-diagnostics-android
description: Как искать причину обрыва стрима/записи mafbase_stream на Android, когда основной logcat уже перетёрся; инцидент 2026-09-19 с Fast Pair-шторкой и чем он закончился
metadata:
  type: project
---

Инцидент 2026-09-19 (Pixel 6a): стрим и запись обрывались «сами» через ~5 минут. Причина — Google Fast Pair
`HalfSheetActivity` (gms) всплывала поверх `StreamActivity`, та получала только `onPause` (без `onStop`),
а `StreamActivity.onPause()` гасил запись, стрим и камеру; `onResume` поднимал только превью. За день так
слетели 3 записи из 5, ещё одна — от короткого выхода на Home.

**Why:** основной буфер logcat на Pixel 6a — 256 KiB (~3–5 минут), к моменту разбора логов уже нет.

**How to apply:** для обрывов стрима/записи на Android смотреть долгоживущие источники:
`adb logcat -d -b events` (wm_pause_activity/wm_create_activity, am_foreground_service_start SaveToGalleryService
= момент финализации записи), `dumpsys batterystats --history` (+/-camera, +/-audio по uid),
`dumpsys media.camera` (CONNECT/DISCONNECT с временем), `dumpsys media.metrics` (audio.record start/stop, codec),
`netstats_mobile_sample` в events (профиль аплоуда), mtime файлов в /sdcard/Movies. См. [[mafbase-app-renamed]].

**Статус (2026-09-24):** причина устранена архитектурно — пайплайн вынесен из `StreamActivity` в пакет
`pipeline/` (`StreamPipeline` — фасад, `CameraController`, `CompositorHost`, `RecordingController`,
`StreamingController`), который держит `service/StreamForegroundService.kt` (foreground camera|microphone,
нотификация с кнопкой «Остановить»). `onPause`/`onStop` только отцепляют превью; камера переоткрывается сама,
RTMP реконнектится без лимита, сессия пересоздаётся после Failed. На targetSdk 36 Back идёт через
`OnBackInvokedDispatcher`, `onBackPressed` не вызывается.

**Регресс:** скилл `stream-regression` в `mafbase-app/.claude/skills/` — эмулятор + example + ffmpeg-приёмник,
девять сценариев за ~6 минут; тест-кейсы и история прогонов в `mafbase_stream/docs/dev/android_lifecycle_tests.md`.
Задача по iOS — `mafbase_stream/docs/19_ios_stream_resilience.md`.
