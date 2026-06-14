import AVFoundation
import CoreMedia
import Foundation
import VideoToolbox

/// Аппаратный H.264-энкодер на базе VideoToolbox `VTCompressionSession`.
///
/// Принимает `CVPixelBuffer` (от `AVCaptureVideoDataOutput`) и выдаёт готовые
/// `CMSampleBuffer` с H.264 NAL в AVCC-формате (length-prefixed). Format
/// description, выдаваемый при первом ключевом кадре, содержит готовый
/// `avcC`-extradata — его можно сразу отдать в `AVAssetWriterInput` через
/// `sourceFormatHint`.
///
/// Жизненный цикл:
///  1. `prepare(width:height:)` — создаёт сессию, выставляет битрейт и keyframe-interval.
///  2. `encode(pixelBuffer:pts:duration:)` — вызывается из delegate-потока camera.
///  3. `finish()` — дренирует оставшиеся кадры и инвалидирует сессию.
final class H264Encoder {

    enum EncoderError: Error {
        case sessionCreate(OSStatus)
        case propertyConfigure(OSStatus)
    }

    /// Битрейт `kVTCompressionPropertyKey_AverageBitRate`. По умолчанию 4 Мбит/с —
    /// разумный компромисс для 720p30 на iPhone.
    private let bitRate: Int

    /// Целевой FPS. От него считается `MaxKeyFrameInterval` = `frameRate * keyFrameIntervalSec`.
    private let frameRate: Int

    /// Интервал между keyframe в секундах.
    private let keyFrameIntervalSec: Int

    private var session: VTCompressionSession?

    /// Счётчик закодированных кадров — нужен для принудительных IDR. Без этого
    /// VT в RealTime/AllowFrameReordering=false режиме может игнорировать
    /// MaxKeyFrameInterval и выдавать ровно один keyframe на старте — HLS-
    /// сегментер при таком потоке не может резать на границы IDR, плеер
    /// фризит при смене сегмента.
    private var encodedFrameCount: Int = 0

    /// `CMVideoFormatDescription` с заполненным `avcC`-extradata. Прокидывается в
    /// AssetWriter через `sourceFormatHint` ровно один раз.
    private(set) var formatDescription: CMFormatDescription?

    var onFormat: ((CMFormatDescription) -> Void)?
    var onSample: ((CMSampleBuffer) -> Void)?
    var onError: ((Error) -> Void)?

    init(bitRate: Int = 4_000_000, frameRate: Int = 30, keyFrameIntervalSec: Int = 2) {
        self.bitRate = bitRate
        self.frameRate = frameRate
        self.keyFrameIntervalSec = keyFrameIntervalSec
    }

    func prepare(width: Int32, height: Int32) throws {
        encodedFrameCount = 0
        var newSession: VTCompressionSession?
        let opaque = Unmanaged.passUnretained(self).toOpaque()
        let createStatus = VTCompressionSessionCreate(
            allocator: kCFAllocatorDefault,
            width: width,
            height: height,
            codecType: kCMVideoCodecType_H264,
            encoderSpecification: nil,
            imageBufferAttributes: nil,
            compressedDataAllocator: nil,
            outputCallback: h264EncoderOutputCallback,
            refcon: opaque,
            compressionSessionOut: &newSession
        )
        guard createStatus == noErr, let session = newSession else {
            throw EncoderError.sessionCreate(createStatus)
        }

        // Реал-тайм режим — низкая задержка, без B-кадров.
        VTSessionSetProperty(session, key: kVTCompressionPropertyKey_RealTime, value: kCFBooleanTrue)
        VTSessionSetProperty(
            session,
            key: kVTCompressionPropertyKey_ProfileLevel,
            value: kVTProfileLevel_H264_High_AutoLevel
        )
        VTSessionSetProperty(
            session,
            key: kVTCompressionPropertyKey_AllowFrameReordering,
            value: kCFBooleanFalse
        )

        VTSessionSetProperty(
            session,
            key: kVTCompressionPropertyKey_AverageBitRate,
            value: NSNumber(value: bitRate)
        )
        // Жёсткий потолок данных — приближает AverageBitRate (по сути VBR-среднее)
        // к CBR. Без него VT трактует AverageBitRate как мягкое долгосрочное
        // среднее, сильно перестреливает на движении и слабо реагирует на
        // runtime-снижение битрейта — адаптивный битрейт почти не срезает поток.
        VTSessionSetProperty(
            session,
            key: kVTCompressionPropertyKey_DataRateLimits,
            value: Self.dataRateLimits(for: bitRate)
        )
        VTSessionSetProperty(
            session,
            key: kVTCompressionPropertyKey_ExpectedFrameRate,
            value: NSNumber(value: frameRate)
        )
        VTSessionSetProperty(
            session,
            key: kVTCompressionPropertyKey_MaxKeyFrameInterval,
            value: NSNumber(value: frameRate * keyFrameIntervalSec)
        )
        VTSessionSetProperty(
            session,
            key: kVTCompressionPropertyKey_MaxKeyFrameIntervalDuration,
            value: NSNumber(value: keyFrameIntervalSec)
        )

        VTCompressionSessionPrepareToEncodeFrames(session)
        self.session = session
    }

    func encode(pixelBuffer: CVPixelBuffer, pts: CMTime, duration: CMTime = .invalid) {
        guard let session = session else { return }
        var flagsOut: VTEncodeInfoFlags = []

        // Каждые keyFrameIntervalSec секунд (по счётчику кадров) форсируем IDR.
        // Первый кадр — всегда IDR.
        let interval = max(1, frameRate * keyFrameIntervalSec)
        let forceIDR = (encodedFrameCount % interval == 0)
        encodedFrameCount += 1

        var frameProperties: CFDictionary?
        if forceIDR {
            frameProperties = [
                kVTEncodeFrameOptionKey_ForceKeyFrame: kCFBooleanTrue as Any
            ] as CFDictionary
        }

        let status = VTCompressionSessionEncodeFrame(
            session,
            imageBuffer: pixelBuffer,
            presentationTimeStamp: pts,
            duration: duration,
            frameProperties: frameProperties,
            sourceFrameRefcon: nil,
            infoFlagsOut: &flagsOut
        )
        if status != noErr {
            onError?(EncoderError.propertyConfigure(status))
        }
    }

    /// Дренирует все буферизованные кадры (синхронно) и закрывает сессию.
    func finish() {
        guard let session = session else { return }
        VTCompressionSessionCompleteFrames(session, untilPresentationTimeStamp: .invalid)
        VTCompressionSessionInvalidate(session)
        self.session = nil
    }

    /// Сдвигает счётчик кадров так, чтобы следующий вызов `encode(...)` пометил
    /// кадр как `forceIDR`. Используется ядром после reconnect — без принудительного
    /// keyframe на новом соединении плеер не сможет начать декодинг.
    func forceKeyFrame() {
        encodedFrameCount = 0
    }

    /// Меняет целевой битрейт VTSession runtime'е. Принимает в bps.
    /// Обновляем и AverageBitRate, и DataRateLimits — иначе старый жёсткий
    /// потолок не даст реально снизить поток (или, при повышении, зажмёт его).
    func setBitrate(_ bitrateBps: Int) {
        guard let session = session, bitrateBps > 0 else { return }
        VTSessionSetProperty(
            session,
            key: kVTCompressionPropertyKey_AverageBitRate,
            value: NSNumber(value: bitrateBps)
        )
        VTSessionSetProperty(
            session,
            key: kVTCompressionPropertyKey_DataRateLimits,
            value: Self.dataRateLimits(for: bitrateBps)
        )
    }

    /// `DataRateLimits` = [байт, секунд]: не более ~1.2× целевого битрейта за 1с.
    /// Небольшой запас сверх цели оставляет место под всплески на движении,
    /// но не даёт VT уходить в многократный овершут.
    private static func dataRateLimits(for bitrateBps: Int) -> CFArray {
        let bytesPerSecond = Int(Double(bitrateBps) / 8.0 * 1.2)
        return [NSNumber(value: bytesPerSecond), NSNumber(value: 1.0)] as CFArray
    }

    fileprivate func handleEncoded(status: OSStatus, sampleBuffer: CMSampleBuffer?) {
        if status != noErr {
            onError?(EncoderError.propertyConfigure(status))
            return
        }
        guard let sampleBuffer = sampleBuffer, CMSampleBufferDataIsReady(sampleBuffer) else {
            return
        }
        if formatDescription == nil, let format = CMSampleBufferGetFormatDescription(sampleBuffer) {
            formatDescription = format
            onFormat?(format)
        }
        onSample?(sampleBuffer)
    }
}

private let h264EncoderOutputCallback: VTCompressionOutputCallback = { (
    outputCallbackRefCon, _, status, _, sampleBuffer
) -> Void in
    guard let refcon = outputCallbackRefCon else { return }
    let encoder = Unmanaged<H264Encoder>.fromOpaque(refcon).takeUnretainedValue()
    encoder.handleEncoded(status: status, sampleBuffer: sampleBuffer)
}
