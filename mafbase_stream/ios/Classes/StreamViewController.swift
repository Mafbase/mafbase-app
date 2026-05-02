import AVFoundation
import CoreMedia
import CoreVideo
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

    // MARK: - Capture

    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "com.example.mafbase_stream.session")
    private let videoDataQueue = DispatchQueue(label: "com.example.mafbase_stream.video.data")
    private let audioDataQueue = DispatchQueue(label: "com.example.mafbase_stream.audio.data")
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let audioDataOutput = AVCaptureAudioDataOutput()
    private var didFireOnClose = false

    // MARK: - Pipeline (compositor as source of truth)

    /// Жёстко зафиксированный размер кадра пайплайна. Совпадает с
    /// `sessionPreset = .hd1280x720`, и дальше — фиксированный размер
    /// Compositor'а / VTCompressionSession / AVAssetWriter.
    private static let frameWidth: Int = 1280
    private static let frameHeight: Int = 720

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

    // MARK: - Recording / Streaming state

    private var mp4Recorder: Mp4Recorder?
    private var isRecording = false
    private var isTransitioning = false

    private var streamSession: StreamSession?
    private var isStreaming = false
    private var streamButtonLabel = "Стрим"

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        modalPresentationStyle = .fullScreen

        setupPreviewDisplayLayer()
        setupCloseButton()
        setupBottomButtons()
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
        let comp = Compositor(width: Self.frameWidth, height: Self.frameHeight)
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

    /// Если задан `overlayViewType` — создаёт overlay через каталог и привязывает
    /// к compositor'у. Overlay живёт всю жизнь compositor'а и видим во всех выходах.
    private func attachOverlayIfNeeded(_ comp: Compositor) {
        guard let viewType = overlayViewType else {
            NSLog("[Stream] attachOverlay: NO overlayViewType set")
            return
        }
        NSLog("[Stream] attachOverlay: viewType=\(viewType) tournamentId=\(overlayParams.tournamentId.map(String.init) ?? "nil") table=\(overlayParams.table.map(String.init) ?? "nil")")
        let renderer = OverlayViewRenderer(width: Self.frameWidth, height: Self.frameHeight)
        guard let overlay = OverlayCatalog.create(
            viewType: viewType,
            params: overlayParams,
            invalidator: renderer
        ) else {
            NSLog("[Stream] overlay '\(viewType)' not found in catalog")
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
        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            self.captureSession.beginConfiguration()
            if self.captureSession.canSetSessionPreset(.hd1280x720) {
                self.captureSession.sessionPreset = .hd1280x720
            } else {
                self.captureSession.sessionPreset = .high
            }

            if let videoDevice = self.bestBackCamera(),
               let videoInput = try? AVCaptureDeviceInput(device: videoDevice),
               self.captureSession.canAddInput(videoInput) {
                self.captureSession.addInput(videoInput)
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
        layer.videoGravity = .resizeAspectFill
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
    }

    @objc private func toggleOverlayTapped() {
        (overlayView as? OverlayDebugTarget)?.onDebugToggle()
    }

    @objc private func closeTapped() {
        if isRecording {
            stopRecordingSync()
        }
        if isStreaming {
            stopStreamingSync()
        }
        dismissWithReason(.user)
    }

    @objc private func recordTapped() {
        if isTransitioning { return }
        if isStreaming {
            showAlert(title: "Сначала остановите стрим", message: "Запись MP4 и стрим одновременно не поддерживаются.")
            return
        }
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }

    @objc private func streamTapped() {
        if isTransitioning { return }
        if isRecording {
            showAlert(title: "Сначала остановите запись", message: "Запись MP4 и стрим одновременно не поддерживаются.")
            return
        }
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
        isTransitioning = true
        recordButton.isEnabled = false

        let recorder = Mp4Recorder()
        do {
            _ = try recorder.start(width: Int32(Self.frameWidth), height: Int32(Self.frameHeight))
        } catch {
            NSLog("[mafbase_stream] Mp4Recorder.start failed: \(error)")
            isTransitioning = false
            recordButton.isEnabled = true
            showAlert(title: "Не удалось начать запись", message: "\(error)")
            return
        }
        mp4Recorder = recorder
        isRecording = true
        isTransitioning = false
        recordButton.setTitle("Стоп", for: .normal)
        recordButton.isEnabled = true
    }

    private func stopRecording() {
        guard let recorder = mp4Recorder else { return }
        isTransitioning = true
        recordButton.isEnabled = false
        // Сначала отписываемся от compositor.onFrame, чтобы не приходили новые кадры
        // в writer'ы, пока он финишит.
        isRecording = false

        recorder.stop { [weak self] url, error in
            guard let self = self else { return }
            self.mp4Recorder = nil
            self.isTransitioning = false
            self.recordButton.setTitle("Запись", for: .normal)
            self.recordButton.isEnabled = true

            if let error = error {
                self.showAlert(title: "Ошибка записи", message: "\(error)")
                return
            }
            guard let url = url else {
                self.showAlert(title: "Запись пуста", message: "Файл не создан.")
                return
            }
            self.presentShareSheet(for: url)
        }
    }

    /// Синхронная версия для onPause/закрытия — без UI-фидбека.
    private func stopRecordingSync() {
        guard let recorder = mp4Recorder else { return }
        isRecording = false
        recorder.stop { _, _ in }
        mp4Recorder = nil
        recordButton.setTitle("Запись", for: .normal)
    }

    private func presentShareSheet(for url: URL) {
        let alert = UIAlertController(
            title: "Запись сохранена",
            message: url.lastPathComponent,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Поделиться", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let share = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            share.popoverPresentationController?.sourceView = self.recordButton
            self.present(share, animated: true)
        })
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }

    private func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
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
                width: Self.frameWidth,
                height: Self.frameHeight
            )
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
