#ifndef MAFBASE_STREAM_RTMP_PUBLISHER_H
#define MAFBASE_STREAM_RTMP_PUBLISHER_H

#include <cstdint>
#include <string>
#include <vector>

#include "mafbase_stream/session.h"

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
}

namespace mafbase_stream {

// Обёртка над libavformat для публикации в RTMP/FLV. Принимает уже сжатые
// H.264 NAL-юниты (Annex-B или AVCC) и AAC-фреймы (ADTS или raw).
class RtmpPublisher {
public:
    RtmpPublisher();
    ~RtmpPublisher();

    RtmpPublisher(const RtmpPublisher&) = delete;
    RtmpPublisher& operator=(const RtmpPublisher&) = delete;

    ms_result open(const std::string& url, const ms_session_params& params);
    ms_result write_video(const uint8_t* data, size_t size, int64_t pts_us, bool keyframe);
    ms_result write_audio(const uint8_t* data, size_t size, int64_t pts_us);
    ms_result close();

private:
    ms_result init_video_stream(const ms_session_params& params);
    ms_result init_audio_stream(const ms_session_params& params);

    AVFormatContext* fmt_ctx_ = nullptr;
    AVStream* video_stream_ = nullptr;
    AVStream* audio_stream_ = nullptr;
    bool header_written_ = false;

    int video_fps_ = 30;

    // Кеш SPS/PPS, извлекаемых из первого keyframe в Annex-B, если extradata
    // не передан в params. Нужен FFmpeg для FLV-muxer (он требует extradata
    // при write_header). На практике задаём extradata перед open.
    std::vector<uint8_t> video_extradata_;
    std::vector<uint8_t> audio_extradata_;
};

}  // namespace mafbase_stream

#endif
