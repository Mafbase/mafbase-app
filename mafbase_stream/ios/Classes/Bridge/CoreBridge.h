// Obj-C обёртка над C-API ядра mafbase_stream (см. native/include/mafbase_stream/session.h).
// Открывается Swift-у через автогенерируемый module map (defines_module = YES в podspec).
//
// Все методы маппятся 1:1 на ms_session_*. Видео/аудио передаются как NSData —
// для одного access unit / AAC frame копирование пренебрежимо мало по сравнению с
// энкодингом, так что не пытаемся делать zero-copy.
//
// Колбеки от ядра (события, request keyframe, set bitrate) приходят из writer-thread
// и форвардятся через блоки в Swift. Swift сам диспатчит на свой serial queue
// перед обращением к VTSession / Combine subjects, если требуется.

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

typedef NS_ENUM(NSInteger, MafbaseStreamCoreEventType) {
    MafbaseStreamCoreEventTypeState = 0,
    MafbaseStreamCoreEventTypeQueueDepth = 1,
    MafbaseStreamCoreEventTypeBitrate = 2,
    MafbaseStreamCoreEventTypeReconnecting = 3,
    MafbaseStreamCoreEventTypeReconnected = 4,
    MafbaseStreamCoreEventTypeFailed = 5,
};

typedef NS_ENUM(NSInteger, MafbaseStreamCoreBackpressure) {
    MafbaseStreamCoreBackpressureNone = 0,
    MafbaseStreamCoreBackpressureLow = 1,
    MafbaseStreamCoreBackpressureHigh = 2,
};

typedef NS_ENUM(NSInteger, MafbaseStreamCoreNetworkQuality) {
    MafbaseStreamCoreNetworkQualityGood = 0,
    MafbaseStreamCoreNetworkQualityDegraded = 1,
    MafbaseStreamCoreNetworkQualityBad = 2,
};

typedef NS_ENUM(NSInteger, MafbaseStreamCoreIOSubcode) {
    MafbaseStreamCoreIOSubcodeNone = 0,
    MafbaseStreamCoreIOSubcodeTimeout = 1,
    MafbaseStreamCoreIOSubcodeEOF = 2,
    MafbaseStreamCoreIOSubcodeConnReset = 3,
    MafbaseStreamCoreIOSubcodeOther = 4,
};

/// Полная репрезентация события из ядра. Создаётся в native в момент колбека и
/// форвардится в Swift. Нужно стереть перед выходом из колбека: reason — pointer-
/// only-valid-during-callback в C-API, мы копируем его сюда.
@interface MafbaseStreamCoreEvent : NSObject
@property (nonatomic, readonly) MafbaseStreamCoreEventType type;
@property (nonatomic, readonly) MafbaseStreamCoreState state;
@property (nonatomic, readonly) int32_t bitrateBps;
@property (nonatomic, readonly) int32_t queueDepthVideoMs;
@property (nonatomic, readonly) int32_t queueDepthAudioMs;
@property (nonatomic, readonly) int32_t droppedFramesTotal;
@property (nonatomic, readonly) MafbaseStreamCoreBackpressure backpressure;
@property (nonatomic, readonly) MafbaseStreamCoreNetworkQuality networkQuality;
@property (nonatomic, readonly) int32_t reconnectAttempt;
@property (nonatomic, readonly) MafbaseStreamCoreIOSubcode ioSubcode;
@property (nonatomic, readonly, nullable) NSString *reason;
@end

/// Тонкая Obj-C обёртка вокруг ms_session_*.
///
/// Жизненный цикл: init → start(...) → pushVideo:/pushAudio: (много раз) → stop.
/// dealloc автоматически вызывает stop + ms_session_destroy.
@interface MafbaseStreamCoreBridge : NSObject

/// Создаёт bridge и `ms_session`. Возвращает nil, если ядро отказалось выделить
/// память под сессию (OOM) — на практике этого не бывает.
- (nullable instancetype)init NS_DESIGNATED_INITIALIZER;

/// Колбеки. Можно установить один раз перед start. Все опциональны.
/// Колбек срабатывает на writer-thread ядра — если нужно UI/main, переключайтесь сами.
@property (nonatomic, copy, nullable) void (^onEvent)(MafbaseStreamCoreEvent *event);
@property (nonatomic, copy, nullable) void (^onRequestKeyframe)(void);
@property (nonatomic, copy, nullable) void (^onSetVideoBitrate)(int32_t bitrateBps);

/// Открывает RTMP-соединение. Доп. параметры (adaptive, reconnect, timeout)
/// — 0/false для дефолтов ядра.
- (MafbaseStreamCoreResult)startWithRtmpURL:(NSString *)rtmpURL
                                      width:(int32_t)width
                                     height:(int32_t)height
                                        fps:(int32_t)fps
                               videoBitrate:(int32_t)videoBitrate
                            audioSampleRate:(int32_t)audioSampleRate
                              audioChannels:(int32_t)audioChannels
                               audioBitrate:(int32_t)audioBitrate
                             videoExtradata:(nullable NSData *)videoExtradata
                             audioExtradata:(nullable NSData *)audioExtradata
                            adaptiveBitrate:(BOOL)adaptiveBitrate
                       maxReconnectAttempts:(int32_t)maxReconnectAttempts
                       reconnectBaseDelayMs:(int32_t)reconnectBaseDelayMs
                        reconnectCapDelayMs:(int32_t)reconnectCapDelayMs
                                ioTimeoutUs:(int32_t)ioTimeoutUs;

/// Публикует один H.264 access unit. ptsUs — микросекунды от начала сессии.
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
