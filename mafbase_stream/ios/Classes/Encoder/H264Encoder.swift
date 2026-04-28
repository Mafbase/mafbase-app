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
