# Задача 09: iOS — GL-композитор и полный RTMP-pipeline

## Цель

Соединить камеру → GL ES композитор → VideoToolbox → C++ ядро (через Obj-C++ bridge) → RTMP. С iPhone из `example` запускается стрим, виден в VLC через локальный nginx-rtmp.

## Связь с BRD

- §7.1: Obj-C++ bridge для подключения C++ ядра.
- §7.2: OpenGL ES 3.0 на обеих платформах для единообразия шейдеров.

## Содержание

1. **FFmpeg для iOS.** Аналогично `jniLibs/` на Android, кладём prebuilt
   xcframework-и `libavformat/libavcodec/libavutil/libswresample/libswscale`
   в `ios/Frameworks/ffmpeg/`. Источник — локальная сборка
   [arthenica/ffmpeg-kit](https://github.com/arthenica/ffmpeg-kit) (LGPL):
   готовых iOS-релизов в репо нет, поэтому в нём нужно один раз запустить
   `./ios.sh -x` (~30–60 мин). После этого
   `native/scripts/fetch_ffmpeg_ios.sh` копирует артефакты из
   `prebuilt/bundle-apple-xcframework-ios{,-lts}/` в `ios/Frameworks/ffmpeg/`.
   Путь к ffmpeg-kit задаётся переменной `MS_FFMPEG_KIT_SRC` (default —
   `~/Downloads/ffmpeg-kit-6.0.LTS`).
2. Сборка `mafbase_stream_core` под iOS-архитектуры (arm64, simulator-arm64) и
   упаковка в xcframework — `native/scripts/build_ios.sh`. CMake-сборка core
   видит FFmpeg-заголовки из `ios/Frameworks/ffmpeg/include/`; линковка
   FFmpeg делается уже Xcode'ом через `vendored_frameworks` в podspec.
3. Obj-C++ bridge `ios/Classes/Bridge/CoreBridge.{h,mm}` — тонкая Obj-C обёртка
   над `ms_session_*` (NSData payload'ы, ARC-safe). В podspec она объявлена
   `public_header_files`, чтобы Swift-часть видела её через автогенерируемый
   module map.
4. GL ES 3.0 композитор `ios/Classes/GL/Compositor.swift`: `EAGLContext`,
   `CVOpenGLESTextureCache` для входной BGRA-текстуры из `CVPixelBuffer`,
   passthrough-шейдер, FBO привязан к output `CVPixelBuffer` из
   `CVPixelBufferPool` (тоже через `CVOpenGLESTextureCache`). Точка
   расширения для оверлея в задаче 10.
5. Output `CVPixelBuffer` от композитора → `H264Encoder` (`VTCompressionSession`)
   → `CMSampleBuffer` с AVCC-NALU → bridge → `ms_session_push_video`.
   SPS/PPS извлекаются из `CMVideoFormatDescription` и передаются в
   `ms_session_start` как Annex-B; `RtmpPublisher` сам перепакует в avcC.
6. AAC-фреймы (как в задаче 08) → bridge → `ms_session_push_audio`.
   `AudioSpecificConfig` (2 байта) генерируется напрямую из ASBD —
   парсить magic cookie не нужно.
7. Оркестратор `ios/Classes/StreamSession.swift` — зеркальный Android-варианту,
   с общим `referencePtsUs` для AV-sync.
8. UI: `StreamViewController` получает кнопку «Стрим» рядом с «Запись»;
   запись и стрим взаимоисключающие. RTMP URL/key передаются из Dart через
   `MafbaseStreamPlugin.openStreamScreen(rtmpUrl:streamKey:)`.

## Критерий приёмки

- На реальном iPhone: запуск стрима из `example` → в VLC виден живой видеопоток с камеры со звуком.
- 5-минутная сессия без crash и без нарастающего расхода памяти (Xcode Instruments).
- Остановка корректно завершает RTMP (в логах nginx — `unpublish`).

## Артефакты

- `ios/Classes/Bridge/CoreBridge.mm`, `CoreBridge.h`.
- `ios/Classes/GL/Compositor.swift`.
- `ios/Classes/StreamSession.swift`.
- `native/scripts/fetch_ffmpeg_ios.sh` — выкачка ffmpeg-kit xcframework-ов.
- `native/scripts/build_ios.sh` — сборка `mafbase_stream_core.xcframework`.
- Обновлённые `mafbase_stream.podspec` (vendored frameworks) и
  `native/CMakeLists.txt` (поддержка iOS cross-compile).
