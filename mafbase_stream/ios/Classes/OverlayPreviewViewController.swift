import UIKit

/// Полноэкранный экран превью overlay-view без камеры и стрима. Нужен для
/// отладки вёрстки overlay-view: можно итерировать вёрстку, не поднимая RTMP.
///
/// Серый фон + смонтированная overlay-view в реальном размере кадра пайплайна
/// (1280×720). Если view реализует `OverlayDebugTarget`, показывается кнопка
/// «Toggle overlay» — она дёргает `OverlayDebugTarget.onDebugToggle()` для
/// проверки invalidate-цикла.
final class OverlayPreviewViewController: UIViewController {

    var onClose: (() -> Void)?

    private let overlayViewType: String
    private let overlayParams: OverlayParams
    private var overlayView: UIView?
    private var didFireOnClose = false

    // Размер кадра пайплайна — должен совпадать с тем, что использует Compositor
    // в реальном стриме, чтобы вёрстка отлаживалась под тот же canvas.
    private static let frameWidth: CGFloat = 1920
    private static let frameHeight: CGFloat = 1080

    init(overlayViewType: String, params: OverlayParams) {
        self.overlayViewType = overlayViewType
        self.overlayParams = params
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .landscape }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { .landscapeRight }
    override var prefersStatusBarHidden: Bool { true }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.376, alpha: 1.0)
        modalPresentationStyle = .fullScreen

        // No-op invalidator — в preview нет GL-пайплайна, перерисовка идёт штатной
        // системой UIKit (setNeedsDisplay / layoutIfNeeded). Контракт каталога
        // соблюдается: invalidator передаётся, view может его дёргать.
        let invalidator = NoopOverlayInvalidator()
        guard let overlay = OverlayCatalog.create(
            viewType: overlayViewType,
            params: overlayParams,
            invalidator: invalidator
        ) else {
            dismissPreview()
            return
        }
        overlay.frame = CGRect(x: 0, y: 0, width: Self.frameWidth, height: Self.frameHeight)
        overlay.translatesAutoresizingMaskIntoConstraints = true
        overlay.layoutIfNeeded()
        view.addSubview(overlay)
        overlayView = overlay

        // Layout всегда считается под фиксированный canvas 1920×1080 (как в стриме),
        // а визуально подгоняется под экран через `transform` aspect-fit. Без этого
        // на компактных экранах (≈932×430) низ canvas с плашками уезжает за пределы
        // окна и они кажутся «не отображаются».
        overlay.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            overlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            overlay.widthAnchor.constraint(equalToConstant: Self.frameWidth),
            overlay.heightAnchor.constraint(equalToConstant: Self.frameHeight),
        ])

        setupCloseButton()
        if overlay is OverlayDebugTarget {
            setupToggleButton()
        }
    }

    private func setupCloseButton() {
        let button = UIButton(type: .system)
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onCloseTapped), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }

    private func setupToggleButton() {
        let button = UIButton(type: .system)
        button.setTitle("Toggle overlay", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 60.0 / 255, green: 140.0 / 255, blue: 220.0 / 255, alpha: 0.86)
        button.layer.cornerRadius = 24
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onToggleTapped), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc private func onCloseTapped() {
        dismissPreview()
    }

    @objc private func onToggleTapped() {
        (overlayView as? OverlayDebugTarget)?.onDebugToggle()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let overlay = overlayView else { return }
        let bounds = view.bounds
        guard bounds.width > 0, bounds.height > 0 else { return }
        let scale = min(bounds.width / Self.frameWidth, bounds.height / Self.frameHeight)
        overlay.transform = CGAffineTransform(scaleX: scale, y: scale)
    }

    private func dismissPreview() {
        if !didFireOnClose {
            didFireOnClose = true
            onClose?()
        }
        dismiss(animated: true, completion: nil)
    }
}

private final class NoopOverlayInvalidator: NSObject, OverlayInvalidator {
    func invalidate() {}
}
