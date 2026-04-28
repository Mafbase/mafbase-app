#!/usr/bin/env bash
#
# Пакует и заливает текущие FFmpeg-артефакты (iOS xcframeworks + Android .so)
# в Artifactory (MinIO S3). Версия одна — каждый запуск перезаписывает.
#
# Endpoint: https://artifactory.mafbase.ru, bucket: ffmpeg
#
# Креды берутся из:
#   1) env: MS_ARTIFACTORY_KEY, MS_ARTIFACTORY_SECRET
#   2) файла native/scripts/.artifactory.env (формата KEY=value, gitignored)
#
# Получить креды один раз:
#   ssh strelas@mafbase.ru cat /home/strelas/artifactory/.env
# Скопировать UPLOAD_ACCESS_KEY/UPLOAD_SECRET_KEY в .artifactory.env как
# MS_ARTIFACTORY_KEY/MS_ARTIFACTORY_SECRET.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
IOS_FFMPEG_DIR="${ROOT_DIR}/ios/Frameworks/ffmpeg"
ANDROID_JNILIBS_DIR="${ROOT_DIR}/android/src/main/jniLibs"
ANDROID_INCLUDE_DIR="${ROOT_DIR}/android/src/main/cpp/third_party/ffmpeg/include"

ENDPOINT="https://artifactory.mafbase.ru"
BUCKET="ffmpeg"

# 1. Загрузка кред
if [ -z "${MS_ARTIFACTORY_KEY:-}" ] || [ -z "${MS_ARTIFACTORY_SECRET:-}" ]; then
    if [ -f "${SCRIPT_DIR}/.artifactory.env" ]; then
        # shellcheck disable=SC1091
        set -a && source "${SCRIPT_DIR}/.artifactory.env" && set +a
    fi
fi
if [ -z "${MS_ARTIFACTORY_KEY:-}" ] || [ -z "${MS_ARTIFACTORY_SECRET:-}" ]; then
    cat >&2 <<EOF
[upload_ffmpeg] нет MS_ARTIFACTORY_KEY / MS_ARTIFACTORY_SECRET.

Получить креды:
    ssh strelas@mafbase.ru cat /home/strelas/artifactory/.env

Положить их в ${SCRIPT_DIR}/.artifactory.env:
    MS_ARTIFACTORY_KEY=<UPLOAD_ACCESS_KEY>
    MS_ARTIFACTORY_SECRET=<UPLOAD_SECRET_KEY>

(.artifactory.env уже в .gitignore.)
EOF
    exit 1
fi

# 2. Проверка наличия артефактов
missing=()
[ -d "${IOS_FFMPEG_DIR}" ] || missing+=("${IOS_FFMPEG_DIR}")
[ -d "${ANDROID_JNILIBS_DIR}/arm64-v8a" ] || missing+=("${ANDROID_JNILIBS_DIR}/arm64-v8a")
[ -d "${ANDROID_JNILIBS_DIR}/armeabi-v7a" ] || missing+=("${ANDROID_JNILIBS_DIR}/armeabi-v7a")
[ -d "${ANDROID_INCLUDE_DIR}" ] || missing+=("${ANDROID_INCLUDE_DIR}")
if [ ${#missing[@]} -gt 0 ]; then
    echo "[upload_ffmpeg] нет артефактов:" >&2
    for p in "${missing[@]}"; do echo "  $p" >&2; done
    echo "Соберите их локально: native/scripts/fetch_ffmpeg_ios.sh + ffmpeg-kit android.sh" >&2
    exit 1
fi

# 3. mc client (скачиваем если нет)
MC_BIN="$(command -v mc || true)"
if [ -z "${MC_BIN}" ]; then
    MC_DIR="$(mktemp -d "${TMPDIR:-/tmp}/ms-mc.XXXXXX")"
    trap 'rm -rf "${MC_DIR}"' EXIT
    case "$(uname -sm)" in
        "Darwin arm64")  MC_URL="https://dl.min.io/client/mc/release/darwin-arm64/mc"  ;;
        "Darwin x86_64") MC_URL="https://dl.min.io/client/mc/release/darwin-amd64/mc"  ;;
        "Linux x86_64")  MC_URL="https://dl.min.io/client/mc/release/linux-amd64/mc"   ;;
        "Linux aarch64") MC_URL="https://dl.min.io/client/mc/release/linux-arm64/mc"   ;;
        *) echo "[upload_ffmpeg] неизвестная платформа: $(uname -sm)" >&2; exit 1 ;;
    esac
    echo "[upload_ffmpeg] mc не найден, качаю в ${MC_DIR}/mc"
    curl -fsSL "${MC_URL}" -o "${MC_DIR}/mc"
    chmod +x "${MC_DIR}/mc"
    MC_BIN="${MC_DIR}/mc"
fi

# 4. Настройка alias (имя уникальное, чтобы не конфликтовать с пользовательскими)
ALIAS="mafbase-artifactory-upload"
"${MC_BIN}" alias set "${ALIAS}" "${ENDPOINT}" "${MS_ARTIFACTORY_KEY}" "${MS_ARTIFACTORY_SECRET}" >/dev/null

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/ms-ffmpeg-upload.XXXXXX")"
trap 'rm -rf "${WORK_DIR}"; "${MC_BIN}" alias remove "${ALIAS}" >/dev/null 2>&1 || true' EXIT

# 5. Пакуем iOS-архив. Структура внутри: include/, lib<lib>.xcframework/...
echo "[upload_ffmpeg] пакую ffmpeg-ios.tar.gz"
tar --no-xattrs -czf "${WORK_DIR}/ffmpeg-ios.tar.gz" -C "${IOS_FFMPEG_DIR}" .

# 6. Пакуем Android-архив. Структура: jniLibs/<abi>/*.so + include/...
ANDROID_STAGE="${WORK_DIR}/android-stage"
mkdir -p "${ANDROID_STAGE}"
cp -R "${ANDROID_JNILIBS_DIR}" "${ANDROID_STAGE}/jniLibs"
cp -R "${ANDROID_INCLUDE_DIR}" "${ANDROID_STAGE}/include"
echo "[upload_ffmpeg] пакую ffmpeg-android.tar.gz"
tar --no-xattrs -czf "${WORK_DIR}/ffmpeg-android.tar.gz" -C "${ANDROID_STAGE}" .

# 7. SHA256
( cd "${WORK_DIR}" && shasum -a 256 ffmpeg-ios.tar.gz ffmpeg-android.tar.gz > SHA256SUMS )

# 8. Заливка
for f in ffmpeg-ios.tar.gz ffmpeg-android.tar.gz SHA256SUMS; do
    SIZE="$(du -h "${WORK_DIR}/${f}" | cut -f1)"
    echo "[upload_ffmpeg] → ${BUCKET}/${f} (${SIZE})"
    "${MC_BIN}" cp --quiet "${WORK_DIR}/${f}" "${ALIAS}/${BUCKET}/${f}"
done

echo "[upload_ffmpeg] Готово."
echo
echo "Скачать (публично):"
echo "  curl -O ${ENDPOINT}/${BUCKET}/ffmpeg-ios.tar.gz"
echo "  curl -O ${ENDPOINT}/${BUCKET}/ffmpeg-android.tar.gz"
echo "  curl -O ${ENDPOINT}/${BUCKET}/SHA256SUMS"
