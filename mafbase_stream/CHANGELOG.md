## [UNRELEASED]

- Добавлены SwiftUI-плашки игроков для iOS-стрима (overlay `plashki-mafbase`): фото с saturation-фильтром по статусу, иконки роли и статуса, лейбл «Убит/Заголосован/Дисквалифицирован», ник и номер, реалтайм-подписка на seatingContent через WebSocket — визуально идентично Android-версии.
- Compositor на iOS теперь единственный источник правды видео-пайплайна: камера → compositor → preview (`AVSampleBufferDisplayLayer`) + запись MP4 + RTMP-стрим. Overlay видим во всех трёх выходах одновременно, как на Android.
- iOS API упрощён: overlay'и встроены в плагин и выбираются через enum `MafbaseOverlay` — приложение больше не регистрирует фабрики (как на Android).
- Добавлен механизм наложения нативной overlay-view поверх кадра камеры в RTMP-стриме.
- Добавлен экран «Open overlay preview» (`MafbaseStream.openOverlayPreview`) — нативный экран превью overlay-view без камеры и стрима, для отладки вёрстки.
- Добавлен нативный iOS-экран превью камеры (AVFoundation, landscape) с системным запросом разрешений на камеру и микрофон.
- Добавлена запись MP4 на Android через MediaCodec H.264 + AAC и MediaMuxer.
- Добавлена кнопка «Запись» в нативном экране стрима, по окончании показывается путь к файлу и предлагается share.
- Добавлен RTMP-стрим с Android: камера → GL-композитор → MediaCodec → JNI → C++ ядро → libavformat. Поток виден в VLC через локальный nginx-rtmp.
- Добавлена кнопка «Стрим» в нативном экране стрима и поля «RTMP URL» / «Stream key» в example-приложении (дефолты: `rtmp://10.0.2.2/live`, `test`).
- Добавлен RTMP-стрим с iOS: камера → GL ES 3.0 passthrough-композитор → VideoToolbox → Obj-C++ bridge → C++ ядро → libavformat.

## 0.0.1

* TODO: Describe initial release.
