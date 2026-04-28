// Интеграционный тест: ядро публикует синтетический H.264+AAC в локальный
// nginx-rtmp (см. mafbase_stream/dev/docker-compose.yml), затем проверяет, что
// сервер увидел публикацию по эндпоинту /stat.
//
// Тест подразумевает, что nginx-rtmp поднят на localhost:1935 (RTMP) и
// localhost:8080 (HTTP /stat). Если контейнер не запущен — тест пропускается.

#include <gtest/gtest.h>

#include <atomic>
#include <chrono>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <memory>
#include <string>
#include <thread>
#include <vector>

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavutil/channel_layout.h>
#include <libavutil/frame.h>
#include <libavutil/imgutils.h>
#include <libavutil/opt.h>
#include <libavutil/samplefmt.h>
}

#include "mafbase_stream/session.h"

namespace {

constexpr const char* kRtmpUrl = "rtmp://localhost/live/test";
constexpr const char* kStatUrl = "http://localhost:8080/stat";
constexpr const char* kStreamName = "test";

// Скачивает /stat и грубо проверяет, что в нём есть имя нашего стрима.
bool stat_contains_stream(const std::string& expected_stream) {
    std::string cmd = "curl -sf --max-time 2 " + std::string(kStatUrl);
    FILE* fp = popen(cmd.c_str(), "r");
    if (!fp) return false;
    std::string body;
    char buf[4096];
    while (size_t n = fread(buf, 1, sizeof(buf), fp)) {
        body.append(buf, n);
    }
    int rc = pclose(fp);
    if (rc != 0) return false;
    return body.find("<name>" + expected_stream + "</name>") != std::string::npos;
}

bool nginx_alive() {
    return system("curl -sf --max-time 2 http://localhost:8080/ > /dev/null") == 0;
}

struct VideoEncoder {
    AVCodecContext* ctx = nullptr;
    AVFrame* frame = nullptr;
    int width = 0;
    int height = 0;
    int fps = 0;

    ~VideoEncoder() {
        if (frame) av_frame_free(&frame);
        if (ctx) avcodec_free_context(&ctx);
    }
};

struct AudioEncoder {
    AVCodecContext* ctx = nullptr;
    AVFrame* frame = nullptr;
    int sample_rate = 0;
    int channels = 0;

    ~AudioEncoder() {
        if (frame) av_frame_free(&frame);
        if (ctx) avcodec_free_context(&ctx);
    }
};

bool open_video_encoder(VideoEncoder& v, int w, int h, int fps, int bitrate) {
    const AVCodec* codec = avcodec_find_encoder_by_name("libx264");
    if (!codec) codec = avcodec_find_encoder(AV_CODEC_ID_H264);
    if (!codec) return false;

    v.ctx = avcodec_alloc_context3(codec);
    if (!v.ctx) return false;
    v.ctx->width = w;
    v.ctx->height = h;
    v.ctx->time_base = AVRational{1, fps};
    v.ctx->framerate = AVRational{fps, 1};
    v.ctx->pix_fmt = AV_PIX_FMT_YUV420P;
    v.ctx->bit_rate = bitrate;
    v.ctx->gop_size = fps;  // 1 keyframe в секунду
    v.ctx->max_b_frames = 0;
    v.ctx->flags |= AV_CODEC_FLAG_GLOBAL_HEADER;

    av_opt_set(v.ctx->priv_data, "preset", "ultrafast", 0);
    av_opt_set(v.ctx->priv_data, "tune", "zerolatency", 0);
    av_opt_set(v.ctx->priv_data, "profile", "baseline", 0);

    if (avcodec_open2(v.ctx, codec, nullptr) < 0) return false;

    v.frame = av_frame_alloc();
    v.frame->format = AV_PIX_FMT_YUV420P;
    v.frame->width = w;
    v.frame->height = h;
    if (av_frame_get_buffer(v.frame, 32) < 0) return false;

    v.width = w;
    v.height = h;
    v.fps = fps;
    return true;
}

bool open_audio_encoder(AudioEncoder& a, int sample_rate, int channels, int bitrate) {
    const AVCodec* codec = avcodec_find_encoder_by_name("aac");
    if (!codec) return false;

    a.ctx = avcodec_alloc_context3(codec);
    if (!a.ctx) return false;
    a.ctx->sample_rate = sample_rate;
    av_channel_layout_default(&a.ctx->ch_layout, channels);
    a.ctx->sample_fmt = AV_SAMPLE_FMT_FLTP;
    a.ctx->bit_rate = bitrate;
    a.ctx->time_base = AVRational{1, sample_rate};
    a.ctx->flags |= AV_CODEC_FLAG_GLOBAL_HEADER;

    if (avcodec_open2(a.ctx, codec, nullptr) < 0) return false;

    a.frame = av_frame_alloc();
    a.frame->format = AV_SAMPLE_FMT_FLTP;
    a.frame->nb_samples = a.ctx->frame_size > 0 ? a.ctx->frame_size : 1024;
    av_channel_layout_copy(&a.frame->ch_layout, &a.ctx->ch_layout);
    a.frame->sample_rate = sample_rate;
    if (av_frame_get_buffer(a.frame, 0) < 0) return false;

    a.sample_rate = sample_rate;
    a.channels = channels;
    return true;
}

void fill_test_video_frame(AVFrame* frame, int frame_idx) {
    const int w = frame->width;
    const int h = frame->height;
    // Y plane: gradient + перемещающийся прямоугольник
    for (int y = 0; y < h; ++y) {
        for (int x = 0; x < w; ++x) {
            uint8_t v = static_cast<uint8_t>((x + y + frame_idx * 3) & 0xff);
            const int box_x = (frame_idx * 4) % (w - 32);
            const int box_y = h / 2 - 16;
            if (x >= box_x && x < box_x + 32 && y >= box_y && y < box_y + 32) v = 235;
            frame->data[0][y * frame->linesize[0] + x] = v;
        }
    }
    // Chroma: статичный тинт, чтобы было цветное
    for (int y = 0; y < h / 2; ++y) {
        for (int x = 0; x < w / 2; ++x) {
            frame->data[1][y * frame->linesize[1] + x] = 128 + (frame_idx & 0x1f);
            frame->data[2][y * frame->linesize[2] + x] = 128 - (frame_idx & 0x1f);
        }
    }
}

void fill_test_audio_frame(AVFrame* frame, int64_t sample_offset, int sample_rate) {
    const int n = frame->nb_samples;
    const int channels = frame->ch_layout.nb_channels;
    const double freq = 440.0;
    for (int ch = 0; ch < channels; ++ch) {
        auto* dst = reinterpret_cast<float*>(frame->data[ch]);
        for (int i = 0; i < n; ++i) {
            const double t = static_cast<double>(sample_offset + i) / sample_rate;
            dst[i] = 0.2f * static_cast<float>(std::sin(2.0 * M_PI * freq * t));
        }
    }
}

}  // namespace

class RtmpPublishTest : public ::testing::Test {
protected:
    void SetUp() override {
        if (!nginx_alive()) {
            GTEST_SKIP() << "nginx-rtmp недоступен на localhost:8080. "
                         << "Запустите `cd mafbase_stream/dev && docker compose up -d`.";
        }
    }
};

TEST_F(RtmpPublishTest, PublishesSyntheticH264AndAac) {
    constexpr int kWidth = 320;
    constexpr int kHeight = 240;
    constexpr int kFps = 30;
    constexpr int kDurationFrames = 2 * kFps;  // 2 секунды
    constexpr int kSampleRate = 44100;
    constexpr int kChannels = 2;

    VideoEncoder venc;
    AudioEncoder aenc;
    ASSERT_TRUE(open_video_encoder(venc, kWidth, kHeight, kFps, 800'000)) << "video encoder open";
    ASSERT_TRUE(open_audio_encoder(aenc, kSampleRate, kChannels, 96'000)) << "audio encoder open";
    ASSERT_GT(venc.ctx->extradata_size, 0) << "video extradata должна быть готова после avcodec_open2";
    ASSERT_GT(aenc.ctx->extradata_size, 0) << "audio extradata должна быть готова";

    ms_session_params params{};
    params.width = kWidth;
    params.height = kHeight;
    params.fps = kFps;
    params.video_bitrate_bps = 800'000;
    params.audio_sample_rate = kSampleRate;
    params.audio_channels = kChannels;
    params.audio_bitrate_bps = 96'000;
    params.video_extradata = venc.ctx->extradata;
    params.video_extradata_size = static_cast<size_t>(venc.ctx->extradata_size);
    params.audio_extradata = aenc.ctx->extradata;
    params.audio_extradata_size = static_cast<size_t>(aenc.ctx->extradata_size);

    ms_session* session = ms_session_create();
    ASSERT_NE(session, nullptr);

    ASSERT_EQ(ms_session_start(session, kRtmpUrl, &params), MS_OK) << "session start";
    EXPECT_EQ(ms_session_get_state(session), MS_STATE_STREAMING);

    // Энкодим и пушим параллельно — сначала генерируем все video- и audio-пакеты,
    // затем интерливим их по таймштампам.
    struct EncodedPacket {
        std::vector<uint8_t> data;
        int64_t pts_us;
        bool keyframe;
        bool is_video;
    };
    std::vector<EncodedPacket> queue;

    auto drain_video = [&](AVPacket* pkt) {
        while (true) {
            const int r = avcodec_receive_packet(venc.ctx, pkt);
            if (r == AVERROR(EAGAIN) || r == AVERROR_EOF) return;
            ASSERT_GE(r, 0);
            // pts из time_base {1,fps} → микросекунды
            const int64_t pts_us = av_rescale_q(pkt->pts, venc.ctx->time_base, AVRational{1, 1'000'000});
            EncodedPacket ep;
            ep.data.assign(pkt->data, pkt->data + pkt->size);
            ep.pts_us = pts_us;
            ep.keyframe = (pkt->flags & AV_PKT_FLAG_KEY) != 0;
            ep.is_video = true;
            queue.push_back(std::move(ep));
            av_packet_unref(pkt);
        }
    };

    auto drain_audio = [&](AVPacket* pkt) {
        while (true) {
            const int r = avcodec_receive_packet(aenc.ctx, pkt);
            if (r == AVERROR(EAGAIN) || r == AVERROR_EOF) return;
            ASSERT_GE(r, 0);
            const int64_t pts_us = av_rescale_q(pkt->pts, aenc.ctx->time_base, AVRational{1, 1'000'000});
            EncodedPacket ep;
            ep.data.assign(pkt->data, pkt->data + pkt->size);
            ep.pts_us = pts_us;
            ep.keyframe = true;
            ep.is_video = false;
            queue.push_back(std::move(ep));
            av_packet_unref(pkt);
        }
    };

    AVPacket* pkt = av_packet_alloc();
    ASSERT_NE(pkt, nullptr);

    // Видео
    for (int i = 0; i < kDurationFrames; ++i) {
        ASSERT_GE(av_frame_make_writable(venc.frame), 0);
        fill_test_video_frame(venc.frame, i);
        venc.frame->pts = i;
        ASSERT_GE(avcodec_send_frame(venc.ctx, venc.frame), 0);
        drain_video(pkt);
    }
    ASSERT_GE(avcodec_send_frame(venc.ctx, nullptr), 0);
    drain_video(pkt);

    // Аудио (≈2 секунды)
    int64_t sample_offset = 0;
    const int64_t total_samples = static_cast<int64_t>(kSampleRate) * 2;
    while (sample_offset < total_samples) {
        ASSERT_GE(av_frame_make_writable(aenc.frame), 0);
        fill_test_audio_frame(aenc.frame, sample_offset, kSampleRate);
        aenc.frame->pts = sample_offset;
        ASSERT_GE(avcodec_send_frame(aenc.ctx, aenc.frame), 0);
        drain_audio(pkt);
        sample_offset += aenc.frame->nb_samples;
    }
    ASSERT_GE(avcodec_send_frame(aenc.ctx, nullptr), 0);
    drain_audio(pkt);

    av_packet_free(&pkt);

    // Сортируем по pts (стабильно — внутри одинаковых pts видео раньше аудио)
    std::stable_sort(queue.begin(), queue.end(), [](const EncodedPacket& a, const EncodedPacket& b) {
        if (a.pts_us != b.pts_us) return a.pts_us < b.pts_us;
        return a.is_video && !b.is_video;
    });

    // Реалтайм-пейсинг: отдаём пакеты не быстрее их pts, чтобы nginx не дропнул
    // публикацию из-за слишком плотного потока.
    const auto start_wall = std::chrono::steady_clock::now();
    for (const auto& ep : queue) {
        const auto target = start_wall + std::chrono::microseconds(ep.pts_us);
        std::this_thread::sleep_until(target);
        if (ep.is_video) {
            ASSERT_EQ(ms_session_push_video(session, ep.data.data(), ep.data.size(),
                                            ep.pts_us, ep.keyframe),
                      MS_OK);
        } else {
            ASSERT_EQ(ms_session_push_audio(session, ep.data.data(), ep.data.size(), ep.pts_us), MS_OK);
        }
    }

    // Проверка, что nginx-rtmp видит наш стрим, пока он ещё открыт.
    bool seen = false;
    for (int i = 0; i < 10 && !seen; ++i) {
        seen = stat_contains_stream(kStreamName);
        if (!seen) std::this_thread::sleep_for(std::chrono::milliseconds(200));
    }
    EXPECT_TRUE(seen) << "stream `" << kStreamName << "` не появился в /stat за 2 секунды";

    EXPECT_EQ(ms_session_stop(session), MS_OK);
    EXPECT_EQ(ms_session_get_state(session), MS_STATE_STOPPED);

    // Повторный stop — идемпотентен
    EXPECT_EQ(ms_session_stop(session), MS_OK);

    ms_session_destroy(session);
}

TEST(StateMachineApi, IdleAfterCreate) {
    ms_session* s = ms_session_create();
    ASSERT_NE(s, nullptr);
    EXPECT_EQ(ms_session_get_state(s), MS_STATE_IDLE);
    ms_session_destroy(s);
}

TEST(StateMachineApi, PushBeforeStartIsRejected) {
    ms_session* s = ms_session_create();
    ASSERT_NE(s, nullptr);
    const uint8_t dummy[8] = {0};
    EXPECT_EQ(ms_session_push_video(s, dummy, sizeof(dummy), 0, true), MS_ERR_INVALID_STATE);
    EXPECT_EQ(ms_session_push_audio(s, dummy, sizeof(dummy), 0), MS_ERR_INVALID_STATE);
    ms_session_destroy(s);
}

TEST(StateMachineApi, NullArgsAreRejected) {
    EXPECT_EQ(ms_session_start(nullptr, "rtmp://x", nullptr), MS_ERR_INVALID_ARG);
    EXPECT_EQ(ms_session_stop(nullptr), MS_ERR_INVALID_ARG);
    EXPECT_EQ(ms_session_get_state(nullptr), MS_STATE_STOPPED);
}
