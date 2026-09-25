#!/bin/zsh
# RTMP-приёмник на ffmpeg в режиме сервера: принимает rtmp://<host>:1935/live/test,
# пишет каждую сессию в received_N.flv и перезапускается после её окончания.
# Использование: rtmp_server.sh [рабочий каталог]
WORK=${1:-${STREAM_REGRESSION_DIR:-/tmp/mafbase_stream_regression}}
mkdir -p "$WORK"
echo $$ > "$WORK/rtmp_server.pid"
n=0
while true; do
  n=$((n+1))
  echo "[$(date +%H:%M:%S)] listener #$n waiting on rtmp://0.0.0.0:1935/live/test" >> "$WORK/rtmp_server.log"
  ffmpeg -hide_banner -loglevel info -listen 1 -i rtmp://0.0.0.0:1935/live/test -c copy -f flv -y "$WORK/received_$n.flv" >> "$WORK/rtmp_ffmpeg_$n.log" 2>&1
  echo "[$(date +%H:%M:%S)] listener #$n ended" >> "$WORK/rtmp_server.log"
  sleep 1
done
