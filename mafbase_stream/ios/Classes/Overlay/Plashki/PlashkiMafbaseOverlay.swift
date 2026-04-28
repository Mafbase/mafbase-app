import Combine
import SwiftUI
import UIKit

/// UIView-обёртка над SwiftUI-плашками, которая регистрируется в
/// `OverlayCatalog` под viewType "plashki-mafbase". Эквивалент Compose-функции
/// `PlashkiMafbaseOverlay` (см. android/.../overlay/plashki/PlashkiMafbaseOverlay.kt).
///
/// Подписывается на `TournamentContentSocket` по `tournamentId` + `table` из
/// [OverlayParams]. При апдейте состояния пересобирает SwiftUI-вью, делает
/// `layoutIfNeeded`, и дёргает `invalidator.invalidate()` — чтобы
/// `OverlayViewRenderer` снял свежий снимок и залил в Compositor.
final class PlashkiMafbaseOverlay: UIView {

    private let invalidator: OverlayInvalidator
    private let socket: TournamentContentSocket?
    private var cancellables: Set<AnyCancellable> = []

    private let host: UIHostingController<PlashkiContainerView>
    private let viewModel = PlashkiViewModel()

    /// Pump invalidate'ов на каждый VSync пока активен SwiftUI transition или
    /// идёт асинхронная подгрузка фото. Без него pipeline снимает только один
    /// snapshot в момент content-update, и анимации статусов/ролей + lazy
    /// подгрузки `URLSession.dataTask` в AsyncImageView не попадают в кадр.
    /// Аналог Android `Choreographer.postFrameCallback` в OverlayBitmapRenderer.
    ///
    /// Длительности:
    ///  - `contentPumpDuration` (2.5с) — после изменения content; покрывает 0.4с
    ///    SwiftUI-анимацию + типичное время загрузки фото.
    ///  - `imageLoadedPumpDuration` (0.5с) — на каждое успешное `URLSession.dataTask`
    ///    в `AsyncImageView`; снимает кадр с подгруженным фото в стрим, даже если
    ///    оно загрузилось позже основного 2.5-сек pump'а (медленная сеть, 10-я
    ///    картинка не успела) или до изменения статуса.
    private var displayLink: CADisplayLink?
    private var pumpDeadline: CFTimeInterval = 0
    private static let contentPumpDuration: CFTimeInterval = 2.5
    private static let imageLoadedPumpDuration: CFTimeInterval = 0.5

    init(params: OverlayParams, invalidator: OverlayInvalidator) {
        self.invalidator = invalidator
        if let tournamentId = params.tournamentId, let table = params.table {
            self.socket = TournamentContentSocket(tournamentId: tournamentId, table: table)
        } else {
            self.socket = nil
        }
        let viewModelRef = viewModel
        self.host = UIHostingController(rootView: PlashkiContainerView(model: viewModelRef, onImageLoaded: nil))
        super.init(frame: .zero)
        host.rootView = PlashkiContainerView(model: viewModelRef, onImageLoaded: { [weak self] in
            self?.startInvalidationPump(duration: Self.imageLoadedPumpDuration)
        })

        backgroundColor = .clear
        isOpaque = false

        host.view.backgroundColor = .clear
        host.view.isOpaque = false
        host.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(host.view)
        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            host.view.topAnchor.constraint(equalTo: topAnchor),
            host.view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        NSLog("[Plashki] init params=\(params.tournamentId.map(String.init) ?? "nil")/\(params.table.map(String.init) ?? "nil")")

        socket?.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] content in
                guard let self = self else { return }
                self.viewModel.content = content
                self.startInvalidationPump(duration: Self.contentPumpDuration)
            }
            .store(in: &cancellables)

        socket?.connect()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// SwiftUI вёрстка внутри `UIHostingController` обновляется лениво и
    /// ожидает полноценного `UIViewController`-lifecycle. Без `addChild` +
    /// `didMove(toParent:)` `@Published`-канал не push'ит updates в layout-tree
    /// → видимо пустое содержимое. Привязываем host к ближайшему VC, найденному
    /// через responder chain, как только мы окажемся в hierarchy.
    override func didMoveToWindow() {
        super.didMoveToWindow()
        NSLog("[Plashki] didMoveToWindow window=\(window != nil) host.parent=\(host.parent != nil) bounds=\(bounds)")
        guard window != nil, host.parent == nil else { return }
        guard let parentVC = nearestParentViewController() else {
            NSLog("[Plashki] didMoveToWindow: NO parent VC found")
            return
        }
        parentVC.addChild(host)
        host.didMove(toParent: parentVC)
        NSLog("[Plashki] addChild → \(type(of: parentVC))")
        host.view.setNeedsLayout()
        host.view.layoutIfNeeded()
        invalidator.invalidate()
    }

    private func nearestParentViewController() -> UIViewController? {
        var responder: UIResponder? = self.next
        while let r = responder {
            if let vc = r as? UIViewController { return vc }
            responder = r.next
        }
        return nil
    }

    /// Запускает CADisplayLink на `duration` секунд. Каждый VSync дёргает
    /// invalidator → renderer снимает snapshot и заливает в Compositor. Если
    /// pump уже активен — продлеваем deadline до `max(prev, now + duration)`,
    /// link не пересоздаём.
    private func startInvalidationPump(duration: CFTimeInterval) {
        pumpDeadline = max(pumpDeadline, CACurrentMediaTime() + duration)
        if displayLink != nil { return }
        let link = CADisplayLink(target: self, selector: #selector(onPumpTick))
        link.add(to: .main, forMode: .common)
        displayLink = link
    }

    @objc private func onPumpTick() {
        invalidator.invalidate()
        if CACurrentMediaTime() >= pumpDeadline {
            displayLink?.invalidate()
            displayLink = nil
        }
    }

    deinit {
        displayLink?.invalidate()
        displayLink = nil
        cancellables.removeAll()
        socket?.dispose()
        host.willMove(toParent: nil)
        host.removeFromParent()
    }
}

/// ViewModel для SwiftUI-вью. Не наследуем `ObservableObject` напрямую от
/// PlashkiMafbaseOverlay (UIView), потому что SwiftUI-обновления должны
/// проходить через @Published.
final class PlashkiViewModel: ObservableObject {
    @Published var content: Generated_SeatingContent?
}

struct PlashkiContainerView: View {
    @ObservedObject var model: PlashkiViewModel
    /// Дёргается AsyncImageView через `\.overlayImageLoaded` environment, когда
    /// очередное фото игрока загрузилось — оверлей продлевает CADisplayLink-pump.
    let onImageLoaded: (() -> Void)?

    var body: some View {
        // ignoresSafeArea: UIHostingController.view по умолчанию применяет safe-area
        // insets от parent VC. В landscape iPhone safe area асимметрична (слева ≈44pt
        // из-за notch, справа 0) — поэтому первая плашка отъезжает от левого края
        // canvas'а, а последняя прижимается вплотную к правому. Игнорируем safe area,
        // чтобы вёрстка лежала ровно в полный canvas стрима (1280×720 / 1920×1080).
        Group {
            if let content = model.content {
                MafbaseContent(content: content)
            } else {
                Color.clear
            }
        }
        .ignoresSafeArea()
        .environment(\.overlayImageLoaded, onImageLoaded)
    }
}
