---
name: project_ios_stream_resilience_task19
description: Задача 19 (iOS-устойчивость стрима mafbase_stream) реализована 2026-09-24 целиком, но не проверена на устройстве — список сценариев и логов для ручной проверки.
type: project
---

Задача `mafbase_stream/docs/19_ios_stream_resilience.md` (все 19 пунктов) реализована 2026-09-24
в `mafbase-app`, коммит `25c1674` (2026-09-25), вошла в релиз 4.3.0 (`chore: релиз 4.3.0`, тег в сторы на момент записи не ставился): `ios/Classes/Pipeline/`
(`StreamPipeline`, `StreamingController`, `SilenceGenerator`, `PauseCardRenderer`, `RetryBackoff`),
тонкий `StreamViewController`, режим заглушки в `GL/Compositor.swift`, `UIBackgroundModes: audio`
в обоих Info.plist, README и оба CHANGELOG.

**Why:** Проверить можно только на реальном iPhone (симулятор без камеры), а ручной прогон
делает пользователь. Компиляция example проходит, поведение на устройстве не подтверждено.

**How to apply:** Если пользователь сообщает о проблеме стрима на iOS — сначала спросить, прогнан ли
чек-лист из «Критерия приёмки» задачи 19. Ключевые логи `[mafbase_stream]`: `placeholder mode on/off`,
`silence generator: started / real audio resumed`, `capture session rebuild #N`, `stream restart #N`,
`network path changed — reconnect now`, `thermal level X -> Y`. Открытые вопросы: отдаёт ли
`AVCaptureAudioDataOutput` сэмплы в фоне (иначе работает тишина, fallback `AVAudioEngine` не сделан);
принимает ли Фото фрагментированный MP4; не отдаёт ли VideoToolbox `kVTInvalidSessionErr` в фоне.
