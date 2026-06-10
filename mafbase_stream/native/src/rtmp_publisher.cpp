#include "rtmp_publisher.h"

#include <chrono>
#include <cstdio>
#include <cstring>

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

int64_t now_monotonic_us() {
    using namespace std::chrono;
    return duration_cast<microseconds>(steady_clock::now().time_since_epoch()).count();
}

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

int RtmpPublisher::io_interrupt_cb(void* opaque) {
    auto* self = static_cast<RtmpPublisher*>(opaque);
    if (!self) return 0;
    if (self->cancel_requested_.load(std::memory_order_acquire)) {
        if (!self->interrupt_logged_.exchange(true, std::memory_order_acq_rel)) {
            MS_LOGW(kTag, "interrupt_cb: cancel_requested → abort I/O");
        }
        return 1;
    }
    const int64_t deadline = self->io_deadline_us_.load(std::memory_order_acquire);
    if (deadline > 0 && now_monotonic_us() > deadline) {
        if (!self->interrupt_logged_.exchange(true, std::memory_order_acq_rel)) {
            const int64_t over_ms = (now_monotonic_us() - deadline) / 1000;
            MS_LOGW(kTag, "interrupt_cb: deadline exceeded by " + std::to_string(over_ms) +
                           "ms (timeout=" + std::to_string(self->io_timeout_us_ / 1000) + "ms) → abort I/O");
        }
        return 1;
    }
    return 0;
}

void RtmpPublisher::arm_io_deadline() {
    if (io_timeout_us_ > 0) {
        io_deadline_us_.store(now_monotonic_us() + io_timeout_us_, std::memory_order_release);
    }
    interrupt_logged_.store(false, std::memory_order_release);
}

void RtmpPublisher::disarm_io_deadline() {
    io_deadline_us_.store(0, std::memory_order_release);
}

ms_io_subcode RtmpPublisher::classify_av_error(int err) {
    if (err == AVERROR_EOF) return MS_IO_EOF;
    if (err == AVERROR(ETIMEDOUT)) return MS_IO_TIMEOUT;
    if (err == AVERROR_EXIT) return MS_IO_TIMEOUT;  // сработал interrupt_cb
    if (err == AVERROR(ECONNRESET) || err == AVERROR(EPIPE)) return MS_IO_CONNRESET;
    if (err == AVERROR(ECONNREFUSED) || err == AVERROR(EHOSTUNREACH)) return MS_IO_CONNRESET;
    return MS_IO_OTHER;
}

ms_result RtmpPublisher::open(const std::string& url, const ms_session_params& params, int io_timeout_us) {
    if (fmt_ctx_) return MS_ERR_INVALID_STATE;

    avformat_network_init();

    cancel_requested_.store(false, std::memory_order_release);
    last_io_subcode_ = MS_IO_NONE;
    io_timeout_us_ = io_timeout_us > 0 ? io_timeout_us : 10'000'000;
    pts_base_us_ = INT64_MIN;

    int err = avformat_alloc_output_context2(&fmt_ctx_, nullptr, "flv", url.c_str());
    if (err < 0 || !fmt_ctx_) {
        MS_LOGE(kTag, "avformat_alloc_output_context2 failed: " + av_err(err));
        return MS_ERR_FFMPEG;
    }

    // Прицепляем interrupt_callback к контексту. FFmpeg будет дёргать его из
    // блокирующих сетевых операций (read/write/connect).
    fmt_ctx_->interrupt_callback.callback = &RtmpPublisher::io_interrupt_cb;
    fmt_ctx_->interrupt_callback.opaque = this;

    video_fps_ = params.fps > 0 ? params.fps : 30;

    if (auto r = init_video_stream(params); r != MS_OK) return r;
    has_audio_ = params.audio_extradata != nullptr && params.audio_extradata_size > 0;
    if (has_audio_) {
        if (auto r = init_audio_stream(params); r != MS_OK) return r;
    }

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
    // rw_timeout — в микросекундах (UInt64 string). Это нижний предохранитель,
    // верхний — наш AVIOInterruptCB с таким же бюджетом.
    {
        char buf[32];
        std::snprintf(buf, sizeof(buf), "%d", io_timeout_us_);
        av_dict_set(&opts, "rw_timeout", buf, 0);
    }
    av_dict_set(&opts, "tcp_nodelay", "1", 0);

    const int64_t open_start_us = now_monotonic_us();
    MS_LOGI(kTag, "avio_open2: io_timeout=" + std::to_string(io_timeout_us_ / 1000) + "ms, url=" + url);
    arm_io_deadline();
    err = avio_open2(&fmt_ctx_->pb, url.c_str(), AVIO_FLAG_WRITE,
                     &fmt_ctx_->interrupt_callback, &opts);
    av_dict_free(&opts);
    disarm_io_deadline();
    const int64_t open_elapsed_ms = (now_monotonic_us() - open_start_us) / 1000;
    if (err < 0) {
        MS_LOGE(kTag, "avio_open2 failed after " + std::to_string(open_elapsed_ms) +
                       "ms: " + av_err(err));
        last_io_subcode_ = classify_av_error(err);
        avformat_free_context(fmt_ctx_);
        fmt_ctx_ = nullptr;
        return MS_ERR_IO;
    }
    MS_LOGI(kTag, "avio_open2 ok in " + std::to_string(open_elapsed_ms) + "ms");

    // Если extradata уже известна — пишем header сразу. Иначе ждём первого
    // ключевого кадра (там должны прийти SPS/PPS) и первого аудио-кадра.
    if (!video_extradata_.empty() && (!has_audio_ || !audio_extradata_.empty())) {
        // Прокидываем extradata в AVCodecParameters перед write_header.
        auto set_extradata = [](AVStream* st, const std::vector<uint8_t>& ed) {
            uint8_t* buf = static_cast<uint8_t*>(av_mallocz(ed.size() + AV_INPUT_BUFFER_PADDING_SIZE));
            std::memcpy(buf, ed.data(), ed.size());
            st->codecpar->extradata = buf;
            st->codecpar->extradata_size = static_cast<int>(ed.size());
        };
        set_extradata(video_stream_, video_extradata_);
        if (has_audio_) set_extradata(audio_stream_, audio_extradata_);

        arm_io_deadline();
        err = avformat_write_header(fmt_ctx_, nullptr);
        disarm_io_deadline();
        if (err < 0) {
            MS_LOGE(kTag, "avformat_write_header failed: " + av_err(err));
            last_io_subcode_ = classify_av_error(err);
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
        if (video_extradata_.empty() || (has_audio_ && audio_extradata_.empty())) {
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
        if (has_audio_) set_extradata(audio_stream_, audio_extradata_);
        arm_io_deadline();
        const int err = avformat_write_header(fmt_ctx_, nullptr);
        disarm_io_deadline();
        if (err < 0) {
            MS_LOGE(kTag, "avformat_write_header (lazy) failed: " + av_err(err));
            last_io_subcode_ = classify_av_error(err);
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
    if (pts_base_us_ == INT64_MIN) {
        pts_base_us_ = pts_us;
        MS_LOGI(kTag, "video pts_base set: pts_us=" + std::to_string(pts_us) +
                       " (first packet of session, keyframe=" + (keyframe ? "1" : "0") + ")");
    }
    const int64_t rel_pts_us = pts_us - pts_base_us_;

    std::memcpy(pkt->data, out_data, out_size);
    pkt->stream_index = video_stream_->index;
    pkt->pts = pkt->dts = av_rescale_q(rel_pts_us, AVRational{1, 1'000'000}, video_stream_->time_base);
    pkt->duration = av_rescale_q(1, AVRational{1, video_fps_}, video_stream_->time_base);
    if (keyframe) pkt->flags |= AV_PKT_FLAG_KEY;

    const int64_t write_start_us = now_monotonic_us();
    arm_io_deadline();
    const int err = av_interleaved_write_frame(fmt_ctx_, pkt);
    disarm_io_deadline();
    const int64_t write_elapsed_ms = (now_monotonic_us() - write_start_us) / 1000;
    av_packet_free(&pkt);
    if (err < 0) {
        last_io_subcode_ = classify_av_error(err);
        MS_LOGE(kTag, "av_interleaved_write_frame (video) failed after " +
                       std::to_string(write_elapsed_ms) + "ms (rel_pts=" +
                       std::to_string(rel_pts_us / 1000) + "ms, key=" + (keyframe ? "1" : "0") +
                       ", size=" + std::to_string(out_size) + "B): " + av_err(err));
        return MS_ERR_IO;
    }
    if (write_elapsed_ms >= 500) {
        MS_LOGW(kTag, "video write slow: " + std::to_string(write_elapsed_ms) +
                       "ms (rel_pts=" + std::to_string(rel_pts_us / 1000) + "ms, key=" +
                       (keyframe ? "1" : "0") + ")");
    }
    return MS_OK;
}

ms_result RtmpPublisher::write_audio(const uint8_t* data, size_t size, int64_t pts_us) {
    if (!fmt_ctx_) return MS_ERR_INVALID_STATE;
    if (!data || size == 0) return MS_ERR_INVALID_ARG;
    if (!audio_stream_) return MS_OK;  // video-only сессия

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
        arm_io_deadline();
        const int err = avformat_write_header(fmt_ctx_, nullptr);
        disarm_io_deadline();
        if (err < 0) {
            MS_LOGE(kTag, "avformat_write_header (lazy/audio) failed: " + av_err(err));
            last_io_subcode_ = classify_av_error(err);
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
    if (pts_base_us_ == INT64_MIN) {
        pts_base_us_ = pts_us;
        MS_LOGI(kTag, "audio pts_base set: pts_us=" + std::to_string(pts_us) + " (first packet of session)");
    }
    const int64_t rel_pts_us = pts_us - pts_base_us_;

    std::memcpy(pkt->data, aac.data, aac.size);
    pkt->stream_index = audio_stream_->index;
    pkt->pts = pkt->dts = av_rescale_q(rel_pts_us, AVRational{1, 1'000'000}, audio_stream_->time_base);
    pkt->flags |= AV_PKT_FLAG_KEY;  // AAC — каждый фрейм считается ключевым

    const int64_t write_start_us = now_monotonic_us();
    arm_io_deadline();
    const int err = av_interleaved_write_frame(fmt_ctx_, pkt);
    disarm_io_deadline();
    const int64_t write_elapsed_ms = (now_monotonic_us() - write_start_us) / 1000;
    av_packet_free(&pkt);
    if (err < 0) {
        last_io_subcode_ = classify_av_error(err);
        MS_LOGE(kTag, "av_interleaved_write_frame (audio) failed after " +
                       std::to_string(write_elapsed_ms) + "ms (rel_pts=" +
                       std::to_string(rel_pts_us / 1000) + "ms, size=" +
                       std::to_string(aac.size) + "B): " + av_err(err));
        return MS_ERR_IO;
    }
    if (write_elapsed_ms >= 500) {
        MS_LOGW(kTag, "audio write slow: " + std::to_string(write_elapsed_ms) +
                       "ms (rel_pts=" + std::to_string(rel_pts_us / 1000) + "ms)");
    }
    return MS_OK;
}

ms_result RtmpPublisher::close() {
    if (!fmt_ctx_) return MS_OK;
    MS_LOGI(kTag, "close: header_written=" + std::string(header_written_ ? "1" : "0") +
                   ", pts_base_us=" + std::to_string(pts_base_us_));
    if (header_written_) {
        // На trailer ставим короткий дедлайн — если сокет уже мёртв, не висим.
        const int64_t trailer_start = now_monotonic_us();
        arm_io_deadline();
        const int err = av_write_trailer(fmt_ctx_);
        disarm_io_deadline();
        const int64_t trailer_ms = (now_monotonic_us() - trailer_start) / 1000;
        if (err < 0) {
            MS_LOGW(kTag, "av_write_trailer failed in " + std::to_string(trailer_ms) +
                           "ms: " + av_err(err));
        } else {
            MS_LOGI(kTag, "av_write_trailer ok in " + std::to_string(trailer_ms) + "ms");
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
    has_audio_ = true;
    video_extradata_.clear();
    audio_extradata_.clear();
    pts_base_us_ = INT64_MIN;
    cancel_requested_.store(false, std::memory_order_release);
    return MS_OK;
}

}  // namespace mafbase_stream
