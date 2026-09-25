# Задача 19: iOS — устойчивость стрима и записи к прерываниям и фону

## Цель

Телефон стоит на штативе часами, оператор его не трогает. Стрим и запись на iOS должны переживать
входящие звонки, Siri, будильники, системные окна, кратковременный уход приложения в фон и обрывы
сети, восстанавливаться сами и останавливаться только по явному действию пользователя. Это iOS-часть
той же работы, что уже сделана для Android (см. «Референс» ниже); Dart API плагина не меняется.

## Контекст

Инцидент 2026-09-19 на Pixel 6a: поверх экрана стрима всплыла системная шторка, `StreamActivity`
получила `onPause`, а `onPause` останавливал запись, стрим и камеру. За день так слетели 3 записи из 5.
На Android причина устранена архитектурно: пайплайн вынесен из activity в объект, который держит
foreground service; экран стал тонким окном; камера и RTMP восстанавливаются сами.

На iOS всплывающие окна, баннер звонка и Пункт управления `viewWillDisappear` не вызывают, поэтому
тот же сценарий не воспроизводится. Но та же болезнь сидит в других местах, см. следующий раздел.

## Текущее состояние iOS-кода (проверено 2026-09-24)

Все пути относительно `mafbase_stream/`.

- `ios/Classes/StreamViewController.swift` (≈1345 строк) владеет всем пайплайном: `captureSession`
  (строка 52), `sessionQueue`, `videoDataOutput`/`audioDataOutput`, компоситор, `Mp4Recorder`,
  `StreamSession`, overlay. `viewWillDisappear` (строки 172–180) останавливает запись, стрим,
  capture session и компоситор. `startSession`/`stopSession` — строки 488–500.
- `handleAudioInterruption` (строки 1305–1313): на `AVAudioSession.interruptionNotification` типа
  `.began` вызывает `stopRecording()` и ничего не возобновляет. Любой звонок, Siri или будильник на
  штативе навсегда останавливают запись. README.md (строки 98–100) описывает это как штатное поведение.
- Наблюдателей `AVCaptureSession.wasInterruptedNotification`, `interruptionEndedNotification`,
  `runtimeErrorNotification`, `AVAudioSession.mediaServicesWereResetNotification`,
  `UIApplication.didEnterBackgroundNotification` / `willEnterForegroundNotification`,
  `ProcessInfo.thermalStateDidChangeNotification` нет вообще (grep по `ios/Classes`). Если система
  отобрала камеру или сбросила media services, сессия умирает молча.
- `runProtectedFromSuspension` (строка 1130) — `beginBackgroundTask` только на время финализации
  записи. `UIBackgroundModes` приложения (`mafbase-app/ios/Runner/Info.plist`, строки 64–68) — только
  `fetch` и `remote-notification`: в фоне процесс засыпает через несколько секунд, сокет RTMP умирает.
- `ios/Classes/StreamSession.swift` (строки 330–346): `bridge.start(... maxReconnectAttempts: 0,
  reconnectBaseDelayMs: 0, reconnectCapDelayMs: 0 ...)` — нули означают дефолты C++ ядра: 3 попытки
  (1→2→4 с), затем `FAILED`. Разрыв сети дольше 7 секунд убивает стрим.
- `ios/Classes/Encoder/Mp4Recorder.swift` (строки 78–84): `AVAssetWriter(url:fileType:.mp4)`,
  `shouldOptimizeForNetworkUse = false`, `movieFragmentInterval` не задан. Убийство процесса теряет
  весь текущий сегмент (по умолчанию сегментация выключена, то есть всю запись).
- `ios/Classes/MafbaseStreamPlugin.swift` (строки 56–88): создаёт `StreamViewController`, кладёт в него
  параметры, `present(.fullScreen)`; Dart-future резолвится в `onClose` (`dismissWithReason`,
  строка 827 контроллера).
- `ios/Classes/Overlay/OverlayViewRenderer.swift` (строки 100–125): overlay-view хостится в `view`
  самого верхнего presented VC (`topMostHostView()`), потому что `UIHostingController` внутри overlay
  ищет parent VC. При переносе владения это место надо сохранить рабочим.
- `ios/Classes/GL/Compositor.swift`: `processFrame(pixelBuffer:pts:)` (216), `setOverlayBitmap` (226),
  `clearOverlay` (233), `release` (442). Аудио идёт мимо компоситора напрямую в writer'ы
  (`captureOutput`, строки 1325–1340 контроллера).
- `UIApplication.shared.isIdleTimerDisabled = true` ставится в `viewWillAppear` и снимается в
  `viewWillDisappear` (строки 167–174).

## Ограничения платформы

- Видео с камеры в фоне iOS не даёт: при уходе в фон `AVCaptureSession` получает прерывание
  `.videoDeviceNotAvailableInBackground`. Entitlement multitasking-camera-access нам недоступен.
- Выключить экран без ухода в фон нельзя. Эквивалента foreground service нет.
- Процесс продолжает жить в фоне, пока активна `AVAudioSession` с записью и в `Info.plist` есть
  `UIBackgroundModes: audio`. Это единственный легальный способ держать сеть и энкодеры живыми.
- Кнопка питания на штативе всё равно должна быть под запретом: максимум, что мы даём в фоне, — звук
  плюс заглушка вместо видео.

## Референс: как сделано на Android

Читать перед началом, поведение iOS должно совпадать по смыслу:

- `android/src/main/kotlin/com/example/mafbase_stream/pipeline/StreamPipeline.kt` — движок, владеет
  камерой/компоситором/аудио/записью/стримом; `attachPreview`/`detachPreview`; переоткрытие камеры
  с backoff 1→2→4→8→10 с; пересоздание `StreamSession` после `Failed` с backoff 2→4→8→15 с; тост об
  ошибке не чаще раза в минуту; `stopAll`/`release`; `Listener` на main.
- `android/src/main/kotlin/com/example/mafbase_stream/service/StreamForegroundService.kt` — держатель
  единственного пайплайна на процесс, нотификация с кнопкой «Остановить».
- `android/src/main/kotlin/com/example/mafbase_stream/StreamActivity.kt` — тонкое окно: присоединяется
  к активному пайплайну, `onPause`/`onStop` только отцепляют превью, «Закрыть»/Back при активном
  стриме спрашивают подтверждение.
- `StreamSession.kt`, `maybeStartRtmp`: `maxReconnectAttempts = Int.MAX_VALUE`, base 1000 мс,
  cap 30 000 мс.

## Содержание

### 1. Владение пайплайном

1. Новый `ios/Classes/Pipeline/StreamPipeline.swift`: переносит из контроллера capture session,
   очереди, outputs, выбор объектива, качество, компоситор, `Mp4Recorder` с сегментацией и
   `StorageMonitor`, `StreamSession`, overlay renderer, `PhaseGate`. Поведение записи и стрима
   (сегменты, перенос в Фото через `moveToPhotoLibrary`, PTS, порядок остановки) сохранить один в один —
   это перенос, а не переписывание.
2. Единственный экземпляр на процесс держит `MafbaseStreamPlugin` (статическое поле). Публичный API
   по образцу Kotlin: `start()`, `attachPreview(_ layer: AVSampleBufferDisplayLayer)` /
   `detachPreview()`, `toggleRecording()`, `toggleStreaming()`, `stopAll()`, `release()`, состояние
   (`isRecording`, `isStreaming`, транзишны, `isActive`, `frameSize`, объектив, качество), делегат с
   `onStateChanged`, `onFrameSizeChanged`, `onMessage(text:long:)`, `onFatalError` на main queue.
3. `StreamViewController` становится тонким окном: слой превью получает кадры от пайплайна, кнопки и
   иконка качества синхронизируются из его состояния. `viewWillDisappear` пайплайн не трогает.
   `openStreamScreen` при активном пайплайне открывает новый контроллер, который присоединяется к нему
   и игнорирует новые параметры (одна трансляция на процесс). Контроллер освобождает пайплайн только
   если тот не активен.
4. Кнопка «Закрыть» при активном стриме или записи показывает `UIAlertController`
   «Остановить трансляцию и запись?» с кнопками «Остановить» (стоп всего → `release` → dismiss) и
   «Отмена». Presentation остаётся `.fullScreen`, интерактивный dismiss невозможен.
5. `isIdleTimerDisabled = true` держать, пока контроллер на экране или пайплайн активен; снимать при
   `release`.
6. Overlay: `OverlayViewRenderer.hostInActiveWindowIfPossible` должен переживать смену контроллера:
   явные `hostIn(viewController)`/`unhost()`, при новом хосте — свежий снимок. SwiftUI-контейнер не
   уничтожать при снятии с окна, только при `release` пайплайна (аналог `OverlayComposeContainer` на
   Android).

### 2. Фон и прерывания

7. `UIBackgroundModes: audio` в `mafbase-app/ios/Runner/Info.plist` и в `example/ios/Runner/Info.plist`.
   `AVAudioSession` категории `.playAndRecord` (mode `.videoRecording`, опции по вкусу реализации)
   активна, пока пайплайн активен. Проверить на устройстве, что `AVCaptureAudioDataOutput` продолжает
   отдавать сэмплы в фоне; если нет — брать PCM из `AVAudioEngine.inputNode` на время фона и отдавать в
   те же `appendAudio`/`appendAudioSample`.
8. Наблюдатели: `AVCaptureSession.wasInterruptedNotification` (все причины:
   `.videoDeviceNotAvailableInBackground`, `.audioDeviceInUseByAnotherClient`,
   `.videoDeviceInUseByAnotherClient`, `.videoDeviceNotAvailableWithMultipleForegroundApps`,
   `.videoDeviceNotAvailableDueToSystemPressure`), `interruptionEndedNotification`,
   `runtimeErrorNotification`, `AVAudioSession.interruptionNotification`,
   `AVAudioSession.mediaServicesWereResetNotification`, `UIApplication.didEnterBackgroundNotification`
   и `willEnterForegroundNotification`.
9. Режим заглушки. Пока видео недоступно (фон, чужое приложение с камерой, system pressure), компоситор
   сам генерирует кадры 2 fps из последнего кадра камеры с карточкой «Трансляция на паузе» (для отрисовки
   переиспользовать путь break-заглушки, см. `breakPlaceholderImageUrl` в `OverlayParams`). PTS
   заглушки берутся от host-времени, чтобы `AVAssetWriter` и RTMP видели монотонное время. Звук и запись
   не прерываются. По `interruptionEnded`/`willEnterForeground` — возврат к камере без пересоздания
   энкодеров.
10. Аудиопрерывание: на `.began` ничего не останавливать, звук глушится (тишина с корректными PTS);
    на `.ended` с `.shouldResume` — `setActive(true)` и продолжение. Текущий `stopRecording()` в
    `handleAudioInterruption` убрать.
11. `runtimeError` с `AVError.mediaServicesWereReset` и любой другой фатальный сбой capture session —
    пересборка сессии с backoff 1→2→4→8→10 с без лимита попыток, компоситор и энкодеры не
    пересоздаются (аналог переоткрытия камеры на Android).
12. Финализацию записи и остановку стрима при `release` по-прежнему защищать `beginBackgroundTask`.

### 3. Сеть

13. `StreamSession.swift`: `maxReconnectAttempts: Int32.max`, `reconnectBaseDelayMs: 1000`,
    `reconnectCapDelayMs: 30000` (проверить типы в `ios/Classes/Bridge`). Цикл реконнекта в ядре
    проверяет `stop_requested_` на каждой итерации, остановка по кнопке не зависает.
14. После события `Failed` или ошибки энкодера пайплайн пересоздаёт `StreamSession` целиком
    (detach → stop → новая сессия → attach) с backoff 2→4→8→15 с, пока стрим не остановил пользователь;
    сообщение об ошибке не чаще раза в минуту, после восстановления — «Стрим восстановлен».
15. `NWPathMonitor` (уже есть в `Overlay/Plashki/SeatingContentSocket.swift`): смена сетевого пути —
    немедленная попытка реконнекта, а не ожидание backoff.

### 4. Запись, экран, нагрев

16. `Mp4Recorder`: `writer.movieFragmentInterval = CMTime(seconds: 10, preferredTimescale: 600)`.
    Фрагментированный MP4 читается, даже если процесс убили; `shouldOptimizeForNetworkUse` остаётся
    `false`. Проверить, что Фото принимает такой файл и что `moveToPhotoLibrary` работает без изменений.
17. Затемнение: через 60 секунд без касаний при активном пайплайне `UIScreen.main.brightness`
    опускается до 0.05, слой превью скрывается (компоситор продолжает рендерить для энкодеров);
    касание возвращает яркость и превью; при `release` вернуть исходную яркость.
18. `ProcessInfo.thermalState`: `.serious` — битрейт стрима −50 % и 24 fps, `.critical` — 15 fps;
    разрешение на лету не менять (пересоздаёт пайплайн). `AVCaptureDevice.systemPressureState`
    `.critical` обрабатывать так же. Возврат к норме — при `.nominal`/`.fair`.
19. На экране стрима строка для оператора: «Не блокируйте экран и не сворачивайте приложение: видео в
    фоне iOS не передаёт». Строки на русском, как остальные в контроллере.

### Что не входит

Изменения Dart API и Flutter-приложения, Android, C++ ядра, heartbeat на backend, PiP и
multitasking-camera entitlement, изменение длины сегментов по умолчанию.

## Критерий приёмки

Все проверки на реальном iPhone (симулятор без камеры), стрим идёт в локальный RTMP-приёмник,
запись включена.

| Сценарий | Ожидание |
|---|---|
| Входящий звонок, Siri, будильник во время стрима и записи | После окончания стрим и запись продолжаются, звук возобновился, файл без разрыва |
| Пункт управления, Центр уведомлений, системный alert поверх | Ничего не останавливается |
| Home на 30 с, затем возврат | RTMP-поток идёт всё время (звук + заглушка), запись идёт, видео с камеры вернулось не позже 2 с после возврата |
| Блокировка экрана кнопкой питания на 30 с | То же, что Home |
| Обрыв RTMP-сервера на 60 с | Попытки с backoff до 30 с без `FAILED`, после возврата сервера поток восстановлен сам |
| Переключение на приложение «Камера» и обратно | Заглушка на время, затем камера вернулась |
| Принудительное убийство приложения во время записи | Файл сегмента читается, длительность до момента убийства |
| «Закрыть» при активном стриме | Диалог подтверждения; «Отмена» ничего не меняет, «Остановить» всё освобождает, Dart-future резолвится |
| Повторный `openStreamScreen` при активном пайплайне | Новый экран показывает живое состояние (кнопки «Стоп»), стрим не прерывался |
| 3 часа на штативе на зарядке с затемнённым экраном | Без остановок, thermal state не доходит до `.critical` |

## План проверки

- RTMP-приёмник на Mac без Docker: `ffmpeg -listen 1 -i rtmp://0.0.0.0:1935/live/test -c copy -f flv out.flv`
  (перезапускать после каждой сессии, для теста обрыва — просто убить процесс). В example указать
  `rtmp://<IP Mac в локальной сети>/live`, ключ `test`. Альтернатива — nginx-rtmp из `dev/docker-compose.yml`.
- Example: `cd mafbase_stream/example && fvm flutter run -d <iPhone>`; при первом запуске
  `cd example/ios && pod install` (prepare_command podspec тянет FFmpeg-xcframework, см. `native/scripts/fetch_ffmpeg_ios.sh`).
- Логи: `NSLog` с префиксом `[mafbase_stream]`, смотреть в Console.app или через Xcode. Для звонка
  удобен второй телефон; для Siri — долгое нажатие кнопки питания; будильник — из «Часов».
- Проверка файла после kill: `ffprobe <файл>` на Mac или открыть в Фото.

## Артефакты

- `ios/Classes/Pipeline/StreamPipeline.swift` (новый), `ios/Classes/StreamViewController.swift`
  (тонкое окно), `ios/Classes/MafbaseStreamPlugin.swift` (держатель пайплайна, присоединение),
  `ios/Classes/StreamSession.swift` (реконнект), `ios/Classes/Encoder/Mp4Recorder.swift`
  (фрагменты), `ios/Classes/GL/Compositor.swift` (режим заглушки),
  `ios/Classes/Overlay/OverlayViewRenderer.swift` (смена хоста).
- `mafbase-app/ios/Runner/Info.plist` и `example/ios/Runner/Info.plist`: `UIBackgroundModes: audio`.
- `README.md` (секция iOS: убрать описание остановки записи при прерывании, описать фон и заглушку),
  `CHANGELOG.md` плагина и `mafbase-app/CHANGELOG.md` (`## [UNRELEASED]`).

## Правила работы

- Перед стартом прочитать `mafbase-app/CLAUDE.md`, `mafbase-app/AGENTS.md`, `README.md` плагина
  (секции iOS), `docs/14_background_streaming.md` и Android-референс выше.
- Стиль как в существующих Swift-файлах: 4 пробела, `NSLog("[mafbase_stream] ...")`, комментарии
  короткие и только про внешнюю механику (поведение AVFoundation/UIKit), без истории отладки.
- Работать поэтапно и проверяемо: сначала п. 13 и 16 (по строке, сразу дают эффект), затем п. 1–6
  (перенос владения), затем п. 7–12, затем п. 17–19. После каждого этапа — сборка example на
  устройстве.
- Ничего не коммитить без явной просьбы. Android, C++ и Dart не трогать.
