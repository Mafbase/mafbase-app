#include "mafbase_stream/session.h"

#include <memory>
#include <mutex>
#include <string>

#include "log.h"
#include "rtmp_publisher.h"
#include "state_machine.h"

namespace ms = mafbase_stream;

struct ms_session {
    std::mutex mu;
    ms::StateMachine sm;
    std::unique_ptr<ms::RtmpPublisher> publisher;
    std::string url;
    ms_session_params params{};
};

extern "C" {

ms_session* ms_session_create(void) {
    auto* s = new (std::nothrow) ms_session();
    if (!s) return nullptr;
    s->publisher = std::make_unique<ms::RtmpPublisher>();
    return s;
}

ms_result ms_session_start(ms_session* session, const char* rtmp_url, const ms_session_params* params) {
    if (!session || !rtmp_url || !params) return MS_ERR_INVALID_ARG;
    std::lock_guard lk(session->mu);
    if (!session->sm.transition_to(MS_STATE_CONNECTING)) {
        return MS_ERR_INVALID_STATE;
    }
    session->url = rtmp_url;
    session->params = *params;

    const auto r = session->publisher->open(session->url, session->params);
    if (r != MS_OK) {
        session->sm.transition_to(MS_STATE_STOPPED);
        return r;
    }
    if (!session->sm.transition_to(MS_STATE_STREAMING)) {
        return MS_ERR_INVALID_STATE;
    }
    return MS_OK;
}

ms_result ms_session_push_video(ms_session* session,
                                const uint8_t* nalu,
                                size_t nalu_size,
                                int64_t pts_us,
                                bool is_keyframe) {
    if (!session) return MS_ERR_INVALID_ARG;
    std::lock_guard lk(session->mu);
    if (session->sm.state() != MS_STATE_STREAMING) {
        return MS_ERR_INVALID_STATE;
    }
    return session->publisher->write_video(nalu, nalu_size, pts_us, is_keyframe);
}

ms_result ms_session_push_audio(ms_session* session,
                                const uint8_t* aac_frame,
                                size_t aac_frame_size,
                                int64_t pts_us) {
    if (!session) return MS_ERR_INVALID_ARG;
    std::lock_guard lk(session->mu);
    if (session->sm.state() != MS_STATE_STREAMING) {
        return MS_ERR_INVALID_STATE;
    }
    return session->publisher->write_audio(aac_frame, aac_frame_size, pts_us);
}

ms_result ms_session_stop(ms_session* session) {
    if (!session) return MS_ERR_INVALID_ARG;
    std::lock_guard lk(session->mu);
    const auto current = session->sm.state();
    if (current == MS_STATE_STOPPED) return MS_OK;
    session->publisher->close();
    session->sm.transition_to(MS_STATE_STOPPED);
    return MS_OK;
}

void ms_session_destroy(ms_session* session) {
    if (!session) return;
    {
        std::lock_guard lk(session->mu);
        if (session->sm.state() != MS_STATE_STOPPED) {
            session->publisher->close();
            session->sm.transition_to(MS_STATE_STOPPED);
        }
    }
    delete session;
}

ms_state ms_session_get_state(const ms_session* session) {
    if (!session) return MS_STATE_STOPPED;
    return session->sm.state();
}

const char* ms_result_str(ms_result code) {
    switch (code) {
        case MS_OK: return "OK";
        case MS_ERR_INVALID_ARG: return "INVALID_ARG";
        case MS_ERR_INVALID_STATE: return "INVALID_STATE";
        case MS_ERR_IO: return "IO";
        case MS_ERR_FFMPEG: return "FFMPEG";
        case MS_ERR_NO_MEMORY: return "NO_MEMORY";
        case MS_ERR_TIMEOUT: return "TIMEOUT";
    }
    return "UNKNOWN";
}

const char* ms_state_str(ms_state state) {
    switch (state) {
        case MS_STATE_IDLE: return "idle";
        case MS_STATE_CONNECTING: return "connecting";
        case MS_STATE_STREAMING: return "streaming";
        case MS_STATE_RECONNECTING: return "reconnecting";
        case MS_STATE_STOPPED: return "stopped";
    }
    return "unknown";
}

}  // extern "C"
