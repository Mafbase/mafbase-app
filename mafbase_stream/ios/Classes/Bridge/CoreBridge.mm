#import "CoreBridge.h"

#include "mafbase_stream/session.h"

@interface MafbaseStreamCoreEvent ()
- (instancetype)initWithEvent:(const ms_event *)ev;
@end

@implementation MafbaseStreamCoreEvent
- (instancetype)initWithEvent:(const ms_event *)ev {
    self = [super init];
    if (self) {
        _type = (MafbaseStreamCoreEventType)ev->type;
        _state = (MafbaseStreamCoreState)ev->state;
        _bitrateBps = ev->bitrate_bps;
        _queueDepthVideoMs = ev->queue_depth_video_ms;
        _queueDepthAudioMs = ev->queue_depth_audio_ms;
        _droppedFramesTotal = ev->dropped_frames_total;
        _backpressure = (MafbaseStreamCoreBackpressure)ev->backpressure;
        _networkQuality = (MafbaseStreamCoreNetworkQuality)ev->network_quality;
        _reconnectAttempt = ev->reconnect_attempt;
        _ioSubcode = (MafbaseStreamCoreIOSubcode)ev->io_subcode;
        _reason = ev->reason ? [NSString stringWithUTF8String:ev->reason] : nil;
    }
    return self;
}
@end

@interface MafbaseStreamCoreBridge ()
@end

@implementation MafbaseStreamCoreBridge {
    ms_session *_session;
}

static void core_event_cb(const ms_event *ev, void *user_data) {
    if (!ev || !user_data) return;
    MafbaseStreamCoreBridge *bridge = (__bridge MafbaseStreamCoreBridge *)user_data;
    if (bridge.onEvent) {
        MafbaseStreamCoreEvent *boxed = [[MafbaseStreamCoreEvent alloc] initWithEvent:ev];
        bridge.onEvent(boxed);
    }
}

static void core_request_keyframe_cb(void *user_data) {
    if (!user_data) return;
    MafbaseStreamCoreBridge *bridge = (__bridge MafbaseStreamCoreBridge *)user_data;
    if (bridge.onRequestKeyframe) bridge.onRequestKeyframe();
}

static void core_set_video_bitrate_cb(int bitrate_bps, void *user_data) {
    if (!user_data) return;
    MafbaseStreamCoreBridge *bridge = (__bridge MafbaseStreamCoreBridge *)user_data;
    if (bridge.onSetVideoBitrate) bridge.onSetVideoBitrate((int32_t)bitrate_bps);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _session = ms_session_create();
        if (_session == nullptr) {
            return nil;
        }
        ms_session_set_event_callback(_session, &core_event_cb, (__bridge void *)self);
        ms_session_set_request_keyframe_callback(_session, &core_request_keyframe_cb,
                                                 (__bridge void *)self);
        ms_session_set_video_bitrate_callback(_session, &core_set_video_bitrate_cb,
                                              (__bridge void *)self);
    }
    return self;
}

- (void)dealloc {
    if (_session != nullptr) {
        ms_session_stop(_session);
        ms_session_destroy(_session);
        _session = nullptr;
    }
}

- (MafbaseStreamCoreResult)startWithRtmpURL:(NSString *)rtmpURL
                                      width:(int32_t)width
                                     height:(int32_t)height
                                        fps:(int32_t)fps
                               videoBitrate:(int32_t)videoBitrate
                            audioSampleRate:(int32_t)audioSampleRate
                              audioChannels:(int32_t)audioChannels
                               audioBitrate:(int32_t)audioBitrate
                             videoExtradata:(NSData *)videoExtradata
                             audioExtradata:(NSData *)audioExtradata
                            adaptiveBitrate:(BOOL)adaptiveBitrate
                       maxReconnectAttempts:(int32_t)maxReconnectAttempts
                       reconnectBaseDelayMs:(int32_t)reconnectBaseDelayMs
                        reconnectCapDelayMs:(int32_t)reconnectCapDelayMs
                                ioTimeoutUs:(int32_t)ioTimeoutUs {
    if (_session == nullptr) return MafbaseStreamCoreResultInvalidState;

    ms_session_params params{};
    params.width = width;
    params.height = height;
    params.fps = fps;
    params.video_bitrate_bps = videoBitrate;
    params.audio_sample_rate = audioSampleRate;
    params.audio_channels = audioChannels;
    params.audio_bitrate_bps = audioBitrate;
    params.video_extradata = static_cast<const uint8_t *>(videoExtradata.bytes);
    params.video_extradata_size = videoExtradata.length;
    params.audio_extradata = static_cast<const uint8_t *>(audioExtradata.bytes);
    params.audio_extradata_size = audioExtradata.length;
    params.adaptive_bitrate_enabled = adaptiveBitrate ? true : false;
    params.max_reconnect_attempts = maxReconnectAttempts;
    params.reconnect_base_delay_ms = reconnectBaseDelayMs;
    params.reconnect_cap_delay_ms = reconnectCapDelayMs;
    params.io_timeout_us = ioTimeoutUs;

    const char *url = rtmpURL.UTF8String;
    const ms_result r = ms_session_start(_session, url, &params);
    return static_cast<MafbaseStreamCoreResult>(r);
}

- (MafbaseStreamCoreResult)pushVideo:(NSData *)nalu
                               ptsUs:(int64_t)ptsUs
                          isKeyframe:(BOOL)isKeyframe {
    if (_session == nullptr || nalu.length == 0) return MafbaseStreamCoreResultInvalidArg;
    const ms_result r = ms_session_push_video(
        _session,
        static_cast<const uint8_t *>(nalu.bytes),
        nalu.length,
        ptsUs,
        isKeyframe ? true : false);
    return static_cast<MafbaseStreamCoreResult>(r);
}

- (MafbaseStreamCoreResult)pushAudio:(NSData *)aacFrame ptsUs:(int64_t)ptsUs {
    if (_session == nullptr || aacFrame.length == 0) return MafbaseStreamCoreResultInvalidArg;
    const ms_result r = ms_session_push_audio(
        _session,
        static_cast<const uint8_t *>(aacFrame.bytes),
        aacFrame.length,
        ptsUs);
    return static_cast<MafbaseStreamCoreResult>(r);
}

- (MafbaseStreamCoreResult)stop {
    if (_session == nullptr) return MafbaseStreamCoreResultOk;
    return static_cast<MafbaseStreamCoreResult>(ms_session_stop(_session));
}

- (MafbaseStreamCoreState)state {
    if (_session == nullptr) return MafbaseStreamCoreStateStopped;
    return static_cast<MafbaseStreamCoreState>(ms_session_get_state(_session));
}

+ (NSString *)resultName:(MafbaseStreamCoreResult)code {
    return [NSString stringWithUTF8String:ms_result_str(static_cast<ms_result>(code))];
}

@end
