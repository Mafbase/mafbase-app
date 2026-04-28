#ifndef MAFBASE_STREAM_NETWORK_BITRATE_CONTROLLER_H
#define MAFBASE_STREAM_NETWORK_BITRATE_CONTROLLER_H

#include <chrono>

#include "mafbase_stream/session.h"

namespace mafbase_stream {

// Адаптивный битрейт.
//
// Лестница 100% → 75% → 50% → 33% от выбранного preset. Понижение быстрое
// (срабатывает при первом сигнале давления), повышение медленное (после
// `kStableSeconds` секунд штиля).
//
// Гистерезис: чтобы не «качать» битрейт между соседними ступенями.
class BitrateController {
public:
    struct Config {
        int preset_bps = 4'000'000;
        int stable_seconds = 10;
        int low_water_depth_ms = 200;  // ниже этой глубины очереди — кандидат на повышение
    };

    explicit BitrateController(Config cfg);

    // Подкармливает контроллер метриками (вызывается из writer-thread на
    // каждом emit_event). Возвращает новый целевой битрейт, либо 0, если
    // менять не нужно. Решение фильтруется по гистерезису внутри.
    int update(int queue_depth_video_ms,
               int queue_depth_audio_ms,
               int dropped_in_window,
               ms_backpressure bp);

    int current_bps() const { return current_bps_; }

private:
    int compute_target_for_step(int step) const;

    Config cfg_;
    int current_step_ = 0;  // 0 = 100%, 1 = 75%, 2 = 50%, 3 = 33%
    int current_bps_;
    std::chrono::steady_clock::time_point last_change_;
};

}  // namespace mafbase_stream

#endif
