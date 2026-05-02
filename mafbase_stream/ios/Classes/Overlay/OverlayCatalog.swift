import UIKit

/// Внутренний каталог overlay-вёрстки, известной плагину. Каждый overlay — это
/// фабрика `(OverlayParams, OverlayInvalidator) -> UIView`, которую плагин знает
/// под уникальным `viewType`.
///
/// Чтобы добавить новый overlay — реализуй UIView, принимающую `OverlayParams` +
/// `OverlayInvalidator`, и зарегистрируй её в `overlays`. Тот же `viewType`
/// приложение указывает из Dart через `MafbaseOverlay`.
///
/// Заменяет старый внешний `OverlayRegistry` + `registerOverlayFactory`-API:
/// хост-приложение больше ничего не регистрирует.
enum OverlayCatalog {

    typealias Factory = (OverlayParams, OverlayInvalidator) -> UIView

    private static let overlays: [String: Factory] = [
        "plashki-mafbase": { params, invalidator in
            PlashkiMafbaseOverlay(params: params, invalidator: invalidator)
        },
    ]

    static func has(viewType: String) -> Bool {
        return overlays[viewType] != nil
    }

    static func create(
        viewType: String,
        params: OverlayParams,
        invalidator: OverlayInvalidator
    ) -> UIView? {
        guard let factory = overlays[viewType] else { return nil }
        return factory(params, invalidator)
    }
}
