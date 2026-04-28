#!/usr/bin/env bash
#
# Готовит FFmpeg xcframework-и для iOS-сборки плагина из локального ffmpeg-kit.
#
# Что нужно от ffmpeg-kit: успешно собранные слайсы для arm64-device и
# arm64-simulator. Достаточно того, что выпускает обычный
#   ./ios.sh -x --disable-arm64-mac-catalyst --disable-arm64e \
#            --disable-x86-64 --disable-x86-64-mac-catalyst
# до этапа создания xcframework-ов (на котором ios.sh любит падать из-за
# отсутствующих autotools / EDR-блоков fork). Сами xcframework-и мы соберём
# сами через xcodebuild — обёртка ffmpeg-kit нам не нужна.
#
# Источник по умолчанию: $HOME/Downloads/ffmpeg-kit-6.0.LTS — переопределяется
# через MS_FFMPEG_KIT_SRC.
#
# Что делает скрипт:
#   1. Проверяет наличие dylib-ов и заголовков для arm64 + arm64-simulator.
#   2. Для каждой нужной либы оборачивает .dylib в .framework-бандл с
#      Info.plist и скорректированным install_name.
#   3. Через `xcodebuild -create-xcframework` склеивает device+simulator в
#      один xcframework, кладёт в ios/Frameworks/ffmpeg/.
#   4. Раскладывает заголовки в ios/Frameworks/ffmpeg/include/ — для
#      CMake-сборки core (build_ios.sh).
#
# Идемпотентен: при повторном запуске старые xcframework-и удаляются и
# создаются заново.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
OUT_DIR="${ROOT_DIR}/ios/Frameworks/ffmpeg"

MS_FFMPEG_KIT_SRC="${MS_FFMPEG_KIT_SRC:-${HOME}/Downloads/ffmpeg-kit-6.0.LTS}"
LIBS=(avcodec avformat avutil swresample swscale)

# Slice-ы делятся на «бандлы»: для device — только arm64, для simulator — fat
# из arm64-simulator + (опционально) x86_64. Если x86_64 не собран, simulator
# будет содержать только arm64-simulator — на Apple Silicon-маке этого хватает.
DEVICE_SLICES=(arm64)
SIMULATOR_SLICES=(arm64-simulator)
if [ -d "${MS_FFMPEG_KIT_SRC}/prebuilt/apple-ios-x86_64/ffmpeg/lib" ]; then
    SIMULATOR_SLICES+=(x86_64)
fi
REQUIRED_SLICES=("${DEVICE_SLICES[@]}" "${SIMULATOR_SLICES[@]}")

if [ ! -d "${MS_FFMPEG_KIT_SRC}" ]; then
    cat >&2 <<EOF
[fetch_ffmpeg_ios] не нашёл ffmpeg-kit source: ${MS_FFMPEG_KIT_SRC}

Клонируйте репозиторий и переопределите MS_FFMPEG_KIT_SRC, либо положите его в
\$HOME/Downloads/ffmpeg-kit-6.0.LTS:

    git clone https://github.com/arthenica/ffmpeg-kit.git \\
        \${HOME}/Downloads/ffmpeg-kit-6.0.LTS
EOF
    exit 1
fi

# Проверяем обязательные slice-ы (arm64 device, arm64-simulator).
for slice in "${REQUIRED_SLICES[@]}"; do
    LIB_DIR="${MS_FFMPEG_KIT_SRC}/prebuilt/apple-ios-${slice}/ffmpeg/lib"
    INC_DIR="${MS_FFMPEG_KIT_SRC}/prebuilt/apple-ios-${slice}/ffmpeg/include"
    if [ ! -d "${LIB_DIR}" ] || [ ! -d "${INC_DIR}" ]; then
        cat >&2 <<EOF
[fetch_ffmpeg_ios] нет prebuilt-слайса для apple-ios-${slice}:
  ${LIB_DIR}
  ${INC_DIR}

Соберите ffmpeg-kit заново — нужны slice-ы arm64 (device) и arm64-simulator,
опционально x86_64 для Intel-маков:

    cd "${MS_FFMPEG_KIT_SRC}"
    ./ios.sh -x --disable-arm64-mac-catalyst --disable-arm64e \\
        --disable-x86-64-mac-catalyst

После того как в prebuilt/apple-ios-*/ffmpeg/lib появятся .dylib — даже если
потом ios.sh упадёт на обёртке ffmpeg-kit, нашему плагину этого достаточно.
Запустите fetch_ffmpeg_ios.sh ещё раз.
EOF
        exit 1
    fi
    for lib in "${LIBS[@]}"; do
        if [ ! -f "${LIB_DIR}/lib${lib}.dylib" ]; then
            echo "[fetch_ffmpeg_ios] отсутствует ${LIB_DIR}/lib${lib}.dylib" >&2
            exit 1
        fi
    done
done

mkdir -p "${OUT_DIR}" "${OUT_DIR}/include"

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/msffmpeg.XXXXXX")"
trap 'rm -rf "${WORK_DIR}"' EXIT

# Записывает Info.plist в .framework-бандл.
write_info_plist() {
    local fw="$1"      # путь к .framework
    local lib="$2"     # имя без префикса lib (avformat, avcodec, ...)
    local platform="$3" # iPhoneOS | iPhoneSimulator
    cat > "${fw}/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>en</string>
  <key>CFBundleExecutable</key>
  <string>lib${lib}</string>
  <key>CFBundleIdentifier</key>
  <string>org.ffmpeg.lib${lib}</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>lib${lib}</string>
  <key>CFBundlePackageType</key>
  <string>FMWK</string>
  <key>CFBundleShortVersionString</key>
  <string>1.0</string>
  <key>CFBundleVersion</key>
  <string>1</string>
  <key>MinimumOSVersion</key>
  <string>14.0</string>
  <key>CFBundleSupportedPlatforms</key>
  <array><string>${platform}</string></array>
</dict>
</plist>
EOF
}

# 1. Device .framework-бандлы (arm64).
for slice in "${DEVICE_SLICES[@]}"; do
    SLICE_SRC="${MS_FFMPEG_KIT_SRC}/prebuilt/apple-ios-${slice}/ffmpeg"
    for lib in "${LIBS[@]}"; do
        FW="${WORK_DIR}/device/lib${lib}.framework"
        mkdir -p "${FW}/Headers"
        cp -R "${SLICE_SRC}/include/lib${lib}/." "${FW}/Headers/"
        cp "${SLICE_SRC}/lib/lib${lib}.dylib" "${FW}/lib${lib}"
        install_name_tool -id "@rpath/lib${lib}.framework/lib${lib}" "${FW}/lib${lib}"
        write_info_plist "${FW}" "${lib}" "iPhoneOS"
    done
done

# 2. Simulator .framework-бандлы. Если slice-ов несколько — склеиваем lipo.
for lib in "${LIBS[@]}"; do
    FW="${WORK_DIR}/simulator/lib${lib}.framework"
    mkdir -p "${FW}/Headers"
    # Заголовки берём из первого slice-а (они идентичны).
    FIRST_SLICE="${SIMULATOR_SLICES[0]}"
    cp -R "${MS_FFMPEG_KIT_SRC}/prebuilt/apple-ios-${FIRST_SLICE}/ffmpeg/include/lib${lib}/." "${FW}/Headers/"

    THIN_DIR="${WORK_DIR}/simulator-thin/${lib}"
    mkdir -p "${THIN_DIR}"
    LIPO_INPUTS=()
    for slice in "${SIMULATOR_SLICES[@]}"; do
        SRC_DYLIB="${MS_FFMPEG_KIT_SRC}/prebuilt/apple-ios-${slice}/ffmpeg/lib/lib${lib}.dylib"
        DST_DYLIB="${THIN_DIR}/lib${lib}-${slice}.dylib"
        cp "${SRC_DYLIB}" "${DST_DYLIB}"
        # Перед lipo выставляем единый install_name на каждом thin dylib.
        install_name_tool -id "@rpath/lib${lib}.framework/lib${lib}" "${DST_DYLIB}"
        LIPO_INPUTS+=("${DST_DYLIB}")
    done
    if [ "${#LIPO_INPUTS[@]}" -eq 1 ]; then
        cp "${LIPO_INPUTS[0]}" "${FW}/lib${lib}"
    else
        lipo -create "${LIPO_INPUTS[@]}" -output "${FW}/lib${lib}"
    fi
    write_info_plist "${FW}" "${lib}" "iPhoneSimulator"
done

# 3. Собираем xcframework: device + simulator → один артефакт на либу.
for lib in "${LIBS[@]}"; do
    OUT_XC="${OUT_DIR}/lib${lib}.xcframework"
    rm -rf "${OUT_XC}"
    xcodebuild -create-xcframework \
        -framework "${WORK_DIR}/device/lib${lib}.framework" \
        -framework "${WORK_DIR}/simulator/lib${lib}.framework" \
        -output "${OUT_XC}" >/dev/null
    echo "[fetch_ffmpeg_ios] ✓ lib${lib}.xcframework (sim: ${SIMULATOR_SLICES[*]})"
done

# 3. Заголовки для CMake-сборки core (берём из device-слайса; они идентичны).
# Структура должна быть include/libavformat/avformat.h, чтобы C-код ffmpeg/core
# подключал #include <libavformat/avformat.h> относительно этого корня.
for lib in "${LIBS[@]}"; do
    DST="${OUT_DIR}/include/lib${lib}"
    rm -rf "${DST}"
    mkdir -p "${DST}"
    cp -R "${MS_FFMPEG_KIT_SRC}/prebuilt/apple-ios-arm64/ffmpeg/include/lib${lib}/." "${DST}/"
done

echo "[fetch_ffmpeg_ios] Готово: ${OUT_DIR}"
