#include "reconnect_policy.h"

namespace mafbase_stream {

ReconnectPolicy::ReconnectPolicy(Config cfg) : cfg_(cfg) {
    if (cfg_.max_attempts <= 0) cfg_.max_attempts = 3;
    if (cfg_.base_delay_ms <= 0) cfg_.base_delay_ms = 1000;
    if (cfg_.cap_delay_ms <= 0) cfg_.cap_delay_ms = 8000;
}

void ReconnectPolicy::reset() { attempt_ = 0; }

bool ReconnectPolicy::advance() {
    if (attempt_ >= cfg_.max_attempts) return false;
    ++attempt_;
    return true;
}

int ReconnectPolicy::next_delay_ms() const {
    if (attempt_ <= 0) return cfg_.base_delay_ms;
    int delay = cfg_.base_delay_ms;
    for (int i = 1; i < attempt_; ++i) {
        delay *= 2;
        if (delay >= cfg_.cap_delay_ms) {
            delay = cfg_.cap_delay_ms;
            break;
        }
    }
    return delay;
}

}  // namespace mafbase_stream
