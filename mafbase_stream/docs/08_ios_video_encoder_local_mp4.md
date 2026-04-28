# Задача 08: iOS — энкодер видео/аудио и локальный MP4

## Цель

В нативном `StreamViewController` реализовать аппаратное кодирование H.264 (VideoToolbox) и AAC (AudioToolbox), сохранение в MP4 через `AVAssetWriter`. Изолированная проверка энкодера до RTMP.

## Связь с BRD

- §7.2: «Энкодинг: аппаратный — VideoToolbox (iOS)».
- §4.2 F2.3, §4.5 F5.3.

## Содержание

1. `VTCompressionSession` H.264-энкодер: вход — `CVPixelBuffer` от `AVCaptureVideoDataOutput`, выход — CMSampleBuffer с NALU.
2. Аудио: `AVCaptureAudioDataOutput` + `AudioConverter` для AAC, либо `AVAssetWriter` принимает PCM и кодирует сам.
3. `AVAssetWriter` MP4: видео + аудио треки, корректные `CMTime`.
4. Кнопка «Запись» в `StreamViewController`. После остановки — путь к файлу в Documents directory + share через `UIActivityViewController` (опционально).

## Критерий приёмки

- На реальном iPhone: запись 30 секунд → MP4 проигрывается в Files / Photos.
- AV-синхронизация в пределах ±100 мс.
- При входящем звонке (или Control Center) запись корректно паузится/завершается, файл валиден.

## Артефакты

- `ios/Classes/Encoder/H264Encoder.swift`, `AacEncoder.swift`, `Mp4Recorder.swift`.
- README с заметками по `kVTCompressionPropertyKey_AverageBitRate`, `kVTCompressionPropertyKey_RealTime`.
