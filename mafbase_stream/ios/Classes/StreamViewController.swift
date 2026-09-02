import AVFoundation
import CoreMedia
import CoreVideo
import Photos
import UIKit

/// Полноэкранный нативный экран превью камеры через AVFoundation.
///
/// Запускается из `MafbaseStreamPlugin.openStreamScreen` modally и принудительно
/// удерживается в landscape независимо от ориентации хост-приложения.
/// Закрытие происходит по кнопке «Закрыть»; результат (success / permissions
/// denied) возвращается в Dart через `onClose`.
///
/// Архитектура (зеркальная Android `StreamActivity`):
///  - [Compositor] — единственный источник правды видео-пайплайна, живёт всю
///    жизнь камеры. `AVCaptureVideoDataOutput` всегда отправляет кадры в
///    `compositor.processFrame`. Compositor накладывает overlay (если подключён)
///    и через `onFrame` отдаёт скомпонованный `CVPixelBuffer` всем выходам:
///      • preview — `AVSampleBufferDisplayLayer` (заменяет `AVCaptureVideoPreviewLayer`);
///      • запись MP4 — `Mp4Recorder.appendVideo(pixelBuffer:pts:)`;
///      • стрим RTMP — `StreamSession.appendProcessedVideo(pixelBuffer:pts:)`.
///    Overlay видим во всех трёх выходах одновременно, как на Android.
///  - Запись и стрим больше не пересоздают компositор; они только подписываются /
///    отписываются на колбэк через флаги `isRecording` / `isStreaming`.
final class StreamViewController: UIViewController {

    enum CloseReason {
        case user
        case permissionsDenied
    }

    /// Колбэк, вызываемый ровно один раз — когда экран закрылся.
    var onClose: ((CloseReason) -> Void)?

    /// RTMP URL и stream key передаются из `MafbaseStreamPlugin` через свойства
    /// перед `present`. Финальный URL = `rtmpUrl/streamKey` (если ключ непустой).
    var rtmpUrl: String = "rtmp://10.0.2.2/live"
    var streamKey: String = "test"
    /// Идентификатор overlay из плагинного каталога (см. `OverlayCatalog`).
    /// Если задан — view накладывается на кадр во всех выходах compositor'а.
    var overlayViewType: String?
    /// Параметры overlay (tournamentId/table) — нужны overlay'ям, подписывающимся
    /// на seatingContent. Прокидываются в `OverlayCatalog.create`.
    var overlayParams: OverlayParams = OverlayParams()

    /// Шарится между overlay'ем (writer) и StreamSession.audioEncoder (reader):
    /// overlay выставляет muted=true когда `broadcastPhase` != day.
    private let phaseGate = PhaseGate()

    // MARK: - Capture

    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "com.example.mafbase_stream.session")
    private let videoDataQueue = DispatchQueue(label: "com.example.mafbase_stream.video.data")
    private let audioDataQueue = DispatchQueue(label: "com.example.mafbase_stream.audio.data")
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let audioDataOutput = AVCaptureAudioDataOutput()
    private var videoDeviceInput: AVCaptureDeviceInput?
    private var didFireOnClose = false

    // MARK: - Lens

    private enum Lens: Int {
        case ultraWide = 0
        case wide = 1
    }

    private let ultraWideCamera = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .back)
    private var activeLens: Lens = .wide
    private var isLensSwitching = false

    // MARK: - Pipeline (compositor as source of truth)

    /// Размер кадра пайплайна. Определяется выбранным качеством и меняется только
    /// в простое (applyResolutionChange) — session preset, Compositor,
    /// VTCompressionSession и AVAssetWriter всегда видят один и тот же размер.
    private var qualitySettings = StreamQualityStore.load()
    private lazy var frameWidth: Int = qualitySettings.resolution.width
    private lazy var frameHeight: Int = qualitySettings.resolution.height

    private var compositor: Compositor?
    private var overlayRenderer: OverlayViewRenderer?
    private var overlayView: UIView?

    /// Display layer для preview. Получает `CMSampleBuffer`, обёрнутый поверх
    /// `CVPixelBuffer` из compositor.onFrame. Заменяет `AVCaptureVideoPreviewLayer`.
    private var previewDisplayLayer: AVSampleBufferDisplayLayer?
    private var previewFormatDescription: CMVideoFormatDescription?

    // MARK: - UI

    private var closeButton: UIButton!
    private var recordButton: UIButton!
    private var streamButton: UIButton!
    private var streamSpinner: UIActivityIndicatorView!
    private var overlayToggleButton: UIButton?
    private var bottomButtonsStack: UIStackView!
    private var qualityButton: UIButton!
    private var lensSwitcher: SegmentedPillControl?
    private var qualityPanel: QualitySettingsPanel?
    private var qualityScrim: UIView?

    // MARK: - Recording / Streaming state

    private var mp4Recorder: Mp4Recorder?
    private var isRecording = false
    private var isTransitioning = false

    private var streamSession: StreamSession?
    private var isStreaming = false
    private var streamButtonLabel = "Стрим"

    // MARK: - Segmentation

    /// Длина сегмента записи в секундах. 0 = выключено (по умолчанию).
    var segmentDurationSeconds: TimeInterval = 0

    private var segmentIndex: Int = 1
    private var recordingSessionId: String = ""
    private var segmentTimer: Timer?
    /// Сессия записи активна и ролловеры разрешены. В отличие от `isRecording`,
    /// который остаётся true на время асинхронной финализации сегмента, этот флаг
    /// сбрасывается сразу при любой остановке — по нему завершившийся ролловер
    /// понимает, что следующий сегмент начинать уже не нужно.
    private var segmentingActive = false

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        modalPresentationStyle = .fullScreen

        setupPreviewDisplayLayer()
        setupCloseButton()
        setupBottomButtons()
        setupQualityButton()
        setupLensSwitcher()
        registerInterruptionObserver()

        requestPermissions { [weak self] granted in
            guard let self = self else { return }
            if granted {
                self.startCompositorPipeline()
                self.configureSession()
                self.startSession()
            } else {
                self.dismissWithReason(.permissionsDenied)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
        if isRecording {
            stopRecordingSync()
        }
        if isStreaming {
            stopStreamingSync()
        }
        stopSession()
        stopCompositorPipeline()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewDisplayLayer?.frame = view.bounds
        if let videoConnection = videoDataOutput.connection(with: .video),
           videoConnection.isVideoOrientationSupported {
            videoConnection.videoOrientation = preferredVideoOrientation()
        }
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

    // MARK: - Compositor pipeline

    private func startCompositorPipeline() {
        let comp = Compositor(width: frameWidth, height: frameHeight)
        comp.onFrame = { [weak self] outBuf, pts in
            self?.dispatchProcessedFrame(outBuf, pts: pts)
        }
        comp.onError = { error in
            NSLog("[mafbase_stream] Compositor error: \(error)")
        }
        do {
            try comp.prepare()
        } catch {
            NSLog("[mafbase_stream] Compositor.prepare failed: \(error)")
            return
        }
        compositor = comp

        attachOverlayIfNeeded(comp)
    }

    private func stopCompositorPipeline() {
        overlayRenderer?.detach()
        overlayRenderer = nil
        overlayView = nil
        compositor?.release()
        compositor = nil
    }

    /// Подключает overlay-вёрстку и/или brand-картинку к compositor'у. Поднимается
    /// если задан `overlayViewType` ИЛИ `overlayParams.brandImageUrl` — иначе
    /// overlay-слой не нужен. Wrapper живёт всю жизнь compositor'а и видим во
    /// всех выходах.
    private func attachOverlayIfNeeded(_ comp: Compositor) {
        let viewType = overlayViewType
        let hasBrand = (overlayParams.brandImageUrl?.isEmpty == false)
        if viewType == nil && !hasBrand {
            NSLog("[Stream] attachOverlay: no overlayViewType and no brand image")
            return
        }
        NSLog("[Stream] attachOverlay: viewType=\(viewType ?? "nil") brand=\(overlayParams.brandImageUrl ?? "nil") tournamentId=\(overlayParams.tournamentId.map(String.init) ?? "nil") clubId=\(overlayParams.clubId.map(String.init) ?? "nil") table=\(overlayParams.table.map(String.init) ?? "nil")")
        let renderer = OverlayViewRenderer(width: frameWidth, height: frameHeight)
        // Поднимаем phaseGate из плагина и параметры из overlayParams в
        // новый OverlayParams, который видит overlay и brand-слой.
        let resolvedParams = OverlayParams(
            tournamentId: overlayParams.tournamentId,
            clubId: overlayParams.clubId,
            table: overlayParams.table,
            phaseGate: phaseGate,
            breakPlaceholderImageUrl: overlayParams.breakPlaceholderImageUrl,
            brandImageUrl: overlayParams.brandImageUrl
        )
        guard let overlay = OverlayCatalog.create(
            viewType: viewType,
            params: resolvedParams,
            invalidator: renderer
        ) else {
            NSLog("[Stream] overlay '\(viewType ?? "nil")' not found in catalog and no brand image")
            return
        }
        renderer.setView(overlay)
        renderer.attach(compositor: comp)
        overlayRenderer = renderer
        overlayView = overlay
        if overlay is OverlayDebugTarget {
            overlayToggleButton?.isHidden = false
        }
    }

    /// Compositor.onFrame — раздаём один и тот же CVPixelBuffer на preview,
    /// recorder и stream session. Все три выхода видят overlay (alpha-blend
    /// уже применён внутри compositor.processFrame).
    private func dispatchProcessedFrame(_ pixelBuffer: CVPixelBuffer, pts: CMTime) {
        if let layer = previewDisplayLayer, layer.isReadyForMoreMediaData,
           let sampleBuffer = makeDisplaySampleBuffer(from: pixelBuffer, pts: pts) {
            layer.enqueue(sampleBuffer)
        }
        if isRecording {
            mp4Recorder?.appendVideo(pixelBuffer: pixelBuffer, pts: pts)
        }
        if isStreaming {
            streamSession?.appendProcessedVideo(pixelBuffer: pixelBuffer, pts: pts)
        }
    }

    /// Оборачивает CVPixelBuffer в CMSampleBuffer для AVSampleBufferDisplayLayer.
    /// Format description кешируем, потому что размер кадра фиксирован — Compositor
    /// гарантирует одинаковые dimensions всех выходных буферов.
    private func makeDisplaySampleBuffer(from pixelBuffer: CVPixelBuffer, pts: CMTime) -> CMSampleBuffer? {
        if previewFormatDescription == nil {
            var fd: CMVideoFormatDescription?
            let status = CMVideoFormatDescriptionCreateForImageBuffer(
                allocator: kCFAllocatorDefault,
                imageBuffer: pixelBuffer,
                formatDescriptionOut: &fd
            )
            guard status == noErr else { return nil }
            previewFormatDescription = fd
        }
        guard let fd = previewFormatDescription else { return nil }
        var timing = CMSampleTimingInfo(
            duration: CMTime(value: 1, timescale: 30),
            presentationTimeStamp: pts,
            decodeTimeStamp: .invalid
        )
        var sampleBuffer: CMSampleBuffer?
        let result = CMSampleBufferCreateForImageBuffer(
            allocator: kCFAllocatorDefault,
            imageBuffer: pixelBuffer,
            dataReady: true,
            makeDataReadyCallback: nil,
            refcon: nil,
            formatDescription: fd,
            sampleTiming: &timing,
            sampleBufferOut: &sampleBuffer
        )
        if result != noErr { return nil }
        if let sb = sampleBuffer,
           let attachments = CMSampleBufferGetSampleAttachmentsArray(sb, createIfNecessary: true)
            as? [NSMutableDictionary],
           let dict = attachments.first {
            dict[kCMSampleAttachmentKey_DisplayImmediately] = kCFBooleanTrue
        }
        return sampleBuffer
    }

    // MARK: - Capture session

    private func configureSession() {
        let preferredPreset = sessionPreset(for: qualitySettings.resolution)
        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            self.captureSession.beginConfiguration()
            self.applySessionPreset(preferredPreset)

            if let videoDevice = self.captureDevice(for: self.activeLens),
               let videoInput = try? AVCaptureDeviceInput(device: videoDevice),
               self.captureSession.canAddInput(videoInput) {
                self.captureSession.addInput(videoInput)
                self.videoDeviceInput = videoInput
            } else {
                NSLog("[mafbase_stream] не удалось добавить видео-вход")
            }

            if let audioDevice = AVCaptureDevice.default(for: .audio),
               let audioInput = try? AVCaptureDeviceInput(device: audioDevice),
               self.captureSession.canAddInput(audioInput) {
                self.captureSession.addInput(audioInput)
            }

            self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
            self.videoDataOutput.videoSettings = [
                kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
            ]
            self.videoDataOutput.setSampleBufferDelegate(self, queue: self.videoDataQueue)
            if self.captureSession.canAddOutput(self.videoDataOutput) {
                self.captureSession.addOutput(self.videoDataOutput)
            }

            self.audioDataOutput.setSampleBufferDelegate(self, queue: self.audioDataQueue)
            if self.captureSession.canAddOutput(self.audioDataOutput) {
                self.captureSession.addOutput(self.audioDataOutput)
            }

            self.captureSession.commitConfiguration()

            DispatchQueue.main.async {
                if let videoConnection = self.videoDataOutput.connection(with: .video),
                   videoConnection.isVideoOrientationSupported {
                    videoConnection.videoOrientation = self.preferredVideoOrientation()
                }
            }
        }
    }

    private func bestBackCamera() -> AVCaptureDevice? {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            return device
        }
        return AVCaptureDevice.default(for: .video)
    }

    private func captureDevice(for lens: Lens) -> AVCaptureDevice? {
        switch lens {
        case .ultraWide: return ultraWideCamera ?? bestBackCamera()
        case .wide: return bestBackCamera()
        }
    }

    private func sessionPreset(for resolution: StreamResolution) -> AVCaptureSession.Preset {
        resolution == .fullHd1080 ? .hd1920x1080 : .hd1280x720
    }

    /// Вызывается на sessionQueue внутри begin/commitConfiguration.
    private func applySessionPreset(_ preset: AVCaptureSession.Preset) {
        if captureSession.canSetSessionPreset(preset) {
            captureSession.sessionPreset = preset
        } else {
            captureSession.sessionPreset = .high
        }
    }

    /// Смена объектива «на лету»: заменяется только AVCaptureDeviceInput, размер
    /// кадра и энкодеры не затрагиваются, поэтому доступна и во время записи/стрима.
    private func switchLens(to lens: Lens) {
        guard lens != activeLens, !isLensSwitching else { return }
        guard let device = captureDevice(for: lens) else { return }
        let previousLens = activeLens
        activeLens = lens
        isLensSwitching = true
        lensSwitcher?.setInteractionEnabled(false)

        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            var switched = false
            self.captureSession.beginConfiguration()
            let previousInput = self.videoDeviceInput
            if let current = previousInput {
                self.captureSession.removeInput(current)
            }
            if let newInput = try? AVCaptureDeviceInput(device: device),
               self.captureSession.canAddInput(newInput) {
                self.captureSession.addInput(newInput)
                self.videoDeviceInput = newInput
                switched = true
            } else if let fallback = previousInput, self.captureSession.canAddInput(fallback) {
                self.captureSession.addInput(fallback)
            }
            self.captureSession.commitConfiguration()

            DispatchQueue.main.async {
                self.isLensSwitching = false
                self.lensSwitcher?.setInteractionEnabled(true)
                if !switched {
                    self.activeLens = previousLens
                    self.lensSwitcher?.setSelectedIndex(previousLens.rawValue, animated: true)
                }
                if let connection = self.videoDataOutput.connection(with: .video),
                   connection.isVideoOrientationSupported {
                    connection.videoOrientation = self.preferredVideoOrientation()
                }
            }
        }
    }

    private func startSession() {
        sessionQueue.async { [weak self] in
            guard let self = self, !self.captureSession.isRunning else { return }
            self.captureSession.startRunning()
        }
    }

    private func stopSession() {
        sessionQueue.async { [weak self] in
            guard let self = self, self.captureSession.isRunning else { return }
            self.captureSession.stopRunning()
        }
    }

    // MARK: - UI

    private func setupPreviewDisplayLayer() {
        let layer = AVSampleBufferDisplayLayer()
        // resizeAspect — letterbox: кадр виден целиком, по краям чёрные поля.
        // resizeAspectFill ранее обрезал кадр, чтобы заполнить экран.
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
        stream.setTitle(streamButtonLabel, for: .normal)
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

        let toggle = UIButton(type: .system)
        toggle.setTitle("Toggle overlay", for: .normal)
        toggle.setTitleColor(.white, for: .normal)
        toggle.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        toggle.backgroundColor = UIColor(white: 0.35, alpha: 0.86)
        toggle.contentEdgeInsets = UIEdgeInsets(top: 10, left: 22, bottom: 10, right: 22)
        toggle.layer.cornerRadius = 24
        toggle.isHidden = true
        toggle.addTarget(self, action: #selector(toggleOverlayTapped), for: .touchUpInside)
        overlayToggleButton = toggle

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
        bottomButtonsStack = stack
    }

    private func setupQualityButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
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

    private func setupLensSwitcher() {
        guard ultraWideCamera != nil else { return }
        let switcher = SegmentedPillControl(titles: ["0.5×", "1×"], selectedIndex: Lens.wide.rawValue)
        switcher.onChange = { [weak self] index in
            guard let self = self, let lens = Lens(rawValue: index) else { return }
            self.switchLens(to: lens)
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

    // MARK: - Quality settings

    /// Качество меняется только в простое: смена разрешения пересоздаёт пайплайн,
    /// а битрейт применяется при старте стрима.
    private var isQualityLocked: Bool { isRecording || isStreaming }

    private func updateQualityButtonState() {
        let locked = isQualityLocked
        qualityButton.setImage(
            UIImage(systemName: locked ? "lock.fill" : "gearshape.fill"),
            for: .normal
        )
        qualityButton.alpha = locked ? 0.2 : 1.0
    }

    @objc private func qualityTapped() {
        if isQualityLocked {
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

        let panel = QualitySettingsPanel(settings: qualitySettings)
        panel.onCloseTapped = { [weak self] in self?.closeQualityPanel() }
        panel.onSettingsChanged = { [weak self] settings in
            self?.applyQualitySettings(settings)
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

    private func applyQualitySettings(_ settings: StreamQualitySettings) {
        let previousResolution = qualitySettings.resolution
        qualitySettings = settings
        StreamQualityStore.save(settings)
        guard settings.resolution != previousResolution, !isQualityLocked else { return }
        applyResolutionChange(to: settings.resolution)
    }

    /// Пересобирает пайплайн под новое разрешение. Вызывается только в простое:
    /// запись/стрим блокируют панель, энкодеры ещё не созданы.
    private func applyResolutionChange(to resolution: StreamResolution) {
        stopCompositorPipeline()
        frameWidth = resolution.width
        frameHeight = resolution.height
        previewFormatDescription = nil
        startCompositorPipeline()

        let preset = sessionPreset(for: resolution)
        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            self.captureSession.beginConfiguration()
            self.applySessionPreset(preset)
            self.captureSession.commitConfiguration()
        }
    }

    private func showToast(_ text: String) {
        let container = UIView()
        container.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        container.layer.cornerRadius = 16
        container.alpha = 0
        container.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)
        view.addSubview(container)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 72),
        ])

        UIView.animate(withDuration: 0.2, animations: { container.alpha = 1 }) { _ in
            UIView.animate(withDuration: 0.3, delay: 1.8, options: [], animations: { container.alpha = 0 }) { _ in
                container.removeFromSuperview()
            }
        }
    }

    @objc private func toggleOverlayTapped() {
        (overlayView as? OverlayDebugTarget)?.onDebugToggle()
    }

    @objc private func closeTapped() {
        if isRecording {
            // Останавливаем запись корректно и сохраняем в Фото перед закрытием
            cancelSegmentTimer()
            closeButton.isEnabled = false
            recordButton.isEnabled = false
            isRecording = false
            guard let recorder = mp4Recorder else {
                // Идёт финализация ролловера — он сам сохранит свой сегмент.
                if isStreaming { stopStreamingSync() }
                dismissWithReason(.user)
                return
            }
            mp4Recorder = nil
            // Останавливаем стрим сразу — до async-операций с Фото и запроса разрешений,
            // чтобы камера и микрофон не продолжали вещание пока идёт сохранение.
            if isStreaming { stopStreamingSync() }
            Self.runProtectedFromSuspension { done in
                recorder.stop { [weak self] url, _ in
                    guard let url = url else {
                        done()
                        self?.dismissWithReason(.user)
                        return
                    }
                    Self.moveToPhotoLibrary(url: url) { success in
                        done()
                        guard let self = self else {
                            if !success { NSLog("[mafbase_stream] close: не удалось перенести запись в Фото") }
                            return
                        }
                        if success {
                            self.dismissWithReason(.user)
                        } else {
                            self.showAlert(
                                title: "Не удалось сохранить в Фото",
                                message: Self.photoLibraryFailureMessage(for: url)
                            ) { [weak self] in
                                self?.dismissWithReason(.user)
                            }
                        }
                    }
                }
            }
            return
        }
        if isStreaming {
            stopStreamingSync()
        }
        dismissWithReason(.user)
    }

    @objc private func recordTapped() {
        if isTransitioning { return }
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }

    @objc private func streamTapped() {
        if isTransitioning { return }
        if isStreaming {
            stopStreaming()
        } else {
            startStreaming()
        }
    }

    private func dismissWithReason(_ reason: CloseReason) {
        guard !didFireOnClose else { return }
        didFireOnClose = true
        let callback = onClose
        onClose = nil
        if presentingViewController != nil {
            dismiss(animated: true) { callback?(reason) }
        } else {
            callback?(reason)
        }
    }

    // MARK: - Recording

    private func startRecording() {
        guard captureSession.isRunning else { return }
        // Запрашиваем доступ к Фото заранее — в момент старта записи, а не при её
        // завершении. Если статус ещё не определён, показываем системный диалог сейчас;
        // при остановке используется уже полученный статус без повторного запроса.
        if PHPhotoLibrary.authorizationStatus(for: .addOnly) == .notDetermined {
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { _ in }
        }
        isTransitioning = true
        recordButton.isEnabled = false

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        recordingSessionId = formatter.string(from: Date())
        segmentIndex = 1
        segmentingActive = true

        startRecordingSegment(isRollover: false)
    }

    private func startRecordingSegment(isRollover: Bool) {
        let recorder = Mp4Recorder(segmentName: buildSegmentName())
        do {
            _ = try recorder.start(width: Int32(frameWidth), height: Int32(frameHeight))
        } catch {
            NSLog("[mafbase_stream] Mp4Recorder.start failed: \(error)")
            cancelSegmentTimer()
            isRecording = false
            isTransitioning = false
            updateQualityButtonState()
            recordButton.setTitle("Запись", for: .normal)
            recordButton.isEnabled = true
            showAlert(
                title: isRollover ? "Запись прервана" : "Не удалось начать запись",
                message: "\(error)"
            )
            return
        }
        mp4Recorder = recorder
        isRecording = true
        isTransitioning = false
        updateQualityButtonState()
        if !isRollover {
            recordButton.setTitle("Стоп", for: .normal)
            recordButton.isEnabled = true
        }
        scheduleNextSegment()
    }

    private func buildSegmentName() -> String {
        if segmentDurationSeconds > 0 {
            return "mafbase_stream_\(recordingSessionId)_part\(segmentIndex).mp4"
        } else {
            return "mafbase_stream_\(recordingSessionId).mp4"
        }
    }

    private func scheduleNextSegment() {
        guard segmentDurationSeconds > 0 else { return }
        segmentTimer = Timer.scheduledTimer(withTimeInterval: segmentDurationSeconds, repeats: false) { [weak self] _ in
            self?.rolloverSegment()
        }
    }

    private func cancelSegmentTimer() {
        segmentTimer?.invalidate()
        segmentTimer = nil
        segmentingActive = false
    }

    /// `isRecording` не сбрасывается на время финализации сегмента (как на Android):
    /// иначе закрытие экрана посреди ролловера не увидит активной записи, пропустит
    /// сохранение, а зависшая финализация потом стартует сегмент на мёртвом пайплайне.
    private func rolloverSegment() {
        guard isRecording, !isTransitioning, let recorder = mp4Recorder else { return }
        isTransitioning = true
        mp4Recorder = nil
        segmentIndex += 1

        Self.runProtectedFromSuspension { done in
            recorder.stop { [weak self] url, error in
                guard let url = url, error == nil else {
                    NSLog("[mafbase_stream] rollover: stop failed: \(String(describing: error))")
                    // completion уже на main queue
                    if let self = self {
                        self.cancelSegmentTimer()
                        self.isRecording = false
                        self.isTransitioning = false
                        self.updateQualityButtonState()
                        self.recordButton.setTitle("Запись", for: .normal)
                        self.recordButton.isEnabled = true
                    }
                    done()
                    return
                }
                // Следующий сегмент запускаем до переноса в Фото — без паузы в записи.
                // Запись за время финализации могли остановить (кнопка «Стоп», закрытие
                // экрана) — тогда пайплайна уже нет и продолжать нечего.
                if let self = self, self.segmentingActive, self.isRecording, self.compositor != nil {
                    self.startRecordingSegment(isRollover: true)
                } else {
                    self?.isTransitioning = false
                }
                Self.moveToPhotoLibrary(url: url) { success in
                    if !success {
                        NSLog("[mafbase_stream] rollover: сегмент \(url.lastPathComponent) не перенесён в Фото")
                    }
                    done()
                }
            }
        }
    }

    private func stopRecording() {
        cancelSegmentTimer()
        // Сначала отписываемся от compositor.onFrame, чтобы не приходили новые кадры
        // в writer'ы, пока он финишит.
        isRecording = false
        updateQualityButtonState()
        guard let recorder = mp4Recorder else {
            // Идёт финализация ролловера — она сохранит сегмент сама и, увидев
            // сброшенный segmentingActive, не начнёт следующий.
            recordButton.setTitle("Запись", for: .normal)
            return
        }
        mp4Recorder = nil
        isTransitioning = true
        recordButton.isEnabled = false

        Self.runProtectedFromSuspension { done in
            recorder.stop { [weak self] url, error in
                self?.isTransitioning = false
                self?.recordButton.setTitle("Запись", for: .normal)
                self?.recordButton.isEnabled = true

                if let error = error {
                    self?.showAlert(title: "Ошибка записи", message: "\(error)")
                    done()
                    return
                }
                guard let url = url else {
                    self?.showAlert(title: "Запись пуста", message: "Файл не создан.")
                    done()
                    return
                }
                Self.moveToPhotoLibrary(url: url) { success in
                    done()
                    guard !success else { return }
                    if let self = self {
                        self.showAlert(
                            title: "Не удалось сохранить в Фото",
                            message: Self.photoLibraryFailureMessage(for: url)
                        )
                    } else {
                        NSLog("[mafbase_stream] stop: не удалось перенести запись в Фото")
                    }
                }
            }
        }
    }

    /// Синхронная версия для системных прерываний — сохраняет запись в Фото без UI.
    /// Сохранение не должно зависеть от жизни контроллера: метод вызывается из
    /// `viewWillDisappear`, а finishWriting многочасового файла длится секунды.
    private func stopRecordingSync() {
        cancelSegmentTimer()
        isRecording = false
        updateQualityButtonState()
        recordButton.setTitle("Запись", for: .normal)
        // Ролловер в этот момент мог уже забрать recorder себе — тогда он и сохранит
        // сегмент, а сброшенный segmentingActive не даст ему начать следующий.
        guard let recorder = mp4Recorder else { return }
        mp4Recorder = nil
        Self.runProtectedFromSuspension { done in
            recorder.stop { url, _ in
                guard let url = url else {
                    done()
                    return
                }
                Self.moveToPhotoLibrary(url: url) { success in
                    if !success {
                        NSLog("[mafbase_stream] sync stop: запись \(url.lastPathComponent) не перенесена в Фото")
                    }
                    done()
                }
            }
        }
    }

    /// Переносит видеофайл в библиотеку Фото. Файл забирается перемещением на том же
    /// томе (shouldMoveFile), без копирования данных — операция мгновенна для любого
    /// размера записи; при ошибке оригинал остаётся в Documents. Completion — на main queue.
    ///
    /// Статический намеренно: перенос запускается из завершения `recorder.stop`, которое
    /// может прийти уже после освобождения контроллера, и не должен от него зависеть.
    private static func moveToPhotoLibrary(url: URL, completion: @escaping (Bool) -> Void) {
        // Разрешение уже запрошено при старте записи — используем текущий статус,
        // чтобы не показывать диалог повторно в момент остановки.
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        guard status == .authorized || status == .limited else {
            NSLog("[mafbase_stream] Photos access denied: \(status.rawValue)")
            DispatchQueue.main.async { completion(false) }
            return
        }
        PHPhotoLibrary.shared().performChanges({
            let options = PHAssetResourceCreationOptions()
            options.shouldMoveFile = true
            PHAssetCreationRequest.forAsset().addResource(with: .video, fileURL: url, options: options)
        }) { success, error in
            if let error = error {
                NSLog("[mafbase_stream] Failed to move video to Photos: \(error)")
            }
            DispatchQueue.main.async { completion(success) }
        }
    }

    /// Выполняет финализацию записи (finishWriting + перенос в Фото) под защитой
    /// background task: если приложение свернули сразу после остановки, iOS даёт
    /// ~30 секунд фонового времени — этого хватает, т.к. перенос в Фото мгновенный.
    /// `work` обязан вызвать переданный ему callback по завершении (на main queue).
    private static func runProtectedFromSuspension(_ work: (@escaping () -> Void) -> Void) {
        var taskId = UIBackgroundTaskIdentifier.invalid
        let finish = {
            if taskId != .invalid {
                UIApplication.shared.endBackgroundTask(taskId)
                taskId = .invalid
            }
        }
        taskId = UIApplication.shared.beginBackgroundTask(
            withName: "mafbase_stream.save-recording",
            expirationHandler: finish
        )
        work(finish)
    }

    /// Текст для пользователя, когда перенос в Фото не состоялся: файл никуда не пропал,
    /// но лежит внутри приложения и сам в галерее не появится.
    private static func photoLibraryFailureMessage(for url: URL) -> String {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        if status != .authorized && status != .limited {
            return "Нет доступа к Фото. Разрешите его в Настройках, запись сохранена в файлах приложения: \(url.lastPathComponent)"
        }
        return "Запись сохранена в файлах приложения: \(url.lastPathComponent)"
    }

    private func showAlert(title: String, message: String?, onDismiss: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in onDismiss?() })
        present(alert, animated: true)
    }

    // MARK: - Streaming

    private func setStreamButtonLabel(_ label: String) {
        streamButtonLabel = label
        if !streamSpinner.isAnimating {
            streamButton.setTitle(label, for: .normal)
        }
    }

    private func setStreamButtonLoading(_ loading: Bool) {
        if loading {
            streamButton.setTitle("", for: .normal)
            streamSpinner.startAnimating()
        } else {
            streamSpinner.stopAnimating()
            streamButton.setTitle(streamButtonLabel, for: .normal)
        }
    }

    private func composedRtmpUrl() -> String {
        let trimmed = rtmpUrl.trimmingCharacters(in: .whitespacesAndNewlines)
        let key = streamKey.trimmingCharacters(in: .whitespacesAndNewlines)
        let base = trimmed.hasSuffix("/") ? String(trimmed.dropLast()) : trimmed
        if key.isEmpty { return base }
        return "\(base)/\(key)"
    }

    private func startStreaming() {
        guard captureSession.isRunning else { return }
        isTransitioning = true
        streamButton.isEnabled = false
        recordButton.isEnabled = false
        setStreamButtonLoading(true)

        let session = StreamSession(
            config: StreamSession.Config(
                rtmpUrl: composedRtmpUrl(),
                width: frameWidth,
                height: frameHeight,
                videoBitrate: qualitySettings.bitrateBps
            ),
            phaseGate: phaseGate
        )
        session.onStarted = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.showAlert(title: "Стрим запущен", message: nil)
            }
        }
        session.onError = { [weak self] error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                NSLog("[mafbase_stream] stream error: \(error)")
                self.showAlert(title: "Ошибка стрима", message: "\(error)")
            }
        }
        session.onEvent = { event in
            StreamEventBus.shared.emit(event)
        }

        // start() занимает 100–300 мс — выполняем в фоне.
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            do {
                try session.start()
            } catch {
                NSLog("[mafbase_stream] StreamSession.start failed: \(error)")
                session.stop()
                DispatchQueue.main.async {
                    self.isTransitioning = false
                    self.setStreamButtonLoading(false)
                    self.streamButton.isEnabled = true
                    self.recordButton.isEnabled = true
                    self.showAlert(title: "Не удалось начать стрим", message: "\(error)")
                }
                return
            }
            DispatchQueue.main.async {
                self.streamSession = session
                self.isStreaming = true
                self.isTransitioning = false
                self.updateQualityButtonState()
                self.setStreamButtonLabel("Стоп")
                self.setStreamButtonLoading(false)
                self.streamButton.isEnabled = true
                self.recordButton.isEnabled = true
            }
        }
    }

    private func stopStreaming() {
        guard let session = streamSession else { return }
        isTransitioning = true
        streamButton.isEnabled = false
        recordButton.isEnabled = false
        setStreamButtonLoading(true)
        // Сначала отписываемся, потом дренируем энкодер.
        isStreaming = false
        updateQualityButtonState()

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            session.stop()
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.streamSession = nil
                self.isTransitioning = false
                self.setStreamButtonLabel("Стрим")
                self.setStreamButtonLoading(false)
                self.streamButton.isEnabled = true
                self.recordButton.isEnabled = true
            }
        }
    }

    /// Синхронный stop для onPause/закрытия — без UI-фидбека.
    private func stopStreamingSync() {
        guard let session = streamSession else { return }
        isStreaming = false
        updateQualityButtonState()
        session.stop()
        streamSession = nil
        setStreamButtonLabel("Стрим")
        setStreamButtonLoading(false)
    }

    // MARK: - Audio session interruption

    private func registerInterruptionObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleAudioInterruption),
            name: AVAudioSession.interruptionNotification,
            object: nil
        )
    }

    @objc private func handleAudioInterruption(_ note: Notification) {
        guard
            let info = note.userInfo,
            let typeRaw = info[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeRaw)
        else { return }
        if type == .began && isRecording {
            stopRecording()
        }
    }
}

// MARK: - Sample buffer delegates

extension StreamViewController: AVCaptureVideoDataOutputSampleBufferDelegate,
    AVCaptureAudioDataOutputSampleBufferDelegate {

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard CMSampleBufferDataIsReady(sampleBuffer) else { return }
        if output === videoDataOutput {
            // Видео всегда идёт через compositor — он раздаёт processed-кадр на
            // preview / recorder / stream session (см. dispatchProcessedFrame).
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            let pts = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
            compositor?.processFrame(pixelBuffer: pixelBuffer, pts: pts)
        } else if output === audioDataOutput {
            // Аудио идёт мимо compositor'а — напрямую в writer'ы.
            if isRecording, let recorder = mp4Recorder {
                recorder.appendAudio(sampleBuffer: sampleBuffer)
            }
            if isStreaming, let session = streamSession {
                session.appendAudioSample(sampleBuffer)
            }
        }
    }
}
