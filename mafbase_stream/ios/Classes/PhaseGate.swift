import Foundation

/// Шарится между overlay-слоем (writer) и audio-encoder'ом (reader).
///
/// Overlay подписан на `SeatingContent.broadcastPhase` через `TournamentContentSocket`
/// и выставляет `muted = true` для всех фаз кроме `day` (т.е. на ночь и перерыв).
/// Audio encoder читает флаг в `appendAudioSample` и зануляет PCM-данные перед
/// `AudioConverterFillComplexBuffer` — таким образом timing/PTS не теряются и
/// AV-sync не разъезжается.
///
/// Доступ конкурентный (overlay пишет с main, audio reader — с capture queue),
/// атомарность даёт `OSAtomic`-уровень через `os_unfair_lock`.
final class PhaseGate {
    private var _muted: Bool = false
    private var lock = os_unfair_lock()

    var muted: Bool {
        get {
            os_unfair_lock_lock(&lock)
            defer { os_unfair_lock_unlock(&lock) }
            return _muted
        }
        set {
            os_unfair_lock_lock(&lock)
            defer { os_unfair_lock_unlock(&lock) }
            _muted = newValue
        }
    }
}
