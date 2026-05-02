// Obj-C обёртка над C-API ядра mafbase_stream (см. native/include/mafbase_stream/session.h).
// Открывается Swift-у через автогенерируемый module map (defines_module = YES в podspec).
//
// Все методы маппятся 1:1 на ms_session_*. Видео/аудио передаются как NSData —
// для одного access unit / AAC frame копирование пренебрежимо мало по сравнению с
// энкодингом, так что не пытаемся делать zero-copy.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MafbaseStreamCoreResult) {
    MafbaseStreamCoreResultOk = 0,
    MafbaseStreamCoreResultInvalidArg = -1,
    MafbaseStreamCoreResultInvalidState = -2,
    MafbaseStreamCoreResultIO = -3,
    MafbaseStreamCoreResultFFmpeg = -4,
    MafbaseStreamCoreResultNoMemory = -5,
    MafbaseStreamCoreResultTimeout = -6,
};

typedef NS_ENUM(NSInteger, MafbaseStreamCoreState) {
    MafbaseStreamCoreStateIdle = 0,
    MafbaseStreamCoreStateConnecting = 1,
    MafbaseStreamCoreStateStreaming = 2,
    MafbaseStreamCoreStateReconnecting = 3,
    MafbaseStreamCoreStateStopped = 4,
};

/// Тонкая Obj-C обёртка вокруг ms_session_*. Не thread-safe — вызывайте все
/// методы из одного потока (на iOS это обычно отдельный serial queue в Swift-
/// оркестраторе StreamSession).
///
/// Жизненный цикл: init → start(...) → pushVideo:/pushAudio: (много раз) → stop.
/// dealloc автоматически вызывает stop + ms_session_destroy.
@interface MafbaseStreamCoreBridge : NSObject

/// Создаёт bridge и `ms_session`. Возвращает nil, если ядро отказалось выделить
/// память под сессию (OOM) — на практике этого не бывает.
- (nullable instancetype)init NS_DESIGNATED_INITIALIZER;

/// Открывает RTMP-соединение и пишет header. Возвращает результат C-API.
///
/// videoExtradata: SPS/PPS — допустимы Annex-B (00 00 00 01) или AVCC. Если nil,
/// ядро попытается извлечь параметры из первых ключевых пакетов.
/// audioExtradata: AudioSpecificConfig для AAC LC, обычно 2 байта. Если nil,
/// ядро попытается извлечь его из первого AAC-пакета.
- (MafbaseStreamCoreResult)startWithRtmpURL:(NSString *)rtmpURL
                                      width:(int32_t)width
                                     height:(int32_t)height
                                        fps:(int32_t)fps
                               videoBitrate:(int32_t)videoBitrate
                            audioSampleRate:(int32_t)audioSampleRate
                              audioChannels:(int32_t)audioChannels
                               audioBitrate:(int32_t)audioBitrate
                             videoExtradata:(nullable NSData *)videoExtradata
                             audioExtradata:(nullable NSData *)audioExtradata;

/// Публикует один H.264 access unit. ptsUs — микросекунды от начала сессии,
/// должно быть монотонно возрастающим.
- (MafbaseStreamCoreResult)pushVideo:(NSData *)nalu
                               ptsUs:(int64_t)ptsUs
                          isKeyframe:(BOOL)isKeyframe;

/// Публикует один AAC-фрейм (raw, не ADTS — раз `audioExtradata` задан в start).
- (MafbaseStreamCoreResult)pushAudio:(NSData *)aacFrame ptsUs:(int64_t)ptsUs;

/// Закрывает RTMP-сессию. Идемпотентно.
- (MafbaseStreamCoreResult)stop;

/// Текущее состояние state-machine ядра.
- (MafbaseStreamCoreState)state;

/// Человекочитаемое имя для кода ошибки (для логов).
+ (NSString *)resultName:(MafbaseStreamCoreResult)code;

@end

NS_ASSUME_NONNULL_END
