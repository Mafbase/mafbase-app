#include "rtmp_publisher.h"

#include <algorithm>
#include <cstring>
#include <sstream>

#include "log.h"

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavutil/error.h>
#include <libavutil/mem.h>
#include <libavutil/rational.h>
}

namespace mafbase_stream {

namespace {

constexpr const char* kTag = "rtmp";

std::string av_err(int code) {
    char buf[AV_ERROR_MAX_STRING_SIZE] = {0};
    av_strerror(code, buf, sizeof(buf));
    return buf;
}

bool starts_with_annexb(const uint8_t* data, size_t size) {
    if (size >= 4 && data[0] == 0 && data[1] == 0 && data[2] == 0 && data[3] == 1) {
        return true;
    }
    if (size >= 3 && data[0] == 0 && data[1] == 0 && data[2] == 1) {
        return true;
    }
    return false;
}

// Возвращает индекс начала следующего start-code или size, если не найден.
// `prefix_size` — длина найденного start-code (3 или 4).
size_t find_next_start_code(const uint8_t* data, size_t from, size_t size, int* prefix_size) {
    for (size_t i = from; i + 2 < size; ++i) {
        if (data[i] == 0 && data[i + 1] == 0) {
            if (data[i + 2] == 1) {
                *prefix_size = 3;
                return i;
            }
            if (i + 3 < size && data[i + 2] == 0 && data[i + 3] == 1) {
                *prefix_size = 4;
                return i;
            }
        }
    }
    *prefix_size = 0;
    return size;
}

struct Nal {
    const uint8_t* data;
    size_t size;
    uint8_t nal_type;  // младшие 5 бит первого байта
};

std::vector<Nal> split_annexb(const uint8_t* data, size_t size) {
    std::vector<Nal> nals;
    if (!starts_with_annexb(data, size)) {
        return nals;
    }
    size_t i = 0;
    int prefix = 0;
    i = find_next_start_code(data, 0, size, &prefix);
    while (i < size) {
        size_t nal_start = i + prefix;
        int next_prefix = 0;
        size_t nal_end = find_next_start_code(data, nal_start, size, &next_prefix);
        if (nal_start >= size) break;
        Nal n{data + nal_start, nal_end - nal_start, static_cast<uint8_t>(data[nal_start] & 0x1f)};
        if (n.size > 0) {
            nals.push_back(n);
        }
        i = nal_end;
        prefix = next_prefix;
        if (prefix == 0) break;
    }
    return nals;
}

// Кодирует список NAL в AVCC (4-байтовый префикс длины big-endian).
std::vector<uint8_t> encode_avcc(const std::vector<Nal>& nals) {
    size_t total = 0;
    for (const auto& n : nals) total += 4 + n.size;
    std::vector<uint8_t> out(total);
    size_t off = 0;
    for (const auto& n : nals) {
        const uint32_t len = static_cast<uint32_t>(n.size);
        out[off + 0] = static_cast<uint8_t>((len >> 24) & 0xff);
        out[off + 1] = static_cast<uint8_t>((len >> 16) & 0xff);
        out[off + 2] = static_cast<uint8_t>((len >> 8) & 0xff);
        out[off + 3] = static_cast<uint8_t>(len & 0xff);
        std::memcpy(out.data() + off + 4, n.data, n.size);
        off += 4 + n.size;
    }
    return out;
}

// Строит avcC (ISO/IEC 14496-15 §5.2.4.1.1) из SPS и PPS.
std::vector<uint8_t> build_avcc_extradata(const std::vector<uint8_t>& sps,
                                          const std::vector<uint8_t>& pps) {
    std::vector<uint8_t> out;
    if (sps.size() < 4 || pps.empty()) return out;

    out.push_back(0x01);             // configurationVersion
    out.push_back(sps[1]);           // AVCProfileIndication
    out.push_back(sps[2]);           // profile_compatibility
    out.push_back(sps[3]);           // AVCLevelIndication
    out.push_back(0xff);             // 6 bits reserved + 2 bits NALU length size minus one (= 3)
    out.push_back(0xe1);             // 3 bits reserved + 5 bits numOfSPS (= 1)
    const uint16_t sps_len = static_cast<uint16_t>(sps.size());
    out.push_back(static_cast<uint8_t>((sps_len >> 8) & 0xff));
    out.push_back(static_cast<uint8_t>(sps_len & 0xff));
    out.insert(out.end(), sps.begin(), sps.end());
    out.push_back(0x01);             // numOfPPS
    const uint16_t pps_len = static_cast<uint16_t>(pps.size());
    out.push_back(static_cast<uint8_t>((pps_len >> 8) & 0xff));
    out.push_back(static_cast<uint8_t>(pps_len & 0xff));
    out.insert(out.end(), pps.begin(), pps.end());
    return out;
}

// Парсит ADTS-фрейм AAC: возвращает указатель на raw-AAC payload и его длину;
// если не ADTS — возвращает оригинал.
struct AacPayload {
    const uint8_t* data;
    size_t size;
    bool was_adts;
    int profile;        // MPEG-4 audio object type
    int sample_rate_idx;
    int channel_cfg;
};

AacPayload parse_adts(const uint8_t* data, size_t size) {
    AacPayload p{data, size, false, 0, 0, 0};
    if (size < 7) return p;
    if (data[0] != 0xff || (data[1] & 0xf0) != 0xf0) return p;
    const int profile = ((data[2] >> 6) & 0x03) + 1;  // 1=AAC Main, 2=LC, ...
    const int sr_idx = (data[2] >> 2) & 0x0f;
    const int ch_cfg = ((data[2] & 0x01) << 2) | ((data[3] >> 6) & 0x03);
    const int has_crc = !(data[1] & 0x01);
    const int header_len = has_crc ? 9 : 7;
    if (size < static_cast<size_t>(header_len)) return p;
    p.data = data + header_len;
    p.size = size - header_len;
    p.was_adts = true;
    p.profile = profile;
    p.sample_rate_idx = sr_idx;
    p.channel_cfg = ch_cfg;
    return p;
}

// Строит AudioSpecificConfig (2 байта) из ADTS-полей.
std::vector<uint8_t> build_asc(int profile, int sr_idx, int channel_cfg) {
    std::vector<uint8_t> asc(2);
    asc[0] = static_cast<uint8_t>((profile << 3) | ((sr_idx >> 1) & 0x07));
    asc[1] = static_cast<uint8_t>(((sr_idx & 0x01) << 7) | ((channel_cfg & 0x0f) << 3));
    return asc;
}

// FLV-muxer ждёт video extradata в виде avcC (AVCDecoderConfigurationRecord,
// начинается с 0x01). Некоторые энкодеры (libx264 c AV_CODEC_FLAG_GLOBAL_HEADER)
// отдают extradata в Annex-B (concatenated SPS/PPS со старт-кодами). Если
// получили Annex-B — парсим и пересобираем avcC. Иначе — используем как есть.
std::vector<uint8_t> normalize_h264_extradata(const std::vector<uint8_t>& in) {
    if (in.empty()) return in;
    if (!starts_with_annexb(in.data(), in.size())) {
        return in;  // считаем что уже avcC
    }
    const auto nals = split_annexb(in.data(), in.size());
    std::vector<uint8_t> sps;
    std::vector<uint8_t> pps;
    for (const auto& n : nals) {
        if (n.nal_type == 7 && sps.empty()) sps.assign(n.data, n.data + n.size);
        else if (n.nal_type == 8 && pps.empty()) pps.assign(n.data, n.data + n.size);
    }
    if (sps.empty() || pps.empty()) return {};
    return build_avcc_extradata(sps, pps);
}

}  // namespace

RtmpPublisher::RtmpPublisher() = default;

RtmpPublisher::~RtmpPublisher() { close(); }

ms_result RtmpPublisher::open(const std::string& url, const ms_session_params& params) {
    if (fmt_ctx_) return MS_ERR_INVALID_STATE;

    avformat_network_init();

    int err = avformat_alloc_output_context2(&fmt_ctx_, nullptr, "flv", url.c_str());
    if (err < 0 || !fmt_ctx_) {
        MS_LOGE(kTag, "avformat_alloc_output_context2 failed: " + av_err(err));
        return MS_ERR_FFMPEG;
    }

    video_fps_ = params.fps > 0 ? params.fps : 30;

    if (auto r = init_video_stream(params); r != MS_OK) return r;
    if (auto r = init_audio_stream(params); r != MS_OK) return r;

    if (params.video_extradata && params.video_extradata_size > 0) {
        std::vector<uint8_t> ed(params.video_extradata,
                                params.video_extradata + params.video_extradata_size);
        video_extradata_ = normalize_h264_extradata(ed);
        if (video_extradata_.empty()) {
            MS_LOGW(kTag, "video_extradata в Annex-B без SPS+PPS — будет извлечена из первого keyframe");
        }
    }
    if (params.audio_extradata && params.audio_extradata_size > 0) {
        audio_extradata_.assign(params.audio_extradata,
                                params.audio_extradata + params.audio_extradata_size);
    }

    AVDictionary* opts = nullptr;
    av_dict_set(&opts, "flvflags", "no_duration_filesize", 0);
    av_dict_set(&opts, "rtmp_live", "live", 0);

    err = avio_open2(&fmt_ctx_->pb, url.c_str(), AVIO_FLAG_WRITE, nullptr, &opts);
    av_dict_free(&opts);
    if (err < 0) {
        MS_LOGE(kTag, "avio_open2 failed: " + av_err(err));
        avformat_free_context(fmt_ctx_);
        fmt_ctx_ = nullptr;
        return MS_ERR_IO;
    }

    // Если extradata уже известна — пишем header сразу. Иначе ждём первого
    // ключевого кадра (там должны прийти SPS/PPS) и первого аудио-кадра.
    if (!video_extradata_.empty() && !audio_extradata_.empty()) {
        // Прокидываем extradata в AVCodecParameters перед write_header.
        auto set_extradata = [](AVStream* st, const std::vector<uint8_t>& ed) {
            uint8_t* buf = static_cast<uint8_t*>(av_mallocz(ed.size() + AV_INPUT_BUFFER_PADDING_SIZE));
            std::memcpy(buf, ed.data(), ed.size());
            st->codecpar->extradata = buf;
            st->codecpar->extradata_size = static_cast<int>(ed.size());
        };
        set_extradata(video_stream_, video_extradata_);
        set_extradata(audio_stream_, audio_extradata_);

        err = avformat_write_header(fmt_ctx_, nullptr);
        if (err < 0) {
            MS_LOGE(kTag, "avformat_write_header failed: " + av_err(err));
            avio_closep(&fmt_ctx_->pb);
            avformat_free_context(fmt_ctx_);
            fmt_ctx_ = nullptr;
            return MS_ERR_FFMPEG;
        }
        header_written_ = true;
    }

    MS_LOGI(kTag, "RTMP opened: " + url);
    return MS_OK;
}

ms_result RtmpPublisher::init_video_stream(const ms_session_params& params) {
    video_stream_ = avformat_new_stream(fmt_ctx_, nullptr);
    if (!video_stream_) return MS_ERR_NO_MEMORY;
    auto* p = video_stream_->codecpar;
    p->codec_type = AVMEDIA_TYPE_VIDEO;
    p->codec_id = AV_CODEC_ID_H264;
    p->width = params.width > 0 ? params.width : 1280;
    p->height = params.height > 0 ? params.height : 720;
    p->bit_rate = params.video_bitrate_bps > 0 ? params.video_bitrate_bps : 2'000'000;
    p->format = AV_PIX_FMT_YUV420P;
    video_stream_->time_base = AVRational{1, 1000};  // FLV — миллисекунды
    return MS_OK;
}

ms_result RtmpPublisher::init_audio_stream(const ms_session_params& params) {
    audio_stream_ = avformat_new_stream(fmt_ctx_, nullptr);
    if (!audio_stream_) return MS_ERR_NO_MEMORY;
    auto* p = audio_stream_->codecpar;
    p->codec_type = AVMEDIA_TYPE_AUDIO;
    p->codec_id = AV_CODEC_ID_AAC;
    p->sample_rate = params.audio_sample_rate > 0 ? params.audio_sample_rate : 44100;
    const int ch = params.audio_channels > 0 ? params.audio_channels : 2;
    av_channel_layout_default(&p->ch_layout, ch);
    p->bit_rate = params.audio_bitrate_bps > 0 ? params.audio_bitrate_bps : 128'000;
    p->format = AV_SAMPLE_FMT_FLTP;
    audio_stream_->time_base = AVRational{1, 1000};
    return MS_OK;
}

ms_result RtmpPublisher::write_video(const uint8_t* data, size_t size, int64_t pts_us, bool keyframe) {
    if (!fmt_ctx_) return MS_ERR_INVALID_STATE;
    if (!data || size == 0) return MS_ERR_INVALID_ARG;

    std::vector<uint8_t> avcc_payload;
    const uint8_t* out_data = data;
    size_t out_size = size;

    if (starts_with_annexb(data, size)) {
        const auto nals = split_annexb(data, size);
        std::vector<uint8_t> sps;
        std::vector<uint8_t> pps;
        std::vector<Nal> payload_nals;
        for (const auto& n : nals) {
            if (n.nal_type == 7) {
                sps.assign(n.data, n.data + n.size);
            } else if (n.nal_type == 8) {
                pps.assign(n.data, n.data + n.size);
            } else {
                payload_nals.push_back(n);
            }
        }
        if (video_extradata_.empty() && !sps.empty() && !pps.empty()) {
            video_extradata_ = build_avcc_extradata(sps, pps);
        }
        if (payload_nals.empty()) {
            return MS_OK;
        }
        avcc_payload = encode_avcc(payload_nals);
        out_data = avcc_payload.data();
        out_size = avcc_payload.size();
    }

    if (!header_written_) {
        if (video_extradata_.empty() || audio_extradata_.empty()) {
            // Аудио ещё не подвезло extradata — не можем писать header.
            return MS_OK;
        }
        auto set_extradata = [](AVStream* st, const std::vector<uint8_t>& ed) {
            if (st->codecpar->extradata) return;
            uint8_t* buf = static_cast<uint8_t*>(av_mallocz(ed.size() + AV_INPUT_BUFFER_PADDING_SIZE));
            std::memcpy(buf, ed.data(), ed.size());
            st->codecpar->extradata = buf;
            st->codecpar->extradata_size = static_cast<int>(ed.size());
        };
        set_extradata(video_stream_, video_extradata_);
        set_extradata(audio_stream_, audio_extradata_);
        const int err = avformat_write_header(fmt_ctx_, nullptr);
        if (err < 0) {
            MS_LOGE(kTag, "avformat_write_header (lazy) failed: " + av_err(err));
            return MS_ERR_FFMPEG;
        }
        header_written_ = true;
    }

    AVPacket* pkt = av_packet_alloc();
    if (!pkt) return MS_ERR_NO_MEMORY;
    if (av_new_packet(pkt, static_cast<int>(out_size)) < 0) {
        av_packet_free(&pkt);
        return MS_ERR_NO_MEMORY;
    }
    std::memcpy(pkt->data, out_data, out_size);
    pkt->stream_index = video_stream_->index;
    pkt->pts = pkt->dts = av_rescale_q(pts_us, AVRational{1, 1'000'000}, video_stream_->time_base);
    pkt->duration = av_rescale_q(1, AVRational{1, video_fps_}, video_stream_->time_base);
    if (keyframe) pkt->flags |= AV_PKT_FLAG_KEY;

    const int err = av_interleaved_write_frame(fmt_ctx_, pkt);
    av_packet_free(&pkt);
    if (err < 0) {
        MS_LOGE(kTag, "av_interleaved_write_frame (video) failed: " + av_err(err));
        return MS_ERR_IO;
    }
    return MS_OK;
}

ms_result RtmpPublisher::write_audio(const uint8_t* data, size_t size, int64_t pts_us) {
    if (!fmt_ctx_) return MS_ERR_INVALID_STATE;
    if (!data || size == 0) return MS_ERR_INVALID_ARG;

    AacPayload aac = parse_adts(data, size);
    if (aac.was_adts && audio_extradata_.empty()) {
        audio_extradata_ = build_asc(aac.profile, aac.sample_rate_idx, aac.channel_cfg);
    }

    if (!header_written_) {
        if (video_extradata_.empty() || audio_extradata_.empty()) {
            return MS_OK;
        }
        auto set_extradata = [](AVStream* st, const std::vector<uint8_t>& ed) {
            if (st->codecpar->extradata) return;
            uint8_t* buf = static_cast<uint8_t*>(av_mallocz(ed.size() + AV_INPUT_BUFFER_PADDING_SIZE));
            std::memcpy(buf, ed.data(), ed.size());
            st->codecpar->extradata = buf;
            st->codecpar->extradata_size = static_cast<int>(ed.size());
        };
        set_extradata(video_stream_, video_extradata_);
        set_extradata(audio_stream_, audio_extradata_);
        const int err = avformat_write_header(fmt_ctx_, nullptr);
        if (err < 0) {
            MS_LOGE(kTag, "avformat_write_header (lazy/audio) failed: " + av_err(err));
            return MS_ERR_FFMPEG;
        }
        header_written_ = true;
    }

    AVPacket* pkt = av_packet_alloc();
    if (!pkt) return MS_ERR_NO_MEMORY;
    if (av_new_packet(pkt, static_cast<int>(aac.size)) < 0) {
        av_packet_free(&pkt);
        return MS_ERR_NO_MEMORY;
    }
    std::memcpy(pkt->data, aac.data, aac.size);
    pkt->stream_index = audio_stream_->index;
    pkt->pts = pkt->dts = av_rescale_q(pts_us, AVRational{1, 1'000'000}, audio_stream_->time_base);
    pkt->flags |= AV_PKT_FLAG_KEY;  // AAC — каждый фрейм считается ключевым

    const int err = av_interleaved_write_frame(fmt_ctx_, pkt);
    av_packet_free(&pkt);
    if (err < 0) {
        MS_LOGE(kTag, "av_interleaved_write_frame (audio) failed: " + av_err(err));
        return MS_ERR_IO;
    }
    return MS_OK;
}

ms_result RtmpPublisher::close() {
    if (!fmt_ctx_) return MS_OK;
    if (header_written_) {
        const int err = av_write_trailer(fmt_ctx_);
        if (err < 0) {
            MS_LOGW(kTag, "av_write_trailer failed: " + av_err(err));
        }
    }
    if (fmt_ctx_->pb) {
        avio_closep(&fmt_ctx_->pb);
    }
    avformat_free_context(fmt_ctx_);
    fmt_ctx_ = nullptr;
    video_stream_ = nullptr;
    audio_stream_ = nullptr;
    header_written_ = false;
    video_extradata_.clear();
    audio_extradata_.clear();
    return MS_OK;
}

}  // namespace mafbase_stream
