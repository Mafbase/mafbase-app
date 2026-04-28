# Задача 01: Локальный nginx-rtmp для тестов

## Цель

Поднять локальный RTMP-сервер, в который можно слать тестовые потоки во время разработки и принимать их любым плеером. Без этой инфраструктуры дальше тестировать стрим-pipeline нечем.

## Связь с BRD

- §7.3 «Тестируемость»: «E2E-тесты стрим-pipeline проводятся против локального nginx-rtmp».

## Содержание

1. Запустить nginx с модулем `nginx-rtmp` локально (через Docker или brew).
2. Открыть порт 1935 для приёма RTMP.
3. Через `ffmpeg` отправить в сервер тестовый pattern (`testsrc` + `sine`) на адрес `rtmp://localhost/live/test`.
4. Принять поток в VLC: `Media → Open Network Stream → rtmp://localhost/live/test`.
5. Записать инструкцию (Docker-compose / brew-команды / плейбук) в `mafbase_stream/docs/dev/local_rtmp_setup.md` так, чтобы любой разработчик команды поднял сервер за 5 минут.

## Критерий приёмки

- В VLC играется ffmpeg test-pattern с синусоидой (видео и звук).
- Документация воспроизводимо запускает сервер с чистого ноутбука.

## Артефакты

- `mafbase_stream/docs/dev/local_rtmp_setup.md`
- `mafbase_stream/dev/docker-compose.yml` (если используется Docker).
