# Задача 13: Адаптивный битрейт и переподключение

## Цель

Стрим адаптируется к качеству сети (битрейт снижается при загруженности и поднимается при улучшении) и переживает временные обрывы соединения с RTMP-сервером. Энкодер и поток отправки развязаны, плохая сеть не блокирует пайплайну захвата.

## Связь с BRD

- §4.2 F2.5: адаптивный битрейт.
- §4.2 F2.7: автореконнект, минимум 3 попытки с увеличивающимся интервалом.
- §5.2 NF2.2: при потере сети не падает.
- §9 R3: митигация для нестабильной мобильной сети.

## Текущее состояние (что есть до задачи)

- `native/src/rtmp_publisher.cpp`: `avio_open2` без `rw_timeout` и без `interrupt_callback` → `av_interleaved_write_frame` на мёртвом сокете может зависнуть на минуты, ошибка не прилетает.
- `native/src/session.cpp`: один `std::mutex mu` сериализует `push_video` и `push_audio` через одну и ту же блокировку. При зависании сокета блокируется и видео-, и аудио-дорожка одновременно.
- `android/.../StreamSession.kt`, `ios/.../StreamSession.swift`: `pushVideo`/`pushAudio` вызываются прямо из drain-потока энкодера под `synchronized(lock)`. Если C-API блокируется — drain-поток замораживается, output-буферы MediaCodec/VideoToolbox не освобождаются, давление на энкодер растёт.
- При `MS_ERR_IO` кадр молча дропается, reconnect отсутствует, состояние `MS_STATE_RECONNECTING` объявлено, но никем не выставляется.
- Наружу в Dart нет ни события backpressure, ни события reconnect/failed.

## Содержание

### 1. Сетевые таймауты (предусловие для всего остального)

Без этого reconnect-политика не сработает: ошибка записи никогда не прилетит, пока FFmpeg ждёт TCP.

- Сконфигурировать `avio_open2` через `AVDictionary`:
  - `rw_timeout` = 3 000 000 мкс (3 с) на чтение/запись.
  - `tcp_nodelay` = 1.
- Установить `AVIOInterruptCB` на `fmt_ctx_->interrupt_callback`: callback возвращает `1` (прерывание), если истёк дедлайн текущей операции либо взведён флаг `cancel_requested_` (выставляется из `RtmpPublisher::close()` и из reconnect-политики при таймауте). Дедлайн обновляется перед каждым `av_interleaved_write_frame` / `avformat_write_header`.
- Любая ошибка записи преобразуется в `MS_ERR_IO` с подкодом (`timeout`, `eof`, `econnreset`) — нужен enum для логирования.

### 2. Writer-thread + очередь пакетов

`push_video`/`push_audio` не должны выполнять сетевой I/O синхронно — иначе очередь не имеет смысла.

- Новые модули:
  - `native/src/network/packet_queue.{h,cpp}` — потокобезопасная очередь `EncodedPacket { stream, data, pts_us, is_keyframe }` с политикой дропа (см. ниже).
  - `native/src/network/writer_thread.{h,cpp}` — consumer-поток, владеет `RtmpPublisher`, дренажит очередь и вызывает `av_interleaved_write_frame`.
- `ms_session_push_video`/`ms_session_push_audio` теперь только копируют payload и `enqueue` в очередь. Возвращаются мгновенно, не держат глобальную мьютексу сессии на время сетевого I/O.
- Раздельные подочереди для видео и аудио (одна общая структура с двумя FIFO внутри), interleave по PTS внутри writer-thread перед `av_interleaved_write_frame`.
- Бюджет очереди: ≤ 2 секунды по PTS на каждую дорожку (конфигурируется), плюс жёсткий cap по байтам (например, 4 MB) как защита от нереалистичных битрейтов.
- Drop-политика при превышении бюджета:
  1. Сначала дропаем самые старые **видео non-keyframe** до ближайшего IDR.
  2. Если этого недостаточно — дропаем самые старые **аудио** пакеты.
  3. Видео keyframe и `extradata` (SPS/PPS, ASC) **никогда не дропаются**: их потеря фризит плеер на интервал GOP.
  4. Каждый дроп инкрементит счётчик `droppedFrames` (видим в `StreamEvent`).
- Сигналы наружу:
  - `onQueueDepth(videoMs, audioMs)` — публикуется раз в N мс (≈ 200) для UI-индикатора.
  - `onBackpressure(level)` — `none/low/high`, дискретизация по проценту заполнения очереди.

### 3. Развязка мьютексов

- Глобальный `session->mu` остаётся только для смены состояния и lifecycle (`start`/`stop`/`destroy`), не для push.
- `push_video`/`push_audio` берут лёгкий мьютекс очереди (или lock-free структуру) и не пересекаются с writer-thread иначе как через очередь.
- `StreamSession.kt` / `StreamSession.swift`: убрать `synchronized(lock)` вокруг push (оставить только вокруг lifecycle и `referencePtsUs`-инициализации). Либо разделить на `videoLock` и `audioLock`.

### 4. BitrateController

- Входы:
  - длина очереди отправки (видео и аудио, в мс PTS);
  - процент дропнутых кадров за последнее окно;
  - RTT (если доступно — из RTMP `setBufferLength`/`Acknowledgement`, опционально).
- Выход: целевой битрейт, переключаемый через `MediaCodec.setParameters(PARAMETER_KEY_VIDEO_BITRATE)` / `VTSessionSetProperty(kVTCompressionPropertyKey_AverageBitRate)`.
- Шаги: 100% → 75% → 50% → 33% (от выбранного preset). Возврат вверх — только после стабильного периода (например, 10 с с очередью < 200 мс и без дропов).
- Гистерезис: понижение быстрее повышения, чтобы не «качать».

### 5. Reconnect-политика

- При ошибке записи (`MS_ERR_IO`) или прерывании по `AVIOInterruptCB`:
  1. Перевод сессии в `MS_STATE_RECONNECTING`, событие `streamReconnecting(attempt)` в Dart.
  2. `RtmpPublisher::close()` (быстрый, использует `cancel_requested_` для немедленного выхода из любых висящих FFmpeg-вызовов).
  3. Exponential backoff: 1с → 2с → 4с, cap 8с, до 3 попыток. Между попытками очередь продолжает наполняться (по политике дропа).
  4. На каждой попытке — новый `RtmpPublisher::open` с теми же extradata.
  5. После успеха: `MS_STATE_STREAMING`, событие `streamReconnected`. После первого пакета на новом соединении — обязательный keyframe (запросить у энкодера через `MediaCodec.PARAMETER_KEY_REQUEST_SYNC_FRAME` / `kVTEncodeFrameOptionKey_ForceKeyFrame`).
  6. После исчерпания попыток: `MS_STATE_STOPPED`, событие `streamFailed(reason)`.

### 6. State machine

```
idle → connecting → streaming ⇄ reconnecting → streaming
                                            ↘ stopped
                       streaming  → stopped
```

- Переходы только через `StateMachine::transition_to`, новые события: `enter_reconnecting`, `exit_reconnecting`.
- В `reconnecting`: захват кадров не останавливается, push в очередь продолжается, writer-thread приостановлен.

### 7. События в Dart

- Расширить `StreamEvent`:
  ```
  StreamEvent {
    type: streaming | reconnecting | reconnected | failed | backpressure
    bitrate: int                // текущий целевой
    droppedFrames: int          // суммарно за сессию
    queueDepthMs: { video, audio }
    networkQuality: good | degraded | bad
    reconnectAttempt: int?      // только для reconnecting/failed
    reason: string?             // только для failed
  }
  ```
- Канал — `EventChannel` (см. задачу 18). Throttle на стороне native: не чаще 5 событий/сек, кроме критичных (`reconnecting`/`failed`/`reconnected` — мгновенно).

## Артефакты

- `native/src/network/packet_queue.{h,cpp}` — FIFO с drop-политикой.
- `native/src/network/writer_thread.{h,cpp}` — поток отправки, владеет `RtmpPublisher`.
- `native/src/network/bitrate_controller.{h,cpp}` — адаптивный битрейт.
- `native/src/session/reconnect_policy.{h,cpp}` — exp backoff, счётчик попыток.
- Изменения: `rtmp_publisher.cpp` (timeouts, interrupt_cb, `cancel_requested_`), `session.cpp` (push без сетевого I/O под глобальной мьютексой), `state_machine.{h,cpp}` (события reconnect).
- Android: `VideoEncoder.kt` (хук `requestKeyFrame()`), `StreamSession.kt` (убрать `synchronized` вокруг push, прокинуть `setVideoBitrate`).
- iOS: `H264Encoder.swift` (`forceKeyFrame()`, `setBitrate()`), `StreamSession.swift` (аналогично).
- Dart: расширенный `StreamEvent`, обновлённая публичная API-документация в `lib/`.

## Критерий приёмки

- Тест с `tc qdisc` (Linux) или Network Link Conditioner (iOS): искусственно ограниченная полоса 1 Мбит → битрейт стрима опускается шагами до стабильного уровня, обрывов нет, очередь не растёт неограниченно.
- Полная блокировка сети на 10–20 сек: после восстановления стрим продолжается без перезапуска приложения, первый пакет после reconnect — keyframe, в Dart прилетают события `reconnecting → reconnected`.
- Полная блокировка >30 сек (выходим за лимит реконнектов): в Dart прилетает `streamFailed`, экран стрима показывает уведомление, RTMP-сессия в `stopped`, ресурсы освобождены.
- 30-минутная сессия с периодическими подёргиваниями сети (mock): без crash, без зависшего UI, видео-дорожка не замораживается дольше, чем на интервал GOP.
- Юнит-тесты `packet_queue`: drop non-keyframe раньше keyframe, дроп аудио после исчерпания non-keyframe видео, корректная сериализация по PTS, без дедлоков под нагрузкой (stress-тест с двумя продюсерами и одним консьюмером).
- Юнит-тест `interrupt_callback`: при выставленном `cancel_requested_` `av_interleaved_write_frame` возвращается за < 100 мс на симулированном медленном сокете.
