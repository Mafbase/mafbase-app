import Foundation

/// Колбэк, который overlay-view дёргает, когда содержимое изменилось и нужно
/// пересобрать GL-текстуру оверлея.
///
/// Для статичных оверлеев — вызывается при явных изменениях. Для анимированных —
/// view сама подписывается на vsync (`CADisplayLink`) и вызывает `invalidate()`
/// в каждом tick.
@objc public protocol OverlayInvalidator: AnyObject {
    func invalidate()
}
