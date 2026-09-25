#!/bin/bash
# Регресс lifecycle-сценариев mafbase_stream на Android через example-приложение плагина.
#
# Использование: lifecycle_suite.sh [apk] [serial]
#   apk    — по умолчанию mafbase_stream/example/build/app/outputs/flutter-apk/app-debug.apk
#   serial — по умолчанию emulator-5554
# Переменные окружения:
#   RTMP_URL              — адрес приёмника с точки зрения устройства (по умолчанию rtmp://10.0.2.2/live,
#                           для реального телефона — rtmp://<IP Mac в LAN>/live)
#   STREAM_REGRESSION_DIR — рабочий каталог для логов и принятых потоков (/tmp/mafbase_stream_regression)
#   SKIP_SCREEN_OFF=1     — пропустить сценарий с выключением экрана (устройство с PIN не разблокируется)
# Требует: adb, ffmpeg; экран 1080x2400 (координаты тапов по example-приложению).
set -u
SKILL_DIR=$(cd "$(dirname "$0")/.." && pwd)
REPO=$(cd "$SKILL_DIR/../../.." && pwd)
APK=${1:-$REPO/mafbase_stream/example/build/app/outputs/flutter-apk/app-debug.apk}
S=${2:-emulator-5554}
RTMP_URL=${RTMP_URL:-rtmp://10.0.2.2/live}
WORK=${STREAM_REGRESSION_DIR:-/tmp/mafbase_stream_regression}
mkdir -p "$WORK"
PKG=com.example.mafbase_stream_example
STREAM_ACT="$PKG/com.example.mafbase_stream.StreamActivity"
LOG="$WORK/suite_$(date +%Y%m%d_%H%M%S).log"
PASS=0; FAIL=0

a() { adb -s "$S" shell "$@" 2>/dev/null; }
say() { echo "$*" | tee -a "$LOG"; }
check() { if [ "$2" -eq 0 ]; then PASS=$((PASS+1)); say "  PASS  $1"; else FAIL=$((FAIL+1)); say "  FAIL  $1"; fi; }
top() { a dumpsys activity activities | grep -m1 topResumedActivity | sed 's/.*u0 //' | cut -d' ' -f1; }
fgs() { a dumpsys activity services $PKG | grep -oE 'isForeground=[a-z]*' | head -1; }
notifs() { a dumpsys notification --noredact | grep -c "NotificationRecord.*pkg=$PKG"; }
# Открытые камеры в текущей секции dumpsys media.camera (история прошлых сессий отрезается).
cam_open() { a dumpsys media.camera | sed '/previous open session/,$d' | grep -c 'is open. Client instance dump'; }
latest_flv() { ls -t "$WORK"/received_*.flv 2>/dev/null | head -1; }
fsz() { stat -f %z "$1" 2>/dev/null || echo 0; }
growth() { local f; f=$(latest_flv); local b; b=$(fsz "$f"); sleep "$1"; f=$(latest_flv); echo $(( $(fsz "$f") - b )); }
plog() { adb -s "$S" logcat -d -v time 2>/dev/null | grep -E " [DIWE]/(StreamPipeline|CameraController|StreamingController|RecordingController|CompositorHost|StreamForegroundService|StreamActivity|Compositor|ms\.[a-z_]+)\("; }

ui_dump() { local i; for i in 1 2 3 4; do
    a uiautomator dump /sdcard/ui.xml >/dev/null; adb -s "$S" pull /sdcard/ui.xml "$WORK/ui.xml" >/dev/null 2>&1 && grep -q "<node" "$WORK/ui.xml" && { echo "$WORK/ui.xml"; return; }
    sleep 1; done; echo ""; }
bounds_center() { grep -oE 'bounds="\[[0-9]+,[0-9]+\]\[[0-9]+,[0-9]+\]"' | head -1 | sed -E 's/.*\[([0-9]+),([0-9]+)\]\[([0-9]+),([0-9]+)\].*/\1 \2 \3 \4/' | awk '{printf "%d %d", ($1+$3)/2, ($2+$4)/2}'; }
node_center() { tr '>' '\n' < "$1" | grep -E "$2" | head -1 | bounds_center; }
tap_node() { local xml; xml=$(ui_dump); [ -z "$xml" ] && return 1
  local c; c=$(node_center "$xml" "$1"); [ -z "$c" ] && return 1
  a input tap $c; return 0; }

start_rtmp_loop() { pkill -f rtmp_server.sh 2>/dev/null; pkill -f "ffmpeg -hide_banner" 2>/dev/null; sleep 1; ( "$SKILL_DIR/scripts/rtmp_server.sh" "$WORK" > "$WORK/rtmp_server.out" 2>&1 & ); sleep 2; }
stop_rtmp_loop() { pkill -f rtmp_server.sh 2>/dev/null; pkill -f "ffmpeg -hide_banner" 2>/dev/null; sleep 1; }
open_stream_screen() { a am start -n $PKG/.MainActivity >/dev/null; sleep 4
  a input tap 540 534; sleep 1; a input keycombination 113 29; sleep 0.5; a input text "$RTMP_URL"; sleep 0.5; a input keyevent KEYCODE_BACK; sleep 1
  a input tap 540 1406; sleep 6; }
return_to_stream_screen() { a am start -n $PKG/.MainActivity >/dev/null; sleep 3; a input keyevent KEYCODE_BACK; sleep 4; }

say "=== stream-regression $(date) device=$S apk=$APK rtmp=$RTMP_URL ==="
[ -f "$APK" ] || { say "APK не найден: $APK"; exit 2; }
start_rtmp_loop
a am force-stop $PKG
adb -s "$S" install -r -g "$APK" 2>&1 | tail -1 | tee -a "$LOG"
for p in android.permission.CAMERA android.permission.RECORD_AUDIO android.permission.POST_NOTIFICATIONS; do a pm grant $PKG $p; done
adb -s "$S" logcat -c

say "--- T1. открыть экран стрима"
open_stream_screen
[ "$(top)" = "$STREAM_ACT" ]; check "StreamActivity на экране" $?
[ "$(cam_open)" -ge 1 ]; check "камера открыта" $?

say "--- T2. запись + стрим"
a input tap 1084 966; sleep 3; a input tap 1290 966; sleep 10
[ "$(fgs)" = "isForeground=true" ]; check "сервис foreground" $?
[ "$(notifs)" -ge 1 ]; check "нотификация есть" $?
g=$(growth 5); [ "$g" -gt 1000000 ]; check "RTMP-поток идёт (+$g байт за 5 с)" $?

say "--- T3. полупрозрачное окно поверх (share sheet)"
a am start -a android.intent.action.SEND -t text/plain --es android.intent.extra.TEXT x >/dev/null; sleep 6
[ "$(top)" != "$STREAM_ACT" ]; check "поверх стрима другое окно" $?
g=$(growth 5); [ "$g" -gt 1000000 ]; check "поток идёт под окном (+$g)" $?
[ "$(cam_open)" -ge 1 ]; check "камера не отдана" $?
a input keyevent KEYCODE_BACK; sleep 3
[ "$(top)" = "$STREAM_ACT" ]; check "экран стрима вернулся" $?

say "--- T4. Home на 20 с"
a input keyevent KEYCODE_HOME; sleep 20
g=$(growth 5); [ "$g" -gt 1000000 ]; check "поток идёт в фоне (+$g)" $?
[ "$(cam_open)" -ge 1 ]; check "камера открыта в фоне" $?
[ "$(fgs)" = "isForeground=true" ]; check "сервис foreground в фоне" $?
return_to_stream_screen
[ "$(top)" = "$STREAM_ACT" ]; check "вернулись на экран стрима" $?
plog | grep -q "attachOutput PREVIEW ok"; check "превью переподключено" $?

if [ "${SKIP_SCREEN_OFF:-0}" != "1" ]; then
say "--- T5. экран выключен 15 с"
a input keyevent KEYCODE_SLEEP; sleep 15
g=$(growth 5); [ "$g" -gt 1000000 ]; check "поток идёт при выключенном экране (+$g)" $?
a input keyevent KEYCODE_WAKEUP; sleep 2; a input keyevent 82; sleep 4
[ "$(top)" = "$STREAM_ACT" ]; check "экран стрима после пробуждения" $?
else say "--- T5. экран выключен: пропущен (SKIP_SCREEN_OFF=1)"; fi

say "--- T6. другое приложение с камерой поверх"
adb -s "$S" logcat -c
a am start -a android.media.action.STILL_IMAGE_CAMERA >/dev/null; sleep 8
[ "$(top)" != "$STREAM_ACT" ]; check "приложение камеры открылось" $?
if plog | grep -qiE "disconnected|camera reopen|available again"; then say "  info  система отбирала камеру, см. лог"; else say "  info  камера не отбиралась (эмулятор отдал другой сенсор)"; fi
a input keyevent KEYCODE_BACK; sleep 6
[ "$(top)" = "$STREAM_ACT" ]; check "экран стрима после камеры" $?
[ "$(cam_open)" -ge 1 ]; check "наша камера открыта" $?
g=$(growth 5); [ "$g" -gt 1000000 ]; check "поток идёт после возврата камеры (+$g)" $?

say "--- T7. обрыв RTMP на 40 с"
adb -s "$S" logcat -c; stop_rtmp_loop; sleep 40
n=$(plog | grep -c "reconnect attempt [0-9]*/"); [ "$n" -ge 3 ]; check "попытки реконнекта идут ($n)" $?
plog | grep -q "reconnect exhausted"; [ $? -ne 0 ]; check "нет FAILED/exhausted" $?
[ "$(fgs)" = "isForeground=true" ]; check "сервис foreground во время обрыва" $?
start_rtmp_loop; sleep 40
plog | grep -q "reconnect attempt [0-9]* ok"; check "реконнект успешен после возврата сервера" $?
g=$(growth 5); [ "$g" -gt 1000000 ]; check "поток восстановился (+$g)" $?

say "--- T8. Остановить из нотификации (шторка на Home)"
adb -s "$S" logcat -c
a input keyevent KEYCODE_HOME; sleep 3; a cmd statusbar expand-notifications; sleep 3
xml=$(ui_dump); c=$(node_center "$xml" 'text="Mafbase"[^>]*package="com.android.systemui"'); my=$(echo "$c" | awk '{print $2}')
tapped=1
if [ -n "$c" ]; then
  best=""; bestd=99999
  while read -r line; do
    b=$(echo "$line" | bounds_center); [ -z "$b" ] && continue
    cy=$(echo "$b" | awk '{print $2}'); d=$(( cy > my ? cy - my : my - cy ))
    if [ "$d" -lt "$bestd" ]; then bestd=$d; best="$b"; fi
  done < <(tr '>' '\n' < "$xml" | grep 'resource-id="android:id/expand_button"')
  if [ -n "$best" ]; then a input tap $best; sleep 2; tap_node 'text="Остановить"[^>]*package="com.android.systemui"'; tapped=$?; fi
fi
[ "$tapped" -eq 0 ]; check "кнопка Остановить в нотификации нажата" $?
sleep 8; a cmd statusbar collapse; sleep 2
plog | grep -q "stop requested from notification"; check "сервис получил остановку" $?
[ "$(fgs)" != "isForeground=true" ]; check "сервис снят с foreground" $?
[ "$(notifs)" -eq 0 ]; check "нотификация убрана" $?
a content query --uri content://media/external/video/media --projection _display_name:_size:is_pending | grep "mafbase_stream" | tail -1 | grep -q "is_pending=0"; check "запись финализирована в MediaStore" $?
return_to_stream_screen
[ "$(top)" = "$STREAM_ACT" ]; check "экран стрима остался" $?

say "--- T9. Back и Закрыть с подтверждением"
a input tap 1290 966; sleep 8
[ "$(fgs)" = "isForeground=true" ]; check "стрим снова запущен" $?
a input keyevent KEYCODE_BACK; sleep 2
xml=$(ui_dump); grep -q 'Остановить трансляцию и запись' "$xml"; check "Back показывает диалог" $?
tap_node "text=\"Отмена\"[^>]*package=\"$PKG\""; sleep 2
[ "$(fgs)" = "isForeground=true" ]; check "после Отмены стрим идёт" $?
a input tap 2252 98; sleep 2; tap_node "text=\"Остановить\"[^>]*package=\"$PKG\""; sleep 8
[ "$(top)" != "$STREAM_ACT" ]; check "экран стрима закрыт" $?
[ "$(a dumpsys activity services $PKG | grep -c ServiceRecord)" -eq 0 ]; check "сервис остановлен" $?
[ "$(cam_open)" -eq 0 ]; check "камера закрыта" $?
a dumpsys power | grep -q "^Wake Locks: size=0"; check "wake lock отпущен" $?

stop_rtmp_loop
say "=== итог: PASS=$PASS FAIL=$FAIL (лог: $LOG) ==="
[ "$FAIL" -eq 0 ]
