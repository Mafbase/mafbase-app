import Foundation

/// Bundle с overlay-ассетами (`mafbase_stream_overlay.xcassets`).
///
/// Когда плагин подгружается как CocoaPods framework, ресурсы лежат в отдельном
/// `mafbase_stream_overlay.bundle` рядом с framework-бинарём (см. `s.resource_bundles`
/// в подспеке). Сначала ищем именно этот bundle; если ресурсы лежат прямо во
/// фреймворке (статическая сборка) — фоллбек на bundle самого класса.
enum PluginBundle {
    static let resources: Bundle = {
        let frameworkBundle = Bundle(for: BundleToken.self)
        if let bundleURL = frameworkBundle.url(forResource: "mafbase_stream_overlay", withExtension: "bundle"),
           let resourceBundle = Bundle(url: bundleURL) {
            return resourceBundle
        }
        return frameworkBundle
    }()

    private final class BundleToken {}
}
