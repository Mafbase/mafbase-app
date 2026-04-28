#ifndef MAFBASE_STREAM_LOG_H
#define MAFBASE_STREAM_LOG_H

#include <string>

namespace mafbase_stream {

enum class LogLevel { Debug, Info, Warn, Error };

void log_message(LogLevel level, const char* tag, const std::string& msg);

#define MS_LOGD(tag, msg) ::mafbase_stream::log_message(::mafbase_stream::LogLevel::Debug, (tag), (msg))
#define MS_LOGI(tag, msg) ::mafbase_stream::log_message(::mafbase_stream::LogLevel::Info, (tag), (msg))
#define MS_LOGW(tag, msg) ::mafbase_stream::log_message(::mafbase_stream::LogLevel::Warn, (tag), (msg))
#define MS_LOGE(tag, msg) ::mafbase_stream::log_message(::mafbase_stream::LogLevel::Error, (tag), (msg))

}  // namespace mafbase_stream

#endif
