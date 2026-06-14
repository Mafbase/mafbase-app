// Юнит-тесты BitrateController (см. native/src/network/bitrate_controller.h).
//
// Покрываем контракт адаптивного битрейта:
//  1. понижение быстрое — каскад вниз по лестнице 100/75/50/33/20/10% при
//     HIGH backpressure и при дропах за окно, с упором в нижнюю ступень;
//  2. восстановление медленное — шаг вверх только после kStableSeconds штиля
//     при bp==NONE, без дропов в окне и при очереди ниже low-water;
//  3. регрессия: ненулевые дропы В ОКНЕ блокируют повышение (контроллер ждёт
//     именно дельту за окно, а не сумму за сессию — см. session.cpp).
//
// stable_seconds в тестах = 1, чтобы не растягивать прогон; ожидание реализуем
// через sleep_for, т.к. контроллер берёт время из steady_clock внутри.

#include <gtest/gtest.h>

#include <chrono>
#include <thread>

#include "../src/network/bitrate_controller.h"

using mafbase_stream::BitrateController;

namespace {

constexpr int kPreset = 4'000'000;

BitrateController::Config makeCfg() {
    BitrateController::Config cfg{};
    cfg.preset_bps = kPreset;
    cfg.stable_seconds = 1;
    cfg.low_water_depth_ms = 200;
    return cfg;
}

// Удобный helper: «штилевой» вызов — нет давления, нет дропов, очередь пустая.
int calmUpdate(BitrateController& c) {
    return c.update(/*video_ms=*/0, /*audio_ms=*/0, /*dropped=*/0,
                    MS_BP_NONE);
}

}  // namespace

TEST(BitrateController, StartsAtPreset) {
    BitrateController c(makeCfg());
    EXPECT_EQ(c.current_bps(), kPreset);
}

TEST(BitrateController, ZeroPresetFallsBackToDefault) {
    BitrateController::Config cfg{};
    cfg.preset_bps = 0;
    BitrateController c(cfg);
    EXPECT_EQ(c.current_bps(), 2'000'000);
}

TEST(BitrateController, HighBackpressureStepsDownOnce) {
    BitrateController c(makeCfg());
    // 100% → 75% = 3 Мбит/с.
    EXPECT_EQ(c.update(300, 0, 0, MS_BP_HIGH), 3'000'000);
    EXPECT_EQ(c.current_bps(), 3'000'000);
}

TEST(BitrateController, DropsInWindowStepDownEvenWithoutBackpressure) {
    BitrateController c(makeCfg());
    EXPECT_EQ(c.update(0, 0, /*dropped=*/5, MS_BP_NONE), 3'000'000);
}

TEST(BitrateController, CascadeDownToFloorMatchesLadder) {
    BitrateController c(makeCfg());
    // Лестница 4M → 3M → 2M → 1.32M → 800k → 400k (100/75/50/33/20/10%).
    EXPECT_EQ(c.update(0, 0, 1, MS_BP_HIGH), 3'000'000);
    EXPECT_EQ(c.update(0, 0, 1, MS_BP_HIGH), 2'000'000);
    EXPECT_EQ(c.update(0, 0, 1, MS_BP_HIGH), 1'320'000);
    EXPECT_EQ(c.update(0, 0, 1, MS_BP_HIGH), 800'000);
    EXPECT_EQ(c.update(0, 0, 1, MS_BP_HIGH), 400'000);
    // На полу дальше не опускаемся — update возвращает 0 (без изменений).
    EXPECT_EQ(c.update(0, 0, 1, MS_BP_HIGH), 0);
    EXPECT_EQ(c.current_bps(), 400'000);
}

TEST(BitrateController, NoChangeWhenLowBackpressureAndNoDrops) {
    BitrateController c(makeCfg());
    // LOW не понижает (понижение только на HIGH/дропах) и не повышает (мы на 100%).
    EXPECT_EQ(c.update(250, 0, 0, MS_BP_LOW), 0);
    EXPECT_EQ(c.current_bps(), kPreset);
}

TEST(BitrateController, RecoversUpAfterStablePeriod) {
    BitrateController c(makeCfg());
    ASSERT_EQ(c.update(0, 0, 1, MS_BP_HIGH), 3'000'000);  // вниз на ступень

    // Сразу повышения нет — не прошло stable_seconds.
    EXPECT_EQ(calmUpdate(c), 0);

    std::this_thread::sleep_for(std::chrono::milliseconds(1100));

    // После штиля — шаг вверх обратно к 100%.
    EXPECT_EQ(calmUpdate(c), kPreset);
    EXPECT_EQ(c.current_bps(), kPreset);
}

// Регрессия на баг: восстановление должно работать ПОСЛЕ просадки с дропами.
// Контроллеру подаётся дельта за окно (как теперь делает session.cpp): пока в
// окнах есть новые дропы — вверх не идём (контроллер вправе даже снижать
// дальше); как только окна становятся чистыми — повышение разблокируется. Если
// бы подавалась накопительная сумма за сессию, dropped остался бы > 0 навсегда
// и битрейт застрял бы внизу до конца стрима.
TEST(BitrateController, RecoveryNeedsWindowsWithoutDrops) {
    BitrateController c(makeCfg());
    // Чистый HIGH без дропов — ровно одна ступень вниз, есть куда восстанавливаться.
    ASSERT_EQ(c.update(0, 0, 0, MS_BP_HIGH), 3'000'000);

    // Пока в каждом окне есть дропы — точно не повышаемся, даже после штиля по
    // времени.
    for (int i = 0; i < 3; ++i) {
        std::this_thread::sleep_for(std::chrono::milliseconds(1100));
        c.update(0, 0, /*dropped=*/1, MS_BP_NONE);
        EXPECT_LE(c.current_bps(), 3'000'000);
    }
    const int after_drops = c.current_bps();

    // Окно без дропов + штиль по времени → шаг вверх.
    std::this_thread::sleep_for(std::chrono::milliseconds(1100));
    EXPECT_GT(calmUpdate(c), after_drops);
}

TEST(BitrateController, HighDepthBlocksRecovery) {
    BitrateController c(makeCfg());
    ASSERT_EQ(c.update(0, 0, 1, MS_BP_HIGH), 3'000'000);

    std::this_thread::sleep_for(std::chrono::milliseconds(1100));

    // Очередь выше low-water (200мс) → не кандидат на повышение, даже при bp==NONE.
    EXPECT_EQ(c.update(/*video_ms=*/250, 0, 0, MS_BP_NONE), 0);
    EXPECT_EQ(c.current_bps(), 3'000'000);
}
