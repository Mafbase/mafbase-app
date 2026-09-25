package com.example.mafbase_stream.pipeline

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.Surface
import android.view.View
import com.example.mafbase_stream.PhaseGate
import com.example.mafbase_stream.gl.Compositor
import com.example.mafbase_stream.overlay.OverlayCatalog
import com.example.mafbase_stream.overlay.OverlayDebugTarget
import com.example.mafbase_stream.overlay.OverlayParams
import com.example.mafbase_stream.overlay.OverlayViewRenderer

/**
 * Владеет [Compositor] и overlay-слоем поверх него.
 *
 * Camera2 пишет ровно в [cameraSurface], а Compositor рисует FBO (с overlay) в подключённые
 * output-окна: PREVIEW (SurfaceView activity), RECORD_ENCODER (Mp4Recorder.videoInputSurface),
 * STREAM_ENCODER (StreamSession.encoderSurface). Превью и хост overlay'я запоминаются и
 * переживают пересоздание компоситора при смене разрешения.
 */
internal class CompositorHost(
    private val appContext: Context,
    private val config: StreamPipeline.Config,
    private val phaseGate: PhaseGate,
) {

    private var compositor: Compositor? = null
    private var overlayRenderer: OverlayViewRenderer? = null
    private var overlayView: View? = null

    var overlayHost: Activity? = null
        private set

    var previewSurface: Surface? = null
        private set

    /** Меняется при создании и освобождении компоситора — отложенная работа узнаёт, что он уже другой. */
    var generation: Int = 0
        private set

    val isCreated: Boolean get() = compositor != null
    val cameraSurface: Surface? get() = compositor?.cameraSurface
    val overlayDebugTarget: OverlayDebugTarget? get() = overlayView as? OverlayDebugTarget

    /** Поднимает компоситор под размер кадра, подключает сохранённое превью и overlay. */
    fun create(width: Int, height: Int, rotationDegrees: Int) {
        val comp = Compositor(width, height, rotationDegrees).also {
            it.setListener(object : Compositor.Listener {
                override fun onError(t: Throwable) {
                    Log.e(TAG, "Compositor error", t)
                }
            })
            it.start()
        }
        compositor = comp
        generation++
        previewSurface?.let {
            comp.attachOutput(Compositor.OutputId.PREVIEW, it, needsPresentationTime = false)
        }
        attachOverlayIfNeeded(comp, width, height)
    }

    fun attachPreview(surface: Surface) {
        previewSurface = surface
        compositor?.attachOutput(Compositor.OutputId.PREVIEW, surface, needsPresentationTime = false)
    }

    /**
     * Отцепляет превью, только если подключено именно [surface]: старая activity может
     * получить onStop уже после того, как новая подключила своё.
     */
    fun detachPreview(surface: Surface) {
        if (previewSurface !== surface) return
        previewSurface = null
        compositor?.detachOutput(Compositor.OutputId.PREVIEW)
    }

    fun attachOutput(id: Compositor.OutputId, surface: Surface, needsPresentationTime: Boolean) {
        compositor?.attachOutput(id, surface, needsPresentationTime)
    }

    /** Блокирующий, как [Compositor.detachOutput]: после возврата в surface никто не рисует. */
    fun detachOutput(id: Compositor.OutputId) {
        compositor?.detachOutput(id)
    }

    fun setOverlayHost(activity: Activity) {
        overlayHost = activity
        overlayRenderer?.hostIn(activity)
    }

    fun clearOverlayHost(activity: Activity) {
        if (overlayHost !== activity) return
        overlayHost = null
        overlayRenderer?.unhost()
    }

    /** Освобождает overlay и компоситор; превью и хост overlay'я остаются для пересоздания. */
    fun release() {
        // Сначала overlay (он держит compositor через attach), потом сам compositor.
        try {
            overlayRenderer?.detach()
        } catch (e: Exception) {
            Log.w(TAG, "overlayRenderer.detach failed", e)
        }
        overlayRenderer = null
        overlayView = null

        try {
            compositor?.release()
        } catch (e: Exception) {
            Log.w(TAG, "compositor release failed", e)
        }
        if (compositor != null) generation++
        compositor = null
    }

    /** Забывает превью и хост overlay'я — при окончательном освобождении пайплайна. */
    fun clear() {
        previewSurface = null
        overlayHost = null
    }

    /**
     * Подключает overlay-вёрстку и/или brand-картинку к [comp]. Поднимается если
     * задан `overlayViewType` ИЛИ `brandImageUrl` — иначе overlay-слой не нужен.
     * Compose-контейнер живёт всю жизнь Compositor'а, поэтому виден в preview,
     * recording и стриме.
     */
    private fun attachOverlayIfNeeded(comp: Compositor, width: Int, height: Int) {
        val viewType = config.overlayViewType
        val brandUrl = config.brandImageUrl
        if (viewType == null && brandUrl.isNullOrBlank()) return
        Log.d(TAG, "attachOverlay: viewType=$viewType brand=$brandUrl frame=${width}x$height")
        val renderer = OverlayViewRenderer(width, height)
        val params = OverlayParams(
            tournamentId = config.overlayTournamentId,
            clubId = config.overlayClubId,
            table = config.overlayTable,
            phaseGate = phaseGate,
            breakPlaceholderImageUrl = config.breakPlaceholderImageUrl,
            brandImageUrl = brandUrl,
        )
        val view = OverlayCatalog.create(viewType, appContext, renderer, params)
        if (view == null) {
            Log.w(TAG, "Overlay '$viewType' not found in catalog and no brand image — running without overlay")
            return
        }
        renderer.setView(view)
        overlayHost?.let { renderer.hostIn(it) }
        renderer.attach(comp)
        overlayRenderer = renderer
        overlayView = view
    }

    companion object {
        private const val TAG = "CompositorHost"
    }
}
