# mafbase_stream

Flutter-плагин стриминга и записи видео.

## iOS — нативный экран превью камеры (задача 07)

`MafbaseStream.openStreamScreen()` поднимает нативный `StreamViewController`
modally в полноэкранном режиме. Экран запускает `AVCaptureSession`
(основная камера + микрофон), показывает превью через
`AVCaptureVideoPreviewLayer` и принудительно держится в landscape
(`supportedInterfaceOrientations = .landscape`). Кнопка «Закрыть» в правом
верхнем углу dismiss'ит контроллер; Dart-`Future` разрешается. При первом
запуске запрашиваются разрешения `.video` и `.audio` через
`AVCaptureDevice.requestAccess`; при отказе экран не открывается, в Dart
прилетает `PlatformException(code: 'PERMISSIONS_DENIED')`.

Минимальная iOS — **14.0** (NF3.2). В `Info.plist` приложения, использующего
плагин, нужно прописать описание для системных диалогов разрешений:

```xml
<key>NSCameraUsageDescription</key>
<string>Доступ к камере нужен для предпросмотра и стрима видео.</string>
<key>NSMicrophoneUsageDescription</key>
<string>Доступ к микрофону нужен для записи звука во время стрима.</string>
```

Передача RTMP URL и stream key через аргументы метода зарезервирована
(аналогично Android), но на iOS пока используется только превью + локальная
запись MP4 — без публикации в RTMP (задача 09).

## iOS — энкодер видео/аудио и локальный MP4 (задача 08)

### Архитектура

`StreamViewController` поверх `AVCaptureSession` добавляет два data output'а
(`AVCaptureVideoDataOutput` + `AVCaptureAudioDataOutput`) и оркестратор
[`Mp4Recorder`](ios/Classes/Encoder/Mp4Recorder.swift), который соединяет
два аппаратных энкодера c `AVAssetWriter`:

- **`H264Encoder`** — `VTCompressionSession`, вход — `CVPixelBuffer` (BGRA от
  camera), выход — `CMSampleBuffer` с H.264 NAL в AVCC-формате; format
  description содержит готовый `avcC`-extradata.
- **`AacEncoder`** — `AudioConverter` (AudioToolbox), вход — interleaved PCM
  int16 (как выдаёт `AVCaptureAudioDataOutput`), выход — AAC LC по 1024
  семпла на фрейм; format description содержит magic cookie (ESDS).
- **`AVAssetWriter`** в `.mp4` режиме — два `AVAssetWriterInput` в passthrough
  (`outputSettings = nil`, `sourceFormatHint = formatDescription`), без
  повторного транскода.

Энкодеры выдают готовые `CMSampleBuffer` независимо от writer'а — в задаче 09
тот же `H264Encoder` и `AacEncoder` будут переиспользованы для отправки сырых
NAL/AAC-фреймов в RTMP без перекодирования.

### Параметры энкодера

| Параметр                                          | Значение                              | Заметка                                                                     |
|---------------------------------------------------|---------------------------------------|-----------------------------------------------------------------------------|
| Видео codec                                       | `kCMVideoCodecType_H264`              |                                                                             |
| Размер                                            | 1280×720 (sessionPreset `.hd1280x720`)| фиксирован, чтобы `CVPixelBuffer` совпадал с размерами `VTCompressionSession` |
| Pixel format                                      | `kCVPixelFormatType_32BGRA`           |                                                                             |
| `kVTCompressionPropertyKey_RealTime`              | `true`                                | low-latency: VideoToolbox не накапливает кадры дольше необходимого           |
| `kVTCompressionPropertyKey_ProfileLevel`          | `H264_High_AutoLevel`                 |                                                                             |
| `kVTCompressionPropertyKey_AllowFrameReordering`  | `false`                               | без B-кадров — DTS == PTS, что нужно для RTMP (задача 09)                   |
| `kVTCompressionPropertyKey_AverageBitRate`        | 4 000 000                             |                                                                             |
| `kVTCompressionPropertyKey_ExpectedFrameRate`     | 30                                    |                                                                             |
| `kVTCompressionPropertyKey_MaxKeyFrameInterval`   | 60 (= 30 × 2 секунды)                 | дублируется и в секундах через `MaxKeyFrameIntervalDuration`                |
| Аудио формат                                      | `kAudioFormatMPEG4AAC` (AAC LC)        |                                                                             |
| Sample rate                                       | равен `AVCaptureAudioDataOutput`-format | iPhone обычно 44 100 Hz                                                     |
| Каналы                                            | равны `AVCaptureAudioDataOutput`-format | iPhone обычно mono                                                          |
| Аудио bitrate                                     | 64 000                                | `kAudioConverterEncodeBitRate`                                              |

### PTS

- Источник времени для обеих дорожек — общий `mach_absolute_time` (`AVCaptureSession`
  пишет одну шкалу во все sample buffers). Этого достаточно для AV-sync ±100 мс.
- `Mp4Recorder` берёт `t0 = pts` первого закодированного сэмпла любой дорожки,
  вызывает `writer.startSession(atSourceTime: .zero)` и нормализует все последующие
  PTS как `pts - t0` через `CMSampleBufferCreateCopyWithNewTiming`.
- AAC PTS на стороне `AacEncoder` считается монотонно от первого PCM-сэмпла:
  `pts_n = pts_0 + n × 1024 / sampleRate`.

### Файл и шеринг

Запись пишется в `Documents/` приложения под именем
`mafbase_stream_<yyyyMMdd_HHmmss>.mp4`. После остановки `StreamViewController`
показывает алерт с кнопкой «Поделиться», которая открывает
`UIActivityViewController` с готовым файлом.

### Жизненный цикл

- Старт записи кнопкой «Запись» — создаём `Mp4Recorder`, готовим
  `H264Encoder` сразу (размеры известны), `AacEncoder` — лениво при первом
  PCM-сэмпле (нужен ASBD от микрофона).
- Стоп кнопкой «Стоп» — `videoEncoder.finish()` (`VTCompressionSessionCompleteFrames`)
  + `audioEncoder.finish()` дренируют буферизованные кадры синхронно, после
  чего `markAsFinished` на оба `AVAssetWriterInput` и асинхронный
  `writer.finishWriting`.
- При входящем звонке / Control Center — `AVAudioSession.interruptionNotification`
  с типом `.began` приводит к корректной остановке записи: файл валидно
  закрывается через `finishWriting`.

## Android — RTMP-стрим (задача 06)

Полный pipeline: камера → GL-композитор (passthrough OES → FBO) → MediaCodec H.264 →
JNI → C++ ядро `mafbase_stream_core` → libavformat → RTMP. Аудио — `AudioRecord` +
MediaCodec AAC LC → JNI → ядро.

Кнопка **«Стрим»** в `StreamActivity` стартует/останавливает сессию. URL и stream key
передаются через `MafbaseStream.openStreamScreen(rtmpUrl: ..., streamKey: ...)`, дефолты —
`rtmp://10.0.2.2/live` + `test` (для эмулятора). На реальном устройстве укажите IP машины,
на которой поднят nginx-rtmp (см. `dev/docker-compose.yml`).

### FFmpeg (manual подключение)

Нативная сторона линкуется с FFmpeg напрямую — без AAR, без prefab. Это решает
проблему с уходом `com.arthenica:ffmpeg-kit-*` из Maven Central и убирает зависимость
от prefab-метаданных.

Что лежит в репозитории плагина:

- `mafbase_stream/android/src/main/cpp/third_party/ffmpeg/include/` — заголовки FFmpeg
  (`libavformat/`, `libavcodec/`, `libavutil/`, `libswscale/`, `libswresample/`, `config.h`).
- `mafbase_stream/android/src/main/jniLibs/<abi>/lib{avformat,avcodec,avutil,swscale,swresample}.so` —
  готовые рантайм-библиотеки для `arm64-v8a` и `armeabi-v7a`.

Gradle автоматически упаковывает `jniLibs/` в финальный APK/AAR. CMakeLists.txt подключает
`.so` как IMPORTED-таргеты и линкует их со статическим `mafbase_stream_core` и shared
`libmafbase_stream_jni.so`.

#### Откуда взять обновлённые .so и headers

```bash
git clone --depth 1 --branch v6.0.LTS https://github.com/arthenica/ffmpeg-kit.git
cd ffmpeg-kit
ANDROID_SDK_ROOT="$HOME/Library/Android/sdk" \
  ANDROID_NDK_ROOT="$HOME/Library/Android/sdk/ndk/26.3.11579264" \
  ./android.sh --api-level=24 --enable-android-zlib --enable-android-media-codec
```

После сборки (≈1–2 часа):

- `prebuilt/android-arm64/ffmpeg/include/` → `mafbase_stream/android/src/main/cpp/third_party/ffmpeg/include/`
- `prebuilt/android-arm64/ffmpeg/lib/lib*.so` → `mafbase_stream/android/src/main/jniLibs/arm64-v8a/`
- `prebuilt/android-arm/ffmpeg/lib/lib*.so` → `mafbase_stream/android/src/main/jniLibs/armeabi-v7a/`

NDK r26+ убрал toolchain для API < 21, поэтому флаг `--lts` не работает; используйте
`--api-level=24` (= наш `minSdk`). При этом могут потребоваться warning-suppress в
`android/jni/Android.mk` (`-Wno-single-bit-bitfield-constant-conversion -Wno-incompatible-function-pointer-types -Wno-deprecated-declarations`).

### NDK сборка

`mafbase_stream/android/CMakeLists.txt` собирает:

- `mafbase_stream_core` (статическая) — переиспользует исходники из `native/src/`.
- `libmafbase_stream_jni.so` — `android/src/main/cpp/jni_bridge.cpp` поверх C-API
  ядра. Загружается из `StreamSessionNative` через `System.loadLibrary("mafbase_stream_jni")`.

ABI-фильтры: `arm64-v8a`, `armeabi-v7a`. Для эмулятора x86_64 текущая конфигурация
не подходит — нативный код не собирается.

### GL-композитор

`gl/Compositor.kt` живёт в собственном HandlerThread. Камера пишет в SurfaceTexture
(GL_TEXTURE_EXTERNAL_OES), композитор:

1. `updateTexImage()` — забирает кадр в OES.
2. Рисует passthrough-шейдером в offscreen FBO (2D-текстура, RGBA8).
3. Если подключён encoder Surface — повторно рисует FBO в EGL-окно, выставляет
   `eglPresentationTimeANDROID` равным `SurfaceTexture.timestamp` и swapBuffers.

Оверлеи в задаче 06 не реализованы — слот для них уже есть (FBO между OES и encoder).

### Передача NAL/AAC через JNI

`StreamSession` собирает обе extradata (SPS+PPS из `MediaFormat.csd-0/1`,
AudioSpecificConfig из `csd-0` AAC), вызывает `ms_session_start()` через JNI один раз
после готовности обеих, и затем стримит закодированные access unit-ы / aud-кадры через
direct ByteBuffer (нулевое копирование). MediaCodec иногда возвращает heap-buffer —
в этом случае используется per-thread direct scratch-буфер.

## Android — энкодер видео/аудио и локальный MP4 (задача 05)

### Архитектура

`StreamActivity` показывает Camera2-превью и предоставляет кнопку «Запись».
При старте записи запускается `Mp4Recorder`, который оркестрирует:

- **`VideoEncoder`** — `MediaCodec` H.264 с входом через `createInputSurface()`.
  Surface добавляется в Camera2 capture session как второй target вместе с превью,
  что позволяет камере писать те же кадры одновременно в превью и в энкодер
  без дополнительных копирований через CPU.
- **`AudioEncoder`** — `AudioRecord` (микрофон, mono, 44.1 kHz, 16-bit PCM)
  + `MediaCodec` AAC LC, 128 kbps.
- **`MediaMuxer`** в режиме `MUXER_OUTPUT_MPEG_4` — объединяет видео и аудио треки.

### Параметры энкодера

| Параметр              | Значение                                    | Заметка                                                        |
|-----------------------|---------------------------------------------|----------------------------------------------------------------|
| Видео MIME            | `video/avc`                                 |                                                                |
| Размер                | совпадает с preview (≤1920×1080 16:9)       | один кадр от камеры идёт в обе цели                            |
| Цветовой формат       | `COLOR_FormatSurface`                       | обязательный при использовании `createInputSurface()` — данные не проходят через CPU |
| FPS                   | 30                                          |                                                                |
| Bitrate               | 4 000 000 (VBR)                             |                                                                |
| I-frame interval      | **2 секунды**                               | компромисс: чаще keyframe → больше размер, реже → дольше восстановление при потере |
| Аудио MIME            | `audio/mp4a-latm`                           | AAC LC                                                         |
| Sample rate           | 44 100 Hz                                   |                                                                |
| Каналы                | 1 (mono)                                    |                                                                |
| Аудио bitrate         | 128 000                                     |                                                                |

### PTS

- Видео: encoder заполняет `presentationTimeUs` из меток времени Surface
  (по умолчанию — `SystemClock.elapsedRealtimeNanos()`). `Mp4Recorder` зануляет
  PTS относительно первого закодированного кадра.
- Аудио: PTS считается как `totalSamples * 1_000_000 / sampleRate` — независимая
  от системного времени монотонная шкала. Также зануляется относительно первого
  кадра аудио. Допустимое расхождение AV — в пределах ±100 мс.

### Файл

Запись пишется в `getExternalFilesDir(Environment.DIRECTORY_MOVIES)` под именем
`mafbase_stream_<yyyyMMdd_HHmmss>.mp4`. После остановки показывается toast с путём
и предлагается share через `Intent.ACTION_SEND` (`FileProvider`,
authority = `${applicationId}.mafbase_stream.fileprovider`).

### Жизненный цикл

- Старт записи: текущая capture session (preview-only, `TEMPLATE_PREVIEW`)
  закрывается, создаётся новая с обоими таргетами и `TEMPLATE_RECORD`,
  что включает `CONTROL_AF_MODE_CONTINUOUS_VIDEO`.
- Стоп: симметрично — энкодеры получают `signalEndOfStream`, дренаж завершается
  по `BUFFER_FLAG_END_OF_STREAM`, muxer закрывается на фоновом потоке, после чего
  возвращается preview-only сессия.
- При `onPause` (например, поворот не происходит — `screenOrientation="landscape"`,
  но возможен уход в фон) запись останавливается синхронно, чтобы файл не
  остался повреждённым.
