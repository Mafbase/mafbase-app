#import "CoreBridge.h"

#include "mafbase_stream/session.h"

@implementation MafbaseStreamCoreBridge {
    ms_session *_session;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _session = ms_session_create();
        if (_session == nullptr) {
            return nil;
        }
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
                             audioExtradata:(NSData *)audioExtradata {
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
