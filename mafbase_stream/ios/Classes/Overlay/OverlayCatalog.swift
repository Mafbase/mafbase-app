import UIKit

/// Внутренний каталог overlay-вёрстки, известной плагину. Каждый overlay — это
/// фабрика `(OverlayParams, OverlayInvalidator) -> UIView`, которую плагин знает
/// под уникальным `viewType`.
///
/// Чтобы добавить новый overlay — реализуй UIView, принимающую `OverlayParams` +
/// `OverlayInvalidator`, и зарегистрируй её в `overlays`. Тот же `viewType`
/// приложение указывает из Dart через `MafbaseOverlay`.
///
/// Помимо overlay'я каталог рисует [BrandOverlayContainerView] под ним —
/// постоянная брендированная картинка, заданная через `params.brandImageUrl`.
/// Она работает независимо от того, выбран overlay или нет.
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

    /// Создаёт wrapper с brand-слоем и (опционально) overlay-вёрсткой.
    /// Возвращает nil, если ни overlay, ни brand-image не заданы — overlay-renderer
    /// в таком случае подключать не нужно.
    static func create(
        viewType: String?,
        params: OverlayParams,
        invalidator: OverlayInvalidator
    ) -> UIView? {
        let overlayView: UIView? = viewType.flatMap { overlays[$0] }.map { $0(params, invalidator) }
        let hasBrand = (params.brandImageUrl?.isEmpty == false)
        if overlayView == nil && !hasBrand {
            return nil
        }
        return BrandOverlayContainerView(
            brandImageUrl: params.brandImageUrl,
            overlayView: overlayView,
            invalidator: invalidator
        )
    }
}
