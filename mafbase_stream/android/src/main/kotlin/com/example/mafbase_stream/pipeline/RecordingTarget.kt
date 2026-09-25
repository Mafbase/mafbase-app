package com.example.mafbase_stream.pipeline

import android.content.ContentValues
import android.content.Context
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.os.ParcelFileDescriptor
import android.provider.MediaStore
import android.util.Log
import androidx.annotation.RequiresApi
import com.example.mafbase_stream.SaveToGalleryService
import com.example.mafbase_stream.encoder.Mp4Recorder
import java.io.File

/**
 * Куда пишется сегмент записи: на API 29+ напрямую в MediaStore через FileDescriptor,
 * ниже — во временный файл с копированием в галерею через [SaveToGalleryService].
 */
internal interface RecordingTarget {

    /** Не удалось подготовить место под сегмент; [message] показывается пользователю. */
    class OpenException(message: String, cause: Throwable? = null) : Exception(message, cause)

    /** Место под один сегмент. */
    interface Opened {
        fun start(recorder: Mp4Recorder, width: Int, height: Int)

        /** Откат, если рекордер так и не запустился. */
        fun discard()

        /**
         * Останавливает рекордер и доводит запись до галереи. Блокирующий — вызывать с
         * фонового потока. true, если запись сохранена или поставлена в очередь копирования.
         */
        fun finalize(recorder: Mp4Recorder, showToast: Boolean): Boolean

        /** Что сказать пользователю после остановки по кнопке; null — сообщит сервис копирования. */
        fun completionMessage(ok: Boolean): String?
    }

    @Throws(OpenException::class)
    fun open(name: String): Opened

    companion object {
        fun create(appContext: Context): RecordingTarget =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                MediaStoreRecordingTarget(appContext)
            } else {
                FileRecordingTarget(appContext)
            }
    }
}

/** Раздел, куда пишется запись; по нему же считается свободное место. */
internal fun recordingStorageDir(appContext: Context): File =
    appContext.getExternalFilesDir(Environment.DIRECTORY_MOVIES) ?: appContext.filesDir

private const val TAG = "RecordingTarget"

/** Останавливает рекордер, возвращая признак того, что стоп не бросил исключение. */
private fun stopRecorder(recorder: Mp4Recorder): Boolean = try {
    recorder.stop()
    true
} catch (e: Exception) {
    Log.e(TAG, "Mp4Recorder.stop failed", e)
    false
}

/** Вариант для файловой записи: возвращает файл, только если в нём есть данные. */
private fun stopRecorderToFile(recorder: Mp4Recorder): File? {
    val file = try {
        recorder.stop()
    } catch (e: Exception) {
        Log.e(TAG, "Mp4Recorder.stop failed", e)
        null
    }
    return file?.takeIf { it.exists() && it.length() > 0 }
}

@RequiresApi(Build.VERSION_CODES.Q)
private class MediaStoreRecordingTarget(private val appContext: Context) : RecordingTarget {

    override fun open(name: String): RecordingTarget.Opened {
        val resolver = appContext.contentResolver
        val values = ContentValues().apply {
            put(MediaStore.Video.Media.DISPLAY_NAME, name)
            put(MediaStore.Video.Media.MIME_TYPE, "video/mp4")
            put(MediaStore.Video.Media.RELATIVE_PATH, Environment.DIRECTORY_MOVIES)
            put(MediaStore.Video.Media.IS_PENDING, 1)
        }
        val uri = resolver.insert(MediaStore.Video.Media.EXTERNAL_CONTENT_URI, values)
        if (uri == null) {
            Log.e(TAG, "failed to create MediaStore entry")
            throw RecordingTarget.OpenException("Не удалось создать запись в галерее")
        }
        val pfd = try {
            resolver.openFileDescriptor(uri, "w")
        } catch (e: Exception) {
            Log.e(TAG, "failed to open MediaStore FD", e)
            resolver.delete(uri, null, null)
            throw RecordingTarget.OpenException("Не удалось открыть файл галереи", e)
        }
        if (pfd == null) {
            resolver.delete(uri, null, null)
            throw RecordingTarget.OpenException("Не удалось открыть файл галереи")
        }
        return Entry(uri, pfd)
    }

    private inner class Entry(
        private val uri: Uri,
        private val pfd: ParcelFileDescriptor,
    ) : RecordingTarget.Opened {

        override fun start(recorder: Mp4Recorder, width: Int, height: Int) {
            recorder.start(width, height, pfd.fileDescriptor)
        }

        override fun discard() {
            try {
                pfd.close()
            } catch (e: Exception) {
                Log.w(TAG, "pfd close failed", e)
            }
            appContext.contentResolver.delete(uri, null, null)
        }

        /**
         * Закрывает дескриптор и снимает IS_PENDING, делая запись видимой в галерее.
         *
         * Одного лишь успешного stop() мало: Mp4Recorder.stop() гасит ошибки муксера внутри
         * себя и почти никогда не бросает, поэтому пустая или нефинализированная запись иначе
         * уехала бы в галерею как валидная. Настоящий признак — сколько байт реально записано.
         */
        override fun finalize(recorder: Mp4Recorder, showToast: Boolean): Boolean {
            val stopOk = stopRecorder(recorder)
            val written = try { pfd.statSize } catch (e: Exception) { -1L }
            try { pfd.close() } catch (e: Exception) { Log.w(TAG, "pfd close failed", e) }
            val ok = stopOk && written > 0
            val resolver = appContext.contentResolver
            return try {
                if (ok) {
                    val values = ContentValues().apply { put(MediaStore.Video.Media.IS_PENDING, 0) }
                    resolver.update(uri, values, null, null)
                } else {
                    resolver.delete(uri, null, null)
                }
                ok
            } catch (e: Exception) {
                Log.e(TAG, "не удалось финализировать запись в галерее", e)
                false
            }
        }

        override fun completionMessage(ok: Boolean): String =
            if (ok) "Запись сохранена в галерею" else "Не удалось сохранить запись"
    }
}

private class FileRecordingTarget(private val appContext: Context) : RecordingTarget {

    override fun open(name: String): RecordingTarget.Opened {
        val dir = recordingStorageDir(appContext)
        if (!dir.exists()) dir.mkdirs()
        return Entry(File(dir, name))
    }

    private inner class Entry(private val file: File) : RecordingTarget.Opened {

        override fun start(recorder: Mp4Recorder, width: Int, height: Int) {
            recorder.start(width, height, file)
        }

        override fun discard() {}

        override fun finalize(recorder: Mp4Recorder, showToast: Boolean): Boolean {
            val written = stopRecorderToFile(recorder) ?: return false
            // Копирование в галерею идёт в foreground service — переживает сворачивание
            // и закрытие приложения; тост показывает сервис.
            SaveToGalleryService.enqueueCopy(appContext, written, showToast)
            return true
        }

        override fun completionMessage(ok: Boolean): String? = if (ok) null else "Запись пуста"
    }
}
