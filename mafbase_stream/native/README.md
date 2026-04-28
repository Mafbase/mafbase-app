# mafbase_stream — C++ ядро

Кросс-платформенное C++ ядро плагина: RTMP-клиент на FFmpeg + state machine
стрим-сессии. Под Android/iOS подключается через JNI/Obj-C++ bridge (см. задачи
06/09), на десктопе собирается отдельно для unit/integration тестов.

## Состав

```
native/
├── include/mafbase_stream/session.h   # публичный C-API
├── src/
│   ├── session.cpp                    # реализация C-API
│   ├── state_machine.{h,cpp}          # idle → connecting → streaming → reconnecting → stopped
│   ├── rtmp_publisher.{h,cpp}         # обёртка над libavformat (flv-muxer)
│   └── log.{h,cpp}                    # минимальный логгер
├── tests/test_rtmp_publish.cpp        # gtest: синтетический H.264+AAC → RTMP
└── CMakeLists.txt
```

## Зависимости (macOS / Linux)

- CMake ≥ 3.20
- pkg-config
- FFmpeg (libavformat, libavcodec, libavutil, libswscale, libswresample) с
  поддержкой `libx264` и `aac` энкодера — нужны для теста.
- GoogleTest подтягивается автоматически через CMake `FetchContent`.

macOS:

```bash
brew install cmake pkg-config ffmpeg
```

Ubuntu:

```bash
sudo apt install cmake pkg-config libavformat-dev libavcodec-dev libavutil-dev \
                 libswscale-dev libswresample-dev libx264-dev
```

## Сборка

```bash
cd mafbase_stream/native
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build -j
```

## Запуск тестов

Перед запуском интеграционного теста должен быть поднят локальный nginx-rtmp
(см. `mafbase_stream/dev/docker-compose.yml`):

```bash
cd mafbase_stream/dev && docker compose up -d
```

Запуск всех тестов:

```bash
cd mafbase_stream/native/build
ctest --output-on-failure
```

Если nginx-rtmp недоступен, RTMP-тест помечается `SKIPPED`, остальные
state-machine тесты отрабатывают всегда.

### ASan (опционально)

```bash
cmake -S . -B build-asan -DCMAKE_BUILD_TYPE=Debug -DMAFBASE_STREAM_ENABLE_ASAN=ON
cmake --build build-asan -j
ASAN_OPTIONS="detect_leaks=0:halt_on_error=1" ctest --test-dir build-asan --output-on-failure
```

> На Apple Silicon LeakSanitizer не поддерживается, поэтому
> `detect_leaks=0` обязателен. На Linux флаг можно убрать.

## Что проверяет интеграционный тест

`RtmpPublishTest.PublishesSyntheticH264AndAac`:

1. Открывает `libx264` и `aac` энкодеры FFmpeg.
2. Генерирует 2 секунды синтетического видео (320×240, 30 fps, движущийся
   прямоугольник) и тон 440 Гц.
3. Публикует кадры через C-API в `rtmp://localhost/live/test` с реалтайм-пейсингом.
4. Поллит `http://localhost:8080/stat` и проверяет, что nginx видит активную
   публикацию `live/test`.
5. Корректно завершает сессию (`stop` → `stopped`, повторный `stop` —
   идемпотентен).

## Публичный C-API (кратко)

```c
ms_session* s = ms_session_create();
ms_session_params p = { .width = 1280, .height = 720, .fps = 30, ... };
ms_session_start(s, "rtmp://...", &p);
ms_session_push_video(s, nalu, nalu_size, pts_us, is_keyframe);
ms_session_push_audio(s, aac, aac_size, pts_us);
ms_session_stop(s);
ms_session_destroy(s);
```

Полная сигнатура — в `include/mafbase_stream/session.h`.
