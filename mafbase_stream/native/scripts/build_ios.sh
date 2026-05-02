#!/usr/bin/env bash
#
# Собирает mafbase_stream_core.xcframework из C++ ядра под iOS:
#   * iphoneos arm64
#   * iphonesimulator arm64
#
# На входе ожидается, что заголовки FFmpeg уже разложены в
# mafbase_stream/ios/Frameworks/ffmpeg/include/ — это делает
# native/scripts/fetch_ffmpeg_ios.sh.
#
# Полученный xcframework линкуется через mafbase_stream.podspec
# (vendored_frameworks). Сами .xcframework FFmpeg линкуются им же.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NATIVE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
ROOT_DIR="$(cd "${NATIVE_DIR}/.." && pwd)"
IOS_DIR="${ROOT_DIR}/ios"
FFMPEG_INCLUDE="${IOS_DIR}/Frameworks/ffmpeg/include"

if [ ! -d "${FFMPEG_INCLUDE}/libavformat" ]; then
    echo "[build_ios] FFmpeg headers not found at ${FFMPEG_INCLUDE}." >&2
    echo "[build_ios] Запустите native/scripts/fetch_ffmpeg_ios.sh." >&2
    exit 1
fi

BUILD_ROOT="${NATIVE_DIR}/build-ios"
OUT_DIR="${IOS_DIR}/Frameworks/mafbase_stream_core.xcframework"

rm -rf "${BUILD_ROOT}" "${OUT_DIR}"
mkdir -p "${BUILD_ROOT}"

# CMake требует ios.toolchain — но у нас простой кейс (один статический .a),
# поэтому ограничимся переменными CMAKE_SYSTEM_NAME / OSX_SYSROOT.
build_slice() {
    local slice="$1"     # ios-arm64 | ios-arm64-simulator | ios-x86_64-simulator
    local sdk="$2"       # iphoneos | iphonesimulator
    local arch="$3"      # arm64 | x86_64
    local build_dir="${BUILD_ROOT}/${slice}"

    mkdir -p "${build_dir}"
    pushd "${build_dir}" > /dev/null

    cmake "${NATIVE_DIR}" \
        -G "Unix Makefiles" \
        -DCMAKE_SYSTEM_NAME=iOS \
        -DCMAKE_OSX_SYSROOT="${sdk}" \
        -DCMAKE_OSX_ARCHITECTURES="${arch}" \
        -DCMAKE_OSX_DEPLOYMENT_TARGET=14.0 \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
        -DMAFBASE_STREAM_BUILD_TESTS=OFF \
        -DMS_IOS_FFMPEG_INCLUDE="${FFMPEG_INCLUDE}"

    cmake --build . --config Release --target mafbase_stream_core -- -j"$(sysctl -n hw.ncpu)"

    popd > /dev/null
}

build_slice "ios-arm64"               "iphoneos"        "arm64"
build_slice "ios-arm64-simulator"     "iphonesimulator" "arm64"
build_slice "ios-x86_64-simulator"    "iphonesimulator" "x86_64"

DEVICE_LIB="${BUILD_ROOT}/ios-arm64/libmafbase_stream_core.a"
SIM_ARM64_LIB="${BUILD_ROOT}/ios-arm64-simulator/libmafbase_stream_core.a"
SIM_X86_64_LIB="${BUILD_ROOT}/ios-x86_64-simulator/libmafbase_stream_core.a"
for f in "${DEVICE_LIB}" "${SIM_ARM64_LIB}" "${SIM_X86_64_LIB}"; do
    if [ ! -f "${f}" ]; then
        echo "[build_ios] не нашёл ${f} после сборки" >&2
        exit 1
    fi
done

# Симуляторный slice в xcframework должен содержать обе архитектуры (arm64 +
# x86_64) — иначе Xcode при сборке симулятора без EXCLUDED_ARCHS не найдёт
# нужный thin .a. lipo-склейка двух статических либ.
SIM_FAT_LIB="${BUILD_ROOT}/ios-simulator-fat/libmafbase_stream_core.a"
mkdir -p "$(dirname "${SIM_FAT_LIB}")"
lipo -create "${SIM_ARM64_LIB}" "${SIM_X86_64_LIB}" -output "${SIM_FAT_LIB}"

xcodebuild -create-xcframework \
    -library "${DEVICE_LIB}"  -headers "${NATIVE_DIR}/include" \
    -library "${SIM_FAT_LIB}" -headers "${NATIVE_DIR}/include" \
    -output "${OUT_DIR}"

echo "[build_ios] Готово: ${OUT_DIR}"
