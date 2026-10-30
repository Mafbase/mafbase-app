# seating_generator_web

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Сборка на другой бэкенд

Мобильная сборка и отладочный запуск ходят на `mafbase.ru`. Другой хост задаётся при компиляции, например для стейджа:

```
fvm flutter run --dart-define=API_HOST=stage.mafbase.ru
```

Тот же флаг работает с `fvm flutter build`. Хост используют HTTP-клиент, сокеты рассадки и перехват возврата с оплаты в WebView. Веб-релиз берёт хост из адреса страницы и `API_HOST` не учитывает.
