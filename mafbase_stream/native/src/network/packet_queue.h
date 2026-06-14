#ifndef MAFBASE_STREAM_NETWORK_PACKET_QUEUE_H
#define MAFBASE_STREAM_NETWORK_PACKET_QUEUE_H

#include <atomic>
#include <condition_variable>
#include <cstdint>
#include <deque>
#include <mutex>
#include <vector>

namespace mafbase_stream {

enum class StreamKind { Video, Audio };

// Один сжатый пакет в очереди отправителя. Owns data — конструктор копирует
// payload во владение, чтобы продюсер мог сразу освободить буфер MediaCodec/VT.
struct EncodedPacket {
    StreamKind stream;
    int64_t pts_us;
    bool is_keyframe;
    std::vector<uint8_t> data;

    EncodedPacket() = default;
    EncodedPacket(StreamKind s, int64_t pts, bool key, const uint8_t* src, size_t n)
        : stream(s), pts_us(pts), is_keyframe(key), data(src, src + n) {}
};

// Поточно-безопасная очередь с двумя FIFO внутри (видео и аудио).
//
// Drop-политика при превышении бюджета (см. PacketQueue::Config):
//   1. Самые старые видео non-keyframe.
//   2. Самые старые видео keyframe (целиком ушедший GOP — после шага 1
//      non-keyframe'ов в очереди уже нет).
//   3. Аудио — только если byte_cap всё ещё не уложился (на практике никогда:
//      AAC 128 kbit/s в 4 MB кэп влезает ~4 мин). budget_audio_ms аудио НЕ
//      дропает — иначе при долгих блокировках send'а ffplay получает рваный
//      AAC с PTS-дырами и его декодер теряет sync безвозвратно.
//
// Аудио приоритетнее видео: при плохой сети звук должен дойти до плеера, а
// картинка может лагать. Если бы аудио дропалось раньше видео keyframe,
// приёмник терял бы A/V-sync и видео шло бы пачками между keyframe'ами на
// ускоренной скорости.
//
// Дренаж — через `pop_for_send`, который выдаёт следующий пакет для отправки,
// интерливя по PTS (между видео и аудио — что было раньше). При пустой очереди
// блокируется в `wait` до push'а или до `close()`.
class PacketQueue {
public:
    struct Config {
        // budget_video_ms — порог при котором мы дропаем старое видео. Держим
        // тесно (500ms), иначе плеер не успевает: при канале меньше энкодерного
        // битрейта queue копит delay; за 1.5с накапливается > jitter-buffer'а
        // плеера и звук с видео обрываются вместе.
        int budget_video_ms = 500;
        int budget_audio_ms = 2000;
        int byte_cap = 4 * 1024 * 1024;  // 4 MB
    };

    struct Stats {
        // Текущая глубина очереди (по PTS) для каждой дорожки, в миллисекундах.
        int video_depth_ms = 0;
        int audio_depth_ms = 0;
        // Размер всех пакетов в очереди в байтах.
        int bytes_used = 0;
        // Сколько пакетов в каждой подочереди.
        int video_count = 0;
        int audio_count = 0;
        // Общий счётчик дропов за жизнь очереди.
        int dropped_total = 0;
        int dropped_video_total = 0;
        int dropped_audio_total = 0;
    };

    explicit PacketQueue(Config cfg);

    // Кладёт пакет в соответствующую подочередь и применяет drop-политику.
    // Возвращает true, если пакет принят; false — если он сам был дропнут
    // (это случай, когда extradata-конфигу не хватает места — на практике не
    // происходит, т.к. cap >> размера IDR).
    bool push(EncodedPacket pkt);

    // Блокируется до появления пакета или до close(). Возвращает false при
    // закрытой очереди и пустых FIFO.
    bool wait_and_pop(EncodedPacket& out);

    // Неблокирующий вариант: пытается извлечь пакет, возвращает false, если
    // очередь сейчас пуста.
    bool try_pop(EncodedPacket& out);

    // Будит всех ожидающих и переводит очередь в режим «слив». После close()
    // push() возвращает false, wait_and_pop() выдаёт всё оставшееся, затем false.
    void close();

    // Сбрасывает все пакеты (например, при reconnect, чтобы не отдавать старое
    // состояние на новое соединение). Stats.dropped_total НЕ инкрементируется
    // (это явный flush, а не overflow drop).
    void clear();

    Stats stats() const;

private:
    // Применяет drop-политику до тех пор, пока бюджет не выполнен. Должен
    // вызываться под mu_.
    void enforce_budget_locked();

    // Возвращает PTS-глубину подочереди (последний - первый, в мс).
    static int depth_ms_locked(const std::deque<EncodedPacket>& q);

    Config cfg_;

    mutable std::mutex mu_;
    std::condition_variable cv_;

    std::deque<EncodedPacket> video_;
    std::deque<EncodedPacket> audio_;
    int bytes_used_ = 0;
    bool closed_ = false;

    std::atomic<int> dropped_total_{0};
    std::atomic<int> dropped_video_total_{0};
    std::atomic<int> dropped_audio_total_{0};
};

}  // namespace mafbase_stream

#endif
