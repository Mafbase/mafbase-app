#include "packet_queue.h"

namespace mafbase_stream {

PacketQueue::PacketQueue(Config cfg) : cfg_(cfg) {
    if (cfg_.budget_video_ms <= 0) cfg_.budget_video_ms = 500;
    if (cfg_.budget_audio_ms <= 0) cfg_.budget_audio_ms = 2000;
    if (cfg_.byte_cap <= 0) cfg_.byte_cap = 4 * 1024 * 1024;
}

int PacketQueue::depth_ms_locked(const std::deque<EncodedPacket>& q) {
    if (q.size() < 2) return 0;
    const int64_t span_us = q.back().pts_us - q.front().pts_us;
    if (span_us <= 0) return 0;
    return static_cast<int>(span_us / 1000);
}

bool PacketQueue::push(EncodedPacket pkt) {
    const int packet_bytes = static_cast<int>(pkt.data.size());
    {
        std::lock_guard<std::mutex> lk(mu_);
        if (closed_) return false;

        if (pkt.stream == StreamKind::Video) {
            video_.push_back(std::move(pkt));
        } else {
            audio_.push_back(std::move(pkt));
        }
        bytes_used_ += packet_bytes;

        enforce_budget_locked();
    }
    cv_.notify_one();
    return true;
}

void PacketQueue::enforce_budget_locked() {
    auto video_over = [&]() { return depth_ms_locked(video_) > cfg_.budget_video_ms; };
    auto audio_over = [&]() { return depth_ms_locked(audio_) > cfg_.budget_audio_ms; };
    auto bytes_over = [&]() { return bytes_used_ > cfg_.byte_cap; };

    // Шаг 1: дропаем самые старые видео non-keyframe. Триггер — только видео-
    // или байт-перегрузка; распухший аудио сам по себе видео не дропает.
    auto needs_video_drop = [&]() { return video_over() || bytes_over(); };
    while (needs_video_drop()) {
        bool dropped_any = false;
        for (auto it = video_.begin(); it != video_.end(); ++it) {
            if (!it->is_keyframe) {
                bytes_used_ -= static_cast<int>(it->data.size());
                video_.erase(it);
                dropped_total_.fetch_add(1, std::memory_order_relaxed);
                dropped_video_total_.fetch_add(1, std::memory_order_relaxed);
                dropped_any = true;
                break;
            }
        }
        if (!dropped_any) break;
    }

    // Шаг 2: если всё ещё над лимитом — дропаем самые старые видео keyframe
    // (после шага 1 non-keyframe'ов уже нет, так что front — keyframe). Аудио
    // не трогаем: пусть лучше плеер увидит «застывший» кадр, но услышит звук.
    while (needs_video_drop() && !video_.empty()) {
        bytes_used_ -= static_cast<int>(video_.front().data.size());
        video_.pop_front();
        dropped_total_.fetch_add(1, std::memory_order_relaxed);
        dropped_video_total_.fetch_add(1, std::memory_order_relaxed);
    }

    // Шаг 3: дропаем аудио только если byte_cap всё ещё не уложился — это
    // последний резерв на случай гигантской утечки. По audio_depth_ms сами
    // дропать НЕ будем: AAC 128 kbit/s — это ~16 KB/с, в 4 MB кэп влезает
    // ~4 минуты звука, а WriterThread по io_timeout раньше упадёт в reconnect.
    //
    // Историческая причина: при долгих блокировках send'а (`av_interleaved_
    // write_frame` 2–3 с) очередь аудио распухает выше своего budget'а быстрее,
    // чем видео — и если дропать её по depth, ffplay получает рваный AAC c
    // большими PTS-дырами, его декодер теряет sync и звук пропадает совсем
    // даже после восстановления сети.
    (void)audio_over;
    while (bytes_over() && !audio_.empty()) {
        bytes_used_ -= static_cast<int>(audio_.front().data.size());
        audio_.pop_front();
        dropped_total_.fetch_add(1, std::memory_order_relaxed);
        dropped_audio_total_.fetch_add(1, std::memory_order_relaxed);
    }
}

bool PacketQueue::wait_and_pop(EncodedPacket& out) {
    std::unique_lock<std::mutex> lk(mu_);
    cv_.wait(lk, [&]() { return closed_ || !video_.empty() || !audio_.empty(); });
    if (video_.empty() && audio_.empty()) return false;  // closed

    auto& chosen = [&]() -> std::deque<EncodedPacket>& {
        if (video_.empty()) return audio_;
        if (audio_.empty()) return video_;
        // Интерливим по PTS. На равенстве — отдаём видео раньше: FLV-muxer
        // ожидает video-config-frame на нулевом PTS до audio.
        return (video_.front().pts_us <= audio_.front().pts_us) ? video_ : audio_;
    }();
    out = std::move(chosen.front());
    chosen.pop_front();
    bytes_used_ -= static_cast<int>(out.data.size());
    return true;
}

bool PacketQueue::try_pop(EncodedPacket& out) {
    std::lock_guard<std::mutex> lk(mu_);
    if (video_.empty() && audio_.empty()) return false;
    auto& chosen = [&]() -> std::deque<EncodedPacket>& {
        if (video_.empty()) return audio_;
        if (audio_.empty()) return video_;
        return (video_.front().pts_us <= audio_.front().pts_us) ? video_ : audio_;
    }();
    out = std::move(chosen.front());
    chosen.pop_front();
    bytes_used_ -= static_cast<int>(out.data.size());
    return true;
}

void PacketQueue::close() {
    {
        std::lock_guard<std::mutex> lk(mu_);
        closed_ = true;
    }
    cv_.notify_all();
}

void PacketQueue::clear() {
    std::lock_guard<std::mutex> lk(mu_);
    video_.clear();
    audio_.clear();
    bytes_used_ = 0;
}

PacketQueue::Stats PacketQueue::stats() const {
    std::lock_guard<std::mutex> lk(mu_);
    Stats s;
    s.video_depth_ms = depth_ms_locked(video_);
    s.audio_depth_ms = depth_ms_locked(audio_);
    s.bytes_used = bytes_used_;
    s.video_count = static_cast<int>(video_.size());
    s.audio_count = static_cast<int>(audio_.size());
    s.dropped_total = dropped_total_.load(std::memory_order_relaxed);
    s.dropped_video_total = dropped_video_total_.load(std::memory_order_relaxed);
    s.dropped_audio_total = dropped_audio_total_.load(std::memory_order_relaxed);
    return s;
}

}  // namespace mafbase_stream
