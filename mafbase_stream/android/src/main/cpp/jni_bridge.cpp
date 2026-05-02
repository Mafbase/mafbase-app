// JNI-обёртка над C-API ядра mafbase_stream (см. native/include/mafbase_stream/session.h).
// Все методы маппятся 1:1 на ms_session_*. Видео/аудио-данные передаются через direct ByteBuffer
// — JNI отдаёт прямой указатель в нативный код без копирования.

#include <jni.h>
#include <cstdint>
#include <cstring>

#include "mafbase_stream/session.h"

namespace {

constexpr const char* kClass = "com/example/mafbase_stream/jni/StreamSessionNative";

inline ms_session* handleToSession(jlong handle) {
    return reinterpret_cast<ms_session*>(static_cast<uintptr_t>(handle));
}

inline jlong sessionToHandle(ms_session* s) {
    return static_cast<jlong>(reinterpret_cast<uintptr_t>(s));
}

}  // namespace

extern "C" {

JNIEXPORT jlong JNICALL
Java_com_example_mafbase_1stream_jni_StreamSessionNative_nativeCreate(JNIEnv*, jclass) {
    return sessionToHandle(ms_session_create());
}

JNIEXPORT void JNICALL
Java_com_example_mafbase_1stream_jni_StreamSessionNative_nativeDestroy(JNIEnv*, jclass, jlong handle) {
    ms_session_destroy(handleToSession(handle));
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
    jbyteArray audioExtradata) {
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
