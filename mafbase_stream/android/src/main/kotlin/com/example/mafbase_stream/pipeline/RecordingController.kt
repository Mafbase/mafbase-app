package com.example.mafbase_stream.pipeline

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.util.Size
import com.example.mafbase_stream.SaveToGalleryService
import com.example.mafbase_stream.StorageMonitor
import com.example.mafbase_stream.encoder.AudioPipeline
import com.example.mafbase_stream.encoder.Mp4Recorder
import com.example.mafbase_stream.encoder.VideoEncoder
import com.example.mafbase_stream.events.StreamEventBus
import com.example.mafbase_stream.gl.Compositor
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/** Имя файла сегмента: с номером части, когда сегментация включена. */
internal fun segmentFileName(sessionId: String, index: Int, segmented: Boolean): String =
    if (segmented) "mafbase_stream_${sessionId}_part$index.mp4" else "mafbase_stream_$sessionId.mp4"

/**
 * MP4-запись: [Mp4Recorder] как ещё один выход компоситора, сегментация по таймеру,
 * контроль свободного места и финализация в галерею через [RecordingTarget].
 *
 * Публичные методы — с main-потока, колбэки [Host] — на нём же; остановка рекордера
 * (запись moov-атома) идёт в фоновом потоке под keep-alive [SaveToGalleryService].
 */
internal class RecordingController(
    private val appContext: Context,
    private val config: StreamPipeline.Config,
    private val audioPipeline: AudioPipeline,
    private val compositorHost: CompositorHost,
    private val host: Host,
) {

    interface Host {
        fun frameSize(): Size?

        /** Общий переход пайплайна: ролловер ждёт, пока стартует или пересоздаётся стрим. */
        fun isTransitioning(): Boolean

        fun onStateChanged()

        fun onActiveChanged()

        fun onMessage(text: String, long: Boolean)
    }

    private val mainHandler = Handler(Looper.getMainLooper())
    private val target = RecordingTarget.create(appContext)

    private var mp4Recorder: Mp4Recorder? = null
    private var activeTarget: RecordingTarget.Opened? = null

    var isRecording: Boolean = false
        private set

    var isRecordTransition: Boolean = false
        private set

    private var segmentIndex: Int = 1
    private var recordingSessionId: String = ""
    private var segmentTimerRunnable: Runnable? = null

    // Проверка свободного места (см. StorageMonitor). Не блокирует запись — только
    // предупреждает и, при критически малом остатке, останавливает её.
    private var storageCheckRunnable: Runnable? = null
    private var storageWarningReported = false

    fun start() {
        if (isRecording || isRecordTransition) return
        val size = host.frameSize() ?: return
        if (!compositorHost.isCreated) return
        isRecordTransition = true
        host.onStateChanged()

        recordingSessionId = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date())
        segmentIndex = 1

        startSegment(size, isRollover = false)
        if (isRecording) {
            storageWarningReported = false
            checkStorageAndMaybeStop()
        }
    }

    fun stop() {
        // Состояние сбрасываем до раннего выхода: если прямо сейчас идёт ролловер,
        // mp4Recorder уже null, и отложенный старт следующего сегмента должен увидеть,
        // что запись прекращена.
        cancelSegmentTimer()
        cancelStorageCheck()
        val recorder = mp4Recorder
        val opened = activeTarget
        mp4Recorder = null
        activeTarget = null
        val wasRecording = isRecording
        isRecording = false
        if (wasRecording) host.onActiveChanged()
        if (recorder == null || opened == null) {
            host.onStateChanged()
            return
        }
        isRecordTransition = true
        host.onStateChanged()

        // Сначала отцепляем encoder Surface от Compositor'а ДО recorder.stop() —
        // иначе Compositor продолжит eglSwapBuffers на разрушенный BufferQueue.
        compositorHost.detachOutput(Compositor.OutputId.RECORD_ENCODER)

        finalizeAsync(recorder, opened, showToast = true, threadName = "Mp4Recorder-stop") { ok ->
            isRecordTransition = false
            host.onStateChanged()
            opened.completionMessage(ok)?.let { host.onMessage(it, long = false) }
        }
    }

    /** Вариант для освобождения пайплайна: сохраняет запись в галерею без UI. */
    fun stopForRelease() {
        cancelSegmentTimer()
        cancelStorageCheck()
        val recorder = mp4Recorder
        val opened = activeTarget
        mp4Recorder = null
        activeTarget = null
        isRecording = false
        if (recorder == null || opened == null) return
        compositorHost.detachOutput(Compositor.OutputId.RECORD_ENCODER)
        finalizeAsync(recorder, opened, showToast = false, threadName = "Mp4Recorder-stop-sync", onDone = null)
    }

    /**
     * Общий сброс состояния, когда старт записи или очередного сегмента не удался.
     * При провале ролловера запись фактически прекращается — гасим таймер, иначе
     * пользователь видит «Стоп» на экране, где ничего не пишется.
     */
    private fun abortStart(isRollover: Boolean, message: String) {
        isRecordTransition = false
        if (isRollover) {
            cancelSegmentTimer()
            cancelStorageCheck()
            isRecording = false
            host.onActiveChanged()
        }
        host.onStateChanged()
        host.onMessage(message, long = true)
    }

    private fun startSegment(size: Size, isRollover: Boolean) {
        val name = segmentFileName(recordingSessionId, segmentIndex, segmented = config.segmentDurationMs > 0)
        val opened = try {
            target.open(name)
        } catch (e: RecordingTarget.OpenException) {
            abortStart(isRollover, e.message.orEmpty())
            return
        }
        val recorder = Mp4Recorder(audioPipeline)
        try {
            opened.start(recorder, size.width, size.height)
        } catch (e: Exception) {
            Log.e(TAG, "Mp4Recorder.start failed", e)
            recorder.stop()
            opened.discard()
            abortStart(isRollover, "Не удалось начать запись: ${e.message}")
            return
        }
        val encoderSurface = recorder.videoInputSurface
        if (encoderSurface == null) {
            Log.e(TAG, "startSegment: encoder surface is null")
            recorder.stop()
            opened.discard()
            abortStart(isRollover, "Не удалось начать запись")
            return
        }
        mp4Recorder = recorder
        activeTarget = opened
        // Capture session не трогаем — добавляем encoder как новый output Compositor'а.
        compositorHost.attachOutput(Compositor.OutputId.RECORD_ENCODER, encoderSurface, needsPresentationTime = true)

        val wasRecording = isRecording
        isRecording = true
        isRecordTransition = false
        if (!wasRecording) host.onActiveChanged()
        host.onStateChanged()
        scheduleNextSegment()
    }

    private fun scheduleNextSegment() {
        if (config.segmentDurationMs <= 0) return
        postSegmentTimer(config.segmentDurationMs)
    }

    private fun postSegmentTimer(delayMs: Long) {
        val runnable = Runnable { rolloverSegment() }
        segmentTimerRunnable = runnable
        mainHandler.postDelayed(runnable, delayMs)
    }

    private fun cancelSegmentTimer() {
        segmentTimerRunnable?.let { mainHandler.removeCallbacks(it) }
        segmentTimerRunnable = null
    }

    /** Автоматически завершает текущий сегмент и сразу начинает следующий. */
    private fun rolloverSegment() {
        if (!isRecording) return
        if (host.isTransitioning()) {
            // Стрим как раз стартует или пересоздаётся — переносим ролловер, а не теряем его.
            postSegmentTimer(TRANSITION_RETRY_MS)
            return
        }
        val recorder = mp4Recorder ?: return
        val opened = activeTarget ?: return
        val size = host.frameSize() ?: return
        if (!compositorHost.isCreated) return
        val generation = compositorHost.generation

        isRecordTransition = true
        host.onStateChanged()
        compositorHost.detachOutput(Compositor.OutputId.RECORD_ENCODER)
        mp4Recorder = null
        activeTarget = null
        segmentIndex++

        finalizeAsync(recorder, opened, showToast = false, threadName = "Mp4Segment-rollover") {
            continueSegmentation(size, generation)
        }
    }

    /**
     * Начинает следующий сегмент после финализации предыдущего. Пока сегмент дописывался,
     * запись могли остановить или компоситор — пересоздать. Тогда новый сегмент начинать
     * нельзя: он повиснет на мёртвом пайплайне и будет бесконечно перезаводить таймер.
     */
    private fun continueSegmentation(size: Size, generation: Int) {
        isRecordTransition = false
        if (!isRecording || compositorHost.generation != generation) {
            host.onStateChanged()
            return
        }
        startSegment(size, isRollover = true)
    }

    /**
     * Финализация занимает секунды (запись moov-атома), а процесс в этот момент может
     * уходить в фон — без foreground-приоритета его успевают заморозить или убить,
     * и запись не доезжает до галереи. Поэтому держим [SaveToGalleryService] на время работы.
     */
    private fun finalizeAsync(
        recorder: Mp4Recorder,
        opened: RecordingTarget.Opened,
        showToast: Boolean,
        threadName: String,
        onDone: ((Boolean) -> Unit)?,
    ) {
        SaveToGalleryService.beginKeepAlive(appContext)
        Thread({
            val ok = try {
                opened.finalize(recorder, showToast)
            } finally {
                SaveToGalleryService.endKeepAlive(appContext)
            }
            if (onDone != null) mainHandler.post { onDone(ok) }
        }, threadName).start()
    }

    /**
     * Проверяет свободное место и сама себя переставляет каждые [STORAGE_CHECK_INTERVAL_MS],
     * пока запись активна. Не блокирует запись: при нехватке места на ~8ч (см. [StorageMonitor])
     * только предупреждает тостом и событием [StreamEventBus.emitStorageEvent] — предупреждение
     * показывается один раз, пока место не появится снова. При критическом остатке
     * (< [StorageMonitor.CRITICAL_FREE_BYTES]) останавливает текущую запись.
     */
    private fun checkStorageAndMaybeStop() {
        // Битрейт стрима (quality.bitrateBps) на объём MP4-записи не влияет — Mp4Recorder
        // всегда пишет видео с фиксированным VideoEncoder.DEFAULT_BIT_RATE_BPS, поэтому и
        // оценку места считаем по нему, а не по настройке качества стрима.
        val totalBitrateBps = VideoEncoder.DEFAULT_BIT_RATE_BPS + ESTIMATED_AUDIO_BITRATE_BPS
        val check = StorageMonitor.check(recordingStorageDir(appContext), totalBitrateBps)
        if (check.isCritical) {
            Log.w(TAG, "Свободного места критически мало (${check.freeBytes} байт) — останавливаем запись")
            StreamEventBus.emitStorageEvent(
                StreamEventBus.StorageEventType.Low,
                "low_free_space:freeBytes=${check.freeBytes}",
            )
            if (isRecording) {
                host.onMessage("Запись остановлена: на устройстве закончилось место", long = true)
                stop()
            }
            return
        }
        if (check.isBelowTarget) {
            if (!storageWarningReported) {
                storageWarningReported = true
                host.onMessage(
                    "Мало места на устройстве: может не хватить на ${StorageMonitor.TARGET_RECORDING_HOURS}ч записи",
                    long = true,
                )
                StreamEventBus.emitStorageEvent(
                    StreamEventBus.StorageEventType.Warning,
                    "insufficient_free_space:freeBytes=${check.freeBytes},requiredBytes=${check.requiredBytesForTarget}",
                )
            }
        } else {
            storageWarningReported = false
        }
        scheduleStorageCheck()
    }

    private fun scheduleStorageCheck() {
        val runnable = Runnable { checkStorageAndMaybeStop() }
        storageCheckRunnable = runnable
        mainHandler.postDelayed(runnable, STORAGE_CHECK_INTERVAL_MS)
    }

    private fun cancelStorageCheck() {
        storageCheckRunnable?.let { mainHandler.removeCallbacks(it) }
        storageCheckRunnable = null
        storageWarningReported = false
    }

    companion object {
        private const val TAG = "RecordingController"

        /** Как часто перепроверяем свободное место, пока идёт запись. */
        private const val STORAGE_CHECK_INTERVAL_MS = 30_000L

        /**
         * Аудио-битрейт записи не настраивается пользователем (см. AudioEncoder/AudioPipeline —
         * 128 kbps AAC по умолчанию), поэтому для оценки объёма записи берём его константой,
         * прибавляя к битрейту видео-энкодера записи (см. [VideoEncoder.DEFAULT_BIT_RATE_BPS]).
         */
        private const val ESTIMATED_AUDIO_BITRATE_BPS = 128_000
    }
}
