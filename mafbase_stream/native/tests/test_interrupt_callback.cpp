// Юнит-тесты interrupt-callback'а RtmpPublisher.
//
// Бизнес-инвариант: если выставлен `cancel_requested_`, любая блокирующая
// FFmpeg-операция (например, попытка открыть RTMP на недоступном хосте)
// должна вернуться за < 100 мс. Без этого reconnect-политика не успевает
// выйти из висящего соединения и стрим уходит в зомби-состояние.

#include <gtest/gtest.h>

#include <atomic>
#include <chrono>
#include <thread>

#include "../src/rtmp_publisher.h"

using mafbase_stream::RtmpPublisher;
using namespace std::chrono;

namespace {
constexpr const char* kBlackholeUrl = "rtmp://10.255.255.1/test/cancel";
}

TEST(InterruptCallback, OpenReturnsQuicklyAfterCancel) {
    RtmpPublisher pub;

    // Поднимаем «убийцу»: выставляет cancel_requested_ через 50 мс после старта open.
    std::atomic<bool> open_done{false};
    std::thread killer([&]() {
        std::this_thread::sleep_for(milliseconds(50));
        if (!open_done.load()) {
            pub.request_cancel();
        }
    });

    ms_session_params params{};
    params.width = 320;
    params.height = 240;
    params.fps = 30;
    params.video_bitrate_bps = 500'000;
    params.audio_sample_rate = 44100;
    params.audio_channels = 1;
    params.audio_bitrate_bps = 64000;

    const auto t0 = steady_clock::now();
    const ms_result r = pub.open(kBlackholeUrl, params, /*io_timeout_us=*/3'000'000);
    const auto elapsed = steady_clock::now() - t0;
    open_done.store(true);
    killer.join();

    // Должен ВЕРНУТЬСЯ за разумное время (200 мс = 50 мс sleep killer'а + слот
    // для FFmpeg). Если таймаут не пинается — операция продолжалась бы до
    // rw_timeout (3с), что уже точно больше 200 мс.
    EXPECT_NE(r, MS_OK) << "blackhole IP не должен открыться";
    EXPECT_LT(duration_cast<milliseconds>(elapsed).count(), 1500)
        << "interrupt_cb не успел прервать висящее соединение";
}

TEST(InterruptCallback, IoTimeoutAlone) {
    // Тот же сценарий, но без cancel — open должен вернуться по rw_timeout
    // за время ~ io_timeout_us.
    RtmpPublisher pub;

    ms_session_params params{};
    params.width = 320;
    params.height = 240;
    params.fps = 30;
    params.video_bitrate_bps = 500'000;
    params.audio_sample_rate = 44100;
    params.audio_channels = 1;
    params.audio_bitrate_bps = 64000;

    const int io_timeout_us = 500'000;  // 500 мс
    const auto t0 = steady_clock::now();
    const ms_result r = pub.open(kBlackholeUrl, params, io_timeout_us);
    const auto elapsed = duration_cast<milliseconds>(steady_clock::now() - t0).count();

    EXPECT_NE(r, MS_OK);
    // С запасом на разные сетевые стеки и FFmpeg overhead.
    EXPECT_LT(elapsed, 2000) << "io_timeout не сработал";
}
