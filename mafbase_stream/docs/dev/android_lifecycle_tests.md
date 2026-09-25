# Android: тест-кейсы устойчивости стрима и записи

Что проверяется после переноса пайплайна в `StreamForegroundService` (сентябрь 2026) и как это
воспроизвести. Автоматический прогон — скилл `stream-regression`
(`.claude/skills/stream-regression/`), сценарии T1–T9 выполняет `scripts/lifecycle_suite.sh` на
эмуляторе с example-приложением; сценарии M1–M5 — только руками.

## Стенд

- Эмулятор `sdk_gphone64_arm64`, Android 16 (API 36), 1080x2400, камера и микрофон эмулятора.
- Example-приложение плагина `com.example.mafbase_stream_example`, debug-сборка
  (`cd mafbase_stream/example && fvm flutter build apk --debug`), разрешения выдаются через `pm grant`.
- RTMP-приёмник: `ffmpeg -listen 1 -i rtmp://0.0.0.0:1935/live/test -c copy -f flv received_N.flv`
  на Mac; с эмулятора адрес `rtmp://10.0.2.2/live`, ключ `test`. Здоровье потока измеряется ростом
  размера принятого файла (норма ≈2.6 МБ за 5 с при 4 Мбит/с).
- Источники правды на устройстве: `dumpsys activity services` (foreground-статус сервиса),
  `dumpsys media.camera` (открытые камеры, текущая секция до `previous open session`),
  `dumpsys notification --noredact`, `dumpsys power` (wake lock), `logcat -b events`
  (`wm_pause_activity`, `wm_stop_activity`, `wm_finish_activity`), MediaStore (`content query`,
  `is_pending`), логи `StreamPipeline`/`CameraController`/`StreamingController`/`ms.writer`.

## Автоматические сценарии (T1–T9)

| ID | Сценарий | Шаги | Ожидание | Как проверяется |
|---|---|---|---|---|
| T1 | Открытие экрана | Ввести RTMP URL, «Открыть стрим» | `StreamActivity` сверху, камера открыта | top activity; `dumpsys media.camera` |
| T2 | Запись + стрим | «Запись», «Стрим», 10 с | сервис `isForeground=true` с типами camera\|microphone, нотификация есть, поток идёт | services, notification, рост `received_N.flv` |
| T3 | Полупрозрачное окно поверх | `am start ACTION_SEND` (share sheet), 6 с, Back | activity только в pause, поток идёт, камера не отдана, после Back экран стрима | events `wm_pause_activity` без `wm_stop`, рост файла, камера, top |
| T4 | Home на 20 с | `KEYCODE_HOME`, 20 с, вернуться | поток идёт в фоне, камера открыта, сервис foreground, превью переподключено | рост файла, камера, services, лог `attachOutput PREVIEW ok` |
| T5 | Экран выключен 15 с | `KEYCODE_SLEEP`, 15 с, `WAKEUP` | поток идёт, экран стрима после пробуждения | рост файла, top |
| T6 | Чужое приложение с камерой | `am start STILL_IMAGE_CAMERA`, 8 с, Back | после возврата наша камера открыта, поток идёт; потеря и переоткрытие — по логу, если система камеру отобрала | лог `disconnected` / `available again, reopening now`, камера, рост файла |
| T7 | Обрыв RTMP на 40 с | убить приёмник, 40 с, поднять, 40 с | попытки с backoff 1→2→4→8→16→30 с без `FAILED`, сервис foreground, после возврата сервера `reconnect attempt N ok`, поток идёт | лог `ms.writer`, services, рост файла |
| T8 | «Остановить» из нотификации | Home, шторка, развернуть карточку Mafbase, «Остановить» | сервис получил команду, снят с foreground, нотификация убрана, запись финализирована (`is_pending=0`), экран стрима остался | лог `stop requested from notification`, services, notification, MediaStore, top |
| T9 | Back и «Закрыть» | «Стрим», Back → диалог → «Отмена»; «Закрыть» → «Остановить» | Back показывает «Остановить трансляцию и запись?», «Отмена» ничего не меняет, «Остановить» закрывает экран, останавливает сервис, закрывает камеру, отпускает wake lock | `uiautomator dump`, top, services, камера, `dumpsys power` |

## Ручные сценарии (M1–M5)

| ID | Сценарий | Результат | Дата |
|---|---|---|---|
| M1 | Реальная потеря камеры: приложение «Камера» на эмуляторе забрало сенсор 10 | `camera 10 disconnected` → `camera reopen #1 in 1000ms` → `available again, reopening now` через 130 мс, поток не прерывался | 2026-09-23 |
| M2 | Полноэкранное приложение поверх (Настройки) на 5 с | `wm_stop_activity`, поток идёт (+2.6 МБ за 5 с) | 2026-09-23 |
| M3 | Уничтожение `StreamActivity` при активном стриме и повторный `openStreamScreen` | пайплайн жив, новый экран пишет `joining active pipeline`, кнопки в состоянии «Стоп», превью подключено | 2026-09-23 |
| M4 | Тап по нотификации при обычной task affinity (как в боевом приложении) | живой `StreamActivity` поднят наверх задачи, новых экземпляров нет | 2026-09-23 |
| M5 | Тап по нотификации в example с `taskAffinity=""` (шаблон Flutter) | создаётся отдельная задача с новым `StreamActivity`, присоединённым к пайплайну — особенность example, в боевом приложении affinity обычная | 2026-09-23 |

Найдено и исправлено в ходе ручных прогонов 2026-09-23: системный Back на targetSdk 36 закрывал
экран без диалога (`onBackPressed` не вызывается, нужен `OnBackInvokedDispatcher`); launch intent
пакета в нотификации создавал новый `MainActivity` поверх стрима (заменён явным intent на
`StreamActivity` с `REORDER_TO_FRONT`).

## История прогонов

| Дата | Сборка | Устройство | Результат |
|---|---|---|---|
| 2026-09-23 | пайплайн в сервисе, до правок Back и нотификации | эмулятор API 36 | ручной прогон T2–T5, T7–T8, M1–M3: пройдены; Back и тап по нотификации — дефекты, исправлены |
| 2026-09-24 12:23 | `StreamPipeline.kt` единым файлом (1543 строки) | эмулятор API 36 | T1–T9: 38 проверок, 0 ошибок |
| 2026-09-24 12:36 | после разбиения на `CameraController`/`CompositorHost`/`RecordingController`/`StreamingController` | эмулятор API 36 | T1–T9: 38 проверок, 0 ошибок |
| 2026-09-24 12:45 | та же сборка, прогон скиллом `stream-regression` из `.claude/skills/` | эмулятор API 36 | T1–T9: 38 проверок, 0 ошибок |

## Что не покрыто

- Реальное устройство: Pixel 6a с настоящей шторкой Fast Pair, входящим звонком и cached-app freezer
  (на эмуляторе freezer не срабатывал за 20 с фона).
- Многочасовой стрим: нагрев, `thermalservice`, стабильность памяти, ролловер сегментов через 60 минут.
- Overlay при уничтоженной activity: инвалидации теряются до следующего `hostIn`, обновление плашек
  в этом состоянии не проверялось.
- Приложение с `targetSdk 34+` в Play Console: декларация типов foreground service camera и microphone.
