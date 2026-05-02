#include "log.h"

#include <cstdio>

#if defined(__ANDROID__)
#include <android/log.h>
#endif

namespace mafbase_stream {

namespace {

const char* level_name(LogLevel level) {
    switch (level) {
        case LogLevel::Debug: return "D";
        case LogLevel::Info:  return "I";
        case LogLevel::Warn:  return "W";
        case LogLevel::Error: return "E";
    }
    return "?";
}

#if defined(__ANDROID__)
int android_priority(LogLevel level) {
    switch (level) {
        case LogLevel::Debug: return ANDROID_LOG_DEBUG;
        case LogLevel::Info:  return ANDROID_LOG_INFO;
        case LogLevel::Warn:  return ANDROID_LOG_WARN;
        case LogLevel::Error: return ANDROID_LOG_ERROR;
    }
    return ANDROID_LOG_DEFAULT;
}
#endif

}  // namespace

void log_message(LogLevel level, const char* tag, const std::string& msg) {
#if defined(__ANDROID__)
    // На Android stderr по умолчанию никуда не выводится — без этого пути все
    // сообщения от RtmpPublisher (включая текст ошибок FFmpeg) теряются.
    // Тег префиксуем "ms.", чтобы легко фильтровать в logcat.
    char android_tag[64];
    std::snprintf(android_tag, sizeof(android_tag), "ms.%s", tag);
    __android_log_print(android_priority(level), android_tag, "%s", msg.c_str());
#else
    std::fprintf(stderr, "[mafbase_stream][%s][%s] %s\n", level_name(level), tag, msg.c_str());
#endif
}

}  // namespace mafbase_stream
