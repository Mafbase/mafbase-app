# Локальный nginx-rtmp для разработки

## Зачем это нужно

Плагин `mafbase_stream` строит RTMP-pipeline (захват камеры/экрана → композитор → энкодер → отправка по RTMP). Чтобы проверять каждый этап pipeline без живого стрима на реальный сервер, в команде используется локальный nginx с модулем `nginx-rtmp`. Сервер принимает поток на `rtmp://localhost/live/<key>` и отдаёт его обратно любому плееру (VLC, ffplay) или через HLS в браузер.

Это требование зафиксировано в BRD проекта (§7.3 «Тестируемость»): «E2E-тесты стрим-pipeline проводятся против локального nginx-rtmp». Поднимать сервер должен уметь любой разработчик команды за 5 минут с чистого ноутбука. Вся конфигурация лежит рядом — в `mafbase_stream/dev/`.

## Что понадобится

- **Docker** + Docker Compose (предпочтительный путь, работает одинаково на macOS / Linux / Windows).
- **ffmpeg** — для отправки тестового pattern (`brew install ffmpeg` на macOS).
- **VLC** — для приёма потока (`brew install --cask vlc` или с [videolan.org](https://www.videolan.org/)).

## Запуск через Docker (рекомендуется)

Из корня плагина:

```bash
cd mafbase_stream/dev
docker compose up -d
```

Что произойдёт:

- Поднимется контейнер `mafbase-nginx-rtmp` на образе `tiangolo/nginx-rtmp`.
- Порт `1935` (RTMP) и `8080` (HTTP — статус и HLS) пробрасываются на хост.
- Конфиг `nginx.conf` маунтится из текущего каталога read-only — правки в файле подхватываются после `docker compose restart`.

Проверить что сервер жив:

```bash
curl http://localhost:8080/
# mafbase-nginx-rtmp is up

# Статус-страница со списком активных стримов:
open http://localhost:8080/stat
```

## Альтернатива через Homebrew (fallback, только macOS)

Если Docker по каким-то причинам недоступен — на macOS можно собрать nginx с модулем rtmp вручную:

```bash
brew tap denji/nginx
brew install nginx-full --with-rtmp-module
```

Дальше нужно подсунуть наш `nginx.conf` (см. `mafbase_stream/dev/nginx.conf`) в `/usr/local/etc/nginx/nginx.conf` и запустить `brew services start nginx-full`. Этот путь поддерживается на «всякий случай» — основной сценарий разработки команды это Docker.

## Отправка тестового pattern через ffmpeg

ffmpeg умеет генерировать видео-`testsrc` (движущиеся цветные полосы с таймером) и аудио-`sine` (чистый тон 1 кГц) без камеры/микрофона. Команда:

```bash
ffmpeg -re \
  -f lavfi -i "testsrc=size=1280x720:rate=30" \
  -f lavfi -i "sine=frequency=1000:sample_rate=44100" \
  -c:v libx264 -preset veryfast -tune zerolatency -pix_fmt yuv420p -g 60 -b:v 2500k \
  -c:a aac -b:a 128k -ar 44100 \
  -f flv rtmp://localhost/live/test
```

Пояснения:

- `-re` — читать вход с реальной скоростью (иначе ffmpeg зальёт всё за секунду).
- `testsrc` + `sine` — синтетические источники, не нужны камера/микрофон.
- `-tune zerolatency`, `-g 60` — низкая задержка, ключевой кадр каждые 2 с.
- `-f flv` — RTMP принимает контейнер FLV.
- `rtmp://localhost/live/test` — application `live` (см. `nginx.conf`), ключ потока `test`.

## Приём потока в VLC

1. Запустить VLC.
2. `Media → Open Network Stream...` (на macOS: `File → Open Network...`).
3. Ввести URL: `rtmp://localhost/live/test`.
4. Нажать `Play`.

Через 1–3 секунды должно появиться видео `testsrc` с таймером и слышаться синусоида 1 кГц.

Альтернативно — через ffplay из консоли:

```bash
ffplay -fflags nobuffer rtmp://localhost/live/test
```

Или через HLS прямо в браузере (через `<video>` плеер с поддержкой HLS, например [hls.js demo](https://hls-js.netlify.app/demo/)):

```
http://localhost:8080/hls/test.m3u8
```

> HLS добавляет ~5–10 секунд задержки относительно RTMP — это нормально, формат сегментный.

## Troubleshooting

### Порт 1935 или 8080 занят

```
Error starting userland proxy: listen tcp4 0.0.0.0:1935: bind: address already in use
```

Кто-то уже слушает порт. Найти и остановить:

```bash
lsof -nP -iTCP:1935 -sTCP:LISTEN
lsof -nP -iTCP:8080 -sTCP:LISTEN
```

Либо переопределить порт в `docker-compose.yml` (например `"11935:1935"`), и тогда отправлять стрим на `rtmp://localhost:11935/live/test`.

### Docker Desktop не запущен

```
Cannot connect to the Docker daemon at unix:///var/run/docker.sock
```

Запустить Docker Desktop (macOS) или `sudo systemctl start docker` (Linux).

### ffmpeg не находит libx264

Установить полную сборку: `brew install ffmpeg` (на macOS базовый brew-пакет уже содержит `libx264`). Если всё равно нет — `ffmpeg -encoders | grep 264` должен показать `libx264`.

### VLC не открывает поток (Connection failed)

- Проверить что ffmpeg реально шлёт данные — в его логах должны бегать `frame=`/`bitrate=`.
- Проверить статус-страницу `http://localhost:8080/stat` — там должен появиться активный publisher на application `live`.
- Убедиться что URL ровно `rtmp://localhost/live/test` без лишнего `/` или порта.
- На некоторых билдах VLC RTMP по умолчанию выключен — попробовать `rtmp://localhost:1935/live/test`.

### Видео есть — звука нет

ffmpeg по умолчанию не подмешивает аудио, если не задан явный `-i sine=...`. Проверить что во второй `-i` действительно `lavfi sine`.

### Поток подключается, но статус-страница и плееры пустые

`nginx.conf` намеренно использует `worker_processes 1`. Модуль `nginx-rtmp` хранит состояние сессий в памяти worker'а и не синхронизирует его между процессами — при `worker_processes auto` RTMP-publish прилетает в один worker, а HTTP-запрос статуса/чтение — в другой, и никто никого не видит. Не возвращайте `auto`.

## Остановка и очистка

```bash
cd mafbase_stream/dev

# Остановить, контейнер останется
docker compose stop

# Полностью снести контейнер
docker compose down

# Снести вместе с висящими volume'ами и сетью (если нужно начисто)
docker compose down -v
```

ffmpeg-публикация останавливается через `Ctrl+C` в его терминале.
