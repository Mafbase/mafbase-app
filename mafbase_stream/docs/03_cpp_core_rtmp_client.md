# Задача 03: C++ ядро + RTMP-клиент

## Цель

Создать кросс-платформенное C++ ядро плагина с RTMP-клиентом на FFmpeg, которое умеет принимать H.264 NAL-юниты и AAC-фреймы и публиковать их в RTMP-сервер. Сборка и тесты — на десктопе, без эмулятора.

Объединено: «скелет C++ ядра» отдельно нечем тестировать, поэтому RTMP-клиент идёт в этой же задаче — финальная проверка через консоль.

## Связь с BRD

- §7.1 «Архитектура»: C++ ядро с GL-композитором, RTMP-клиентом, state machine.
- §7.2 «Ключевые библиотеки»: «RTMP-клиент: на старте — FFmpeg (libavformat)».
- §7.3 «Тестируемость»: «C++ ядро тестируется unit-тестами на десктопе через gtest, без эмуляторов».

## Содержание

1. `mafbase_stream/native/` с CMake-проектом:
   - библиотека `mafbase_stream_core` (статическая, .a/.lib);
   - зависимости: FFmpeg (libavformat, libavcodec, libavutil), gtest.
2. Публичный C-API ядра (для дальнейшего JNI/Obj-C++ bridge):
   - `ms_session_create`, `ms_session_start(rtmp_url, params)`, `ms_session_push_video(nalu, pts)`, `ms_session_push_audio(aac_frame, pts)`, `ms_session_stop`, `ms_session_destroy`.
3. State machine стрим-сессии: `idle → connecting → streaming → reconnecting → stopped` (без логики реконнекта пока — заглушки с переходами).
4. RTMP-клиент: обёртка над `avformat_alloc_output_context2("flv", ...)`, `avformat_write_header`, `av_interleaved_write_frame`.
5. gtest, который:
   - открывает заранее подготовленный H.264+AAC файл (или генерирует синтетический H.264 через `libavcodec` + тон);
   - публикует его кадры через C-API в `rtmp://localhost/live/test`;
   - проверяет, что nginx-rtmp принял поток (callback `on_publish` либо `stat.xml`).

## Критерий приёмки

- На macOS/Linux: `cmake --build build && ctest` — все тесты зелёные.
- В VLC, подключённом к `rtmp://localhost/live/test`, во время прогона теста виден тестовый поток (видео + звук).
- Поток корректно завершается, сессия переходит в `stopped`, закрывается без утечек (проверить через `valgrind` или ASan).

## Артефакты

- `native/CMakeLists.txt`, `native/include/mafbase_stream/*.h`, `native/src/`.
- `native/tests/test_rtmp_publish.cpp`.
- README в `native/` с инструкцией сборки и запуска тестов.
