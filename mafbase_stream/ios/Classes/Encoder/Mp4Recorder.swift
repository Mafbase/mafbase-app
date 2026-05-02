import AVFoundation
import CoreMedia
import Foundation

/// Оркестратор аппаратного энкодинга и записи MP4 на iOS.
///
/// Архитектура (зеркальна Android `Mp4Recorder`):
///  1. `start(width:height:)` создаёт `AVAssetWriter` и оба энкодера.
///     `H264Encoder` готовится сразу с заданными размерами; `AacEncoder` —
///     лениво, при первом аудиосэмпле, потому что точный source ASBD выясняется
///     только из `CMSampleBuffer` микрофона.
///  2. Пока энкодеры не выдали `CMFormatDescription`, входящие camera/mic
///     sample buffers просто кодируются. Как только оба формата готовы — создаём
///     `AVAssetWriterInput`'ы (passthrough, `outputSettings = nil`) и стартуем
///     `AVAssetWriter`.
///  3. PTS первого закодированного сэмпла берём за `t0`, нормализуем все
///     последующие PTS к нему и пишем `startSession(atSourceTime: .zero)`.
///  4. `stop(completion:)` дренирует энкодеры (`finish`), маркирует входы
///     `markAsFinished` и закрывает writer асинхронно.
///
/// Если микрофон недоступен (`AacEncoder.prepare` упал) — пишем только видео.
final class Mp4Recorder {

    enum RecorderError: Error {
        case writerCreate(Error)
        case writerStart
        case writerFinalize(Error)
    }

    // MARK: - Конфигурация

    private let outputDirectory: URL
    private let lock = NSLock()

    // MARK: - Энкодеры

    private let videoEncoder = H264Encoder()
    private let audioEncoder = AacEncoder()
    private var audioPrepared = false
    private var audioPrepareFailed = false

    // MARK: - AVAssetWriter

    private(set) var outputURL: URL?
    private var writer: AVAssetWriter?
    private var videoInput: AVAssetWriterInput?
    private var audioInput: AVAssetWriterInput?
    private var writerStarted = false

    // MARK: - PTS-нормализация

    /// PTS первого закодированного сэмпла любой дорожки. От него отсчитываем все остальные.
    private var startPts: CMTime = .invalid

    // MARK: - Состояние

    private var isStopped = false

    // MARK: - Инициализация

    init() {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            ?? URL(fileURLWithPath: NSTemporaryDirectory())
        outputDirectory = dir
    }

    // MARK: - Public API

    func start(width: Int32, height: Int32) throws -> URL {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let filename = "mafbase_stream_\(formatter.string(from: Date())).mp4"
        let url = outputDirectory.appendingPathComponent(filename)
        try? FileManager.default.removeItem(at: url)

        let writer: AVAssetWriter
        do {
            writer = try AVAssetWriter(url: url, fileType: .mp4)
        } catch {
            throw RecorderError.writerCreate(error)
        }
        writer.shouldOptimizeForNetworkUse = true
        self.writer = writer
        outputURL = url

        // Видео-энкодер: callbacks → AssetWriter input
        videoEncoder.onFormat = { [weak self] format in
            self?.handleVideoFormat(format)
        }
        videoEncoder.onSample = { [weak self] sampleBuffer in
            self?.handleEncodedVideoSample(sampleBuffer)
        }
        videoEncoder.onError = { error in
            NSLog("[mafbase_stream] H264Encoder error: \(error)")
        }

        audioEncoder.onFormat = { [weak self] format in
            self?.handleAudioFormat(format)
        }
        audioEncoder.onSample = { [weak self] sampleBuffer in
            self?.handleEncodedAudioSample(sampleBuffer)
        }
        audioEncoder.onError = { error in
            NSLog("[mafbase_stream] AacEncoder error: \(error)")
        }

        try videoEncoder.prepare(width: width, height: height)
        return url
    }

    /// Кодирует уже обработанный (через Compositor) pixel buffer и кладёт в writer.
    /// Вызывается из колбэка Compositor'а, который живёт в `StreamViewController` —
    /// тот же кадр одновременно уходит на preview, в Mp4Recorder и в StreamSession.
    func appendVideo(pixelBuffer: CVPixelBuffer, pts: CMTime) {
        guard !isStopped else { return }
        videoEncoder.encode(pixelBuffer: pixelBuffer, pts: pts)
    }

    /// Кладём в очередь аудио-фрейм от `AVCaptureAudioDataOutput`.
    func appendAudio(sampleBuffer: CMSampleBuffer) {
        guard !isStopped else { return }
        if !audioPrepared && !audioPrepareFailed {
            if let format = CMSampleBufferGetFormatDescription(sampleBuffer) {
                do {
                    try audioEncoder.prepare(sourceFormat: format)
                    audioPrepared = true
                } catch {
                    audioPrepareFailed = true
                    NSLog("[mafbase_stream] AacEncoder prepare failed: \(error). Recording video only.")
                    // Если writer уже стартовал без аудио — закрываем audio input,
                    // чтобы muxer не ждал аудио-дорожку.
                    finalizeAudioTrackIfNeeded()
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

    func stop(completion: @escaping (URL?, Error?) -> Void) {
        lock.lock()
        if isStopped {
            lock.unlock()
            completion(outputURL, nil)
            return
        }
        isStopped = true
        lock.unlock()

        // Дренируем закодированные кадры синхронно — после этого callbacks гарантированно завершатся.
        videoEncoder.finish()
        audioEncoder.finish()

        guard let writer = writer else {
            completion(outputURL, nil)
            return
        }

        if !writerStarted {
            // Ничего не успели записать — просто отменяем writer.
            writer.cancelWriting()
            self.writer = nil
            completion(nil, nil)
            return
        }

        videoInput?.markAsFinished()
        audioInput?.markAsFinished()

        let url = outputURL
        writer.finishWriting { [weak self] in
            let error = writer.error
            self?.writer = nil
            self?.videoInput = nil
            self?.audioInput = nil
            DispatchQueue.main.async {
                completion(url, error)
            }
        }
    }

    // MARK: - Encoder callbacks

    private func handleVideoFormat(_ format: CMFormatDescription) {
        lock.lock()
        defer { lock.unlock() }
        guard let writer = writer, videoInput == nil else { return }
        let input = AVAssetWriterInput(mediaType: .video, outputSettings: nil, sourceFormatHint: format)
        input.expectsMediaDataInRealTime = true
        if writer.canAdd(input) {
            writer.add(input)
            videoInput = input
        } else {
            NSLog("[mafbase_stream] writer cannot add video input")
        }
        maybeStartWriter()
    }

    private func handleAudioFormat(_ format: CMFormatDescription) {
        lock.lock()
        defer { lock.unlock() }
        guard let writer = writer, audioInput == nil else { return }
        let input = AVAssetWriterInput(mediaType: .audio, outputSettings: nil, sourceFormatHint: format)
        input.expectsMediaDataInRealTime = true
        if writer.canAdd(input) {
            writer.add(input)
            audioInput = input
        } else {
            NSLog("[mafbase_stream] writer cannot add audio input")
        }
        maybeStartWriter()
    }

    private func handleEncodedVideoSample(_ sampleBuffer: CMSampleBuffer) {
        lock.lock()
        defer { lock.unlock() }
        guard writerStarted, let input = videoInput, input.isReadyForMoreMediaData else { return }
        appendNormalized(sampleBuffer: sampleBuffer, to: input)
    }

    private func handleEncodedAudioSample(_ sampleBuffer: CMSampleBuffer) {
        lock.lock()
        defer { lock.unlock() }
        guard writerStarted, let input = audioInput, input.isReadyForMoreMediaData else { return }
        appendNormalized(sampleBuffer: sampleBuffer, to: input)
    }

    // MARK: - Writer lifecycle

    /// Стартуем writer, как только готовы все ожидаемые дорожки.
    /// Видео — обязательно; аудио — если `audioPrepareFailed == false`.
    private func maybeStartWriter() {
        guard let writer = writer, !writerStarted else { return }
        let videoReady = videoInput != nil
        let audioReady = audioInput != nil || audioPrepareFailed
        guard videoReady && audioReady else { return }

        if writer.startWriting() {
            writerStarted = true
            // startSession будет вызван при первом нормализованном сэмпле (.zero).
        } else {
            NSLog("[mafbase_stream] writer.startWriting failed: \(String(describing: writer.error))")
        }
    }

    /// Если AAC prepare упал уже после старта прелоадного flow — закрываем audio input,
    /// чтобы writer не ждал аудио-данных.
    private func finalizeAudioTrackIfNeeded() {
        lock.lock()
        defer { lock.unlock() }
        if writerStarted, let input = audioInput {
            input.markAsFinished()
            audioInput = nil
        } else if !writerStarted {
            // Ещё не стартовали — теперь можем запускать без аудио.
            maybeStartWriter()
        }
    }

    private func appendNormalized(sampleBuffer: CMSampleBuffer, to input: AVAssetWriterInput) {
        guard let writer = writer else { return }
        let originalPts = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
        if !originalPts.isValid { return }

        if !startPts.isValid {
            startPts = originalPts
            writer.startSession(atSourceTime: .zero)
        }

        let normalizedPts = CMTimeSubtract(originalPts, startPts)
        if normalizedPts < .zero { return }

        let adjusted = retimedSampleBuffer(sampleBuffer, withPts: normalizedPts) ?? sampleBuffer
        if !input.append(adjusted) {
            NSLog("[mafbase_stream] writer append failed: \(String(describing: writer.error))")
        }
    }

    /// Пересобирает CMSampleBuffer с новым PTS (DTS — `.invalid`, длительность сохраняется).
    private func retimedSampleBuffer(_ source: CMSampleBuffer, withPts newPts: CMTime) -> CMSampleBuffer? {
        var count: CMItemCount = 0
        CMSampleBufferGetSampleTimingInfoArray(source, entryCount: 0, arrayToFill: nil, entriesNeededOut: &count)
        guard count > 0 else { return nil }

        var timings = [CMSampleTimingInfo](repeating: CMSampleTimingInfo(), count: Int(count))
        let status = CMSampleBufferGetSampleTimingInfoArray(
            source,
            entryCount: count,
            arrayToFill: &timings,
            entriesNeededOut: nil
        )
        guard status == noErr else { return nil }

        for i in 0..<timings.count {
            timings[i].presentationTimeStamp = newPts
            timings[i].decodeTimeStamp = .invalid
        }

        var newBuffer: CMSampleBuffer?
        let copyStatus = CMSampleBufferCreateCopyWithNewTiming(
            allocator: kCFAllocatorDefault,
            sampleBuffer: source,
            sampleTimingEntryCount: count,
            sampleTimingArray: timings,
            sampleBufferOut: &newBuffer
        )
        return copyStatus == noErr ? newBuffer : nil
    }
}
