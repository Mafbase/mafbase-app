package com.example.mafbase_stream.data.sockets

import android.os.Handler
import android.os.Looper
import android.util.Log
import generated.Mafia
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import okhttp3.WebSocket
import okhttp3.WebSocketListener
import okio.ByteString
import java.util.concurrent.TimeUnit

/**
 * Подписка на seatingContent через websocket. Кодовый аналог Dart-класса
 * `TournamentContentSocket` (см. `lib/data/sockets/tournament_content_socket.dart`):
 * тот же URL, тот же бинарный proto-формат, тот же auto-reconnect через 3 секунды.
 *
 * Поток данных отдаётся через [state] — Compose интегрируется через `collectAsState`.
 */
internal class TournamentContentSocket(
    tournamentId: Int,
    table: Int,
) {
    private val url = "wss://mafbase.ru/api/seatingContent?table=$table&tournamentId=$tournamentId"
    private val client = OkHttpClient.Builder()
        .pingInterval(20, TimeUnit.SECONDS)
        .build()
    private val handler = Handler(Looper.getMainLooper())
    private var socket: WebSocket? = null

    @Volatile
    private var manualClosed = false

    private val _state = MutableStateFlow<Mafia.SeatingContent?>(null)
    val state: StateFlow<Mafia.SeatingContent?> = _state

    fun connect() {
        socket?.cancel()
        Log.d(TAG, "connect $url")
        socket = client.newWebSocket(
            Request.Builder().url(url).build(),
            object : WebSocketListener() {
                override fun onMessage(webSocket: WebSocket, bytes: ByteString) {
                    runCatching { Mafia.SeatingContent.parseFrom(bytes.toByteArray()) }
                        .onSuccess { _state.value = it }
                        .onFailure { Log.w(TAG, "parse SeatingContent failed", it) }
                }

                override fun onClosed(webSocket: WebSocket, code: Int, reason: String) {
                    Log.d(TAG, "onClosed code=$code reason=$reason")
                    scheduleReconnect()
                }

                override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) {
                    Log.w(TAG, "onFailure", t)
                    scheduleReconnect()
                }
            },
        )
    }

    private fun scheduleReconnect() {
        if (manualClosed) return
        handler.postDelayed({ if (!manualClosed) connect() }, RECONNECT_DELAY_MS)
    }

    fun dispose() {
        manualClosed = true
        handler.removeCallbacksAndMessages(null)
        socket?.cancel()
        socket = null
        client.dispatcher.executorService.shutdown()
    }

    companion object {
        private const val TAG = "TournamentSocket"
        private const val RECONNECT_DELAY_MS = 3_000L
    }
}
