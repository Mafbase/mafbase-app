package com.example.mafbase_stream

import kotlin.test.Test
import kotlin.test.assertFalse
import kotlin.test.assertTrue

internal class StorageMonitorTest {

    // 4_128_000 bps ≈ 720p standard (4000 kbps видео) + 128 kbps AAC.
    private val totalBitrateBps = 4_128_000

    @Test
    fun evaluate_belowTarget_whenFreeSpaceLessThanEightHours() {
        val required = StorageMonitor.requiredBytesForTarget(totalBitrateBps)
        val check = StorageMonitor.evaluate(freeBytes = required - 1, totalBitrateBps = totalBitrateBps)

        assertTrue(check.isBelowTarget)
        assertFalse(check.isCritical)
    }

    @Test
    fun evaluate_notBelowTarget_whenFreeSpaceCoversEightHours() {
        val required = StorageMonitor.requiredBytesForTarget(totalBitrateBps)
        val check = StorageMonitor.evaluate(freeBytes = required, totalBitrateBps = totalBitrateBps)

        assertFalse(check.isBelowTarget)
        assertFalse(check.isCritical)
    }

    @Test
    fun evaluate_critical_whenFreeSpaceBelow100Mb() {
        val check = StorageMonitor.evaluate(
            freeBytes = StorageMonitor.CRITICAL_FREE_BYTES - 1,
            totalBitrateBps = totalBitrateBps,
        )

        assertTrue(check.isCritical)
        assertTrue(check.isBelowTarget)
    }

    @Test
    fun evaluate_notCritical_whenFreeSpaceAt100Mb() {
        val check = StorageMonitor.evaluate(
            freeBytes = StorageMonitor.CRITICAL_FREE_BYTES,
            totalBitrateBps = totalBitrateBps,
        )

        assertFalse(check.isCritical)
    }
}
