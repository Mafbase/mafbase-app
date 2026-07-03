# Задача 05: Android — энкодер видео/аудио и локальный MP4

## Цель

В нативном `StreamActivity` реализовать аппаратное кодирование H.264 (MediaCodec) и AAC (MediaCodec) кадров с камеры/микрофона и сохранение в MP4-файл через `MediaMuxer`. Это позволит проверить корректность энкодера и аудиозахвата отдельно от RTMP.

## Связь с BRD

- §7.2: «Энкодинг: аппаратный — MediaCodec (Android)».
- §4.2 F2.3: «Кодирование видео в H.264, аудио в AAC».
- §4.5 F5.3: «Формат записи — MP4 (H.264 + AAC)».

## Содержание

1. `MediaCodec` H.264-энкодер: вход — `Surface` от Camera2 (`createInputSurface`), выход — NAL-юниты.
2. `AudioRecord` + `MediaCodec` AAC-энкодер: захват с встроенного микрофона (mono, 44.1 kHz).
3. `MediaMuxer` MP4: объединить два потока, корректно проставлять PTS.
4. На экране — кнопка «Запись». При нажатии: started recording → файл в `getExternalFilesDir(Environment.DIRECTORY_MOVIES)`. Повторное нажатие — стоп и сохранение.
5. После остановки — toast с путём к файлу и MIME-type-share через `Intent.ACTION_SEND` (опционально для проверки).

## Критерий приёмки

- На реальном Android-устройстве: запись 30 секунд → MP4 проигрывается в галерее устройства и на десктопе (VLC).
- В файле есть и видео, и звук, AV-синхронизация в пределах ±100 мс.
- При повороте устройства / пропадании discrete focus запись не падает.

## Артефакты

- `android/src/main/kotlin/.../encoder/VideoEncoder.kt`, `AudioEncoder.kt`, `Mp4Recorder.kt`.
- README с примечаниями по выбранному цветовому формату (`COLOR_FormatSurface`) и keyframe interval.
