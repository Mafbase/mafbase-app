package com.example.mafbase_stream

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Environment
import android.os.Handler
import android.os.HandlerThread
import android.os.IBinder
import android.os.Looper
import android.os.SystemClock
import android.provider.MediaStore
import android.util.Log
import android.widget.Toast
import androidx.core.app.NotificationCompat
import java.io.File
import java.util.concurrent.atomic.AtomicInteger

/**
 * Foreground service, удерживающий процесс на время сохранения записи в галерею.
 *
 * Оба сценария сохранения занимают заметное время и продолжаются после того, как
 * пользователь свернул приложение; без foreground-приоритета система замораживает
 * или убивает процесс, и запись до галереи не доезжает:
 *
 *  - [ACTION_COPY] (API < 29) — копирование файла в MediaStore с прогрессом;
 *    многогигабайтный файл копируется минутами.
 *  - [ACTION_KEEP_ALIVE] / [ACTION_RELEASE] (API 29+) — запись идёт напрямую в
 *    MediaStore, копировать нечего, но финализация (запись moov-атома муксером и
 *    снятие IS_PENDING) всё равно длится секунды и выполняется в activity.
 *    Пока она идёт, сервис просто держит процесс живым.
 */
class SaveToGalleryService : Service() {

    private lateinit var workerThread: HandlerThread
    private lateinit var workerHandler: Handler
    private val mainHandler = Handler(Looper.getMainLooper())
    private val notificationManager: NotificationManager by lazy {
        getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    }

    // Копирования и удержания считаем раздельно: если startForegroundService для
    // удержания не прошёл, непарный RELEASE не должен снять сервис с идущего копирования.
    private val keepAlives = AtomicInteger(0)
    private val pendingCopies = AtomicInteger(0)

    private var lastProgressPct = -1

    override fun onCreate() {
        super.onCreate()
        workerThread = HandlerThread("SaveToGallery")
        workerThread.start()
        workerHandler = Handler(workerThread.looper)
        createChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val action = intent?.action
        val path = intent?.getStringExtra(EXTRA_FILE_PATH)
        val showToast = intent?.getBooleanExtra(EXTRA_SHOW_TOAST, false) ?: false

        // startForeground обязателен сразу после startForegroundService, иначе система
        // убьёт сервис с ANR. Если промоушен запрещён (фон на API 31+), работу всё равно
        // доводим до конца — просто без гарантий приоритета.
        try {
            val name = path?.let { File(it).name }.orEmpty()
            startForeground(NOTIFICATION_ID, buildProgressNotification(name, if (action == ACTION_COPY) 0 else null))
        } catch (e: Exception) {
            Log.w(TAG, "startForeground failed", e)
        }

        when (action) {
            ACTION_KEEP_ALIVE -> keepAlives.incrementAndGet()

            ACTION_RELEASE -> {
                if (keepAlives.get() > 0) keepAlives.decrementAndGet()
                stopIfIdle()
            }

            ACTION_COPY -> {
                if (path == null) {
                    stopIfIdle()
                } else {
                    pendingCopies.incrementAndGet()
                    workerHandler.post {
                        val file = File(path)
                        val saved = copyToGallery(file)
                        if (!saved) Log.e(TAG, "failed to save $path to gallery")
                        if (showToast) {
                            val text = if (saved) "Запись сохранена в галерею" else "Не удалось сохранить запись"
                            mainHandler.post { Toast.makeText(applicationContext, text, Toast.LENGTH_SHORT).show() }
                        }
                        mainHandler.post {
                            showDoneNotification(saved, file.name)
                            pendingCopies.decrementAndGet()
                            stopIfIdle()
                        }
                    }
                }
            }

            else -> stopIfIdle()
        }
        return START_NOT_STICKY
    }

    /**
     * На API 34+ shortService принудительно останавливают примерно через три минуты.
     * Копирование туда не попадает (оно бывает только на API < 29), а удержание на время
     * финализации в этот лимит укладывается, но досидеть до принудительного убийства
     * всё равно нельзя — снимаем себя сами.
     */
    override fun onTimeout(startId: Int) {
        Log.w(TAG, "foreground service timeout, останавливаюсь")
        keepAlives.set(0)
        pendingCopies.set(0)
        stopSelf()
    }

    override fun onDestroy() {
        workerThread.quitSafely()
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun stopIfIdle() {
        if (keepAlives.get() <= 0 && pendingCopies.get() <= 0) stopSelf()
    }

    /** Копирует файл в MediaStore с прогрессом в нотификации; удаляет оригинал при успехе. */
    private fun copyToGallery(file: File): Boolean {
        if (!file.exists() || file.length() <= 0) return false
        return try {
            val values = ContentValues().apply {
                put(MediaStore.Video.Media.DISPLAY_NAME, file.name)
                put(MediaStore.Video.Media.MIME_TYPE, "video/mp4")
                put(MediaStore.Video.Media.DATE_ADDED, System.currentTimeMillis() / 1000)
                put(MediaStore.Video.Media.DATE_MODIFIED, System.currentTimeMillis() / 1000)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    put(MediaStore.Video.Media.RELATIVE_PATH, Environment.DIRECTORY_MOVIES)
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
                            val now = SystemClock.elapsedRealtime()
                            if (now - lastUpdate >= PROGRESS_UPDATE_MS) {
                                lastUpdate = now
                                val pct = if (total > 0) (copied * 100 / total).toInt() else 0
                                if (pct != lastProgressPct) {
                                    lastProgressPct = pct
                                    notify(buildProgressNotification(file.name, pct))
                                }
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
            notificationManager.createNotificationChannel(
                NotificationChannel(CHANNEL_ID, "Сохранение записей", NotificationManager.IMPORTANCE_LOW),
            )
        }
    }

    /** [progress] == null — неопределённый индикатор (финализация, длину которой мы не знаем). */
    private fun buildProgressNotification(fileName: String, progress: Int?): Notification {
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.stat_sys_download)
            .setContentTitle("Сохранение записи в галерею")
            .setContentText(fileName)
            .setProgress(100, progress ?: 0, progress == null)
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
        try {
            notificationManager.notify(id, notification)
        } catch (e: Exception) {
            Log.w(TAG, "notify failed", e)
        }
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

        private const val ACTION_COPY = "com.example.mafbase_stream.COPY"
        private const val ACTION_KEEP_ALIVE = "com.example.mafbase_stream.KEEP_ALIVE"
        private const val ACTION_RELEASE = "com.example.mafbase_stream.RELEASE"

        /** Ставит файл в очередь на копирование в галерею (API < 29). */
        fun enqueueCopy(context: Context, file: File, showToast: Boolean) {
            start(
                context,
                Intent(context, SaveToGalleryService::class.java)
                    .setAction(ACTION_COPY)
                    .putExtra(EXTRA_FILE_PATH, file.absolutePath)
                    .putExtra(EXTRA_SHOW_TOAST, showToast),
            )
        }

        /**
         * Поднимает приоритет процесса на время финализации записи, идущей напрямую
         * в MediaStore (API 29+). Каждому вызову обязан соответствовать [endKeepAlive].
         */
        fun beginKeepAlive(context: Context) {
            start(context, Intent(context, SaveToGalleryService::class.java).setAction(ACTION_KEEP_ALIVE))
        }

        fun endKeepAlive(context: Context) {
            start(context, Intent(context, SaveToGalleryService::class.java).setAction(ACTION_RELEASE))
        }

        /**
         * Запуск foreground service из фона запрещён с API 31 и бросает
         * ForegroundServiceStartNotAllowedException. Ловим: остаться без приоритета
         * хуже, чем с ним, но несравнимо лучше, чем уронить приложение в onPause.
         */
        private fun start(context: Context, intent: Intent) {
            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    context.startForegroundService(intent)
                } else {
                    context.startService(intent)
                }
            } catch (e: Exception) {
                Log.w(TAG, "не удалось запустить сервис сохранения (${intent.action})", e)
            }
        }
    }
}
