#include "bitrate_controller.h"

#include <algorithm>

namespace mafbase_stream {

namespace {
// Лестница: 100, 75, 50, 33, 20, 10 процентов. Нижние ступени нужны при сильных
// потерях + RTT: TCP throughput при 2% loss и 200ms RTT ≈ 400-1000 kbit/s,
// поэтому при preset 4Mbit нужно уметь падать до ~400-600 kbit/s.
constexpr int kSteps = 6;
constexpr int kPercents[kSteps] = {100, 75, 50, 33, 20, 10};
}  // namespace

BitrateController::BitrateController(Config cfg)
    : cfg_(cfg),
      current_bps_(cfg.preset_bps > 0 ? cfg.preset_bps : 2'000'000),
      last_change_(std::chrono::steady_clock::now()) {
    if (cfg_.stable_seconds <= 0) cfg_.stable_seconds = 10;
    if (cfg_.low_water_depth_ms <= 0) cfg_.low_water_depth_ms = 200;
}

int BitrateController::compute_target_for_step(int step) const {
    if (step < 0) step = 0;
    if (step >= kSteps) step = kSteps - 1;
    const long long preset = cfg_.preset_bps;
    return static_cast<int>(preset * kPercents[step] / 100);
}

int BitrateController::update(int queue_depth_video_ms,
                              int queue_depth_audio_ms,
                              int dropped_in_window,
                              ms_backpressure bp) {
    using clock = std::chrono::steady_clock;
    const auto now = clock::now();
    const int worst_depth = std::max(queue_depth_video_ms, queue_depth_audio_ms);

    // 1) Понижаем быстро. HIGH backpressure или дропы за окно → шаг вниз.
    if ((bp == MS_BP_HIGH || dropped_in_window > 0) && current_step_ < kSteps - 1) {
        ++current_step_;
        current_bps_ = compute_target_for_step(current_step_);
        last_change_ = now;
        return current_bps_;
    }

    // 2) Повышаем медленно. Должен пройти stable_seconds, очередь под low-water,
    //    bp == NONE и без дропов.
    if (bp == MS_BP_NONE && dropped_in_window == 0 &&
        worst_depth < cfg_.low_water_depth_ms && current_step_ > 0) {
        const auto elapsed = std::chrono::duration_cast<std::chrono::seconds>(
                                 now - last_change_)
                                 .count();
        if (elapsed >= cfg_.stable_seconds) {
            --current_step_;
            current_bps_ = compute_target_for_step(current_step_);
            last_change_ = now;
            return current_bps_;
        }
    }

    return 0;
}

}  // namespace mafbase_stream
