# Задача 07: iOS — нативный экран и превью камеры

## Цель

Из Dart открывать modally нативный `UIViewController` с превью камеры (AVFoundation) в landscape. Аналог задачи 04, но для iOS.

## Связь с BRD

- §7.1: «iOS: Swift + AVFoundation + VideoToolbox. Открывает нативный UIViewController modally».
- §4.2 F2.1: горизонтальная ориентация.
- §5.3 NF3.2: iOS 14.0+.

## Содержание

1. В `ios/Classes/`: `StreamViewController.swift` с `AVCaptureSession` и `AVCaptureVideoPreviewLayer`.
2. Запрос разрешений через `AVCaptureDevice.requestAccess(.video)` и `.audio`.
3. В `Info.plist` example-приложения: `NSCameraUsageDescription`, `NSMicrophoneUsageDescription`.
4. MethodChannel-обработчик в `MafbaseStreamPlugin.swift` открывает контроллер через `UIApplication.shared.keyWindow?.rootViewController?.present(...)`.
5. Принудительная landscape-ориентация для контроллера (`supportedInterfaceOrientations`).
6. На экране — кнопка «Закрыть».

## Критерий приёмки

- На реальном iPhone (iOS 14+): из `example` открывается превью камеры, landscape.
- При первом запуске — системный диалог разрешений; при отказе экран не открывается, в Dart возвращается ошибка.
- Закрытие — корректное, без чёрного экрана / зависаний.

## Артефакты

- `ios/Classes/StreamViewController.swift`.
- `ios/Classes/MafbaseStreamPlugin.swift` (обновлённый).
- Пример настроек `Info.plist` в README плагина.
