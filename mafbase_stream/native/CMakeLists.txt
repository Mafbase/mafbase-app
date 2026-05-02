cmake_minimum_required(VERSION 3.20)
project(mafbase_stream_core LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD 11)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

option(MAFBASE_STREAM_BUILD_TESTS "Build unit/integration tests" ON)
option(MAFBASE_STREAM_ENABLE_ASAN "Enable AddressSanitizer (Debug)" OFF)

if(MAFBASE_STREAM_ENABLE_ASAN)
    add_compile_options(-fsanitize=address -fno-omit-frame-pointer)
    add_link_options(-fsanitize=address)
endif()

# ---- FFmpeg ------------------------------------------------------------------
# Desktop (macOS/Linux): pkg-config находит системный FFmpeg.
# iOS cross-compile: pkg-config недоступен и системного FFmpeg нет — заголовки
# берутся из ../ios/Frameworks/ffmpeg/include (распакованные ffmpeg-kit headers).
# Линковка с .xcframework делается уже Xcode'ом / podspec'ом, статической core
# нужны только заголовки.
# Android: подключение делается отдельным CMakeLists.txt в android/, который сам
# импортирует .so из jniLibs/ и не использует этот файл.
if(CMAKE_SYSTEM_NAME STREQUAL "iOS")
    set(MS_IOS_FFMPEG_INCLUDE
        "${CMAKE_CURRENT_SOURCE_DIR}/../ios/Frameworks/ffmpeg/include"
        CACHE PATH "Path to FFmpeg headers for iOS cross-compile")
    if(NOT EXISTS "${MS_IOS_FFMPEG_INCLUDE}/libavformat/avformat.h")
        message(FATAL_ERROR
            "FFmpeg headers not found at ${MS_IOS_FFMPEG_INCLUDE}.\n"
            "Run native/scripts/fetch_ffmpeg_ios.sh first.")
    endif()
    add_library(ms_ffmpeg_headers INTERFACE)
    target_include_directories(ms_ffmpeg_headers SYSTEM INTERFACE "${MS_IOS_FFMPEG_INCLUDE}")
    set(MS_FFMPEG_TARGET ms_ffmpeg_headers)
else()
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(FFMPEG REQUIRED IMPORTED_TARGET
        libavformat
        libavcodec
        libavutil
        libswscale
        libswresample)
    set(MS_FFMPEG_TARGET PkgConfig::FFMPEG)
endif()

# ---- Core library ------------------------------------------------------------
add_library(mafbase_stream_core STATIC
    src/session.cpp
    src/state_machine.cpp
    src/rtmp_publisher.cpp
    src/log.cpp)

target_include_directories(mafbase_stream_core
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src)

target_link_libraries(mafbase_stream_core
    PUBLIC
        ${MS_FFMPEG_TARGET})

target_compile_options(mafbase_stream_core PRIVATE
    -Wall -Wextra -Wpedantic -Wno-unused-parameter)

# ---- Tests -------------------------------------------------------------------
if(MAFBASE_STREAM_BUILD_TESTS AND NOT CMAKE_SYSTEM_NAME STREQUAL "iOS")
    enable_testing()
    include(FetchContent)
    set(FETCHCONTENT_QUIET OFF)
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG        v1.15.2)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)

    add_executable(test_rtmp_publish tests/test_rtmp_publish.cpp)
    target_link_libraries(test_rtmp_publish
        PRIVATE
            mafbase_stream_core
            GTest::gtest_main)

    include(GoogleTest)
    gtest_discover_tests(test_rtmp_publish
        PROPERTIES
            LABELS "rtmp;integration"
            TIMEOUT 60)
endif()
