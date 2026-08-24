package com.example.mafbase_stream

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.HandlerThread
import android.os.IBinder
import android.os.Looper
import android.provider.MediaStore
import android.util.Log
import android.widget.Toast
import androidx.core.app.NotificationCompat
import java.io.File

/**
 * Foreground service для копирования записи в галерею (MediaStore) на API < 29,
 * где нет прямой записи через FileDescriptor. Копирование многогигабайтного файла
 * занимает минуты; без foreground-приоритета процесс замораживается или убивается,
 * когда пользователь сворачивает приложение, и запись не попадает в галерею.
 */
class SaveToGalleryService : Service() {

    private lateinit var workerThread: HandlerThread
    private lateinit var workerHandler: Handler
    private val mainHandler = Handler(Looper.getMainLooper())
    private var lastStartId = 0

    override fun onCreate() {
        super.onCreate()
        workerThread = HandlerThread("SaveToGallery")
        workerThread.start()
        workerHandler = Handler(workerThread.looper)
        createChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        lastStartId = startId
        val path = intent?.getStringExtra(EXTRA_FILE_PATH)
        val showToast = intent?.getBooleanExtra(EXTRA_SHOW_TOAST, false) ?: false

        // startForeground нужно вызвать сразу после startForegroundService, до фоновой работы.
        startForeground(NOTIFICATION_ID, buildProgressNotification(path?.let { File(it).name } ?: "", 0))

        if (path == null) {
            stopSelf(startId)
            return START_NOT_STICKY
        }

        workerHandler.post {
            val file = File(path)
            val saved = if (file.exists() && file.length() > 0) copyToGallery(file) else false
            if (showToast) {
                val text = if (saved) "Запись сохранена в галерею" else "Не удалось сохранить запись"
                mainHandler.post { Toast.makeText(applicationContext, text, Toast.LENGTH_SHORT).show() }
            }
            if (!saved) Log.e(TAG, "failed to save $path to gallery")
            // Очередь пуста только если этот startId — последний.
            if (stopSelfResult(startId)) {
                showDoneNotification(saved, file.name)
            }
        }
        return START_NOT_STICKY
    }

    override fun onDestroy() {
        workerThread.quitSafely()
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    /** Копирует файл в MediaStore с прогрессом в нотификации; удаляет оригинал при успехе. */
    private fun copyToGallery(file: File): Boolean {
        return try {
            val values = ContentValues().apply {
                put(MediaStore.Video.Media.DISPLAY_NAME, file.name)
                put(MediaStore.Video.Media.MIME_TYPE, "video/mp4")
                put(MediaStore.Video.Media.DATE_ADDED, System.currentTimeMillis() / 1000)
                put(MediaStore.Video.Media.DATE_MODIFIED, System.currentTimeMillis() / 1000)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    put(MediaStore.Video.Media.RELATIVE_PATH, android.os.Environment.DIRECTORY_MOVIES)
                    put(MediaStore.Video.Media.IS_PENDING, 1)
                }
            }
            val resolver = contentResolver
            val uri = resolver.insert(MediaStore.Video.Media.EXTERNAL_CONTENT_URI, values) ?: return false

            val total = file.length()
            var copied = 0L
            var lastUpdate = 0L
            try {
                resolver.openOutputStream(uri)?.use { out ->
                    file.inputStream().use { input ->
                        val buffer = ByteArray(BUFFER_SIZE)
                        while (true) {
                            val read = input.read(buffer)
                            if (read < 0) break
                            out.write(buffer, 0, read)
                            copied += read
                            val now = android.os.SystemClock.elapsedRealtime()
                            if (now - lastUpdate >= PROGRESS_UPDATE_MS) {
                                lastUpdate = now
                                val pct = if (total > 0) (copied * 100 / total).toInt() else 0
                                notify(buildProgressNotification(file.name, pct))
                            }
                        }
                    }
                } ?: run {
                    resolver.delete(uri, null, null)
                    return false
                }
            } catch (e: Exception) {
                // Недокачанную запись из галереи убираем.
                try { resolver.delete(uri, null, null) } catch (_: Exception) {}
                throw e
            }

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                values.clear()
                values.put(MediaStore.Video.Media.IS_PENDING, 0)
                resolver.update(uri, values, null, null)
            }
            try { file.delete() } catch (e: Exception) { Log.w(TAG, "failed to delete original file", e) }
            true
        } catch (e: Exception) {
            Log.e(TAG, "copyToGallery failed", e)
            false
        }
    }

    private fun createChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Сохранение записей",
                NotificationManager.IMPORTANCE_LOW,
            )
            val nm = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            nm.createNotificationChannel(channel)
        }
    }

    private fun buildProgressNotification(fileName: String, progress: Int): Notification {
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.stat_sys_download)
            .setContentTitle("Сохранение записи в галерею")
            .setContentText(fileName)
            .setProgress(100, progress, false)
            .setOngoing(true)
            .setOnlyAlertOnce(true)
            .build()
    }

    private fun showDoneNotification(saved: Boolean, fileName: String) {
        val notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(
                if (saved) android.R.drawable.stat_sys_download_done else android.R.drawable.stat_notify_error,
            )
            .setContentTitle(if (saved) "Запись сохранена в галерею" else "Не удалось сохранить запись")
            .setContentText(fileName)
            .setAutoCancel(true)
            .build()
        notify(notification, DONE_NOTIFICATION_ID)
    }

    private fun notify(notification: Notification, id: Int = NOTIFICATION_ID) {
        val nm = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        nm.notify(id, notification)
    }

    companion object {
        private const val TAG = "SaveToGalleryService"
        private const val CHANNEL_ID = "mafbase_stream_save"
        private const val NOTIFICATION_ID = 0x5A7E
        private const val DONE_NOTIFICATION_ID = 0x5A7F
        private const val EXTRA_FILE_PATH = "filePath"
        private const val EXTRA_SHOW_TOAST = "showToast"
        private const val BUFFER_SIZE = 256 * 1024
        private const val PROGRESS_UPDATE_MS = 500L

        /** Ставит файл в очередь на сохранение в галерею через foreground service. */
        fun enqueue(context: Context, file: File, showToast: Boolean) {
            val intent = Intent(context, SaveToGalleryService::class.java)
                .putExtra(EXTRA_FILE_PATH, file.absolutePath)
                .putExtra(EXTRA_SHOW_TOAST, showToast)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }
    }
}
