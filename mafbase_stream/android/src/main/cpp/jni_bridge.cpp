// JNI-обёртка над C-API ядра mafbase_stream (см. native/include/mafbase_stream/session.h).
// Все методы маппятся 1:1 на ms_session_*. Видео/аудио-данные передаются через direct ByteBuffer
// — JNI отдаёт прямой указатель в нативный код без копирования.
//
// Колбеки в Kotlin: ядро вызывает их из writer-thread, мы аттачимся к JVM
// через global JavaVM*, ищем static-метод диспатчера в `StreamSessionNative` и
// вызываем его с handle'ом сессии. Kotlin сам найдёт нужный экземпляр в map'е.

#include <jni.h>
#include <atomic>
#include <cstdint>
#include <cstring>
#include <mutex>
#include <unordered_map>

#include "mafbase_stream/session.h"

namespace {

constexpr const char* kClass = "com/example/mafbase_stream/jni/StreamSessionNative";

JavaVM* g_vm = nullptr;
jclass g_native_class = nullptr;
jmethodID g_dispatch_event = nullptr;
jmethodID g_dispatch_request_keyframe = nullptr;
jmethodID g_dispatch_set_bitrate = nullptr;

inline ms_session* handleToSession(jlong handle) {
    return reinterpret_cast<ms_session*>(static_cast<uintptr_t>(handle));
}

inline jlong sessionToHandle(ms_session* s) {
    return static_cast<jlong>(reinterpret_cast<uintptr_t>(s));
}

struct AttachedEnv {
    JNIEnv* env = nullptr;
    bool need_detach = false;

    AttachedEnv() {
        if (!g_vm) return;
        const int rc = g_vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6);
        if (rc == JNI_EDETACHED) {
            if (g_vm->AttachCurrentThread(&env, nullptr) == JNI_OK) {
                need_detach = true;
            } else {
                env = nullptr;
            }
        } else if (rc != JNI_OK) {
            env = nullptr;
        }
    }
    ~AttachedEnv() {
        if (need_detach && g_vm) g_vm->DetachCurrentThread();
    }
};

// Колбек событий: упаковывает ms_event в плоский массив примитивов и строку
// причины, отдаёт в Kotlin static-диспатчер. Сделано так, чтобы не
// аллоцировать Java-объект из C++ под нагрузкой.
void event_cb(const ms_event* ev, void* user_data) {
    if (!ev || !g_vm || !g_native_class || !g_dispatch_event) return;
    AttachedEnv attached;
    if (!attached.env) return;
    JNIEnv* env = attached.env;

    jstring reason = nullptr;
    if (ev->reason) reason = env->NewStringUTF(ev->reason);

    const jlong handle = static_cast<jlong>(reinterpret_cast<uintptr_t>(user_data));
    env->CallStaticVoidMethod(
        g_native_class, g_dispatch_event,
        handle,
        static_cast<jint>(ev->type),
        static_cast<jint>(ev->state),
        static_cast<jint>(ev->bitrate_bps),
        static_cast<jint>(ev->queue_depth_video_ms),
        static_cast<jint>(ev->queue_depth_audio_ms),
        static_cast<jint>(ev->dropped_frames_total),
        static_cast<jint>(ev->backpressure),
        static_cast<jint>(ev->network_quality),
        static_cast<jint>(ev->reconnect_attempt),
        static_cast<jint>(ev->io_subcode),
        reason);
    if (env->ExceptionCheck()) {
        env->ExceptionDescribe();
        env->ExceptionClear();
    }
    if (reason) env->DeleteLocalRef(reason);
}

void request_keyframe_cb(void* user_data) {
    if (!g_vm || !g_native_class || !g_dispatch_request_keyframe) return;
    AttachedEnv attached;
    if (!attached.env) return;
    const jlong handle = static_cast<jlong>(reinterpret_cast<uintptr_t>(user_data));
    attached.env->CallStaticVoidMethod(g_native_class, g_dispatch_request_keyframe, handle);
    if (attached.env->ExceptionCheck()) {
        attached.env->ExceptionDescribe();
        attached.env->ExceptionClear();
    }
}

void set_video_bitrate_cb(int bitrate_bps, void* user_data) {
    if (!g_vm || !g_native_class || !g_dispatch_set_bitrate) return;
    AttachedEnv attached;
    if (!attached.env) return;
    const jlong handle = static_cast<jlong>(reinterpret_cast<uintptr_t>(user_data));
    attached.env->CallStaticVoidMethod(g_native_class, g_dispatch_set_bitrate,
                                       handle, static_cast<jint>(bitrate_bps));
    if (attached.env->ExceptionCheck()) {
        attached.env->ExceptionDescribe();
        attached.env->ExceptionClear();
    }
}

}  // namespace

extern "C" {

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM* vm, void* /*reserved*/) {
    g_vm = vm;
    JNIEnv* env = nullptr;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK) {
        return JNI_ERR;
    }
    jclass cls = env->FindClass(kClass);
    if (!cls) return JNI_ERR;
    g_native_class = static_cast<jclass>(env->NewGlobalRef(cls));
    g_dispatch_event = env->GetStaticMethodID(
        g_native_class, "dispatchEvent",
        "(JIIIIIIIIIILjava/lang/String;)V");
    g_dispatch_request_keyframe = env->GetStaticMethodID(
        g_native_class, "dispatchRequestKeyframe", "(J)V");
    g_dispatch_set_bitrate = env->GetStaticMethodID(
        g_native_class, "dispatchSetVideoBitrate", "(JI)V");
    return JNI_VERSION_1_6;
}

JNIEXPORT jlong JNICALL
Java_com_example_mafbase_1stream_jni_StreamSessionNative_nativeCreate(JNIEnv*, jclass) {
    return sessionToHandle(ms_session_create());
}

JNIEXPORT void JNICALL
Java_com_example_mafbase_1stream_jni_StreamSessionNative_nativeDestroy(JNIEnv*, jclass, jlong handle) {
    ms_session_destroy(handleToSession(handle));
}

JNIEXPORT void JNICALL
Java_com_example_mafbase_1stream_jni_StreamSessionNative_nativeSetCallbacks(JNIEnv*, jclass, jlong handle) {
    auto* session = handleToSession(handle);
    if (!session) return;
    void* user = reinterpret_cast<void*>(static_cast<uintptr_t>(handle));
    ms_session_set_event_callback(session, &event_cb, user);
    ms_session_set_request_keyframe_callback(session, &request_keyframe_cb, user);
    ms_session_set_video_bitrate_callback(session, &set_video_bitrate_cb, user);
}

JNIEXPORT jint JNICALL
Java_com_example_mafbase_1stream_jni_StreamSessionNative_nativeStart(
    JNIEnv* env,
    jclass,
    jlong handle,
    jstring url,
    jint width,
    jint height,
    jint fps,
    jint videoBitrate,
    jint audioSampleRate,
    jint audioChannels,
    jint audioBitrate,
    jbyteArray videoExtradata,
    jbyteArray audioExtradata,
    jboolean adaptiveBitrate,
    jint maxReconnectAttempts,
    jint reconnectBaseDelayMs,
    jint reconnectCapDelayMs,
    jint ioTimeoutUs) {
    auto* session = handleToSession(handle);
    if (!session || !url) return MS_ERR_INVALID_ARG;

    const char* urlChars = env->GetStringUTFChars(url, nullptr);
    if (!urlChars) return MS_ERR_NO_MEMORY;

    jbyte* videoExtra = nullptr;
    jsize videoExtraSize = 0;
    if (videoExtradata != nullptr) {
        videoExtraSize = env->GetArrayLength(videoExtradata);
        if (videoExtraSize > 0) {
            videoExtra = env->GetByteArrayElements(videoExtradata, nullptr);
        }
    }

    jbyte* audioExtra = nullptr;
    jsize audioExtraSize = 0;
    if (audioExtradata != nullptr) {
        audioExtraSize = env->GetArrayLength(audioExtradata);
        if (audioExtraSize > 0) {
            audioExtra = env->GetByteArrayElements(audioExtradata, nullptr);
        }
    }

    ms_session_params params{};
    params.width = width;
    params.height = height;
    params.fps = fps;
    params.video_bitrate_bps = videoBitrate;
    params.audio_sample_rate = audioSampleRate;
    params.audio_channels = audioChannels;
    params.audio_bitrate_bps = audioBitrate;
    params.video_extradata = reinterpret_cast<const uint8_t*>(videoExtra);
    params.video_extradata_size = static_cast<size_t>(videoExtraSize);
    params.audio_extradata = reinterpret_cast<const uint8_t*>(audioExtra);
    params.audio_extradata_size = static_cast<size_t>(audioExtraSize);
    params.adaptive_bitrate_enabled = adaptiveBitrate == JNI_TRUE;
    params.max_reconnect_attempts = maxReconnectAttempts;
    params.reconnect_base_delay_ms = reconnectBaseDelayMs;
    params.reconnect_cap_delay_ms = reconnectCapDelayMs;
    params.io_timeout_us = ioTimeoutUs;

    const ms_result result = ms_session_start(session, urlChars, &params);

    if (videoExtra) env->ReleaseByteArrayElements(videoExtradata, videoExtra, JNI_ABORT);
    if (audioExtra) env->ReleaseByteArrayElements(audioExtradata, audioExtra, JNI_ABORT);
    env->ReleaseStringUTFChars(url, urlChars);

    return static_cast<jint>(result);
}

JNIEXPORT jint JNICALL
Java_com_example_mafbase_1stream_jni_StreamSessionNative_nativePushVideo(
    JNIEnv* env,
    jclass,
    jlong handle,
    jobject directBuffer,
    jint offset,
    jint size,
    jlong ptsUs,
    jboolean isKeyframe) {
    auto* session = handleToSession(handle);
    if (!session || !directBuffer) return MS_ERR_INVALID_ARG;

    auto* base = static_cast<uint8_t*>(env->GetDirectBufferAddress(directBuffer));
    if (!base) return MS_ERR_INVALID_ARG;

    return static_cast<jint>(ms_session_push_video(
        session,
        base + offset,
        static_cast<size_t>(size),
        static_cast<int64_t>(ptsUs),
        isKeyframe == JNI_TRUE));
}

JNIEXPORT jint JNICALL
Java_com_example_mafbase_1stream_jni_StreamSessionNative_nativePushAudio(
    JNIEnv* env,
    jclass,
    jlong handle,
    jobject directBuffer,
    jint offset,
    jint size,
    jlong ptsUs) {
    auto* session = handleToSession(handle);
    if (!session || !directBuffer) return MS_ERR_INVALID_ARG;

    auto* base = static_cast<uint8_t*>(env->GetDirectBufferAddress(directBuffer));
    if (!base) return MS_ERR_INVALID_ARG;

    return static_cast<jint>(ms_session_push_audio(
        session,
        base + offset,
        static_cast<size_t>(size),
        static_cast<int64_t>(ptsUs)));
}

JNIEXPORT jint JNICALL
Java_com_example_mafbase_1stream_jni_StreamSessionNative_nativeStop(JNIEnv*, jclass, jlong handle) {
    return static_cast<jint>(ms_session_stop(handleToSession(handle)));
}

JNIEXPORT jint JNICALL
Java_com_example_mafbase_1stream_jni_StreamSessionNative_nativeGetState(JNIEnv*, jclass, jlong handle) {
    return static_cast<jint>(ms_session_get_state(handleToSession(handle)));
}

JNIEXPORT jstring JNICALL
Java_com_example_mafbase_1stream_jni_StreamSessionNative_nativeResultStr(JNIEnv* env, jclass, jint code) {
    return env->NewStringUTF(ms_result_str(static_cast<ms_result>(code)));
}

}  // extern "C"
