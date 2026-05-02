#!/usr/bin/env bash
#
# Скачивает prebuilt FFmpeg .so + headers для Android из artifactory:
#   * jniLibs/<abi>/lib*.so          → android/src/main/jniLibs/
#   * include/libav*/, include/...   → android/src/main/cpp/third_party/ffmpeg/include/
#
# Источник: https://artifactory.mafbase.ru/ffmpeg/ffmpeg-android.tar.gz
# Целостность проверяется по SHA256SUMS.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
ANDROID_MAIN="${ROOT_DIR}/android/src/main"
JNILIBS_DIR="${ANDROID_MAIN}/jniLibs"
INCLUDE_DIR="${ANDROID_MAIN}/cpp/third_party/ffmpeg/include"

ARTIFACTORY_URL="${MS_ARTIFACTORY_URL:-https://artifactory.mafbase.ru/ffmpeg}"
ARCHIVE="ffmpeg-android.tar.gz"

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/ms-fetch-android.XXXXXX")"
trap 'rm -rf "${WORK_DIR}"' EXIT

echo "[fetch_ffmpeg_android] качаю ${ARTIFACTORY_URL}/${ARCHIVE}"
curl -fsSL --retry 3 -o "${WORK_DIR}/${ARCHIVE}" "${ARTIFACTORY_URL}/${ARCHIVE}"
curl -fsSL --retry 3 -o "${WORK_DIR}/SHA256SUMS"  "${ARTIFACTORY_URL}/SHA256SUMS"

echo "[fetch_ffmpeg_android] проверяю SHA256"
EXPECTED="$(awk -v f="${ARCHIVE}" '$2==f {print $1}' "${WORK_DIR}/SHA256SUMS")"
if [ -z "${EXPECTED}" ]; then
    echo "[fetch_ffmpeg_android] нет ${ARCHIVE} в SHA256SUMS" >&2
    exit 1
fi
ACTUAL="$(shasum -a 256 "${WORK_DIR}/${ARCHIVE}" | awk '{print $1}')"
if [ "${EXPECTED}" != "${ACTUAL}" ]; then
    echo "[fetch_ffmpeg_android] SHA256 mismatch: expected ${EXPECTED}, got ${ACTUAL}" >&2
    exit 1
fi

# Архив имеет структуру:
#   jniLibs/<abi>/*.so
#   include/<libav*>/*.h, include/config.h, ...
EXTRACT_DIR="${WORK_DIR}/extract"
mkdir -p "${EXTRACT_DIR}"
tar -xzf "${WORK_DIR}/${ARCHIVE}" -C "${EXTRACT_DIR}"

rm -rf "${JNILIBS_DIR}" "${INCLUDE_DIR}"
mkdir -p "${JNILIBS_DIR}" "${INCLUDE_DIR}"
cp -R "${EXTRACT_DIR}/jniLibs/." "${JNILIBS_DIR}/"
cp -R "${EXTRACT_DIR}/include/." "${INCLUDE_DIR}/"

echo "[fetch_ffmpeg_android] Готово:"
echo "  ${JNILIBS_DIR}"
echo "  ${INCLUDE_DIR}"
