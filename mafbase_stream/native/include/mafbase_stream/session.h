#ifndef MAFBASE_STREAM_SESSION_H
#define MAFBASE_STREAM_SESSION_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct ms_session ms_session;

typedef enum {
    MS_OK = 0,
    MS_ERR_INVALID_ARG = -1,
    MS_ERR_INVALID_STATE = -2,
    MS_ERR_IO = -3,
    MS_ERR_FFMPEG = -4,
    MS_ERR_NO_MEMORY = -5,
    MS_ERR_TIMEOUT = -6,
} ms_result;

typedef enum {
    MS_STATE_IDLE = 0,
    MS_STATE_CONNECTING = 1,
    MS_STATE_STREAMING = 2,
    MS_STATE_RECONNECTING = 3,
    MS_STATE_STOPPED = 4,
} ms_state;

typedef struct {
    int width;
    int height;
    int fps;
    int video_bitrate_bps;
    int audio_sample_rate;
    int audio_channels;
    int audio_bitrate_bps;

    // Опциональный extradata для H.264 (SPS/PPS в AVCC-формате) и AAC (AudioSpecificConfig).
    // Если NULL — будет извлечён из первых ключевых пакетов (SPS/PPS из Annex-B,
    // ASC формируется в момент push_audio).
    const uint8_t* video_extradata;
    size_t video_extradata_size;
    const uint8_t* audio_extradata;
    size_t audio_extradata_size;
} ms_session_params;

ms_session* ms_session_create(void);

// Запускает сессию: переход idle → connecting → streaming. Блокирующий вызов,
// внутри открывает RTMP-соединение и пишет header. rtmp_url — обычная RTMP-схема,
// например "rtmp://localhost/live/test". Параметры params копируются.
ms_result ms_session_start(ms_session* session,
                           const char* rtmp_url,
                           const ms_session_params* params);

// Публикует один H.264 access unit. nalu может содержать несколько NAL-юнитов
// в Annex-B (00 00 00 01) или AVCC-форме. pts_us — в микросекундах от начала
// сессии. Должно быть монотонно возрастающим.
ms_result ms_session_push_video(ms_session* session,
                                const uint8_t* nalu,
                                size_t nalu_size,
                                int64_t pts_us,
                                bool is_keyframe);

// Публикует один AAC ADTS-кадр или raw-AAC (если задан audio_extradata в params).
ms_result ms_session_push_audio(ms_session* session,
                                const uint8_t* aac_frame,
                                size_t aac_frame_size,
                                int64_t pts_us);

// Закрывает поток (writes trailer), переход → stopped. Идемпотентно.
ms_result ms_session_stop(ms_session* session);

void ms_session_destroy(ms_session* session);

ms_state ms_session_get_state(const ms_session* session);

const char* ms_result_str(ms_result code);
const char* ms_state_str(ms_state state);

#ifdef __cplusplus
}
#endif

#endif  // MAFBASE_STREAM_SESSION_H
