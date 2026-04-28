# Задача 18: Аналитика и polish

## Цель

Трекинг ключевых событий в аналитику + закрытие edge-кейсов (поворот, звонок, понижение яркости, нагрев), чтобы фича дошла до релиз-кандидата.

## Связь с BRD

- §2.2: метрики успеха требуют сбора данных.
- §5.2 NF2.1, NF2.3: 4-часовая стабильность, корректная обработка системных событий.
- §5.1 NF1.4: thermal — без throttling за час.
- §8.2 «Критерии готовности к релизу».
- §10 Q7: «какие события трекать и куда».

## Содержание

1. Аналитические события (отправляются через существующий аналитический сервис Mafbase):
   - `stream_setup_opened`, `stream_setup_completed`;
   - `stream_started` (preset, isRecording, tournamentId);
   - `stream_event_network_quality_changed` (level);
   - `stream_event_reconnect_attempt`;
   - `stream_event_reconnect_failed`;
   - `stream_stopped` (durationSec, avgBitrate, droppedFrames, reason);
   - `stream_consent_shown`, `stream_consent_accepted`;
   - `stream_paywall_shown`.
2. Edge-кейсы (тестировать в реальных условиях):
   - поворот устройства — экран зафиксирован в landscape, но обработать корректно;
   - входящий звонок — см. задачу 14, проверить итоговое поведение;
   - системное понижение яркости / DND — без обрыва;
   - сильный нагрев — фиксируем уведомление пользователю «Устройство перегревается, рекомендуем снять чехол» (на основе `BatteryManager.thermalState` Android / `ProcessInfo.thermalState` iOS).
3. 4-часовой стресс-тест: записать сессию, мониторить память (LeakCanary / Xcode Memory Graph), CPU, температуру.
4. Crash reporting: убедиться, что Crashlytics/Sentry ловит падения в нативном слое (для C++ — `breakpad`/`sentry-native` опционально).
5. README плагина и документация для организаторов:
   - `docs/users/how_to_setup_vk_video_stream.md` — пошагово получить RTMP URL и stream key из VK Видео;
   - FAQ.

## Критерий приёмки

- В аналитической системе видны события стрима с корректными атрибутами.
- 4-часовой стресс-тест: без crash, память не растёт неограниченно (стабилизация после warm-up), thermal не уходит в `critical`.
- Crash-free rate ≥ 99% на минимум 5 полевых сессиях >2 часов (BRD §8.2).
- Все ДОПУЩЕНИЯ из BRD пройдены и закрыты в плане.
- `fvm flutter analyze`, `fvm flutter test`, golden-тесты — зелёные.

## Артефакты

- `lib/features/.../analytics/stream_analytics.dart` — обёртка над аналитикой.
- `docs/users/how_to_setup_vk_video_stream.md`.
- `docs/users/stream_faq.md`.
- Чек-лист релиза в `docs/release_checklist.md`.
