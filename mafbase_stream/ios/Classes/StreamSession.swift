import AVFoundation
import CoreMedia
import CoreVideo
import Foundation

/// Оркестратор RTMP-стрима для iOS.
///
/// Жизненный цикл (зеркальный Android-варианту в `StreamSession.kt`):
///  1. `start()` — поднимает [H264Encoder] и [MafbaseStreamCoreBridge].
///     [AacEncoder] поднимается лениво при первом аудио-сэмпле — точный source ASBD
///     известен только из CMSampleBuffer микрофона.
///  2. `appendProcessedVideo(...)` принимает уже скомпонованный (через Compositor)
///     CVPixelBuffer от хост-контроллера. Compositor живёт у `StreamViewController`
///     и параллельно фанаутит кадр в preview (AVSampleBufferDisplayLayer) и в
///     Mp4Recorder. `appendAudioSample(_:)` принимает CMSampleBuffer от микрофона.
///  3. Когда оба формата готовы (avcC из VT + ASC из AAC) — открываем RTMP-сессию
///     через C-API ядра и переходим в стриминг.
///  4. Каждый encoded sample → `ms_session_push_video` / `ms_session_push_audio`.
///  5. `stop()` — дренирует энкодеры, закрывает bridge.
///
/// AV-sync: используем общий `referencePtsUs` — абсолютный PTS первого пакета
/// любой дорожки, дошедшего до push'а. Все последующие нормализуются от этого нуля.
/// Это исключает 100–300 мс desync между видео и аудио, который возникает, если
/// каждая дорожка стартует со своего нуля.
final class StreamSession {

    struct Config {
        let rtmpUrl: String
        let width: Int
        let height: Int
        let fps: Int
        let videoBitrate: Int
        let audioSampleRate: Int
        let audioChannels: Int
        let audioBitrate: Int

        init(
            rtmpUrl: String,
            width: Int,
            height: Int,
            fps: Int = 30,
            videoBitrate: Int = 4_000_000,
            audioSampleRate: Int = 44_100,
            audioChannels: Int = 1,
            audioBitrate: Int = 128_000
        ) {
            self.rtmpUrl = rtmpUrl
            self.width = width
            self.height = height
            self.fps = fps
            self.videoBitrate = videoBitrate
            self.audioSampleRate = audioSampleRate
            self.audioChannels = audioChannels
            self.audioBitrate = audioBitrate
        }
    }

    enum SessionError: Error {
        case alreadyStarted
        case h264Prepare(Error)
        case bridgeInit
        case bridgeStart(MafbaseStreamCoreResult)
    }

    var onStarted: (() -> Void)?
    var onStopped: (() -> Void)?
    var onError: ((Error) -> Void)?

    private let config: Config
    private let lock = NSLock()

    private let videoEncoder: H264Encoder
    private let audioEncoder = AacEncoder()
    private var audioPrepared = false
    private var audioPrepareFailed = false
    private var started = false

    private var bridge: MafbaseStreamCoreBridge?

    private var videoExtradata: Data?
    private var audioExtradata: Data?
    private var rtmpStarted = false
    private var stopped = false

    private var referencePtsUs: Int64 = -1
    private var videoFrameCounter: Int64 = 0
    private var audioFrameCounter: Int64 = 0

    init(config: Config) {
        self.config = config
        self.videoEncoder = H264Encoder(
            bitRate: config.videoBitrate,
            frameRate: config.fps
        )
    }

    // MARK: - Lifecycle

    func start() throws {
        lock.lock()
        defer { lock.unlock() }
        if started { throw SessionError.alreadyStarted }
        started = true

        videoEncoder.onFormat = { [weak self] format in
            self?.handleVideoFormat(format)
        }
        videoEncoder.onSample = { [weak self] sb in
            self?.handleEncodedVideoSample(sb)
        }
        videoEncoder.onError = { [weak self] error in
            self?.handleError(error)
        }
        do {
            try videoEncoder.prepare(width: Int32(config.width), height: Int32(config.height))
        } catch {
            started = false
            throw SessionError.h264Prepare(error)
        }

        audioEncoder.onFormat = { [weak self] format in
            self?.handleAudioFormat(format)
        }
        audioEncoder.onSample = { [weak self] sb in
            self?.handleEncodedAudioSample(sb)
        }
        audioEncoder.onError = { [weak self] error in
            self?.handleError(error)
        }

        guard let newBridge = MafbaseStreamCoreBridge() else {
            videoEncoder.finish()
            started = false
            throw SessionError.bridgeInit
        }
        bridge = newBridge
    }

    func stop() {
        lock.lock()
        if stopped {
            lock.unlock()
            return
        }
        stopped = true
        let wasStarted = rtmpStarted
        rtmpStarted = false
        let bridgeRef = bridge
        bridge = nil
        lock.unlock()

        videoEncoder.finish()
        audioEncoder.finish()
        bridgeRef?.stop()

        videoExtradata = nil
        audioExtradata = nil
        referencePtsUs = -1
        videoFrameCounter = 0
        audioFrameCounter = 0

        if wasStarted { onStopped?() }
    }

    // MARK: - Frame ingest

    /// Принимает уже обработанный через Compositor (с overlay) pixel buffer.
    /// Compositor живёт в `StreamViewController` и фанаутит этот же кадр
    /// одновременно в preview и Mp4Recorder.
    func appendProcessedVideo(pixelBuffer: CVPixelBuffer, pts: CMTime) {
        guard !stopped else { return }
        videoEncoder.encode(pixelBuffer: pixelBuffer, pts: pts)
    }

    func appendAudioSample(_ sampleBuffer: CMSampleBuffer) {
        guard !stopped else { return }
        if !audioPrepared && !audioPrepareFailed {
            if let format = CMSampleBufferGetFormatDescription(sampleBuffer) {
                do {
                    try audioEncoder.prepare(sourceFormat: format)
                    audioPrepared = true
                } catch {
                    audioPrepareFailed = true
                    NSLog("[mafbase_stream] AacEncoder prepare failed: \(error). Streaming video only.")
                    lock.lock()
                    maybeStartRtmpLocked()
                    lock.unlock()
                    return
                }
            } else {
                return
            }
        }
        if audioPrepared {
            audioEncoder.encode(sampleBuffer: sampleBuffer)
        }
    }

    // MARK: - Encoder callbacks

    private func handleVideoFormat(_ format: CMFormatDescription) {
        lock.lock()
        defer { lock.unlock() }
        if videoExtradata == nil {
            videoExtradata = StreamSession.extractH264Annexb(from: format)
            maybeStartRtmpLocked()
        }
    }

    private func handleAudioFormat(_ format: CMFormatDescription) {
        lock.lock()
        defer { lock.unlock() }
        if audioExtradata == nil {
            audioExtradata = StreamSession.extractAacAsc(from: format)
            maybeStartRtmpLocked()
        }
    }

    private func handleEncodedVideoSample(_ sampleBuffer: CMSampleBuffer) {
        lock.lock()
        defer { lock.unlock() }
        guard rtmpStarted, let bridge = bridge else { return }
        let absoluteUs = StreamSession.ptsMicroseconds(of: sampleBuffer)
        guard absoluteUs >= 0 else { return }
        if referencePtsUs < 0 { referencePtsUs = absoluteUs }
        let pts = absoluteUs - referencePtsUs
        if pts < 0 { return }

        guard let payload = StreamSession.extractData(from: sampleBuffer) else { return }
        let isKey = StreamSession.isKeyframe(sampleBuffer)
        let result = bridge.pushVideo(payload, ptsUs: pts, isKeyframe: isKey)
        if result != .ok {
            NSLog("[mafbase_stream] pushVideo failed: \(MafbaseStreamCoreBridge.resultName(result))")
        }
        videoFrameCounter += 1
        if videoFrameCounter % 60 == 0 {
            NSLog("[mafbase_stream] v#\(videoFrameCounter) pts=\(pts)us key=\(isKey)")
        }
    }

    private func handleEncodedAudioSample(_ sampleBuffer: CMSampleBuffer) {
        lock.lock()
        defer { lock.unlock() }
        guard rtmpStarted, let bridge = bridge else { return }
        let absoluteUs = StreamSession.ptsMicroseconds(of: sampleBuffer)
        guard absoluteUs >= 0 else { return }
        if referencePtsUs < 0 { referencePtsUs = absoluteUs }
        let pts = absoluteUs - referencePtsUs
        if pts < 0 { return }

        guard let payload = StreamSession.extractData(from: sampleBuffer) else { return }
        let result = bridge.pushAudio(payload, ptsUs: pts)
        if result != .ok {
            NSLog("[mafbase_stream] pushAudio failed: \(MafbaseStreamCoreBridge.resultName(result))")
        }
        audioFrameCounter += 1
        if audioFrameCounter % 50 == 0 {
            NSLog("[mafbase_stream] a#\(audioFrameCounter) pts=\(pts)us")
        }
    }

    private func handleError(_ error: Error) {
        NSLog("[mafbase_stream] StreamSession error: \(error)")
        onError?(error)
    }

    // MARK: - RTMP start

    /// Должен вызываться под `lock`.
    private func maybeStartRtmpLocked() {
        if rtmpStarted { return }
        guard let bridge = bridge else { return }
        if videoExtradata == nil { return }
        let needAudio = !audioPrepareFailed
        if needAudio && audioExtradata == nil { return }

        let result = bridge.start(
            withRtmpURL: config.rtmpUrl,
            width: Int32(config.width),
            height: Int32(config.height),
            fps: Int32(config.fps),
            videoBitrate: Int32(config.videoBitrate),
            audioSampleRate: Int32(config.audioSampleRate),
            audioChannels: Int32(config.audioChannels),
            audioBitrate: Int32(config.audioBitrate),
            videoExtradata: videoExtradata,
            audioExtradata: audioExtradata
        )
        if result == .ok {
            rtmpStarted = true
            onStarted?()
        } else {
            let name = MafbaseStreamCoreBridge.resultName(result)
            NSLog("[mafbase_stream] RTMP start failed: \(name)")
            onError?(SessionError.bridgeStart(result))
        }
    }

    // MARK: - Helpers (parsing)

    /// Склеивает SPS+PPS из `CMVideoFormatDescription` в Annex-B (00 00 00 01 + NAL).
    /// `RtmpPublisher` (см. native/) сам распознаёт Annex-B и формирует AVCC для FLV.
    private static func extractH264Annexb(from format: CMFormatDescription) -> Data? {
        var paramSetCount = 0
        var nalUnitHeaderLength: Int32 = 0
        let countStatus = CMVideoFormatDescriptionGetH264ParameterSetAtIndex(
            format,
            parameterSetIndex: 0,
            parameterSetPointerOut: nil,
            parameterSetSizeOut: nil,
            parameterSetCountOut: &paramSetCount,
            nalUnitHeaderLengthOut: &nalUnitHeaderLength
        )
        guard countStatus == noErr, paramSetCount >= 1 else { return nil }

        var data = Data()
        let startCode: [UInt8] = [0x00, 0x00, 0x00, 0x01]
        for i in 0..<paramSetCount {
            var psPtr: UnsafePointer<UInt8>?
            var psSize: Int = 0
            let st = CMVideoFormatDescriptionGetH264ParameterSetAtIndex(
                format,
                parameterSetIndex: i,
                parameterSetPointerOut: &psPtr,
                parameterSetSizeOut: &psSize,
                parameterSetCountOut: nil,
                nalUnitHeaderLengthOut: nil
            )
            guard st == noErr, let p = psPtr, psSize > 0 else { return nil }
            data.append(contentsOf: startCode)
            data.append(p, count: psSize)
        }
        return data
    }

    /// Генерирует 2-байтовый AudioSpecificConfig для AAC LC из ASBD (object_type=2,
    /// sampling_frequency_index, channel_config). Не пытаемся парсить magic cookie
    /// (который содержит ESDS) — для FLV/RTMP достаточно minimal ASC.
    private static func extractAacAsc(from format: CMFormatDescription) -> Data? {
        guard let asbdPtr = CMAudioFormatDescriptionGetStreamBasicDescription(format) else {
            return nil
        }
        let asbd = asbdPtr.pointee
        let sampleRateIdx = aacSamplingFrequencyIndex(for: asbd.mSampleRate)
        guard sampleRateIdx >= 0, asbd.mChannelsPerFrame > 0 else { return nil }
        let objectType: UInt16 = 2  // AAC LC
        let channels = UInt16(asbd.mChannelsPerFrame)
        let asc: UInt16 = (objectType << 11) | (UInt16(sampleRateIdx) << 7) | (channels << 3)
        return Data([UInt8((asc >> 8) & 0xFF), UInt8(asc & 0xFF)])
    }

    private static func aacSamplingFrequencyIndex(for sampleRate: Float64) -> Int {
        switch Int(sampleRate.rounded()) {
        case 96000: return 0
        case 88200: return 1
        case 64000: return 2
        case 48000: return 3
        case 44100: return 4
        case 32000: return 5
        case 24000: return 6
        case 22050: return 7
        case 16000: return 8
        case 12000: return 9
        case 11025: return 10
        case 8000: return 11
        case 7350: return 12
        default: return -1
        }
    }

    private static func extractData(from sampleBuffer: CMSampleBuffer) -> Data? {
        guard let block = CMSampleBufferGetDataBuffer(sampleBuffer) else { return nil }
        var totalLength: Int = 0
        var dataPointer: UnsafeMutablePointer<Int8>?
        let st = CMBlockBufferGetDataPointer(
            block,
            atOffset: 0,
            lengthAtOffsetOut: nil,
            totalLengthOut: &totalLength,
            dataPointerOut: &dataPointer
        )
        guard st == kCMBlockBufferNoErr, let p = dataPointer, totalLength > 0 else { return nil }
        return Data(bytes: p, count: totalLength)
    }

    private static func ptsMicroseconds(of sampleBuffer: CMSampleBuffer) -> Int64 {
        let pts = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
        if !pts.isValid { return -1 }
        let micro = CMTimeConvertScale(pts, timescale: 1_000_000, method: .default)
        return micro.value
    }

    private static func isKeyframe(_ sampleBuffer: CMSampleBuffer) -> Bool {
        guard
            let attachments = CMSampleBufferGetSampleAttachmentsArray(sampleBuffer, createIfNecessary: false)
                as? [[CFString: Any]],
            let first = attachments.first
        else {
            return true
        }
        if let notSync = first[kCMSampleAttachmentKey_NotSync] as? Bool {
            return !notSync
        }
        return true
    }
}
