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

// Подкоды для MS_ERR_IO — позволяют различать таймаут от RST/EOF в логах и в ms_event.
typedef enum {
    MS_IO_NONE = 0,
    MS_IO_TIMEOUT = 1,
    MS_IO_EOF = 2,
    MS_IO_CONNRESET = 3,
    MS_IO_OTHER = 4,
} ms_io_subcode;

// Уровень backpressure писателя. Дискретизация по проценту заполнения очереди.
typedef enum {
    MS_BP_NONE = 0,
    MS_BP_LOW = 1,
    MS_BP_HIGH = 2,
} ms_backpressure;

// Качество сети — функция от backpressure и от количества дропов за окно.
typedef enum {
    MS_NETQ_GOOD = 0,
    MS_NETQ_DEGRADED = 1,
    MS_NETQ_BAD = 2,
} ms_network_quality;

// Тип события, прилетающего в ms_event_callback.
typedef enum {
    MS_EVENT_STATE = 0,        // изменилось состояние (см. state)
    MS_EVENT_QUEUE_DEPTH = 1,  // queue_depth_video_ms / queue_depth_audio_ms / backpressure / dropped_frames
    MS_EVENT_BITRATE = 2,      // bitrate_bps изменился
    MS_EVENT_RECONNECTING = 3, // attempt — номер попытки начиная с 1
    MS_EVENT_RECONNECTED = 4,
    MS_EVENT_FAILED = 5,       // io_subcode + reason
} ms_event_type;

typedef struct {
    ms_event_type type;
    ms_state state;                  // актуальное состояние (для всех событий)
    int bitrate_bps;                 // текущий целевой битрейт
    int queue_depth_video_ms;
    int queue_depth_audio_ms;
    int dropped_frames_total;        // суммарно за сессию
    ms_backpressure backpressure;
    ms_network_quality network_quality;
    int reconnect_attempt;           // номер попытки (для RECONNECTING/FAILED), иначе 0
    ms_io_subcode io_subcode;        // последняя подпричина IO-ошибки
    const char* reason;              // утф-8 строка, валидна только в коллбеке
} ms_event;

// Колбек событий. user_data — то, что было передано в ms_session_set_event_callback.
// Гарантии: вызывается из внутреннего потока ядра, никогда не из push_video/push_audio
// и никогда не под session-mutex'ом — слушатель может безопасно вызывать ms_session_*.
typedef void (*ms_event_callback)(const ms_event* ev, void* user_data);

// Колбек запроса keyframe из ядра в платформенный энкодер. Вызывается из writer-thread
// после успешного reconnect. Платформа должна вызвать MediaCodec.setParameters
// PARAMETER_KEY_REQUEST_SYNC_FRAME / VTSession kVTEncodeFrameOptionKey_ForceKeyFrame.
typedef void (*ms_request_keyframe_cb)(void* user_data);

// Колбек запроса смены битрейта от BitrateController. Платформа должна вызвать
// MediaCodec.setParameters PARAMETER_KEY_VIDEO_BITRATE / VTSession AverageBitRate.
typedef void (*ms_set_video_bitrate_cb)(int bitrate_bps, void* user_data);

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

    // ----- Адаптация и реконнект (нули = разумные дефолты) ---------------------

    // Бюджет очереди отправки на каждую дорожку (сек). 0 → 2.
    int queue_budget_video_ms;
    int queue_budget_audio_ms;
    // Жёсткий cap по байтам на всю очередь (защита от нереалистичных битрейтов).
    // 0 → 4 MB.
    int queue_byte_cap;

    // Максимальное число попыток реконнекта перед FAILED. 0 → 3.
    int max_reconnect_attempts;
    // Базовая задержка backoff (мс). 0 → 1000.
    int reconnect_base_delay_ms;
    // Cap задержки backoff (мс). 0 → 8000.
    int reconnect_cap_delay_ms;

    // Включить адаптивный битрейт. true по умолчанию.
    bool adaptive_bitrate_enabled;

    // Дедлайн на одну сетевую операцию (мкс). 0 → 3 000 000 (3 с).
    int io_timeout_us;
} ms_session_params;

ms_session* ms_session_create(void);

// Регистрирует колбеки. Все three опциональны — NULL отключает соответствующий канал.
// Можно вызывать как до, так и после ms_session_start. Не thread-safe относительно
// самих колбеков — устанавливайте один раз перед start.
void ms_session_set_event_callback(ms_session* session,
                                   ms_event_callback cb,
                                   void* user_data);
void ms_session_set_request_keyframe_callback(ms_session* session,
                                              ms_request_keyframe_cb cb,
                                              void* user_data);
void ms_session_set_video_bitrate_callback(ms_session* session,
                                           ms_set_video_bitrate_cb cb,
                                           void* user_data);

// Запускает сессию: переход idle → connecting → streaming. Блокирующий вызов,
// внутри открывает RTMP-соединение и пишет header. rtmp_url — обычная RTMP-схема,
// например "rtmp://localhost/live/test". Параметры params копируются.
ms_result ms_session_start(ms_session* session,
                           const char* rtmp_url,
                           const ms_session_params* params);

// Публикует один H.264 access unit. nalu может содержать несколько NAL-юнитов
// в Annex-B (00 00 00 01) или AVCC-форме. pts_us — в микросекундах от начала
// сессии. Должно быть монотонно возрастающим.
//
// Не выполняет сетевой I/O — кладёт пакет во внутреннюю очередь и возвращается
// мгновенно. Реальную отправку делает writer-thread.
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
const char* ms_io_subcode_str(ms_io_subcode code);
const char* ms_event_type_str(ms_event_type type);

#ifdef __cplusplus
}
#endif

#endif  // MAFBASE_STREAM_SESSION_H
