// Юнит-тесты PacketQueue (см. native/src/network/packet_queue.h).
//
// Покрываем: drop-политику (1. non-keyframe видео; 2. keyframe видео; 3. аудио
// последним — только если само распухло), интерливинг по PTS, корректность под
// нагрузкой (stress с двумя продюсерами и одним консьюмером — без дедлоков).

#include <gtest/gtest.h>

#include <atomic>
#include <chrono>
#include <random>
#include <thread>
#include <vector>

#include "../src/network/packet_queue.h"

using mafbase_stream::EncodedPacket;
using mafbase_stream::PacketQueue;
using mafbase_stream::StreamKind;

namespace {

EncodedPacket make_video(int64_t pts_us, bool key, size_t bytes = 1024) {
    std::vector<uint8_t> data(bytes, 0xab);
    return EncodedPacket(StreamKind::Video, pts_us, key, data.data(), data.size());
}

EncodedPacket make_audio(int64_t pts_us, size_t bytes = 256) {
    std::vector<uint8_t> data(bytes, 0xcd);
    return EncodedPacket(StreamKind::Audio, pts_us, true, data.data(), data.size());
}

}  // namespace

TEST(PacketQueueTest, EmptyQueueClosePopsFalse) {
    PacketQueue q({});
    q.close();
    EncodedPacket out;
    EXPECT_FALSE(q.wait_and_pop(out));
}

TEST(PacketQueueTest, FifoOrderWithinStream) {
    PacketQueue q({});
    EXPECT_TRUE(q.push(make_video(0, true)));
    EXPECT_TRUE(q.push(make_video(33000, false)));
    EXPECT_TRUE(q.push(make_video(66000, false)));
    q.close();

    EncodedPacket out;
    ASSERT_TRUE(q.wait_and_pop(out));
    EXPECT_EQ(out.pts_us, 0);
    ASSERT_TRUE(q.wait_and_pop(out));
    EXPECT_EQ(out.pts_us, 33000);
    ASSERT_TRUE(q.wait_and_pop(out));
    EXPECT_EQ(out.pts_us, 66000);
    EXPECT_FALSE(q.wait_and_pop(out));
}

TEST(PacketQueueTest, InterleavesByPts) {
    PacketQueue q({});
    EXPECT_TRUE(q.push(make_video(0, true)));
    EXPECT_TRUE(q.push(make_audio(20000)));
    EXPECT_TRUE(q.push(make_video(33000, false)));
    EXPECT_TRUE(q.push(make_audio(40000)));
    q.close();

    EncodedPacket out;
    ASSERT_TRUE(q.wait_and_pop(out));
    EXPECT_EQ(out.stream, StreamKind::Video);
    EXPECT_EQ(out.pts_us, 0);
    ASSERT_TRUE(q.wait_and_pop(out));
    EXPECT_EQ(out.stream, StreamKind::Audio);
    EXPECT_EQ(out.pts_us, 20000);
    ASSERT_TRUE(q.wait_and_pop(out));
    EXPECT_EQ(out.stream, StreamKind::Video);
    EXPECT_EQ(out.pts_us, 33000);
    ASSERT_TRUE(q.wait_and_pop(out));
    EXPECT_EQ(out.stream, StreamKind::Audio);
    EXPECT_EQ(out.pts_us, 40000);
}

TEST(PacketQueueTest, DropsNonKeyframeVideoBeforeKeyframe) {
    PacketQueue::Config cfg;
    cfg.budget_video_ms = 100;  // 0.1с — легко превысить
    cfg.budget_audio_ms = 10000;
    cfg.byte_cap = 1024 * 1024;
    PacketQueue q(cfg);

    // 1 keyframe + 10 non-keyframe, PTS-spread 500 мс — гарантированно сверх budget.
    q.push(make_video(0, true));
    for (int i = 1; i <= 10; ++i) {
        q.push(make_video(i * 50 * 1000, false));
    }
    const auto stats = q.stats();

    // Keyframe должен остаться. Часть non-keyframe — выбита.
    EXPECT_EQ(stats.video_count, 1);  // только keyframe
    EXPECT_GE(stats.dropped_video_total, 9);

    // Первый pop — это keyframe.
    EncodedPacket out;
    q.close();
    ASSERT_TRUE(q.wait_and_pop(out));
    EXPECT_TRUE(out.is_keyframe);
    EXPECT_EQ(out.stream, StreamKind::Video);
}

TEST(PacketQueueTest, AudioBudgetAloneDoesNotDrop) {
    // Очередь только из keyframe + аудио, audio_depth_ms сильно выше своего
    // budget'а, но byte_cap не превышен. Ожидаем: аудио НЕ дропается.
    // Историческая мотивация — см. doc-comment к PacketQueue: при долгом
    // зависании send'а audio depth растёт быстрее video, и если бы дропали
    // его по depth, ffplay терял A/V-sync безвозвратно.
    PacketQueue::Config cfg;
    cfg.budget_video_ms = 100000;
    cfg.budget_audio_ms = 100;  // 0.1с — заведомо превысим
    cfg.byte_cap = 1024 * 1024;
    PacketQueue q(cfg);

    q.push(make_video(0, true));
    for (int i = 0; i < 20; ++i) {
        q.push(make_audio(i * 20 * 1000));  // 0..380ms — depth=380ms >> 100ms
    }
    const auto stats = q.stats();
    EXPECT_EQ(stats.dropped_audio_total, 0);
    EXPECT_EQ(stats.audio_count, 20);
    EXPECT_EQ(stats.video_count, 1);
}

TEST(PacketQueueTest, AudioDroppedOnlyWhenByteCapExceeded) {
    // Аудио дропается только при упирании в byte_cap (последний резерв).
    PacketQueue::Config cfg;
    cfg.budget_video_ms = 60000;
    cfg.budget_audio_ms = 60000;
    cfg.byte_cap = 8 * 1024;  // совсем мал, упрёмся даже в одно аудио
    PacketQueue q(cfg);

    for (int i = 0; i < 20; ++i) {
        q.push(make_audio(i * 20 * 1000, 1024));  // 20 KB — выше cap
    }
    const auto stats = q.stats();
    EXPECT_GT(stats.dropped_audio_total, 0);
    EXPECT_LE(stats.bytes_used, cfg.byte_cap + 1024);
}

TEST(PacketQueueTest, KeyframeDroppedBeforeAudioWhenVideoOverBudget) {
    // Видео — только keyframe'ы (non-keyframe нет), их PTS-spread сильно
    // больше budget_video_ms. Аудио в норме. Ожидаем: дропаются видео keyframe
    // (политика «звук приоритетнее картинки»), аудио сохраняется целиком.
    PacketQueue::Config cfg;
    cfg.budget_video_ms = 500;
    cfg.budget_audio_ms = 60000;
    cfg.byte_cap = 1024 * 1024;
    PacketQueue q(cfg);

    for (int i = 0; i < 5; ++i) {
        q.push(make_video(i * 1000 * 1000 /*1с*/, true));
    }
    for (int i = 0; i < 10; ++i) {
        q.push(make_audio(i * 20 * 1000));
    }

    const auto stats = q.stats();
    EXPECT_GT(stats.dropped_video_total, 0);
    EXPECT_LE(stats.video_count, 1);  // выживает только последний keyframe (depth = 0)
    EXPECT_EQ(stats.dropped_audio_total, 0);
    EXPECT_EQ(stats.audio_count, 10);
}

TEST(PacketQueueTest, AudioPreservedWhenOnlyVideoOverflowsByteCap) {
    // Видео упирается в byte_cap, аудио невелико. Ожидаем: всё видео
    // выпиливается, аудио сохраняется.
    PacketQueue::Config cfg;
    cfg.budget_video_ms = 60000;
    cfg.budget_audio_ms = 60000;
    cfg.byte_cap = 16 * 1024;
    PacketQueue q(cfg);

    q.push(make_video(0, true, 8 * 1024));
    for (int i = 0; i < 10; ++i) {
        q.push(make_video((i + 1) * 33000, false, 4 * 1024));
    }
    for (int i = 0; i < 5; ++i) {
        q.push(make_audio(i * 20 * 1000, 256));
    }

    const auto stats = q.stats();
    EXPECT_LE(stats.bytes_used, cfg.byte_cap + 8 * 1024);
    EXPECT_EQ(stats.dropped_audio_total, 0);
    EXPECT_EQ(stats.audio_count, 5);
}

TEST(PacketQueueTest, ByteCapTriggersDrop) {
    PacketQueue::Config cfg;
    cfg.budget_video_ms = 60000;
    cfg.budget_audio_ms = 60000;
    cfg.byte_cap = 16 * 1024;  // 16 KB
    PacketQueue q(cfg);

    q.push(make_video(0, true, 8 * 1024));
    // 10 non-keyframe по 4КБ — превысят cap.
    for (int i = 0; i < 10; ++i) {
        q.push(make_video((i + 1) * 33000, false, 4 * 1024));
    }
    const auto stats = q.stats();
    EXPECT_LE(stats.bytes_used, cfg.byte_cap + 8 * 1024);  // cap + последний keyframe
    EXPECT_GT(stats.dropped_video_total, 0);
}

TEST(PacketQueueTest, ClearResetsButPreservesStats) {
    PacketQueue q({});
    q.push(make_video(0, true));
    q.push(make_audio(0));
    auto before = q.stats();
    EXPECT_EQ(before.video_count, 1);
    EXPECT_EQ(before.audio_count, 1);

    q.clear();
    auto after = q.stats();
    EXPECT_EQ(after.video_count, 0);
    EXPECT_EQ(after.audio_count, 0);
    EXPECT_EQ(after.bytes_used, 0);
    // Drop-counter не должен расти от clear.
    EXPECT_EQ(after.dropped_total, before.dropped_total);
}

TEST(PacketQueueTest, StressTwoProducersOneConsumer) {
    constexpr int kPerStream = 1000;
    PacketQueue::Config cfg;
    cfg.budget_video_ms = 60000;
    cfg.budget_audio_ms = 60000;
    cfg.byte_cap = 16 * 1024 * 1024;
    PacketQueue q(cfg);

    std::atomic<int> consumed{0};
    std::thread consumer([&]() {
        EncodedPacket out;
        while (q.wait_and_pop(out)) {
            ++consumed;
        }
    });

    std::thread video_producer([&]() {
        for (int i = 0; i < kPerStream; ++i) {
            const bool key = (i % 30) == 0;
            q.push(make_video(static_cast<int64_t>(i) * 33000, key));
        }
    });
    std::thread audio_producer([&]() {
        for (int i = 0; i < kPerStream; ++i) {
            q.push(make_audio(static_cast<int64_t>(i) * 21000));
        }
    });

    video_producer.join();
    audio_producer.join();

    // Дадим консьюмеру пошанс выпить из очереди.
    std::this_thread::sleep_for(std::chrono::milliseconds(100));
    q.close();
    consumer.join();

    const auto stats = q.stats();
    // Сумма consumed + drops должна сходиться с количеством push'ов.
    const int total_pushed = 2 * kPerStream;
    EXPECT_EQ(consumed.load() + stats.dropped_total, total_pushed);
}
