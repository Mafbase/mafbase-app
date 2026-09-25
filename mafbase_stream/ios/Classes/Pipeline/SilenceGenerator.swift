import AVFoundation
import CoreMedia
import Foundation

/// Подменяет пропавший звук микрофона нулевым PCM, чтобы аудио-дорожки записи и стрима
/// не прерывались (звонок, Siri, фон без микрофона).
///
/// Формат — от последнего реального сэмпла. Пока пайплайн активен и реального звука нет
/// дольше `silenceThreshold`, таймер на собственной очереди раз в 100 мс отдаёт через
/// `onSample` чанки по 1024 кадра с PTS от `clock`, покрывая интервал от конца последнего
/// выданного чанка до «сейчас». Реальный сэмпл прекращает генерацию; сэмплы, попавшие внутрь
/// уже выданной тишины, `noteRealSample` просит отбросить — PTS остаются монотонными.
final class SilenceGenerator {

    private static let chunkFrames = 1024
    private static let tickInterval: DispatchTimeInterval = .milliseconds(100)
    private static let silenceThreshold = CMTime(value: 250, timescale: 1000)
    /// Дольше этого тишиной не заполняем: стоял процесс, а не микрофон.
    private static let maxBackfill = CMTime(value: 5, timescale: 1)
    /// Реальный сэмпл настолько позади выданной тишины — это не стык, а другая шкала времени.
    private static let maxOverlap = CMTime(value: 1, timescale: 1)

    private struct PcmLayout {
        let timescale: CMTimeScale
        let bytesPerChunk: Int
    }

    /// Вызывается на очереди генератора.
    var onSample: ((CMSampleBuffer) -> Void)?
    /// Генерация идёт только при активном пайплайне (запись или стрим).
    var isActive: (() -> Bool)?
    /// Часы, которыми штампуются реальные сэмплы, — в них же считаются «сейчас» и PTS тишины.
    var clock: () -> CMTime = { CMClockGetTime(CMClockGetHostTimeClock()) }

    private let queue = DispatchQueue(label: "com.example.mafbase_stream.silence")
    private var timer: DispatchSourceTimer?

    // Под `lock`: пишет очередь аудио-колбэков, читает таймер.
    private let lock = NSLock()
    private var formatDescription: CMFormatDescription?
    private var lastRealTime: CMTime = .invalid
    private var lastRealEndPts: CMTime = .invalid
    /// Конец последнего выданного чанка тишины; `.invalid`, когда реальный звук её уже миновал.
    private var silenceEndPts: CMTime = .invalid
    private var generating = false
    private var unsupportedFormatReported = false

    func start() {
        queue.async { [weak self] in
            guard let self = self, self.timer == nil else { return }
            let timer = DispatchSource.makeTimerSource(queue: self.queue)
            timer.schedule(deadline: .now() + Self.tickInterval, repeating: Self.tickInterval)
            timer.setEventHandler { [weak self] in self?.tick() }
            timer.resume()
            self.timer = timer
        }
    }

    func stop() {
        queue.sync {
            timer?.cancel()
            timer = nil
        }
        lock.lock()
        formatDescription = nil
        lastRealTime = .invalid
        lastRealEndPts = .invalid
        silenceEndPts = .invalid
        generating = false
        lock.unlock()
    }

    /// Регистрирует реальный сэмпл. `false` — сэмпл перекрывается с уже выданной тишиной,
    /// вызывающий обязан его отбросить.
    func noteRealSample(_ sampleBuffer: CMSampleBuffer) -> Bool {
        let pts = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
        let duration = CMSampleBufferGetDuration(sampleBuffer)
        lock.lock()
        defer { lock.unlock() }
        formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer)
        lastRealTime = clock()
        if generating {
            generating = false
            NSLog("[mafbase_stream] silence generator: real audio resumed")
        }
        if silenceEndPts.isValid, pts.isValid, CMTimeCompare(pts, silenceEndPts) < 0 {
            if CMTimeCompare(CMTimeSubtract(silenceEndPts, pts), Self.maxOverlap) < 0 {
                return false
            }
            NSLog("[mafbase_stream] silence generator: real audio PTS far behind generated silence, keeping it")
        }
        silenceEndPts = .invalid
        if pts.isValid, duration.isValid {
            lastRealEndPts = CMTimeAdd(pts, duration)
        }
        return true
    }

    private func tick() {
        guard isActive?() == true else { return }
        let now = clock()
        var chunks: [CMSampleBuffer] = []

        lock.lock()
        if let format = formatDescription, lastRealTime.isValid,
           CMTimeCompare(CMTimeSubtract(now, lastRealTime), Self.silenceThreshold) > 0 {
            if let layout = Self.pcmLayout(of: format) {
                chunks = generateLocked(until: now, format: format, layout: layout)
            } else if !unsupportedFormatReported {
                unsupportedFormatReported = true
                NSLog("[mafbase_stream] silence generator: unsupported PCM layout, silence disabled")
            }
        }
        lock.unlock()

        chunks.forEach { onSample?($0) }
    }

    private func generateLocked(until now: CMTime, format: CMFormatDescription, layout: PcmLayout) -> [CMSampleBuffer] {
        let chunkDuration = CMTime(value: Int64(Self.chunkFrames), timescale: layout.timescale)
        if !generating {
            generating = true
            var start = CMTimeSubtract(now, Self.silenceThreshold)
            for lowerBound in [lastRealEndPts, silenceEndPts]
            where lowerBound.isValid && CMTimeCompare(lowerBound, start) > 0 {
                start = lowerBound
            }
            silenceEndPts = CMTimeConvertScale(start, timescale: layout.timescale, method: .default)
            let gapMs = Int(CMTimeGetSeconds(CMTimeSubtract(now, lastRealTime)) * 1000)
            NSLog("[mafbase_stream] silence generator: started, no real audio for \(gapMs)ms")
        } else if CMTimeCompare(CMTimeSubtract(now, silenceEndPts), Self.maxBackfill) > 0 {
            NSLog("[mafbase_stream] silence generator: gap over \(CMTimeGetSeconds(Self.maxBackfill))s, resyncing to now")
            silenceEndPts = CMTimeConvertScale(
                CMTimeSubtract(now, Self.silenceThreshold),
                timescale: layout.timescale,
                method: .default
            )
        }

        var chunks: [CMSampleBuffer] = []
        while CMTimeCompare(CMTimeAdd(silenceEndPts, chunkDuration), now) <= 0 {
            if let chunk = Self.makeChunk(pts: silenceEndPts, format: format, bytes: layout.bytesPerChunk) {
                chunks.append(chunk)
            }
            silenceEndPts = CMTimeAdd(silenceEndPts, chunkDuration)
        }
        return chunks
    }

    /// Interleaved PCM или non-interleaved mono — один буфер данных на чанк.
    private static func pcmLayout(of format: CMFormatDescription) -> PcmLayout? {
        guard let asbd = CMAudioFormatDescriptionGetStreamBasicDescription(format)?.pointee,
              asbd.mFormatID == kAudioFormatLinearPCM,
              asbd.mSampleRate > 0,
              asbd.mBytesPerFrame > 0
        else { return nil }
        let nonInterleaved = (asbd.mFormatFlags & kAudioFormatFlagIsNonInterleaved) != 0
        if nonInterleaved && asbd.mChannelsPerFrame != 1 { return nil }
        return PcmLayout(
            timescale: CMTimeScale(asbd.mSampleRate),
            bytesPerChunk: Int(asbd.mBytesPerFrame) * chunkFrames
        )
    }

    private static func makeChunk(pts: CMTime, format: CMFormatDescription, bytes: Int) -> CMSampleBuffer? {
        guard let memory = calloc(bytes, 1) else { return nil }
        var blockBuffer: CMBlockBuffer?
        let blockStatus = CMBlockBufferCreateWithMemoryBlock(
            allocator: kCFAllocatorDefault,
            memoryBlock: memory,
            blockLength: bytes,
            blockAllocator: kCFAllocatorMalloc,
            customBlockSource: nil,
            offsetToData: 0,
            dataLength: bytes,
            flags: 0,
            blockBufferOut: &blockBuffer
        )
        guard blockStatus == kCMBlockBufferNoErr, let block = blockBuffer else {
            free(memory)
            return nil
        }
        var sampleBuffer: CMSampleBuffer?
        let status = CMAudioSampleBufferCreateReadyWithPacketDescriptions(
            allocator: kCFAllocatorDefault,
            dataBuffer: block,
            formatDescription: format,
            sampleCount: chunkFrames,
            presentationTimeStamp: pts,
            packetDescriptions: nil,
            sampleBufferOut: &sampleBuffer
        )
        return status == noErr ? sampleBuffer : nil
    }
}
