import Foundation

/// Разрешение видео-пайплайна. Ширина/высота совпадают с session preset'ами
/// AVCaptureSession и размерами Compositor/энкодеров.
enum StreamResolution: String, CaseIterable {
    case hd720
    case fullHd1080

    var width: Int { self == .hd720 ? 1280 : 1920 }
    var height: Int { self == .hd720 ? 720 : 1080 }
    var label: String { self == .hd720 ? "720p" : "1080p" }
}

struct StreamQualityPreset {
    let id: String
    let title: String
    let resolution: StreamResolution
    let bitrateKbps: Int

    var subtitle: String { "\(resolution.label) · \(bitrateKbps) kbps" }
}

/// Выбор качества трансляции: именованный пресет или ручные разрешение+битрейт.
/// Битрейт применяется при следующем старте стрима (и становится потолком
/// ABR-лестницы ядра), разрешение дополнительно перестраивает пайплайн экрана.
struct StreamQualitySettings: Equatable {
    static let presets: [StreamQualityPreset] = [
        StreamQualityPreset(id: "eco", title: "Экономный", resolution: .hd720, bitrateKbps: 2000),
        StreamQualityPreset(id: "standard", title: "Стандартный", resolution: .hd720, bitrateKbps: 4000),
        StreamQualityPreset(id: "high", title: "Высокий", resolution: .fullHd1080, bitrateKbps: 6000),
    ]

    static let minBitrateKbps = 1000
    static let maxBitrateKbps = 8000
    static let bitrateStepKbps = 500

    /// Дефолт совпадает с прежним зашитым поведением экрана: 720p / 4000 kbps.
    static let standard = StreamQualitySettings(
        isManual: false,
        presetId: "standard",
        manualResolution: .hd720,
        manualBitrateKbps: 4000
    )

    var isManual: Bool
    var presetId: String
    var manualResolution: StreamResolution
    var manualBitrateKbps: Int

    private var preset: StreamQualityPreset {
        Self.presets.first { $0.id == presetId } ?? Self.presets[1]
    }

    var resolution: StreamResolution { isManual ? manualResolution : preset.resolution }
    var bitrateKbps: Int { isManual ? manualBitrateKbps : preset.bitrateKbps }
    var bitrateBps: Int { bitrateKbps * 1000 }
}

/// Персистентность выбора качества между открытиями экрана трансляции.
enum StreamQualityStore {
    private static let manualKey = "mafbase_stream.quality.manual"
    private static let presetKey = "mafbase_stream.quality.preset"
    private static let resolutionKey = "mafbase_stream.quality.resolution"
    private static let bitrateKey = "mafbase_stream.quality.bitrateKbps"

    static func load() -> StreamQualitySettings {
        let defaults = UserDefaults.standard
        var settings = StreamQualitySettings.standard
        settings.isManual = defaults.bool(forKey: manualKey)
        if let presetId = defaults.string(forKey: presetKey),
           StreamQualitySettings.presets.contains(where: { $0.id == presetId }) {
            settings.presetId = presetId
        }
        if let raw = defaults.string(forKey: resolutionKey),
           let resolution = StreamResolution(rawValue: raw) {
            settings.manualResolution = resolution
        }
        let bitrate = defaults.integer(forKey: bitrateKey)
        if bitrate >= StreamQualitySettings.minBitrateKbps && bitrate <= StreamQualitySettings.maxBitrateKbps {
            settings.manualBitrateKbps = bitrate
        }
        return settings
    }

    static func save(_ settings: StreamQualitySettings) {
        let defaults = UserDefaults.standard
        defaults.set(settings.isManual, forKey: manualKey)
        defaults.set(settings.presetId, forKey: presetKey)
        defaults.set(settings.manualResolution.rawValue, forKey: resolutionKey)
        defaults.set(settings.manualBitrateKbps, forKey: bitrateKey)
    }
}
