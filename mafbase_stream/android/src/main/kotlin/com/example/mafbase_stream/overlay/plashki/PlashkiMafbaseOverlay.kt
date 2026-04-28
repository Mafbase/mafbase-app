package com.example.mafbase_stream.overlay.plashki

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import com.example.mafbase_stream.data.sockets.TournamentContentSocket
import com.example.mafbase_stream.overlay.OverlayParams

@Composable
internal fun PlashkiMafbaseOverlay(params: OverlayParams) {
    val tournamentId = params.tournamentId
    val table = params.table
    if (tournamentId == null || table == null) {
        Box(Modifier.fillMaxSize())
        return
    }

    val socket = remember(tournamentId, table) {
        TournamentContentSocket(tournamentId, table).also { it.connect() }
    }
    DisposableEffect(socket) {
        onDispose { socket.dispose() }
    }
    val content by socket.state.collectAsState()
    content?.let { MafbaseContent(it, modifier = Modifier.fillMaxSize()) }
}
