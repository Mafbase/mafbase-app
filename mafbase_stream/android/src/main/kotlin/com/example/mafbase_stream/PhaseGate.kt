package com.example.mafbase_stream

/**
 * Шарится между overlay-слоем (writer) и audio-pipeline'ом (reader).
 *
 * Overlay подписан на `SeatingContent.broadcastPhase` через `TournamentContentSocket`
 * и выставляет [muted] = true, когда фаза не `day` (т.е. ночь или перерыв). Audio
 * encoder читает флаг в capture-loop'е и заменяет PCM на тишину перед feed в
 * MediaCodec — таким образом timing/PTS не теряются и AV-sync не разъезжается.
 */
class PhaseGate {
    @Volatile
    var muted: Boolean = false
}
