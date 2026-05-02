#!/usr/bin/env bash
#
# Скачивает готовые xcframework-и FFmpeg для iOS из artifactory и
# раскладывает в ios/Frameworks/ffmpeg/.
#
# Источник: https://artifactory.mafbase.ru/ffmpeg/ffmpeg-ios.tar.gz
# Версия одна — каждый запуск берёт текущую. Целостность проверяется по
# SHA256SUMS в том же бакете.
#
# Если нужно пересобрать FFmpeg из ffmpeg-kit (после апгрейда версии или
# смены опций сборки) — запускайте rebuild_ffmpeg_ios.sh, потом
# upload_ffmpeg.sh для заливки нового архива в artifactory.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
OUT_DIR="${ROOT_DIR}/ios/Frameworks/ffmpeg"

ARTIFACTORY_URL="${MS_ARTIFACTORY_URL:-https://artifactory.mafbase.ru/ffmpeg}"
ARCHIVE="ffmpeg-ios.tar.gz"

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/ms-fetch-ios.XXXXXX")"
trap 'rm -rf "${WORK_DIR}"' EXIT

echo "[fetch_ffmpeg_ios] качаю ${ARTIFACTORY_URL}/${ARCHIVE}"
curl -fsSL --retry 3 -o "${WORK_DIR}/${ARCHIVE}" "${ARTIFACTORY_URL}/${ARCHIVE}"
curl -fsSL --retry 3 -o "${WORK_DIR}/SHA256SUMS"  "${ARTIFACTORY_URL}/SHA256SUMS"

echo "[fetch_ffmpeg_ios] проверяю SHA256"
EXPECTED="$(awk -v f="${ARCHIVE}" '$2==f {print $1}' "${WORK_DIR}/SHA256SUMS")"
if [ -z "${EXPECTED}" ]; then
    echo "[fetch_ffmpeg_ios] нет ${ARCHIVE} в SHA256SUMS" >&2
    exit 1
fi
ACTUAL="$(shasum -a 256 "${WORK_DIR}/${ARCHIVE}" | awk '{print $1}')"
if [ "${EXPECTED}" != "${ACTUAL}" ]; then
    echo "[fetch_ffmpeg_ios] SHA256 mismatch: expected ${EXPECTED}, got ${ACTUAL}" >&2
    exit 1
fi

rm -rf "${OUT_DIR}"
mkdir -p "${OUT_DIR}"
tar -xzf "${WORK_DIR}/${ARCHIVE}" -C "${OUT_DIR}"

echo "[fetch_ffmpeg_ios] Готово: ${OUT_DIR}"
