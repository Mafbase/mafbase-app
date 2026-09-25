import AVFoundation
import UIKit
import UIKit.UIGestureRecognizerSubclass

/// Полноэкранный нативный экран трансляции: слой превью и кнопки поверх `StreamPipeline`.
///
/// Сам пайплайн (камера, компоситор, запись MP4, RTMP-стрим) контроллеру не принадлежит —
/// его держит `MafbaseStreamPlugin`, а экран лишь подключает превью, хостит overlay-view
/// и отражает состояние через `StreamPipelineDelegate`. Уход экрана пайплайн не трогает;
/// новый контроллер присоединяется к активному пайплайну, а освобождает его только
/// неактивным. Удерживается в landscape независимо от ориентации хост-приложения;
/// закрывается по кнопке «Закрыть», результат уходит в Dart через `onClose`.
///
/// Пока пайплайн активен, через 60 с без касаний экран затемняется: яркость 0.05, превью
/// скрыто, чёрная шторка поверх кнопок; касание возвращает всё обратно.
final class StreamViewController: UIViewController {

    enum CloseReason {
        case user
        case permissionsDenied
    }

    /// Колбэк, вызываемый ровно один раз — когда экран закрылся.
    var onClose: ((CloseReason) -> Void)?

    private let pipeline: StreamPipeline
    private var didFireOnClose = false

    // MARK: - UI

    private static let dimDelay: TimeInterval = 60
    private static let dimmedBrightness: CGFloat = 0.05

    private var previewDisplayLayer: AVSampleBufferDisplayLayer?
    private var closeButton: UIButton!
    private var recordButton: UIButton!
    private var streamButton: UIButton!
    private var streamSpinner: UIActivityIndicatorView!
    private var overlayToggleButton: UIButton!
    private var bottomButtonsStack: UIStackView!
    private var qualityButton: UIButton!
    private var lensSwitcher: SegmentedPillControl?
    private var qualityPanel: QualitySettingsPanel?
    private var qualityScrim: UIView?
    private var operatorHint: UIView!
    private var toastStack: UIStackView!
    private var stopAlert: UIAlertController?
    private var dimTimer: Timer?
    private var dimCurtain: UIView?
    private var savedBrightness: CGFloat?

    init(pipeline: StreamPipeline) {
        self.pipeline = pipeline
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        dimTimer?.invalidate()
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        modalPresentationStyle = .fullScreen
        isModalInPresentation = true

        setupPreviewDisplayLayer()
        setupCloseButton()
        setupBottomButtons()
        setupQualityButton()
        setupOperatorHint()
        setupLensSwitcher()
        setupToastStack()
        setupTouchObserver()

        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(handleWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        center.addObserver(self, selector: #selector(handleDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)

        pipeline.delegate = self
        pipeline.hostOverlay(in: self)
        syncUiFromPipeline()

        guard !pipeline.isStarted else { return }
        requestPermissions { [weak self] granted in
            guard let self = self else { return }
            if granted {
                self.pipeline.start()
            } else {
                self.dismissWithReason(.permissionsDenied)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let layer = previewDisplayLayer {
            pipeline.attachPreview(layer)
        }
        UIApplication.shared.isIdleTimerDisabled = true
        scheduleDim()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        undimScreen()
        pipeline.detachPreview()
        UIApplication.shared.isIdleTimerDisabled = pipeline.isActive
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewDisplayLayer?.frame = view.bounds
        pipeline.updateVideoOrientation(preferredVideoOrientation())
    }

    // MARK: - Orientation

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .landscape }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { .landscapeRight }
    override var shouldAutorotate: Bool { true }

    private func preferredVideoOrientation() -> AVCaptureVideoOrientation {
        if #available(iOS 13.0, *),
           let interfaceOrientation = view.window?.windowScene?.interfaceOrientation,
           interfaceOrientation == .landscapeLeft {
            return .landscapeLeft
        }
        return .landscapeRight
    }

    // MARK: - Permissions

    private func requestPermissions(completion: @escaping (Bool) -> Void) {
        requestVideoPermission { videoGranted in
            guard videoGranted else {
                DispatchQueue.main.async { completion(false) }
                return
            }
            self.requestAudioPermission { audioGranted in
                DispatchQueue.main.async { completion(audioGranted) }
            }
        }
    }

    private func requestVideoPermission(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: completion(true)
        case .notDetermined: AVCaptureDevice.requestAccess(for: .video) { completion($0) }
        default: completion(false)
        }
    }

    private func requestAudioPermission(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized: completion(true)
        case .notDetermined: AVCaptureDevice.requestAccess(for: .audio) { completion($0) }
        default: completion(false)
        }
    }

    // MARK: - UI setup

    private func setupPreviewDisplayLayer() {
        let layer = AVSampleBufferDisplayLayer()
        // resizeAspect — letterbox: кадр виден целиком, по краям чёрные поля.
        layer.videoGravity = .resizeAspect
        layer.frame = view.bounds
        view.layer.insertSublayer(layer, at: 0)
        previewDisplayLayer = layer
    }

    private func setupCloseButton() {
        let button = UIButton(type: .system)
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.layer.cornerRadius = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
        closeButton = button
    }

    private func setupBottomButtons() {
        let record = UIButton(type: .system)
        record.setTitle("Запись", for: .normal)
        record.setTitleColor(.white, for: .normal)
        record.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        record.backgroundColor = UIColor(red: 0.86, green: 0.23, blue: 0.23, alpha: 0.86)
        record.contentEdgeInsets = UIEdgeInsets(top: 10, left: 22, bottom: 10, right: 22)
        record.layer.cornerRadius = 24
        record.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)

        let stream = UIButton(type: .system)
        stream.setTitle("Стрим", for: .normal)
        stream.setTitleColor(.white, for: .normal)
        stream.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        stream.backgroundColor = UIColor(red: 0.23, green: 0.55, blue: 0.86, alpha: 0.86)
        stream.contentEdgeInsets = UIEdgeInsets(top: 10, left: 22, bottom: 10, right: 22)
        stream.layer.cornerRadius = 24
        stream.addTarget(self, action: #selector(streamTapped), for: .touchUpInside)

        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .white
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        stream.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: stream.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: stream.centerYAnchor),
        ])

        // Видна только если overlay-view реализует OverlayDebugTarget; в видеопоток не попадает.
        let toggle = UIButton(type: .system)
        toggle.setTitle("Toggle overlay", for: .normal)
        toggle.setTitleColor(.white, for: .normal)
        toggle.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        toggle.backgroundColor = UIColor(white: 0.35, alpha: 0.86)
        toggle.contentEdgeInsets = UIEdgeInsets(top: 10, left: 22, bottom: 10, right: 22)
        toggle.layer.cornerRadius = 24
        toggle.isHidden = true
        toggle.addTarget(self, action: #selector(toggleOverlayTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [record, stream, toggle])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        recordButton = record
        streamButton = stream
        streamSpinner = spinner
        overlayToggleButton = toggle
        bottomButtonsStack = stack
    }

    private func setupQualityButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.addTarget(self, action: #selector(qualityTapped), for: .touchUpInside)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
        qualityButton = button
    }

    private func setupOperatorHint() {
        let container = UIView()
        container.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        container.layer.cornerRadius = 12
        container.isUserInteractionEnabled = false
        container.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "Не блокируйте экран и не сворачивайте приложение: видео в фоне iOS не передаёт"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        container.addSubview(label)
        view.addSubview(container)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 6),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -6),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.leadingAnchor.constraint(greaterThanOrEqualTo: qualityButton.trailingAnchor, constant: 12),
            container.trailingAnchor.constraint(lessThanOrEqualTo: closeButton.leadingAnchor, constant: -12),
        ])
        operatorHint = container
    }

    private func setupLensSwitcher() {
        guard pipeline.hasUltraWide else { return }
        let switcher = SegmentedPillControl(titles: ["0.5×", "1×"], selectedIndex: pipeline.activeLens.rawValue)
        switcher.onChange = { [weak self] index in
            guard let self = self, let lens = StreamPipeline.Lens(rawValue: index) else { return }
            self.pipeline.switchLens(to: lens)
        }
        switcher.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(switcher)

        NSLayoutConstraint.activate([
            switcher.bottomAnchor.constraint(equalTo: bottomButtonsStack.topAnchor, constant: -14),
            switcher.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switcher.heightAnchor.constraint(equalToConstant: 36),
        ])
        lensSwitcher = switcher
    }

    private func setupToastStack() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.isUserInteractionEnabled = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: operatorHint.bottomAnchor, constant: 12),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
        ])
        toastStack = stack
    }

    private func setupTouchObserver() {
        let observer = TouchObserverGestureRecognizer(target: nil, action: nil)
        observer.onTouchBegan = { [weak self] in self?.handleTouch() }
        view.addGestureRecognizer(observer)
    }

    // MARK: - State sync

    private func syncUiFromPipeline() {
        let p = pipeline
        recordButton.setTitle(p.isRecording ? "Стоп" : "Запись", for: .normal)
        recordButton.isEnabled = !p.isRecordTransition
        streamButton.isEnabled = !p.isStreamTransition
        if p.isStreamTransition {
            streamButton.setTitle("", for: .normal)
            streamSpinner.startAnimating()
        } else {
            streamSpinner.stopAnimating()
            streamButton.setTitle(p.isStreaming ? "Стоп" : "Стрим", for: .normal)
        }
        let locked = p.isQualityLocked
        qualityButton.setImage(
            UIImage(systemName: locked ? "lock.fill" : "gearshape.fill"),
            for: .normal
        )
        qualityButton.alpha = locked ? 0.2 : 1.0
        if let switcher = lensSwitcher {
            switcher.setSelectedIndex(p.activeLens.rawValue, animated: true)
            switcher.setInteractionEnabled(!p.isLensSwitching)
        }
        overlayToggleButton.isHidden = p.overlayDebugTarget == nil
    }

    // MARK: - Quality settings

    @objc private func qualityTapped() {
        if pipeline.isQualityLocked {
            showToast("Качество можно менять только до начала трансляции")
            return
        }
        openQualityPanel()
    }

    private func openQualityPanel() {
        guard qualityPanel == nil else { return }
        let scrim = UIView()
        scrim.backgroundColor = UIColor.black.withAlphaComponent(0.38)
        scrim.frame = view.bounds
        scrim.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrim.alpha = 0
        scrim.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeQualityPanel)))
        view.addSubview(scrim)

        let panel = QualitySettingsPanel(settings: pipeline.qualitySettings)
        panel.onCloseTapped = { [weak self] in self?.closeQualityPanel() }
        panel.onSettingsChanged = { [weak self] settings in
            self?.pipeline.applyQualitySettings(settings)
        }
        let width = max(300, view.bounds.width * 0.4)
        panel.frame = CGRect(x: -width, y: 0, width: width, height: view.bounds.height)
        panel.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        view.addSubview(panel)

        qualityScrim = scrim
        qualityPanel = panel
        UIView.animate(withDuration: 0.24, delay: 0, options: [.curveEaseOut]) {
            scrim.alpha = 1
            panel.frame.origin.x = 0
        }
    }

    @objc private func closeQualityPanel() {
        guard let panel = qualityPanel, let scrim = qualityScrim else { return }
        qualityPanel = nil
        qualityScrim = nil
        UIView.animate(
            withDuration: 0.22,
            delay: 0,
            options: [.curveEaseIn],
            animations: {
                scrim.alpha = 0
                panel.frame.origin.x = -panel.frame.width
            },
            completion: { _ in
                panel.removeFromSuperview()
                scrim.removeFromSuperview()
            }
        )
    }

    // MARK: - Toasts

    private func showToast(_ text: String, long: Bool = false) {
        let container = UIView()
        container.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        container.layer.cornerRadius = 16
        container.alpha = 0

        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
        ])
        toastStack.addArrangedSubview(container)
        view.bringSubviewToFront(toastStack)
        if let curtain = dimCurtain {
            view.bringSubviewToFront(curtain)
        }

        UIView.animate(withDuration: 0.2, animations: { container.alpha = 1 }) { _ in
            UIView.animate(withDuration: 0.3, delay: long ? 3.5 : 1.8, options: [], animations: { container.alpha = 0 }) { _ in
                container.removeFromSuperview()
            }
        }
    }

    // MARK: - Actions

    @objc private func toggleOverlayTapped() {
        pipeline.overlayDebugTarget?.onDebugToggle()
    }

    @objc private func recordTapped() {
        pipeline.toggleRecording()
    }

    @objc private func streamTapped() {
        pipeline.toggleStreaming()
    }

    @objc private func closeTapped() {
        guard pipeline.isActive else {
            dismissWithReason(.user)
            return
        }
        guard stopAlert == nil else { return }
        let alert = UIAlertController(title: nil, message: "Остановить трансляцию и запись?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Остановить", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.stopAlert = nil
            self.pipeline.stopAll()
            self.pipeline.release()
            self.dismissWithReason(.user)
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel) { [weak self] _ in
            self?.stopAlert = nil
            self?.scheduleDim()
        })
        stopAlert = alert
        dimTimer?.invalidate()
        dimTimer = nil
        present(alert, animated: true)
    }

    // MARK: - Screen dimming

    private func scheduleDim() {
        dimTimer?.invalidate()
        dimTimer = nil
        guard pipeline.isActive, dimCurtain == nil, stopAlert == nil else { return }
        dimTimer = Timer.scheduledTimer(withTimeInterval: Self.dimDelay, repeats: false) { [weak self] _ in
            self?.dimScreen()
        }
    }

    /// Компоситор и энкодеры работают дальше — не обновляется только превью.
    private func dimScreen() {
        dimTimer = nil
        guard dimCurtain == nil, pipeline.isActive else { return }
        if savedBrightness == nil {
            savedBrightness = UIScreen.main.brightness
        }
        UIScreen.main.brightness = Self.dimmedBrightness
        previewDisplayLayer?.isHidden = true
        let curtain = UIView(frame: view.bounds)
        curtain.backgroundColor = .black
        curtain.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(curtain)
        dimCurtain = curtain
    }

    /// Снимает шторку и возвращает яркость и превью; таймер не перезапускает.
    private func undimScreen() {
        dimTimer?.invalidate()
        dimTimer = nil
        dimCurtain?.removeFromSuperview()
        dimCurtain = nil
        previewDisplayLayer?.isHidden = false
        if let brightness = savedBrightness {
            savedBrightness = nil
            UIScreen.main.brightness = brightness
        }
    }

    private func handleTouch() {
        if dimCurtain != nil {
            undimScreen()
        }
        scheduleDim()
    }

    @objc private func handleWillResignActive() {
        undimScreen()
    }

    @objc private func handleDidBecomeActive() {
        scheduleDim()
    }

    /// Единственная точка закрытия экрана. Активный пайплайн переживает контроллер,
    /// неактивный освобождается здесь.
    private func dismissWithReason(_ reason: CloseReason) {
        guard !didFireOnClose else { return }
        didFireOnClose = true
        undimScreen()
        pipeline.detachPreview()
        pipeline.unhostOverlay()
        if pipeline.delegate === self {
            pipeline.delegate = nil
        }
        if !pipeline.isActive {
            pipeline.release()
        }
        let callback = onClose
        onClose = nil
        if let presenter = presentingViewController {
            presenter.dismiss(animated: true) { callback?(reason) }
        } else {
            callback?(reason)
        }
    }
}

// MARK: - StreamPipelineDelegate

extension StreamViewController: StreamPipelineDelegate {

    func onStateChanged() {
        syncUiFromPipeline()
        if !pipeline.isActive {
            undimScreen()
        } else if dimTimer == nil, dimCurtain == nil {
            scheduleDim()
        }
    }

    func onFrameSizeChanged(width: Int, height: Int) {
        previewDisplayLayer?.flushAndRemoveImage()
    }

    func onMessage(text: String, long: Bool) {
        showToast(text, long: long)
    }

    func onFatalError(message: String) {
        NSLog("[mafbase_stream] fatal: \(message)")
        showToast(message, long: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.dismissWithReason(.user)
        }
    }
}

/// Распознаватель-наблюдатель: сообщает о начале касания и сразу проваливается, поэтому
/// кнопки и остальные распознаватели работают как обычно.
private final class TouchObserverGestureRecognizer: UIGestureRecognizer {

    var onTouchBegan: (() -> Void)?

    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        cancelsTouchesInView = false
        delaysTouchesBegan = false
        delaysTouchesEnded = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        onTouchBegan?()
        state = .failed
    }
}
