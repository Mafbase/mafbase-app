package com.example.mafbase_stream.overlay.plashki

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import android.util.Log
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import coil3.compose.AsyncImage
import coil3.request.ImageRequest
import coil3.request.allowHardware
import com.example.mafbase_stream.data.sockets.ClubContentSocket
import com.example.mafbase_stream.data.sockets.TournamentContentSocket
import com.example.mafbase_stream.overlay.OverlayParams
import generated.Mafia

@Composable
internal fun PlashkiMafbaseOverlay(params: OverlayParams) {
    val table = params.table
    val tournamentId = params.tournamentId
    val clubId = params.clubId
    if (table == null || (tournamentId == null && clubId == null)) {
        Box(Modifier.fillMaxSize())
        return
    }

    // Используем клубный сокет если задан clubId, иначе турнирный
    val content by if (clubId != null) {
        val socket = remember(clubId, table) {
            ClubContentSocket(clubId, table).also { it.connect() }
        }
        DisposableEffect(socket) {
            onDispose { socket.dispose() }
        }
        socket.state.collectAsState()
    } else {
        val socket = remember(tournamentId, table) {
            TournamentContentSocket(tournamentId!!, table).also { it.connect() }
        }
        DisposableEffect(socket) {
            onDispose { socket.dispose() }
        }
        socket.state.collectAsState()
    }
    val phase = content?.broadcastPhase

    // Mute audio во всех фазах кроме `day`. Reset на dispose, чтобы между
    // сессиями mute не "залипал".
    LaunchedEffect(phase) {
        Log.d("Plashki", "phase=$phase breakUrl=${params.breakPlaceholderImageUrl}")
        params.phaseGate?.muted = phase != null && phase != Mafia.BroadcastPhase.day
    }
    DisposableEffect(params.phaseGate) {
        onDispose { params.phaseGate?.muted = false }
    }

    Box(modifier = Modifier.fillMaxSize()) {
        content?.let { MafbaseContent(it, modifier = Modifier.fillMaxSize()) }
        if (phase == Mafia.BroadcastPhase.break_phase) {
            BreakPlaceholder(imageUrl = params.breakPlaceholderImageUrl)
        }
    }
}

/**
 * Полноэкранная заглушка на фазе перерыва. Если задан URL — показываем
 * картинку поверх (alpha-blend с непрозрачным фоном гарантирует, что камера
 * полностью скрыта). Без URL — просто тёмный экран.
 */
@Composable
private fun BreakPlaceholder(imageUrl: String?) {
    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.Black),
    ) {
        if (!imageUrl.isNullOrBlank()) {
            val context = LocalContext.current
            AsyncImage(
                model = ImageRequest.Builder(context)
                    .data(imageUrl)
                    .allowHardware(false)
                    .listener(
                        onStart = { Log.d("Plashki", "break placeholder load start: $imageUrl") },
                        onSuccess = { _, result ->
                            Log.d(
                                "Plashki",
                                "break placeholder load success (${result.image.width}x${result.image.height})",
                            )
                        },
                        onError = { _, result ->
                            Log.w("Plashki", "break placeholder load error: ${result.throwable}")
                        },
                    )
                    .build(),
                contentDescription = null,
                modifier = Modifier.fillMaxSize(),
                contentScale = ContentScale.Fit,
            )
        }
    }
}
