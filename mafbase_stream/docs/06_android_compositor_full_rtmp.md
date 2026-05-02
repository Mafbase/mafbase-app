# Задача 06: Android — GL-композитор и полный RTMP-pipeline

## Цель

Соединить камеру → GL-композитор → MediaCodec → C++ ядро (через JNI) → RTMP. На Android-устройстве из `example` запускается стрим, который виден в VLC, подключённом к локальному nginx-rtmp.

## Связь с BRD

- §7.1: «Кадры видео НЕ пересекают границу Dart ↔ натив».
- §7.2: «Композитинг: OpenGL ES 3.0».
- §4.2 F2.4: «Отправка потока на указанный RTMP/RTMPS сервер».

## Содержание

1. JNI bridge `android/src/main/cpp/`:
   - сборка `mafbase_stream_core` под Android NDK (arm64-v8a, armeabi-v7a);
   - JNI-обёртка над C-API из задачи 03.
2. `GLES3 SurfaceTexture`: получаем кадр с камеры в текстуру, рисуем `OES_external` шейдером в offscreen FBO. Пока без оверлея — passthrough.
3. Выход FBO копируется в input-surface MediaCodec H.264 энкодера.
4. NAL-юниты с энкодера → JNI → `ms_session_push_video`.
5. AAC-фреймы (как в задаче 05) → `ms_session_push_audio`.
6. На экране настройки в `example` — поля «RTMP URL» и «Stream key» с дефолтом `rtmp://10.0.2.2/live` + `test` (для эмулятора) или `rtmp://<host-ip>/live` + `test` (для реального устройства).

## Критерий приёмки

- На реальном Android-устройстве: запуск стрима из `example` → в VLC на ноутбуке (через локальный nginx-rtmp) виден живой видеопоток с камеры со звуком.
- Латентность от движения перед камерой до картинки в VLC — в разумных пределах (несколько секунд, типично для RTMP).
- Остановка стрима из приложения корректно завершает сессию (в логах nginx — `unpublish`).
- 5-минутная сессия проходит без crash, без visible memory leak (`adb dumpsys meminfo`).

## Артефакты

- `android/src/main/cpp/CMakeLists.txt`, `jni_bridge.cpp`.
- `android/src/main/kotlin/.../gl/Compositor.kt`.
- `android/src/main/kotlin/.../StreamSession.kt` — оркестратор.
