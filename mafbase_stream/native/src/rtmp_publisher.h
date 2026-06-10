#ifndef MAFBASE_STREAM_RTMP_PUBLISHER_H
#define MAFBASE_STREAM_RTMP_PUBLISHER_H

#include <atomic>
#include <chrono>
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
//
// Сетевые таймауты:
//  - rw_timeout (option) ставится на FFmpeg AVIO. Это нижний предохранитель:
//    операции чтения/записи не должны висеть дольше указанного.
//  - AVIOInterruptCB.callback срабатывает либо при истечении дедлайна (см.
//    `arm_io_deadline()` перед каждой сетевой операцией), либо при выставленном
//    `cancel_requested_`. Это даёт мгновенный выход из mutex'ов FFmpeg при
//    стопе/реконнекте, не дожидаясь rw_timeout.
class RtmpPublisher {
public:
    RtmpPublisher();
    ~RtmpPublisher();

    RtmpPublisher(const RtmpPublisher&) = delete;
    RtmpPublisher& operator=(const RtmpPublisher&) = delete;

    // Открывает RTMP-сессию. io_timeout_us — лимит для одной операции
    // (rw_timeout + дедлайн в interrupt_cb). 0 → 3 000 000 (3 с).
    ms_result open(const std::string& url, const ms_session_params& params, int io_timeout_us);
    ms_result write_video(const uint8_t* data, size_t size, int64_t pts_us, bool keyframe);
    ms_result write_audio(const uint8_t* data, size_t size, int64_t pts_us);
    ms_result close();

    // Подкод последней IO-ошибки. Сбрасывается в open(), обновляется внутри
    // write_video/write_audio при возврате MS_ERR_IO.
    ms_io_subcode last_io_subcode() const { return last_io_subcode_; }

    // Сигнализирует FFmpeg-потоку «отмени всё что висит». Вызывается из
    // другого потока (writer-thread или сессии) при стопе или таймауте.
    // Безопасен относительно конкурентного выполнения write_*.
    void request_cancel() { cancel_requested_.store(true, std::memory_order_release); }

private:
    ms_result init_video_stream(const ms_session_params& params);
    ms_result init_audio_stream(const ms_session_params& params);

    // Перед каждой блокирующей FFmpeg-операцией вызываем arm_io_deadline(),
    // чтобы interrupt_cb имел актуальный дедлайн. После успеха — disarm().
    void arm_io_deadline();
    void disarm_io_deadline();

    // Колбек, который FFmpeg периодически дёргает из своих сетевых операций.
    // Возвращаем 1 → прервать. Привязка через AVIOInterruptCB.opaque = this.
    static int io_interrupt_cb(void* opaque);

    // Преобразует код ошибки FFmpeg в ms_io_subcode (timeout/eof/connreset/other).
    static ms_io_subcode classify_av_error(int err);

    AVFormatContext* fmt_ctx_ = nullptr;
    AVStream* video_stream_ = nullptr;
    AVStream* audio_stream_ = nullptr;
    bool header_written_ = false;
    bool has_audio_ = true;  // false для video-only сессий (audio_extradata не передан)

    int video_fps_ = 30;
    int io_timeout_us_ = 10'000'000;

    // PTS первого пакета (из любой дорожки) в текущей RTMP-сессии. Все
    // последующие PTS пишутся как (pts_us - pts_base_us_), чтобы каждая сессия
    // (включая после reconnect) начиналась с ~0. Без этого FLV-таймстампы после
    // переподключения уезжают на десятки секунд вперёд, и плееры (VK Live)
    // считают поток «зависшим». INT64_MIN = ещё не инициализирован.
    int64_t pts_base_us_ = INT64_MIN;

    // Кеш SPS/PPS, извлекаемых из первого keyframe в Annex-B, если extradata
    // не передан в params. Нужен FFmpeg для FLV-muxer (он требует extradata
    // при write_header). На практике задаём extradata перед open.
    std::vector<uint8_t> video_extradata_;
    std::vector<uint8_t> audio_extradata_;

    // Дедлайн для текущей IO-операции в монотонных микросекундах. 0 = не армирован.
    std::atomic<int64_t> io_deadline_us_{0};
    std::atomic<bool> cancel_requested_{false};
    // Защёлка, чтобы interrupt_cb писал лог-причину прерывания только один раз
    // на одну операцию (FFmpeg может дёргать колбек десятки раз в секунду).
    std::atomic<bool> interrupt_logged_{false};
    ms_io_subcode last_io_subcode_ = MS_IO_NONE;
};

}  // namespace mafbase_stream

#endif
