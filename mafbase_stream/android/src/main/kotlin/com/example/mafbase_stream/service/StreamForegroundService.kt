package com.example.mafbase_stream.service

import android.annotation.SuppressLint
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.PowerManager
import android.os.SystemClock
import android.util.Log
import androidx.core.app.NotificationCompat
import com.example.mafbase_stream.StreamActivity
import com.example.mafbase_stream.pipeline.StreamPipeline
import java.util.Locale

/**
 * Foreground service, держащий [StreamPipeline] живым независимо от `StreamActivity`.
 *
 * Пайплайн — один на процесс, создаётся из activity через [createPipeline] и хранится
 * здесь. Сервис стартует обычным `startService` вместе с пайплайном и повышается до
 * foreground (типы camera|microphone) на время стрима или записи. Это while-in-use типы:
 * из фона такой сервис не поднять, поэтому промоушен идёт в момент старта, пока activity
 * на экране. Когда и стрим, и запись остановлены — снова обычный started service;
 * [StreamPipeline.release] останавливает его совсем.
 */
class StreamForegroundService : Service() {

    private val mainHandler = Handler(Looper.getMainLooper())
    private val notificationManager: NotificationManager by lazy {
        getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    }
    private var wakeLock: PowerManager.WakeLock? = null
    private var isForeground = false
    private var tickRunnable: Runnable? = null

    override fun onCreate() {
        super.onCreate()
        instance = this
        createChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent?.action == ACTION_STOP_ALL) {
            Log.i(TAG, "stop requested from notification")
            pipeline?.stopAll()
        }
        syncForegroundState()
        return START_NOT_STICKY
    }

    /** Пайплайн продолжает работать; остановить его можно кнопкой в нотификации. */
    override fun onTaskRemoved(rootIntent: Intent?) {}

    override fun onDestroy() {
        if (instance === this) instance = null
        demote()
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun syncForegroundState() {
        val p = pipeline
        if (p == null) {
            demote()
            stopSelf()
            return
        }
        if (p.isForegroundNeeded) promote(p) else demote()
    }

    private fun promote(p: StreamPipeline) {
        val notification = buildNotification(p)
        if (isForeground) {
            notify(notification)
            return
        }
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                startForeground(
                    NOTIFICATION_ID,
                    notification,
                    ServiceInfo.FOREGROUND_SERVICE_TYPE_CAMERA or ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE,
                )
            } else {
                startForeground(NOTIFICATION_ID, notification)
            }
        } catch (e: Exception) {
            // ForegroundServiceStartNotAllowedException / SecurityException: работаем дальше
            // без foreground-приоритета, activity предупредит пользователя.
            Log.e(TAG, "startForeground failed", e)
            p.onForegroundUnavailable()
            return
        }
        isForeground = true
        acquireWakeLock()
        scheduleTick()
    }

    private fun demote() {
        cancelTick()
        releaseWakeLock()
        if (!isForeground) return
        isForeground = false
        stopForeground(STOP_FOREGROUND_REMOVE)
    }

    private fun scheduleTick() {
        cancelTick()
        val runnable = Runnable {
            tickRunnable = null
            val p = pipeline ?: return@Runnable
            if (!isForeground || !p.isForegroundNeeded) return@Runnable
            notify(buildNotification(p))
            scheduleTick()
        }
        tickRunnable = runnable
        mainHandler.postDelayed(runnable, TICK_INTERVAL_MS)
    }

    private fun cancelTick() {
        tickRunnable?.let { mainHandler.removeCallbacks(it) }
        tickRunnable = null
    }

    @SuppressLint("WakelockTimeout")
    private fun acquireWakeLock() {
        if (wakeLock?.isHeld == true) return
        val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
        wakeLock = powerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, WAKE_LOCK_TAG).apply {
            setReferenceCounted(false)
            acquire()
        }
    }

    private fun releaseWakeLock() {
        try {
            wakeLock?.takeIf { it.isHeld }?.release()
        } catch (e: Exception) {
            Log.w(TAG, "wake lock release failed", e)
        }
        wakeLock = null
    }

    private fun createChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            notificationManager.createNotificationChannel(
                NotificationChannel(CHANNEL_ID, "Трансляция", NotificationManager.IMPORTANCE_LOW),
            )
        }
    }

    private fun buildNotification(p: StreamPipeline): Notification {
        val stopIntent = PendingIntent.getService(
            this,
            0,
            Intent(this, StreamForegroundService::class.java).setAction(ACTION_STOP_ALL),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
        )
        // Не launch intent пакета: в проде задача запущена по deep link, launch intent с ним не совпадает,
        // и система создаёт новую MainActivity поверх StreamActivity. REORDER_TO_FRONT поднимает живой
        // экземпляр StreamActivity наверх без пересоздания; уничтоженный — создастся заново и присоединится
        // к активному пайплайну (нотификация есть только пока он активен, extras не нужны).
        val openIntent = Intent(this, StreamActivity::class.java).addFlags(
            Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_REORDER_TO_FRONT,
        )
        val contentIntent = PendingIntent.getActivity(
            this,
            1,
            openIntent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
        )
        val status = when {
            p.isStreaming && p.isRecording -> "Идёт трансляция и запись"
            p.isStreaming -> "Идёт трансляция"
            p.isRecording -> "Идёт запись"
            else -> "Завершение"
        }
        val text = if (p.activeSinceElapsedMs > 0L) {
            "$status · ${formatDuration(SystemClock.elapsedRealtime() - p.activeSinceElapsedMs)}"
        } else {
            status
        }
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.presence_video_online)
            .setContentTitle("Mafbase")
            .setContentText(text)
            .setOngoing(true)
            .setOnlyAlertOnce(true)
            .setSilent(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setCategory(NotificationCompat.CATEGORY_SERVICE)
            .setContentIntent(contentIntent)
            .addAction(0, "Остановить", stopIntent)
            .build()
    }

    private fun formatDuration(elapsedMs: Long): String {
        val totalMinutes = (elapsedMs / 60_000L).coerceAtLeast(0L)
        val hours = totalMinutes / 60
        val minutes = totalMinutes % 60
        return if (hours > 0) {
            String.format(Locale.US, "%d ч %02d мин", hours, minutes)
        } else {
            String.format(Locale.US, "%d мин", minutes)
        }
    }

    private fun notify(notification: Notification) {
        try {
            notificationManager.notify(NOTIFICATION_ID, notification)
        } catch (e: Exception) {
            Log.w(TAG, "notify failed", e)
        }
    }

    companion object {
        private const val TAG = "StreamForegroundService"
        private const val CHANNEL_ID = "mafbase_stream_live"
        private const val NOTIFICATION_ID = 0x5A80
        private const val WAKE_LOCK_TAG = "mafbase_stream:pipeline"
        private const val TICK_INTERVAL_MS = 60_000L

        private const val ACTION_STOP_ALL = "com.example.mafbase_stream.STOP_ALL"
        private const val ACTION_SYNC = "com.example.mafbase_stream.SYNC"

        @Volatile
        private var instance: StreamForegroundService? = null

        /** Единственный пайплайн процесса; activity присоединяется к нему, если он активен. */
        @Volatile
        internal var pipeline: StreamPipeline? = null
            private set

        internal fun createPipeline(context: Context, config: StreamPipeline.Config): StreamPipeline {
            pipeline?.release()
            return StreamPipeline(context, config).also { pipeline = it }
        }

        internal fun onPipelineStarted(context: Context) {
            startSafely(context)
        }

        internal fun onPipelineStateChanged(context: Context) {
            val service = instance
            when {
                service != null -> service.syncForegroundState()
                pipeline != null -> startSafely(context)
            }
        }

        internal fun onPipelineReleased(context: Context, released: StreamPipeline) {
            if (pipeline === released) pipeline = null
            val service = instance
            if (service != null) {
                service.demote()
                service.stopSelf()
            } else {
                context.stopService(Intent(context, StreamForegroundService::class.java))
            }
        }

        private fun startSafely(context: Context) {
            try {
                context.startService(Intent(context, StreamForegroundService::class.java).setAction(ACTION_SYNC))
            } catch (e: Exception) {
                // IllegalStateException на API 26+, если приложение уже в фоне.
                Log.w(TAG, "startService failed", e)
            }
        }
    }
}
