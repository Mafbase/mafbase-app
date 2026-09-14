import Foundation

/// Оценивает свободное место на разделе, куда пишется запись. Зеркало Android `StorageMonitor`.
///
/// Не блокирует запись — `Check.isBelowTarget` лишь сигнализирует, что места может не
/// хватить примерно на `targetRecordingHours` часов записи при текущем битрейте (для
/// предупреждения пользователю). `Check.isCritical` — по-настоящему критический порог
/// (меньше `criticalFreeBytes`), при котором вызывающая сторона должна остановить запись.
enum StorageMonitor {
    static let targetRecordingHours: Int64 = 8
    static let criticalFreeBytes: Int64 = 100 * 1024 * 1024

    struct Check {
        let freeBytes: Int64
        let requiredBytesForTarget: Int64

        var isBelowTarget: Bool { freeBytes < requiredBytesForTarget }
        var isCritical: Bool { freeBytes < StorageMonitor.criticalFreeBytes }
    }

    /// Сколько байт займёт `targetRecordingHours` часов записи при `totalBitrateBps`.
    static func requiredBytesForTarget(totalBitrateBps: Int) -> Int64 {
        Int64(totalBitrateBps) / 8 * targetRecordingHours * 3600
    }

    /// Свободное место на разделе, где лежит `url` (обычно Documents). `Int64.max`, если не
    /// удалось посчитать.
    static func freeBytes(at url: URL) -> Int64 {
        guard let values = try? url.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey]),
              let capacity = values.volumeAvailableCapacityForImportantUsage else {
            return .max
        }
        return capacity
    }

    /// Чистая версия для тестов — не трогает файловую систему.
    static func evaluate(freeBytes: Int64, totalBitrateBps: Int) -> Check {
        Check(freeBytes: freeBytes, requiredBytesForTarget: requiredBytesForTarget(totalBitrateBps: totalBitrateBps))
    }

    static func check(at url: URL, totalBitrateBps: Int) -> Check {
        evaluate(freeBytes: freeBytes(at: url), totalBitrateBps: totalBitrateBps)
    }
}
