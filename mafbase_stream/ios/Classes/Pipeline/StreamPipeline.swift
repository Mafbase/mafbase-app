import AVFoundation
import CoreMedia
import CoreVideo
import Photos
import UIKit

/// Колбэки пайплайна; все вызовы приходят на main queue.
protocol StreamPipelineDelegate: AnyObject {
    /// Изменились запись/стрим/транзишны, объектив, качество или overlay.
    func onStateChanged()
    /// Размер кадра выбран заново — превью нужно сбросить.
    func onFrameSizeChanged(width: Int, height: Int)
    func onMessage(text: String, long: Bool)
    /// Пайплайн не может работать (нет камеры, не поднялся компоситор) — экран закрывается.
    func onFatalError(message: String)
}

/// Движок экрана трансляции: `AVCaptureSession` → `Compositor` → превью / MP4-запись / RTMP-стрим.
///
/// Живёт отдельно от `StreamViewController`: единственный экземпляр на процесс держит
/// `MafbaseStreamPlugin`, контроллер лишь подключает слой превью, хостит overlay-view в своём
/// окне и отражает состояние через `StreamPipelineDelegate`. Compositor — единственный источник
/// кадров: `AVCaptureVideoDataOutput` отдаёт кадры в `processFrame`, скомпонованный
/// `CVPixelBuffer` расходится на превью, `Mp4Recorder` и `StreamSession`; запись и стрим
/// подписываются на него флагами `isRecording` / `isStreaming`, аудио идёт мимо компоситора
/// напрямую в энкодеры.
///
/// В фоне и при прерываниях камеры поток не рвётся: компоситор отдаёт заглушку 2 fps без GL,
/// пропавший звук подменяет `SilenceGenerator`, а умершая capture session пересобирается
/// с backoff — энкодеры, рекордер и стрим-сессия при этом живут дальше. Стрим-сессию после
/// сбоя пересоздаёт `StreamingController`, он же реагирует на смену сети; при нагреве
/// пайплайн снижает частоту кадров камеры и битрейт стрима.
///
/// Публичные методы и колбэки делегата — на main queue; capture-колбэки и компоситор работают
/// на своих очередях.
final class StreamPipeline: NSObject {

    struct Config {
        let rtmpUrl: String
        let streamKey: String
        let overlayViewType: String?
        let overlayParams: OverlayParams
        /// Длина сегмента записи в секундах. 0 = сегментация выключена.
        let segmentDurationSeconds: TimeInterval
    }

    enum Lens: Int {
        case ultraWide = 0
        case wide = 1
    }

    let config: Config
    weak var delegate: StreamPipelineDelegate?

    // MARK: - State

    private(set) var isStarted = false
    private(set) var isReleased = false
    private(set) var isRecording = false
    /// Намерение пользователя: остаётся true, пока стрим-сессия пересоздаётся после сбоя.
    var isStreaming: Bool { streaming.isStreaming }
    private(set) var isRecordTransition = false
    var isStreamTransition: Bool { streaming.isStreamTransition }
    var isTransitioning: Bool { isRecordTransition || isStreamTransition }
    /// Идёт стрим или запись — то, что должно пережить закрытие экрана.
    var isActive: Bool { isRecording || isStreaming }
    /// Качество меняется только в простое: смена разрешения пересоздаёт пайплайн, а битрейт
    /// применяется при старте стрима.
    var isQualityLocked: Bool { isRecording || isStreaming || isTransitioning }

    private(set) var qualitySettings: StreamQualitySettings
    /// Размер кадра пайплайна: session preset, Compositor, энкодеры и AVAssetWriter видят один
    /// и тот же размер. Меняется только в простое.
    private(set) var frameWidth: Int
    private(set) var frameHeight: Int

    private(set) var activeLens: Lens = .wide
    private(set) var isLensSwitching = false
    var hasUltraWide: Bool { ultraWideCamera != nil }

    var overlayDebugTarget: OverlayDebugTarget? { overlayView as? OverlayDebugTarget }

    // MARK: - Capture

    private var captureSession = StreamPipeline.makeCaptureSession()
    private let sessionQueue = DispatchQueue(label: "com.example.mafbase_stream.session")
    private let videoDataQueue = DispatchQueue(label: "com.example.mafbase_stream.video.data")
    private let audioDataQueue = DispatchQueue(label: "com.example.mafbase_stream.audio.data")
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let audioDataOutput = AVCaptureAudioDataOutput()
    private var videoDeviceInput: AVCaptureDeviceInput?
    private let ultraWideCamera = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .back)
    private var videoOrientation: AVCaptureVideoOrientation = .landscapeRight
    private var hasVideoInput = false
    private var captureSessionObservers: [NSObjectProtocol] = []
    private var lifecycleObservers: [NSObjectProtocol] = []
    private var isInBackground = false

    /// Пересборка capture session после runtime-ошибки: 1→2→4→8→10 с без лимита попыток.
    private let rebuildBackoff = RetryBackoff(baseMs: 1000, capMs: 10000)
    private var rebuildTimer: Timer?
    private var rebuildDeferred = false
    private var rebuildInProgress = false

    /// Пайплайны сменяют друг друга (release старого, start нового) — аудио-сессию гасит
    /// только тот, кто активировал её последним.
    private static var audioSessionGeneration = 0
    private var audioSessionToken = 0

    private let silenceGenerator = SilenceGenerator()

    // MARK: - Compositor / overlay

    /// Шарится между overlay'ем (writer) и audio-энкодерами (reader): overlay выставляет
    /// muted=true, когда `broadcastPhase` != day.
    private let phaseGate = PhaseGate()
    private var compositor: Compositor?
    /// PTS последнего кадра, ушедшего в превью/recorder/session (только render queue): заглушка
    /// и камера идут по часам capture session, но на стыке кадр камеры может прийти с прошлым PTS.
    private var lastDispatchedVideoPts: CMTime = .invalid
    private var overlayRenderer: OverlayViewRenderer?
    private var overlayView: UIView?
    private weak var overlayHost: UIViewController?

    // MARK: - Preview

    /// Слой подключает контроллер (attach/detach на main), кадры кладёт render queue
    /// компоситора — оба доступа под `previewLock`.
    private let previewLock = NSLock()
    private var previewLayer: AVSampleBufferDisplayLayer?
    private var previewFormatDescription: CMVideoFormatDescription?

    // MARK: - Recording

    private var mp4Recorder: Mp4Recorder?
    private var segmentIndex: Int = 1
    private var recordingSessionId: String = ""
    private var segmentTimer: Timer?
    /// Сессия записи активна и ролловеры разрешены. В отличие от `isRecording`, который остаётся
    /// true на время асинхронной финализации сегмента, сбрасывается сразу при любой остановке —
    /// по нему завершившийся ролловер понимает, что следующий сегмент начинать не нужно.
    private var segmentingActive = false

    private static let storageCheckIntervalSeconds: TimeInterval = 30
    /// Аудио-битрейт записи не настраивается (128 kbps AAC, см. `AacEncoder`) — для оценки объёма
    /// записи берём его константой вместе с битрейтом видео-энкодера записи.
    private static let estimatedAudioBitrateBps = 128_000
    private var storageCheckTimer: Timer?
    private var storageWarningReported = false

    // MARK: - Streaming

    private let streaming = StreamingController()

    // MARK: - Thermal

    private var thermalLevel: ThermalLevel = .nominal
    /// Камера, за `systemPressureState` которой следим (main).
    private var thermalDevice: AVCaptureDevice?
    private var pressureObservation: NSKeyValueObservation?
    private var lastThermalMessageAt: Date?

    init(config: Config) {
        self.config = config
        let quality = StreamQualityStore.load()
        qualitySettings = quality
        frameWidth = quality.resolution.width
        frameHeight = quality.resolution.height
        super.init()
        streaming.makeSession = { [weak self] in self?.makeStreamSession() }
        streaming.isReleased = { [weak self] in self?.isReleased ?? true }
        streaming.isRecordTransition = { [weak self] in self?.isRecordTransition ?? false }
        streaming.onStateChanged = { [weak self] in self?.notifyState() }
        streaming.onMessage = { [weak self] text, long in self?.delegate?.onMessage(text: text, long: long) }
    }

    deinit {
        removeObservers()
    }

    // MARK: - Lifecycle

    /// Поднимает компоситор и capture session. Вызывать, когда разрешения уже выданы.
    func start() {
        guard !isStarted, !isReleased else { return }
        isStarted = true
        frameWidth = qualitySettings.resolution.width
        frameHeight = qualitySettings.resolution.height
        registerLifecycleObservers()
        registerCaptureSessionObservers()
        guard startCompositorPipeline() else { return }
        startSilenceGenerator()
        activateAudioSession()
        configureSession()
        startSession()
        notifyState()
    }

    func attachPreview(_ layer: AVSampleBufferDisplayLayer) {
        previewLock.lock()
        previewLayer = layer
        previewFormatDescription = nil
        previewLock.unlock()
    }

    /// Отцепляет только превью: камера, компоситор и энкодеры работают дальше.
    func detachPreview() {
        previewLock.lock()
        previewLayer = nil
        previewFormatDescription = nil
        previewLock.unlock()
    }

    /// Overlay-view живёт невидимо в `view` контроллера: `UIHostingController` внутри overlay'я
    /// ищет parent VC через responder chain.
    func hostOverlay(in viewController: UIViewController) {
        guard !isReleased else { return }
        overlayHost = viewController
        overlayRenderer?.hostIn(viewController)
    }

    func unhostOverlay() {
        overlayHost = nil
        overlayRenderer?.unhost()
    }

    func updateVideoOrientation(_ orientation: AVCaptureVideoOrientation) {
        videoOrientation = orientation
        applyVideoOrientation()
    }

    /// Останавливает запись (асинхронная финализация и перенос в Фото) и стрим.
    func stopAll() {
        if isRecording { stopRecording() }
        if isStreaming { stopStreaming() }
    }

    /// Необратимо: останавливает всё без UI, гасит capture session, компоситор и overlay.
    func release() {
        guard !isReleased else { return }
        isReleased = true
        UIApplication.shared.isIdleTimerDisabled = false
        rebuildTimer?.invalidate()
        rebuildTimer = nil
        if isRecording { stopRecordingSync() }
        streaming.stopForRelease()
        silenceGenerator.stop()
        stopSession()
        overlayHost = nil
        stopCompositorPipeline()
        lastDispatchedVideoPts = .invalid
        removeObservers()
    }

    // MARK: - Controls

    func toggleRecording() {
        guard !isReleased, !isTransitioning else { return }
        if isRecording { stopRecording() } else { startRecording() }
    }

    func toggleStreaming() {
        guard !isReleased, !isTransitioning else { return }
        if isStreaming { stopStreaming() } else { startStreaming() }
    }

    /// Смена объектива «на лету»: заменяется только AVCaptureDeviceInput, размер кадра и
    /// энкодеры не затрагиваются, поэтому доступна и во время записи/стрима.
    func switchLens(to lens: Lens) {
        guard !isReleased, lens != activeLens, !isLensSwitching else { return }
        guard let device = captureDevice(for: lens) else { return }
        let previousLens = activeLens
        activeLens = lens
        isLensSwitching = true
        notifyState()

        let maxFps = thermalLevel.maxFps
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
            let activeDevice = self.videoDeviceInput?.device
            if let activeDevice = activeDevice, maxFps != nil {
                self.applyFrameRateLimit(maxFps, to: activeDevice)
            }

            DispatchQueue.main.async {
                self.isLensSwitching = false
                if !switched {
                    self.activeLens = previousLens
                }
                self.applyVideoOrientation()
                self.observeSystemPressure(of: activeDevice)
                self.notifyState()
            }
        }
    }

    func applyQualitySettings(_ settings: StreamQualitySettings) {
        guard !isReleased else { return }
        let previousResolution = qualitySettings.resolution
        qualitySettings = settings
        StreamQualityStore.save(settings)
        if settings.resolution != previousResolution, !isQualityLocked, isStarted {
            applyResolutionChange(to: settings.resolution)
        }
        notifyState()
    }

    /// Единственная точка оповещения об изменении состояния.
    private func notifyState() {
        delegate?.onStateChanged()
    }

    // MARK: - Compositor pipeline

    @discardableResult
    private func startCompositorPipeline() -> Bool {
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
            delegate?.onFatalError(message: "Не удалось запустить обработку видео: \(error)")
            return false
        }
        compositor = comp
        comp.clock = { [weak self] in self?.captureClockNow() ?? CMClockGetTime(CMClockGetHostTimeClock()) }
        comp.setPlaceholderCard(PauseCardRenderer.render(width: frameWidth, height: frameHeight))

        attachOverlayIfNeeded(comp)
        return true
    }

    private func stopCompositorPipeline() {
        overlayRenderer?.detach()
        overlayRenderer = nil
        overlayView = nil
        compositor?.release()
        compositor = nil
    }

    /// Подключает overlay-вёрстку и/или brand-картинку к compositor'у — если задан
    /// `overlayViewType` или `brandImageUrl`. Wrapper живёт всю жизнь compositor'а и виден
    /// во всех выходах.
    private func attachOverlayIfNeeded(_ comp: Compositor) {
        let viewType = config.overlayViewType
        let params = config.overlayParams
        let hasBrand = (params.brandImageUrl?.isEmpty == false)
        if viewType == nil && !hasBrand {
            NSLog("[Stream] attachOverlay: no overlayViewType and no brand image")
            return
        }
        NSLog("[Stream] attachOverlay: viewType=\(viewType ?? "nil") brand=\(params.brandImageUrl ?? "nil") tournamentId=\(params.tournamentId.map(String.init) ?? "nil") clubId=\(params.clubId.map(String.init) ?? "nil") table=\(params.table.map(String.init) ?? "nil")")
        let renderer = OverlayViewRenderer(width: frameWidth, height: frameHeight)
        let resolvedParams = OverlayParams(
            tournamentId: params.tournamentId,
            clubId: params.clubId,
            table: params.table,
            phaseGate: phaseGate,
            breakPlaceholderImageUrl: params.breakPlaceholderImageUrl,
            brandImageUrl: params.brandImageUrl
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
        if let host = overlayHost {
            renderer.hostIn(host)
        }
        renderer.attach(compositor: comp)
        overlayRenderer = renderer
        overlayView = overlay
    }

    /// Compositor.onFrame (render queue): один и тот же CVPixelBuffer уходит на превью,
    /// в recorder и в stream session — overlay уже наложен.
    private func dispatchProcessedFrame(_ pixelBuffer: CVPixelBuffer, pts: CMTime) {
        if lastDispatchedVideoPts.isValid, CMTimeCompare(pts, lastDispatchedVideoPts) <= 0 { return }
        lastDispatchedVideoPts = pts
        enqueuePreviewFrame(pixelBuffer, pts: pts)
        if isRecording {
            mp4Recorder?.appendVideo(pixelBuffer: pixelBuffer, pts: pts)
        }
        if streaming.isStreaming, let session = streaming.session {
            session.appendProcessedVideo(pixelBuffer: pixelBuffer, pts: pts)
        }
    }

    private func enqueuePreviewFrame(_ pixelBuffer: CVPixelBuffer, pts: CMTime) {
        previewLock.lock()
        defer { previewLock.unlock() }
        guard let layer = previewLayer else { return }
        // После фона слой остаётся в `.failed` и молча игнорирует кадры, пока его не сбросить.
        if layer.status == .failed { layer.flush() }
        guard layer.isReadyForMoreMediaData,
              let sampleBuffer = makeDisplaySampleBuffer(from: pixelBuffer, pts: pts) else { return }
        layer.enqueue(sampleBuffer)
    }

    /// Оборачивает CVPixelBuffer в CMSampleBuffer для AVSampleBufferDisplayLayer. Format
    /// description кешируем: Compositor гарантирует одинаковые dimensions всех выходных
    /// буферов. Вызывается под `previewLock`.
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

    /// При пересборке отсутствие камеры не фатально — следующую попытку назначит backoff.
    private func configureSession(isRebuild: Bool = false) {
        let preferredPreset = sessionPreset(for: qualitySettings.resolution)
        let maxFps = thermalLevel.maxFps
        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            self.captureSession.beginConfiguration()
            self.applySessionPreset(preferredPreset)

            var addedDevice: AVCaptureDevice?
            if let videoDevice = self.captureDevice(for: self.activeLens),
               let videoInput = try? AVCaptureDeviceInput(device: videoDevice),
               self.captureSession.canAddInput(videoInput) {
                self.captureSession.addInput(videoInput)
                self.videoDeviceInput = videoInput
                addedDevice = videoDevice
            } else {
                NSLog("[mafbase_stream] не удалось добавить видео-вход")
                if !isRebuild {
                    DispatchQueue.main.async {
                        self.delegate?.onFatalError(message: "Камера недоступна")
                    }
                }
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
            if let device = addedDevice, maxFps != nil {
                self.applyFrameRateLimit(maxFps, to: device)
            }

            DispatchQueue.main.async {
                self.hasVideoInput = addedDevice != nil
                self.applyVideoOrientation()
                self.observeSystemPressure(of: addedDevice)
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

    private func applyVideoOrientation() {
        if let connection = videoDataOutput.connection(with: .video),
           connection.isVideoOrientationSupported {
            connection.videoOrientation = videoOrientation
        }
    }

    private func startSession() {
        sessionQueue.async { [weak self] in
            guard let self = self, !self.captureSession.isRunning else { return }
            self.captureSession.startRunning()
        }
    }

    /// Аудио-сессию гасим после stopRunning: с работающим I/O `setActive(false)` отказывает.
    private func stopSession() {
        let session = captureSession
        let token = audioSessionToken
        sessionQueue.async {
            if session.isRunning { session.stopRunning() }
            DispatchQueue.main.async {
                guard Self.audioSessionGeneration == token else { return }
                Self.deactivateAudioSession()
            }
        }
    }

    /// Пересобирает пайплайн под новое разрешение. Только в простое: запись/стрим блокируют
    /// панель качества, энкодеры ещё не созданы.
    private func applyResolutionChange(to resolution: StreamResolution) {
        stopCompositorPipeline()
        frameWidth = resolution.width
        frameHeight = resolution.height
        previewLock.lock()
        previewFormatDescription = nil
        previewLock.unlock()
        delegate?.onFrameSizeChanged(width: frameWidth, height: frameHeight)
        startCompositorPipeline()

        let preset = sessionPreset(for: resolution)
        let maxFps = thermalLevel.maxFps
        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            self.captureSession.beginConfiguration()
            self.applySessionPreset(preset)
            self.captureSession.commitConfiguration()
            if let device = self.videoDeviceInput?.device, maxFps != nil {
                self.applyFrameRateLimit(maxFps, to: device)
            }
        }
    }

    /// Ограничение частоты кадров при нагреве (sessionQueue); `nil` возвращает частоту по
    /// умолчанию для активного формата. Вызывать после `commitConfiguration`: смена preset'а
    /// и добавление входа сами сбрасывают частоту к умолчанию.
    private func applyFrameRateLimit(_ maxFps: Int?, to device: AVCaptureDevice) {
        var duration = CMTime.invalid
        if let fps = maxFps {
            let supported = device.activeFormat.videoSupportedFrameRateRanges.contains {
                Double(fps) >= $0.minFrameRate && Double(fps) <= $0.maxFrameRate
            }
            guard supported else { return }
            duration = CMTime(value: 1, timescale: CMTimeScale(fps))
        }
        do {
            try device.lockForConfiguration()
        } catch {
            NSLog("[mafbase_stream] lockForConfiguration failed: \(error)")
            return
        }
        device.activeVideoMinFrameDuration = duration
        device.activeVideoMaxFrameDuration = duration
        device.unlockForConfiguration()
    }

    // MARK: - Recording

    private func startRecording() {
        guard captureSession.isRunning else { return }
        // Доступ к Фото запрашиваем при старте записи, а не при её завершении: при остановке
        // используется уже полученный статус без повторного диалога.
        if PHPhotoLibrary.authorizationStatus(for: .addOnly) == .notDetermined {
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { _ in }
        }
        isRecordTransition = true
        notifyState()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        recordingSessionId = formatter.string(from: Date())
        segmentIndex = 1
        segmentingActive = true

        startRecordingSegment(isRollover: false)
        if isRecording {
            storageWarningReported = false
            checkStorageAndMaybeStop()
        }
    }

    private func startRecordingSegment(isRollover: Bool) {
        let recorder = Mp4Recorder(segmentName: buildSegmentName())
        do {
            _ = try recorder.start(width: Int32(frameWidth), height: Int32(frameHeight))
        } catch {
            NSLog("[mafbase_stream] Mp4Recorder.start failed: \(error)")
            cancelSegmentTimer()
            cancelStorageCheck()
            isRecording = false
            isRecordTransition = false
            notifyState()
            let title = isRollover ? "Запись прервана" : "Не удалось начать запись"
            delegate?.onMessage(text: "\(title): \(error)", long: true)
            return
        }
        mp4Recorder = recorder
        isRecording = true
        isRecordTransition = false
        notifyState()
        scheduleNextSegment()
    }

    private func buildSegmentName() -> String {
        if config.segmentDurationSeconds > 0 {
            return "mafbase_stream_\(recordingSessionId)_part\(segmentIndex).mp4"
        } else {
            return "mafbase_stream_\(recordingSessionId).mp4"
        }
    }

    private func scheduleNextSegment() {
        guard config.segmentDurationSeconds > 0 else { return }
        segmentTimer = Timer.scheduledTimer(withTimeInterval: config.segmentDurationSeconds, repeats: false) { [weak self] _ in
            self?.rolloverSegment()
        }
    }

    private func cancelSegmentTimer() {
        segmentTimer?.invalidate()
        segmentTimer = nil
        segmentingActive = false
    }

    private var recordingStorageDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            ?? URL(fileURLWithPath: NSTemporaryDirectory())
    }

    /// Проверяет свободное место и сама себя переставляет каждые `storageCheckIntervalSeconds`,
    /// пока запись активна. Не блокирует запись: при нехватке места на ~8ч (см. `StorageMonitor`)
    /// только предупреждает сообщением и событием `StreamEventBus.emitStorageEvent` —
    /// предупреждение показывается один раз, пока место не появится снова. При критическом
    /// остатке (< `StorageMonitor.criticalFreeBytes`) останавливает текущую запись.
    private func checkStorageAndMaybeStop() {
        // Битрейт стрима на объём MP4-записи не влияет — Mp4Recorder всегда пишет видео
        // с фиксированным H264Encoder.defaultBitRateBps, по нему и считаем.
        let totalBitrateBps = H264Encoder.defaultBitRateBps + Self.estimatedAudioBitrateBps
        let check = StorageMonitor.check(at: recordingStorageDirectory, totalBitrateBps: totalBitrateBps)
        if check.isCritical {
            NSLog("[mafbase_stream] Свободного места критически мало (\(check.freeBytes) байт) — останавливаем запись")
            StreamEventBus.shared.emitStorageEvent(type: .low, reason: "low_free_space:freeBytes=\(check.freeBytes)")
            if isRecording {
                delegate?.onMessage(text: "Запись остановлена: на устройстве закончилось место", long: true)
                stopRecording()
            }
            return
        }
        if check.isBelowTarget {
            if !storageWarningReported {
                storageWarningReported = true
                delegate?.onMessage(
                    text: "Мало места на устройстве: может не хватить на \(StorageMonitor.targetRecordingHours)ч записи",
                    long: true
                )
                StreamEventBus.shared.emitStorageEvent(
                    type: .warning,
                    reason: "insufficient_free_space:freeBytes=\(check.freeBytes),requiredBytes=\(check.requiredBytesForTarget)"
                )
            }
        } else {
            storageWarningReported = false
        }
        scheduleStorageCheck()
    }

    private func scheduleStorageCheck() {
        storageCheckTimer = Timer.scheduledTimer(withTimeInterval: Self.storageCheckIntervalSeconds, repeats: false) { [weak self] _ in
            self?.checkStorageAndMaybeStop()
        }
    }

    private func cancelStorageCheck() {
        storageCheckTimer?.invalidate()
        storageCheckTimer = nil
        storageWarningReported = false
    }

    /// `isRecording` не сбрасывается на время финализации сегмента (как на Android): иначе
    /// закрытие экрана посреди ролловера не увидит активной записи, пропустит сохранение,
    /// а зависшая финализация потом стартует сегмент на мёртвом пайплайне.
    private func rolloverSegment() {
        guard isRecording, let recorder = mp4Recorder else { return }
        if isTransitioning {
            segmentTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
                self?.rolloverSegment()
            }
            return
        }
        isRecordTransition = true
        mp4Recorder = nil
        segmentIndex += 1
        notifyState()

        Self.runProtectedFromSuspension { done in
            recorder.stop { [weak self] url, error in
                guard let url = url, error == nil else {
                    NSLog("[mafbase_stream] rollover: stop failed: \(String(describing: error))")
                    // completion уже на main queue
                    if let self = self {
                        self.cancelSegmentTimer()
                        self.cancelStorageCheck()
                        self.isRecording = false
                        self.isRecordTransition = false
                        self.notifyState()
                    }
                    done()
                    return
                }
                // Следующий сегмент запускаем до переноса в Фото — без паузы в записи.
                // Запись за время финализации могли остановить (кнопка «Стоп», закрытие
                // экрана) — тогда пайплайна уже нет и продолжать нечего.
                if let self = self, self.segmentingActive, self.isRecording, self.compositor != nil {
                    self.startRecordingSegment(isRollover: true)
                } else if let self = self {
                    self.isRecordTransition = false
                    self.notifyState()
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
        cancelStorageCheck()
        // Сначала отписываемся от compositor.onFrame, чтобы не приходили новые кадры
        // в writer'ы, пока он финишит.
        isRecording = false
        guard let recorder = mp4Recorder else {
            // Идёт финализация ролловера — она сохранит сегмент сама и, увидев
            // сброшенный segmentingActive, не начнёт следующий.
            notifyState()
            return
        }
        mp4Recorder = nil
        isRecordTransition = true
        notifyState()

        Self.runProtectedFromSuspension { done in
            recorder.stop { [weak self] url, error in
                self?.isRecordTransition = false
                self?.notifyState()

                if let error = error {
                    self?.delegate?.onMessage(text: "Ошибка записи: \(error)", long: true)
                    done()
                    return
                }
                guard let url = url else {
                    self?.delegate?.onMessage(text: "Запись пуста: файл не создан", long: true)
                    done()
                    return
                }
                Self.moveToPhotoLibrary(url: url) { success in
                    done()
                    guard !success else { return }
                    self?.delegate?.onMessage(
                        text: "Не удалось сохранить в Фото: \(Self.photoLibraryFailureMessage(for: url))",
                        long: true
                    )
                }
            }
        }
    }

    /// Синхронная версия для освобождения пайплайна — сохраняет запись в Фото без UI.
    /// Сохранение не зависит от жизни пайплайна: finishWriting многочасового файла длится секунды.
    private func stopRecordingSync() {
        cancelSegmentTimer()
        cancelStorageCheck()
        isRecording = false
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
    /// может прийти уже после освобождения пайплайна, и не должен от него зависеть.
    private static func moveToPhotoLibrary(url: URL, completion: @escaping (Bool) -> Void) {
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
            } else {
                NSLog("[mafbase_stream] recording moved to Photos: \(url.lastPathComponent)")
            }
            DispatchQueue.main.async { completion(success) }
        }
    }

    /// Выполняет финализацию записи (finishWriting + перенос в Фото) или остановку стрима под
    /// защитой background task: если приложение свернули сразу после остановки, iOS даёт
    /// ~30 секунд фонового времени — этого хватает, т.к. перенос в Фото мгновенный.
    /// `work` обязан вызвать переданный ему callback по завершении (на main queue).
    static func runProtectedFromSuspension(
        name: String = "mafbase_stream.save-recording",
        _ work: (@escaping () -> Void) -> Void
    ) {
        var taskId = UIBackgroundTaskIdentifier.invalid
        let finish = {
            if taskId != .invalid {
                UIApplication.shared.endBackgroundTask(taskId)
                taskId = .invalid
            }
        }
        taskId = UIApplication.shared.beginBackgroundTask(withName: name, expirationHandler: finish)
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

    // MARK: - Streaming

    private func composedRtmpUrl() -> String {
        let trimmed = config.rtmpUrl.trimmingCharacters(in: .whitespacesAndNewlines)
        let key = config.streamKey.trimmingCharacters(in: .whitespacesAndNewlines)
        let base = trimmed.hasSuffix("/") ? String(trimmed.dropLast()) : trimmed
        if key.isEmpty { return base }
        return "\(base)/\(key)"
    }

    private func startStreaming() {
        guard captureSession.isRunning else { return }
        streaming.start()
    }

    private func stopStreaming() {
        streaming.stop()
    }

    /// Сессия для `StreamingController` — и первая, и каждая пересозданная после сбоя.
    private func makeStreamSession() -> StreamSession {
        let session = StreamSession(
            config: StreamSession.Config(
                rtmpUrl: composedRtmpUrl(),
                width: frameWidth,
                height: frameHeight,
                videoBitrate: qualitySettings.bitrateBps
            ),
            phaseGate: phaseGate
        )
        session.setBitrateScale(thermalLevel.bitrateScale)
        return session
    }

    /// Часы, которыми capture session штампует сэмплы: в них же живут PTS заглушки и тишины.
    /// Читает `captureSession` в момент вызова — после пересборки это часы новой сессии.
    private func captureClockNow() -> CMTime {
        let clock: CMClock?
        if #available(iOS 15.4, *) {
            clock = captureSession.synchronizationClock
        } else {
            clock = captureSession.masterClock
        }
        return CMClockGetTime(clock ?? CMClockGetHostTimeClock())
    }

    // MARK: - Audio session

    private static func makeCaptureSession() -> AVCaptureSession {
        let session = AVCaptureSession()
        // Категорию и активность аудио-сессии держит пайплайн (playAndRecord живёт и в фоне);
        // иначе AVCaptureSession перенастраивает её на каждом startRunning.
        session.automaticallyConfiguresApplicationAudioSession = false
        return session
    }

    private func activateAudioSession() {
        Self.audioSessionGeneration += 1
        audioSessionToken = Self.audioSessionGeneration
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .videoRecording, options: [.defaultToSpeaker])
            try session.setActive(true)
        } catch {
            NSLog("[mafbase_stream] audio session activation failed: \(error)")
        }
    }

    private static func deactivateAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            NSLog("[mafbase_stream] audio session deactivation failed: \(error)")
        }
    }

    private func startSilenceGenerator() {
        silenceGenerator.isActive = { [weak self] in self?.isActive ?? false }
        silenceGenerator.clock = { [weak self] in self?.captureClockNow() ?? CMClockGetTime(CMClockGetHostTimeClock()) }
        silenceGenerator.onSample = { [weak self] sampleBuffer in
            self?.audioDataQueue.async { self?.dispatchAudioSample(sampleBuffer) }
        }
        silenceGenerator.start()
    }

    // MARK: - Observers

    /// Уведомления приложения — через selector: блочный наблюдатель с очередью срабатывает
    /// асинхронно, а `suspendRendering` обязан отработать до возврата управления системе.
    private func registerLifecycleObservers() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(handleWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        center.addObserver(self, selector: #selector(handleDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        center.addObserver(self, selector: #selector(handleWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        center.addObserver(self, selector: #selector(handleDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        lifecycleObservers = [
            center.addObserver(forName: AVAudioSession.interruptionNotification, object: nil, queue: .main) { [weak self] note in
                self?.handleAudioInterruption(note)
            },
            center.addObserver(forName: AVAudioSession.mediaServicesWereResetNotification, object: nil, queue: .main) { [weak self] _ in
                self?.handleMediaServicesReset()
            },
            center.addObserver(forName: ProcessInfo.thermalStateDidChangeNotification, object: nil, queue: .main) { [weak self] _ in
                self?.updateThermalLevel()
            },
        ]
    }

    /// Привязаны к конкретной `AVCaptureSession` — при пересборке подписываются заново.
    private func registerCaptureSessionObservers() {
        let center = NotificationCenter.default
        let session = captureSession
        captureSessionObservers = [
            center.addObserver(forName: AVCaptureSession.wasInterruptedNotification, object: session, queue: .main) { [weak self] note in
                self?.handleSessionInterrupted(note)
            },
            center.addObserver(forName: AVCaptureSession.interruptionEndedNotification, object: session, queue: .main) { [weak self] _ in
                self?.handleSessionInterruptionEnded()
            },
            center.addObserver(forName: AVCaptureSession.runtimeErrorNotification, object: session, queue: .main) { [weak self] note in
                self?.handleSessionRuntimeError(note)
            },
        ]
    }

    private func unregisterCaptureSessionObservers() {
        captureSessionObservers.forEach { NotificationCenter.default.removeObserver($0) }
        captureSessionObservers = []
    }

    private func removeObservers() {
        unregisterCaptureSessionObservers()
        NotificationCenter.default.removeObserver(self)
        lifecycleObservers.forEach { NotificationCenter.default.removeObserver($0) }
        lifecycleObservers = []
        observeSystemPressure(of: nil)
    }

    // MARK: - Background and interruptions

    /// Камера отдаёт кадры: сессия работает, не прервана и не пересобирается.
    private var isCameraAvailable: Bool {
        captureSession.isRunning && !captureSession.isInterrupted
            && !rebuildInProgress && rebuildTimer == nil && !rebuildDeferred
    }

    @objc private func handleWillResignActive() {
        compositor?.prepareForBackground()
    }

    /// В фоне GL запрещён: рендер приостанавливается до `willEnterForeground`, поток продолжает
    /// заглушка, отрендеренная на `willResignActive`.
    @objc private func handleDidEnterBackground() {
        isInBackground = true
        NSLog("[mafbase_stream] did enter background (recording=\(isRecording) streaming=\(isStreaming))")
        compositor?.suspendRendering()
        compositor?.enterPlaceholderMode()
    }

    @objc private func handleWillEnterForeground() {
        isInBackground = false
        NSLog("[mafbase_stream] will enter foreground (interrupted=\(captureSession.isInterrupted))")
        compositor?.resumeRendering()
        if rebuildDeferred {
            rebuildDeferred = false
            scheduleCaptureSessionRebuild()
        } else if isCameraAvailable {
            compositor?.exitPlaceholderMode()
        }
    }

    @objc private func handleDidBecomeActive() {
        guard !isInBackground, isCameraAvailable else { return }
        compositor?.exitPlaceholderMode()
    }

    private func handleSessionInterrupted(_ note: Notification) {
        let reason = (note.userInfo?[AVCaptureSessionInterruptionReasonKey] as? Int)
            .flatMap(AVCaptureSession.InterruptionReason.init(rawValue:))
        NSLog("[mafbase_stream] capture session interrupted: \(reason.map { String(describing: $0) } ?? "unknown")")
        compositor?.enterPlaceholderMode()
    }

    private func handleSessionInterruptionEnded() {
        NSLog("[mafbase_stream] capture session interruption ended (background=\(isInBackground))")
        guard !isInBackground, isCameraAvailable else { return }
        compositor?.exitPlaceholderMode()
    }

    private func handleSessionRuntimeError(_ note: Notification) {
        let error = note.userInfo?[AVCaptureSessionErrorKey] as? NSError
        NSLog("[mafbase_stream] capture session runtime error: \(error.map { "\($0.domain) \($0.code) \($0.localizedDescription)" } ?? "unknown")")
        if error?.code == AVError.mediaServicesWereReset.rawValue {
            scheduleCaptureSessionRebuild()
            return
        }
        // Сессию после ошибки AVFoundation останавливает асинхронно — isRunning смотрим чуть позже.
        let session = captureSession
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self, session === self.captureSession, !session.isRunning else { return }
            self.scheduleCaptureSessionRebuild()
        }
    }

    private func handleAudioInterruption(_ note: Notification) {
        guard
            let info = note.userInfo,
            let typeRaw = info[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeRaw)
        else { return }
        switch type {
        case .began:
            var reason = "unknown"
            if #available(iOS 14.5, *),
               let reasonRaw = info[AVAudioSessionInterruptionReasonKey] as? UInt,
               let value = AVAudioSession.InterruptionReason(rawValue: reasonRaw) {
                reason = String(describing: value)
            }
            NSLog("[mafbase_stream] audio interruption began (reason=\(reason))")
        case .ended:
            let options = AVAudioSession.InterruptionOptions(
                rawValue: info[AVAudioSessionInterruptionOptionKey] as? UInt ?? 0
            )
            NSLog("[mafbase_stream] audio interruption ended (shouldResume=\(options.contains(.shouldResume)))")
            activateAudioSession()
        @unknown default:
            break
        }
    }

    private func handleMediaServicesReset() {
        NSLog("[mafbase_stream] media services were reset")
        activateAudioSession()
        scheduleCaptureSessionRebuild()
    }

    // MARK: - Capture session rebuild

    /// В фоне откладывается до `willEnterForeground`: камеру там всё равно не дадут.
    private func scheduleCaptureSessionRebuild() {
        guard !isReleased, rebuildTimer == nil, !rebuildInProgress else { return }
        compositor?.enterPlaceholderMode()
        if UIApplication.shared.applicationState == .background {
            rebuildDeferred = true
            NSLog("[mafbase_stream] capture session rebuild deferred until foreground")
            return
        }
        let delayMs = rebuildBackoff.nextDelayMs()
        NSLog("[mafbase_stream] capture session rebuild #\(rebuildBackoff.attempt) in \(delayMs)ms")
        rebuildTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(delayMs) / 1000, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.rebuildTimer = nil
            self.rebuildCaptureSession()
        }
    }

    /// Новая `AVCaptureSession` с теми же outputs, объективом и ориентацией; компоситор, энкодеры,
    /// рекордер и стрим-сессия живут дальше. Успех проверяется через 1 с после `startRunning`.
    private func rebuildCaptureSession() {
        guard !isReleased else { return }
        rebuildInProgress = true
        hasVideoInput = false
        let attempt = rebuildBackoff.attempt
        let oldSession = captureSession
        unregisterCaptureSessionObservers()
        captureSession = Self.makeCaptureSession()
        registerCaptureSessionObservers()
        activateAudioSession()

        sessionQueue.async { [weak self] in
            if oldSession.isRunning { oldSession.stopRunning() }
            // Output принадлежит одной сессии — без removeOutput новая его не примет.
            oldSession.beginConfiguration()
            oldSession.inputs.forEach { oldSession.removeInput($0) }
            oldSession.outputs.forEach { oldSession.removeOutput($0) }
            oldSession.commitConfiguration()
            self?.videoDeviceInput = nil
        }
        configureSession(isRebuild: true)

        let session = captureSession
        sessionQueue.async { [weak self] in
            session.startRunning()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.verifyRebuiltSession(session, attempt: attempt)
            }
        }
    }

    private func verifyRebuiltSession(_ session: AVCaptureSession, attempt: Int) {
        guard !isReleased, session === captureSession else { return }
        rebuildInProgress = false
        if session.isRunning, !session.isInterrupted, hasVideoInput {
            NSLog("[mafbase_stream] capture session rebuild #\(attempt) succeeded")
            rebuildBackoff.reset()
            if !isInBackground {
                compositor?.exitPlaceholderMode()
            }
        } else {
            NSLog("[mafbase_stream] capture session rebuild #\(attempt) failed (running=\(session.isRunning) interrupted=\(session.isInterrupted) video=\(hasVideoInput))")
            scheduleCaptureSessionRebuild()
        }
    }

    // MARK: - Thermal

    /// Уровень нагрева — худший из `ProcessInfo.thermalState` и `systemPressureState` камеры.
    private enum ThermalLevel: Int, Comparable {
        case nominal
        case serious
        case critical

        init(_ state: ProcessInfo.ThermalState) {
            switch state {
            case .serious: self = .serious
            case .critical: self = .critical
            default: self = .nominal
            }
        }

        init(_ level: AVCaptureDevice.SystemPressureState.Level) {
            switch level {
            case .serious: self = .serious
            case .critical, .shutdown: self = .critical
            default: self = .nominal
            }
        }

        static func < (lhs: ThermalLevel, rhs: ThermalLevel) -> Bool { lhs.rawValue < rhs.rawValue }

        /// Потолок частоты кадров камеры; `nil` — без ограничения.
        var maxFps: Int? {
            switch self {
            case .nominal: return nil
            case .serious: return 24
            case .critical: return 15
            }
        }

        var bitrateScale: Double { self == .nominal ? 1 : 0.5 }
    }

    /// KVO на `systemPressureState` активной камеры; при смене устройства — переподписка.
    private func observeSystemPressure(of device: AVCaptureDevice?) {
        pressureObservation?.invalidate()
        thermalDevice = device
        pressureObservation = device?.observe(\.systemPressureState, options: [.new]) { [weak self] _, _ in
            DispatchQueue.main.async { self?.updateThermalLevel() }
        }
        if device != nil {
            updateThermalLevel()
        }
    }

    private func updateThermalLevel() {
        guard !isReleased else { return }
        var level = ThermalLevel(ProcessInfo.processInfo.thermalState)
        if let device = thermalDevice {
            level = max(level, ThermalLevel(device.systemPressureState.level))
        }
        guard level != thermalLevel else { return }
        let previous = thermalLevel
        thermalLevel = level
        NSLog("[mafbase_stream] thermal level \(previous) -> \(level)")

        let maxFps = level.maxFps
        sessionQueue.async { [weak self] in
            guard let self = self, let device = self.videoDeviceInput?.device else { return }
            self.applyFrameRateLimit(maxFps, to: device)
        }
        streaming.session?.setBitrateScale(level.bitrateScale)

        if level == .nominal {
            delegate?.onMessage(text: "Нагрев в норме, качество восстановлено", long: false)
        } else if previous == .nominal {
            let now = Date()
            if lastThermalMessageAt.map({ now.timeIntervalSince($0) >= 60 }) ?? true {
                lastThermalMessageAt = now
                delegate?.onMessage(text: "Устройство перегревается: качество стрима снижено", long: true)
            }
        }
    }
}

// MARK: - Sample buffer delegates

extension StreamPipeline: AVCaptureVideoDataOutputSampleBufferDelegate,
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
            guard silenceGenerator.noteRealSample(sampleBuffer) else { return }
            dispatchAudioSample(sampleBuffer)
        }
    }

    /// Аудио идёт мимо compositor'а — напрямую в writer'ы; сюда же (на audioDataQueue)
    /// приходит тишина генератора.
    private func dispatchAudioSample(_ sampleBuffer: CMSampleBuffer) {
        if isRecording, let recorder = mp4Recorder {
            recorder.appendAudio(sampleBuffer: sampleBuffer)
        }
        if streaming.isStreaming, let session = streaming.session {
            session.appendAudioSample(sampleBuffer)
        }
    }
}
