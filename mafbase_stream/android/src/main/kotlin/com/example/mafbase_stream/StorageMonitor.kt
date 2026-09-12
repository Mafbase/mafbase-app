package com.example.mafbase_stream

import android.os.StatFs
import java.io.File

/**
 * Оценивает свободное место на разделе, куда пишется запись.
 *
 * Не блокирует запись — [Check.isBelowTarget] лишь сигнализирует, что места может не
 * хватить примерно на [TARGET_RECORDING_HOURS] часов записи при текущем битрейте (для
 * предупреждения пользователю). [Check.isCritical] — по-настоящему критический порог
 * (меньше [CRITICAL_FREE_BYTES]), при котором вызывающая сторона должна остановить запись.
 */
object StorageMonitor {
    const val TARGET_RECORDING_HOURS = 8
    const val CRITICAL_FREE_BYTES = 100L * 1024 * 1024

    data class Check(
        val freeBytes: Long,
        val requiredBytesForTarget: Long,
    ) {
        val isBelowTarget: Boolean get() = freeBytes < requiredBytesForTarget
        val isCritical: Boolean get() = freeBytes < CRITICAL_FREE_BYTES
    }

    /** Сколько байт займёт [TARGET_RECORDING_HOURS] часов записи при [totalBitrateBps]. */
    fun requiredBytesForTarget(totalBitrateBps: Int): Long =
        totalBitrateBps.toLong() / 8 * TARGET_RECORDING_HOURS * 3600

    /** Свободное место на разделе, где лежит [dir]. `Long.MAX_VALUE`, если не удалось посчитать. */
    fun freeBytes(dir: File): Long = try {
        StatFs(dir.absolutePath).availableBytes
    } catch (e: Exception) {
        Long.MAX_VALUE
    }

    /** Чистая версия для тестов — не трогает файловую систему. */
    fun evaluate(freeBytes: Long, totalBitrateBps: Int): Check =
        Check(freeBytes, requiredBytesForTarget(totalBitrateBps))

    fun check(dir: File, totalBitrateBps: Int): Check = evaluate(freeBytes(dir), totalBitrateBps)
}
