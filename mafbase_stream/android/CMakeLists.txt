# CMake-конфигурация для Android-сборки нативной части плагина.
#
# Под Android NDK собираем:
#   1) mafbase_stream_core — статическая библиотека из ../native/src (общий C++ код).
#   2) libmafbase_stream_jni.so — JNI-обёртка, подключающая core и линкующаяся
#      с FFmpeg.
#
# FFmpeg подключаем напрямую: заголовки лежат в src/main/cpp/third_party/ffmpeg/include/,
# .so — в src/main/jniLibs/<abi>/. Gradle автоматически упаковывает .so из jniLibs/ в
# APK/AAR, и нативный загрузчик их находит при dlopen-е libmafbase_stream_jni.so.
#
# .so и заголовки получены из распакованного ffmpeg-kit (`prebuilt/`-каталог скрипта
# `android.sh`). Подробности — в README плагина, раздел «FFmpeg AAR».

cmake_minimum_required(VERSION 3.22)
project(mafbase_stream_jni LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD 11)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(MS_NATIVE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../native")
set(MS_FFMPEG_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src/main/cpp/third_party/ffmpeg/include")
set(MS_JNILIBS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src/main/jniLibs/${ANDROID_ABI}")

# ---- Imported FFmpeg targets -------------------------------------------------
foreach(LIB avformat avcodec avutil swscale swresample)
    add_library(ffmpeg_${LIB} SHARED IMPORTED)
    set_target_properties(ffmpeg_${LIB} PROPERTIES
        IMPORTED_LOCATION "${MS_JNILIBS_DIR}/lib${LIB}.so"
        INTERFACE_INCLUDE_DIRECTORIES "${MS_FFMPEG_INCLUDE_DIR}")
endforeach()

# ---- Core static library -----------------------------------------------------
add_library(mafbase_stream_core STATIC
    ${MS_NATIVE_DIR}/src/session.cpp
    ${MS_NATIVE_DIR}/src/state_machine.cpp
    ${MS_NATIVE_DIR}/src/rtmp_publisher.cpp
    ${MS_NATIVE_DIR}/src/log.cpp)

target_include_directories(mafbase_stream_core
    PUBLIC ${MS_NATIVE_DIR}/include
    PRIVATE ${MS_NATIVE_DIR}/src)

target_link_libraries(mafbase_stream_core
    PUBLIC
        ffmpeg_avformat
        ffmpeg_avcodec
        ffmpeg_avutil
        ffmpeg_swscale
        ffmpeg_swresample
    PRIVATE
        log)

target_compile_options(mafbase_stream_core PRIVATE
    -Wall -Wextra -Wno-unused-parameter)

# ---- JNI shared library ------------------------------------------------------
add_library(mafbase_stream_jni SHARED
    src/main/cpp/jni_bridge.cpp)

target_include_directories(mafbase_stream_jni PRIVATE ${MS_NATIVE_DIR}/include)

target_link_libraries(mafbase_stream_jni PRIVATE
    mafbase_stream_core
    log
    android)

# Android 15+ требует выравнивания .so на 16KB-страницы (раньше было 4KB).
# Без флага Google Play / Studio показывает «приложение не поддерживает 16 KB страницы».
# Применяем только к arm64-v8a — armeabi-v7a 32-битный, для него 16KB-страниц нет.
if(ANDROID_ABI STREQUAL "arm64-v8a")
    target_link_options(mafbase_stream_jni PRIVATE
        "LINKER:-z,max-page-size=16384")
endif()
