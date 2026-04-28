# Задача 12: Локальная запись параллельно со стримом

## Цель

Параллельно с RTMP-публикацией писать тот же композитный кадр (камера + оверлей) и тот же аудиопоток в локальный MP4. Включается чекбоксом перед стартом.

## Связь с BRD

- §4.5 F5.1–F5.4: локальная запись, MP4 (H.264 + AAC), ровно тот же контент, что в стриме.
- §4.1 F1.4: проверка свободного места при включённой записи.

## Содержание

1. В C++ ядре — параллельный `Mp4Muxer` (FFmpeg `avformat_alloc_output_context2("mp4", ...)`), потребляющий те же NALU/AAC-фреймы, что и RTMP-клиент.
2. Опция `enableRecording` в параметрах сессии (`ms_session_start`).
3. Перед стартом — `MafbaseStream.checkFreeSpace(estimatedBytes)` через платформенный API; если места мало — Dart-ошибка с кодом `LOW_DISK_SPACE`.
4. Папка сохранения:
   - Android: `MediaStore.Video` или `getExternalFilesDir(DIRECTORY_MOVIES)`;
   - iOS: Documents directory + опционально сохранение в Photos через `PHPhotoLibrary`.
5. После остановки — путь к файлу в `StreamSummary`, передаётся в Dart, отображается на экране итогов (см. задачу 16).
6. Share через системный share sheet (`share_plus` или нативный intent/UIActivityViewController).

## Критерий приёмки

- На реальном устройстве (Android и iOS): стрим 1 минута с включённой записью → MP4 файл лежит на устройстве.
- Содержимое файла визуально идентично тому, что было в VLC (включая оверлей и анимации).
- При попытке старта с заполненной памятью — корректная ошибка, стрим не стартует.

## Артефакты

- `native/src/recorder/mp4_muxer.cpp`.
- Платформенные адаптеры `FreeSpaceChecker` на Android (Kotlin) и iOS (Swift).
- Обновление Dart API: `StreamParams { enableRecording: bool }`, `StreamSummary { recordingPath: String? }`.
