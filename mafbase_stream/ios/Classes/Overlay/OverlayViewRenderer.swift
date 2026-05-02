import CoreGraphics
import CoreVideo
import UIKit

/// Снимает UIView в `CVPixelBuffer` (BGRA premultiplied) и заливает его в
/// Compositor как overlay-текстуру.
///
/// Сам реализует `OverlayInvalidator` — приложение получает экземпляр renderer
/// как invalidator при вызове `OverlayViewFactory.create(invalidator:)` и дёргает
/// `invalidate()` на любые изменения content'а view.
///
/// Поток работы:
///  1. Конструктор + `setView(_:)` — приложение создаёт UIView и привязывает её.
///  2. `attach(compositor:)` — задаёт frame, вызывает `layoutIfNeeded`, делает
///     первый снимок и сразу заливает в Compositor (чтобы первый кадр стрима
///     уже шёл с оверлеем).
///  3. View вызывает `invalidate()` при изменениях. Renderer ре-рендерит UIView
///     в тот же CVPixelBuffer и передаёт компоситору. В простое — `Compositor`
///     переиспользует прошлую текстуру (F3.8 BRD).
///  4. `detach()` — снимает overlay в Compositor и освобождает буфер.
///
/// `view.layer.render(in:)` делается на main thread (UIView требует UI-потока).
/// Загрузка в GL — на render queue Compositor через `Compositor.setOverlayBitmap`.
/// CVPixelBuffer аллоцируется один раз на сессию.
final class OverlayViewRenderer: NSObject, OverlayInvalidator {

    private let width: Int
    private let height: Int
    private weak var view: UIView?
    private weak var compositor: Compositor?

    /// Двойная буферизация: пишем CGContext в один buffer, отдаём compositor'у
    /// для GL upload — другой. Без этого `view.layer.render(in: ctx)` на main thread
    /// и `glTexImage` через `CVOpenGLESTextureCache` на compositor render queue
    /// читают/пишут один CVPixelBuffer одновременно → видны частично обновлённые
    /// карточки и tearing'и при перерисовке. Аналог Android `AtomicReference<Bitmap>`
    /// с двумя bitmap'ами (см. android/.../overlay/OverlayBitmapRenderer.kt).
    private var pixelBuffers: [CVPixelBuffer] = []
    private var writeIndex: Int = 0
    private var attached = false
    private var hostedInWindow = false

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        super.init()
    }

    func setView(_ view: UIView) {
        self.view = view
    }

    func attach(compositor: Compositor) {
        self.compositor = compositor
        runOnMain { [weak self] in
            guard let self = self, !self.attached, let view = self.view else {
                NSLog("[OvlRenderer] attach: skipped attached=\(self?.attached ?? true) view=\(self?.view != nil)")
                return
            }
            self.attached = true
            view.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
            view.isOpaque = false
            view.backgroundColor = .clear
            self.hostInActiveWindowIfPossible(view)
            NSLog("[OvlRenderer] attach: hosted superview=\(type(of: view.superview)) bounds=\(view.bounds)")
            view.setNeedsLayout()
            view.layoutIfNeeded()
            self.allocatePixelBufferIfNeeded()
            NSLog("[OvlRenderer] attach: pixelBuffers=\(self.pixelBuffers.count) -> refreshLocked")
            self.refreshLocked()
        }
    }

    func detach() {
        runOnMain { [weak self] in
            guard let self = self, self.attached else { return }
            self.attached = false
            self.compositor?.clearOverlay()
            self.compositor = nil
            self.pixelBuffers.removeAll()
            if let view = self.view {
                self.unhostFromWindow(view)
            }
        }
    }

    func invalidate() {
        runOnMain { [weak self] in
            guard let self = self, self.attached else {
                NSLog("[OvlRenderer] invalidate: skipped (attached=\(self?.attached ?? false))")
                return
            }
            self.refreshLocked()
        }
    }

    /// SwiftUI-вьюшки внутри `UIHostingController` без window не получают полноценный
    /// lifecycle (приходящие через `@Published` обновления могут не пересчитать layout
    /// до тех пор, пока view не attached). Прячем overlay-view невидимо в `view`
    /// самого верхнего presented `UIViewController`: `alpha = 0` + сдвиг за экран.
    /// Важно вешать именно на `viewController.view`, а не в `UIWindow` напрямую —
    /// иначе responder chain overlay'я не содержит ни одного VC, и
    /// `PlashkiMafbaseOverlay.didMoveToWindow()` не сможет найти parent VC, чтобы
    /// сделать `addChild(host)` для `UIHostingController` (без этого SwiftUI
    /// `@Published` обновления не пересчитывают layout-tree → пустой кадр).
    /// `view.layer.render(in:)` всё равно рисует реальный контент в наш CVPixelBuffer.
    private func hostInActiveWindowIfPossible(_ view: UIView) {
        if view.superview != nil {
            NSLog("[OvlRenderer] host: already in superview=\(type(of: view.superview))")
            return
        }
        guard let host = topMostHostView() else {
            NSLog("[OvlRenderer] host: no host view found")
            return
        }
        // ВНИМАНИЕ: НЕ ставим alpha=0 — `view.layer.render(in:)` учитывает opacity
        // слоя при рендере, и результат был бы полностью прозрачным. Поэтому скрываем
        // overlay от пользователя только через `transform` (сдвиг за экран). Transform
        // на render(in:) не влияет, потому что render(in:) работает в bounds-координатах.
        view.isUserInteractionEnabled = false
        view.transform = CGAffineTransform(translationX: -CGFloat(width) * 4, y: 0)
        host.addSubview(view)
        hostedInWindow = true
        NSLog("[OvlRenderer] host: addSubview to \(type(of: host))")
    }

    private func topMostHostView() -> UIView? {
        guard let window = activeKeyWindow() else {
            NSLog("[OvlRenderer] topMostHostView: no keyWindow")
            return nil
        }
        var vc = window.rootViewController
        while let presented = vc?.presentedViewController {
            vc = presented
        }
        NSLog("[OvlRenderer] topMostHostView: vc=\(vc.map { String(describing: type(of: $0)) } ?? "nil")")
        return vc?.view ?? window
    }

    private func unhostFromWindow(_ view: UIView) {
        if !hostedInWindow { return }
        hostedInWindow = false
        view.removeFromSuperview()
    }

    private func activeKeyWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            let scenes = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .filter { $0.activationState == .foregroundActive }
            if let window = scenes.flatMap({ $0.windows }).first(where: { $0.isKeyWindow }) {
                return window
            }
            return scenes.flatMap { $0.windows }.first
        }
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            ?? UIApplication.shared.windows.first
    }

    private func refreshLocked() {
        guard let view = view, !pixelBuffers.isEmpty, let compositor = compositor else {
            NSLog("[OvlRenderer] refresh: skipped view=\(view != nil) pbCount=\(pixelBuffers.count) comp=\(compositor != nil)")
            return
        }
        // Пишем в свободный (front) buffer; compositor пока ещё может держать
        // прошлый back-buffer для GL upload. После записи swap'аем индекс.
        let pb = pixelBuffers[writeIndex]
        // SwiftUI обновления через @Published применяются на следующем runloop tick
        // после изменения state. Если invalidator.invalidate() вызывается в том же
        // sync-блоке, что и `viewModel.content = newContent`, layout SwiftUI ещё не
        // пересчитал — снимок выйдет старым. Принудительный layout цикл здесь
        // гарантирует, что render(in:) увидит свежее содержимое.
        view.setNeedsLayout()
        view.layoutIfNeeded()
        CVPixelBufferLockBaseAddress(pb, [])
        guard let baseAddress = CVPixelBufferGetBaseAddress(pb) else {
            CVPixelBufferUnlockBaseAddress(pb, [])
            return
        }
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pb)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // BGRA + premultipliedFirst + byteOrder32Little — стандартная Apple-комбинация
        // для BGRA premultiplied (соответствует kCVPixelFormatType_32BGRA).
        let bitmapInfo = CGImageAlphaInfo.premultipliedFirst.rawValue
            | CGBitmapInfo.byteOrder32Little.rawValue
        guard let ctx = CGContext(
            data: baseAddress,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo
        ) else {
            CVPixelBufferUnlockBaseAddress(pb, [])
            return
        }
        // Очистка перед draw (UIView рисует только своё содержимое — фон прозрачный).
        ctx.clear(CGRect(x: 0, y: 0, width: width, height: height))
        // CGContext имеет y-up coordinate system, UIView/CALayer ожидает y-down.
        // Делаем flip перед render, чтобы overlay в стриме был правильно ориентирован.
        ctx.translateBy(x: 0, y: CGFloat(height))
        ctx.scaleBy(x: 1, y: -1)
        // drawHierarchy(afterScreenUpdates:false) вместо `layer.render(in:)`:
        //   1) учитывает presentation layer (анимации показывают промежуточные
        //      кадры вместо «прыжка» к target value);
        //   2) применяет CoreImage-фильтры (`.saturation()` для desaturate-эффекта
        //      убитых игроков). `layer.render(in:)` оба пункта игнорирует.
        // PushContext перенаправляет UIKit-drawing в наш CGContext (CVPixelBuffer).
        UIGraphicsPushContext(ctx)
        view.drawHierarchy(
            in: CGRect(x: 0, y: 0, width: width, height: height),
            afterScreenUpdates: false
        )
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pb, [])
        // Swap front/back: compositor получит свежий буфер, в следующий refresh
        // будем писать в тот, что compositor больше не использует.
        writeIndex = (writeIndex + 1) % pixelBuffers.count
        compositor.setOverlayBitmap(pb)
    }

    private func allocatePixelBufferIfNeeded() {
        if !pixelBuffers.isEmpty { return }
        let attrs: [CFString: Any] = [
            kCVPixelBufferIOSurfacePropertiesKey: [:],
            kCVPixelBufferOpenGLESCompatibilityKey: true,
        ]
        var allocated: [CVPixelBuffer] = []
        for _ in 0..<2 {
            var pb: CVPixelBuffer?
            let ret = CVPixelBufferCreate(
                kCFAllocatorDefault,
                width,
                height,
                kCVPixelFormatType_32BGRA,
                attrs as CFDictionary,
                &pb
            )
            if ret == kCVReturnSuccess, let pb = pb {
                allocated.append(pb)
            } else {
                NSLog("[mafbase_stream] OverlayViewRenderer pixel buffer create failed: \(ret)")
                return
            }
        }
        pixelBuffers = allocated
        writeIndex = 0
    }

    private func runOnMain(_ block: @escaping () -> Void) {
        if Thread.isMainThread { block() } else { DispatchQueue.main.async(execute: block) }
    }
}
