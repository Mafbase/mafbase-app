import AudioToolbox
import AVFoundation
import CoreMedia
import Foundation

/// AAC LC энкодер на базе `AudioConverter` (AudioToolbox).
///
/// Принимает interleaved PCM int16 (как выдаёт `AVCaptureAudioDataOutput`) в виде
/// `CMSampleBuffer` и выдаёт фреймы AAC LC по 1024 семпла на фрейм. Готовый
/// `CMFormatDescription` содержит `magic cookie` (esds) — именно его передаём в
/// `AVAssetWriterInput.sourceFormatHint`, чтобы muxer правильно записал ESDS.
///
/// Поток данных:
///  - Входной PCM накапливается в `pcmBuffer`. Когда накопилось ≥1024 семпла —
///    выдаём один AAC frame через `AudioConverterFillComplexBuffer`.
///  - PTS считается от первого PCM-семпла в накопителе и сдвигается на
///    `1024/sampleRate` для каждого следующего фрейма (монотонная шкала).
///
/// Эта реализация переиспользуется в задаче 09 для отправки сырых AAC-фреймов
/// в RTMP — поэтому энкодер работает независимо от AVAssetWriter и выдаёт
/// готовые `CMSampleBuffer`, которые можно как append'ить в writer, так и
/// разбирать для FLV-muxer'а.
final class AacEncoder {

    enum EncoderError: Error {
        case unsupportedInputFormat
        case converterCreate(OSStatus)
        case converterConfigure(OSStatus)
        case fillComplex(OSStatus)
        case formatDescription(OSStatus)
    }

    /// AAC LC всегда кодирует ровно 1024 семпла на пакет.
    private let aacFrameSize: UInt32 = 1024

    /// Целевой битрейт. 64 kbps mono — минимальная разумная для голоса/стрима;
    /// для stereo обычно 128 kbps.
    private let targetBitRate: UInt32

    private var converter: AudioConverterRef?
    private var inputASBD = AudioStreamBasicDescription()
    private var outputASBD = AudioStreamBasicDescription()
    private(set) var formatDescription: CMFormatDescription?

    /// Накопленный PCM, ещё не отправленный в кодер.
    private var pcmBuffer = Data()

    /// PTS первого PCM-семпла в `pcmBuffer`. Сдвигается после каждого выданного AAC-фрейма.
    private var pcmBufferStartPts: CMTime = .invalid

    /// Указатель на текущий PCM-фрейм для AudioConverter input callback.
    /// Живёт ровно на время одного `AudioConverterFillComplexBuffer`.
    private var inputCallbackPointer: UnsafeMutableRawPointer?
    private var inputCallbackBytes: Int = 0
    private var inputCallbackConsumed: Bool = false

    var onFormat: ((CMFormatDescription) -> Void)?
    var onSample: ((CMSampleBuffer) -> Void)?
    var onError: ((Error) -> Void)?

    init(bitRate: UInt32 = 64_000) {
        targetBitRate = bitRate
    }

    func prepare(sourceFormat: CMFormatDescription) throws {
        guard let asbdPtr = CMAudioFormatDescriptionGetStreamBasicDescription(sourceFormat) else {
            throw EncoderError.unsupportedInputFormat
        }
        inputASBD = asbdPtr.pointee
        guard inputASBD.mFormatID == kAudioFormatLinearPCM else {
            throw EncoderError.unsupportedInputFormat
        }

        outputASBD = AudioStreamBasicDescription(
            mSampleRate: inputASBD.mSampleRate,
            mFormatID: kAudioFormatMPEG4AAC,
            mFormatFlags: UInt32(MPEG4ObjectID.AAC_LC.rawValue),
            mBytesPerPacket: 0,
            mFramesPerPacket: aacFrameSize,
            mBytesPerFrame: 0,
            mChannelsPerFrame: inputASBD.mChannelsPerFrame,
            mBitsPerChannel: 0,
            mReserved: 0
        )

        var newConverter: AudioConverterRef?
        let createStatus = AudioConverterNew(&inputASBD, &outputASBD, &newConverter)
        guard createStatus == noErr, let converter = newConverter else {
            throw EncoderError.converterCreate(createStatus)
        }
        self.converter = converter

        var bitRate: UInt32 = targetBitRate
        let bitRateStatus = AudioConverterSetProperty(
            converter,
            kAudioConverterEncodeBitRate,
            UInt32(MemoryLayout<UInt32>.size),
            &bitRate
        )
        if bitRateStatus != noErr {
            throw EncoderError.converterConfigure(bitRateStatus)
        }

        try buildFormatDescription(from: converter)
    }

    private func buildFormatDescription(from converter: AudioConverterRef) throws {
        // magic cookie (ESDS) — нужен для AVAssetWriter и для FLV/RTMP в задаче 09.
        var cookieSize: UInt32 = 0
        AudioConverterGetPropertyInfo(
            converter,
            kAudioConverterCompressionMagicCookie,
            &cookieSize,
            nil
        )

        var asbd = outputASBD
        var fmt: CMFormatDescription?

        if cookieSize > 0 {
            var cookie = Data(count: Int(cookieSize))
            let getStatus = cookie.withUnsafeMutableBytes { ptr -> OSStatus in
                guard let base = ptr.baseAddress else { return -1 }
                var size = cookieSize
                return AudioConverterGetProperty(
                    converter,
                    kAudioConverterCompressionMagicCookie,
                    &size,
                    base
                )
            }
            if getStatus != noErr {
                throw EncoderError.converterConfigure(getStatus)
            }
            let createStatus = cookie.withUnsafeBytes { (raw: UnsafeRawBufferPointer) -> OSStatus in
                CMAudioFormatDescriptionCreate(
                    allocator: kCFAllocatorDefault,
                    asbd: &asbd,
                    layoutSize: 0,
                    layout: nil,
                    magicCookieSize: cookie.count,
                    magicCookie: raw.baseAddress,
                    extensions: nil,
                    formatDescriptionOut: &fmt
                )
            }
            if createStatus != noErr {
                throw EncoderError.formatDescription(createStatus)
            }
        } else {
            let createStatus = CMAudioFormatDescriptionCreate(
                allocator: kCFAllocatorDefault,
                asbd: &asbd,
                layoutSize: 0,
                layout: nil,
                magicCookieSize: 0,
                magicCookie: nil,
                extensions: nil,
                formatDescriptionOut: &fmt
            )
            if createStatus != noErr {
                throw EncoderError.formatDescription(createStatus)
            }
        }

        if let fmt = fmt {
            formatDescription = fmt
            onFormat?(fmt)
        }
    }

    func encode(sampleBuffer: CMSampleBuffer) {
        guard converter != nil else { return }

        var blockBuffer: CMBlockBuffer?
        var audioBufferList = AudioBufferList()
        let status = CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(
            sampleBuffer,
            bufferListSizeNeededOut: nil,
            bufferListOut: &audioBufferList,
            bufferListSize: MemoryLayout<AudioBufferList>.size,
            blockBufferAllocator: nil,
            blockBufferMemoryAllocator: nil,
            flags: 0,
            blockBufferOut: &blockBuffer
        )
        guard status == noErr else {
            onError?(EncoderError.fillComplex(status))
            return
        }
        let buffer = audioBufferList.mBuffers
        guard let data = buffer.mData else { return }
        let length = Int(buffer.mDataByteSize)
        guard length > 0 else { return }

        if pcmBuffer.isEmpty {
            pcmBufferStartPts = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
        }
        pcmBuffer.append(Data(bytes: data, count: length))

        let bytesPerFrame = Int(inputASBD.mBytesPerFrame)
        guard bytesPerFrame > 0 else { return }
        let bytesPerAacFrame = Int(aacFrameSize) * bytesPerFrame

        while pcmBuffer.count >= bytesPerAacFrame {
            encodeOneFrame(bytesPerAacFrame: bytesPerAacFrame)
        }
    }

    private func encodeOneFrame(bytesPerAacFrame: Int) {
        guard let converter = converter, let formatDescription = formatDescription else { return }

        let frame = pcmBuffer.prefix(bytesPerAacFrame)
        pcmBuffer.removeFirst(bytesPerAacFrame)
        let framePts = pcmBufferStartPts
        let nextPts = CMTimeAdd(
            pcmBufferStartPts,
            CMTime(value: Int64(aacFrameSize), timescale: CMTimeScale(inputASBD.mSampleRate))
        )
        pcmBufferStartPts = nextPts

        // Промежуточный буфер живёт ровно на время вызова callback.
        let pcmCopy = UnsafeMutableRawPointer.allocate(byteCount: bytesPerAacFrame, alignment: 1)
        defer { pcmCopy.deallocate() }
        frame.withUnsafeBytes { src in
            if let base = src.baseAddress {
                pcmCopy.copyMemory(from: base, byteCount: bytesPerAacFrame)
            }
        }
        inputCallbackPointer = pcmCopy
        inputCallbackBytes = bytesPerAacFrame
        inputCallbackConsumed = false

        // Максимальный размер AAC-пакета пускай будет 4 КБ — для AAC LC mono достаточно с запасом.
        let maxOutputBytes = 4096
        let outputBytes = UnsafeMutableRawPointer.allocate(byteCount: maxOutputBytes, alignment: 1)
        defer { outputBytes.deallocate() }

        var outputBufferList = AudioBufferList(
            mNumberBuffers: 1,
            mBuffers: AudioBuffer(
                mNumberChannels: inputASBD.mChannelsPerFrame,
                mDataByteSize: UInt32(maxOutputBytes),
                mData: outputBytes
            )
        )
        var packetDescription = AudioStreamPacketDescription()
        var ioOutputDataPacketSize: UInt32 = 1

        let opaque = Unmanaged.passUnretained(self).toOpaque()
        let convertStatus = AudioConverterFillComplexBuffer(
            converter,
            aacEncoderInputCallback,
            opaque,
            &ioOutputDataPacketSize,
            &outputBufferList,
            &packetDescription
        )

        inputCallbackPointer = nil
        inputCallbackBytes = 0

        guard convertStatus == noErr || convertStatus == kAudioConverterErr_InvalidInputSize else {
            onError?(EncoderError.fillComplex(convertStatus))
            return
        }
        guard ioOutputDataPacketSize > 0 else { return }

        let aacSize = Int(outputBufferList.mBuffers.mDataByteSize)
        guard aacSize > 0 else { return }

        // CMBlockBuffer берёт владение памятью — kCFAllocatorMalloc освободит её при release.
        let aacBytes = UnsafeMutableRawPointer(malloc(aacSize))
        guard let aacBytes = aacBytes else { return }
        aacBytes.copyMemory(from: outputBytes, byteCount: aacSize)

        var blockBuffer: CMBlockBuffer?
        let blockStatus = CMBlockBufferCreateWithMemoryBlock(
            allocator: kCFAllocatorDefault,
            memoryBlock: aacBytes,
            blockLength: aacSize,
            blockAllocator: kCFAllocatorMalloc,
            customBlockSource: nil,
            offsetToData: 0,
            dataLength: aacSize,
            flags: 0,
            blockBufferOut: &blockBuffer
        )
        guard blockStatus == kCMBlockBufferNoErr, let blockBuffer = blockBuffer else {
            free(aacBytes)
            return
        }

        var sampleBuffer: CMSampleBuffer?
        var sampleSizeArray: [Int] = [aacSize]
        var timing = CMSampleTimingInfo(
            duration: CMTime(value: Int64(aacFrameSize), timescale: CMTimeScale(inputASBD.mSampleRate)),
            presentationTimeStamp: framePts,
            decodeTimeStamp: .invalid
        )
        let createStatus = CMSampleBufferCreate(
            allocator: kCFAllocatorDefault,
            dataBuffer: blockBuffer,
            dataReady: true,
            makeDataReadyCallback: nil,
            refcon: nil,
            formatDescription: formatDescription,
            sampleCount: 1,
            sampleTimingEntryCount: 1,
            sampleTimingArray: &timing,
            sampleSizeEntryCount: 1,
            sampleSizeArray: &sampleSizeArray,
            sampleBufferOut: &sampleBuffer
        )
        if createStatus == noErr, let sampleBuffer = sampleBuffer {
            onSample?(sampleBuffer)
        } else {
            onError?(EncoderError.formatDescription(createStatus))
        }
    }

    func finish() {
        if let converter = converter {
            AudioConverterDispose(converter)
            self.converter = nil
        }
        pcmBuffer.removeAll(keepingCapacity: false)
        pcmBufferStartPts = .invalid
    }

    fileprivate func provideInput(
        ioNumberDataPackets: UnsafeMutablePointer<UInt32>,
        ioData: UnsafeMutablePointer<AudioBufferList>
    ) -> OSStatus {
        if inputCallbackConsumed || inputCallbackPointer == nil {
            ioNumberDataPackets.pointee = 0
            return noErr
        }
        ioData.pointee.mNumberBuffers = 1
        ioData.pointee.mBuffers.mNumberChannels = inputASBD.mChannelsPerFrame
        ioData.pointee.mBuffers.mDataByteSize = UInt32(inputCallbackBytes)
        ioData.pointee.mBuffers.mData = inputCallbackPointer
        ioNumberDataPackets.pointee = aacFrameSize
        inputCallbackConsumed = true
        return noErr
    }
}

private let aacEncoderInputCallback: AudioConverterComplexInputDataProc = { (
    _, ioNumberDataPackets, ioData, _, inUserData
) -> OSStatus in
    guard let inUserData = inUserData else {
        ioNumberDataPackets.pointee = 0
        return -1
    }
    let encoder = Unmanaged<AacEncoder>.fromOpaque(inUserData).takeUnretainedValue()
    return encoder.provideInput(ioNumberDataPackets: ioNumberDataPackets, ioData: ioData)
}
