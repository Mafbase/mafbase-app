package com.example.mafbase_stream.overlay

import android.app.Activity
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.PorterDuff
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.View
import android.view.ViewGroup
import com.example.mafbase_stream.gl.Compositor
import java.util.concurrent.atomic.AtomicBoolean

/**
 * Снимает Android-View в Bitmap и заливает его в Compositor как overlay-текстуру.
 *
 * Сам реализует [OverlayInvalidator] — overlay получает экземпляр renderer'а
 * как invalidator при создании через [OverlayCatalog] и дёргает [invalidate]
 * на любые изменения content'а view.
 *
 * Поток работы:
 *  1. Конструктор + [setView] — приложение создаёт view и привязывает её к renderer.
 *  2. [hostIn] — прячет view в окно activity: без window-attach `View.invalidate()`
 *     no-op'ится, и Compose-overlay не сообщал бы об изменениях. Activity может
 *     смениться ([unhost] + [hostIn] новой) — пайплайн при этом живёт дальше.
 *  3. [attach] — измеряет/layout-ит view под размер кадра, делает первый снимок и
 *     сразу заливает в Compositor (чтобы первый кадр стрима уже шёл с оверлеем).
 *  4. View вызывает [invalidate] при любом изменении содержимого. Renderer
 *     ре-рендерит view в свободный bitmap из пула и отдаёт его компоситору.
 *     В простое вызовов нет — Compositor переиспользует прошлую текстуру (F3.8 BRD).
 *     Пока view не захощена ни в одном окне, инвалидации теряются; следующий
 *     [hostIn] делает свежий снимок.
 *  5. [detach] — снимает overlay в Compositor, освобождает Bitmap'ы и Compose-окружение.
 *
 * Двойная буферизация: чтобы не было race между `view.draw(Canvas)` на main-потоке
 * и `glTexSubImage2D(bitmap)` на GL-потоке (последний читает тот же буфер
 * синхронно, и если main за это время успел сделать `drawColor` следующего кадра —
 * GL прочитает полу-нарисованное), держим пул из двух bitmap'ов. Main рисует в
 * свободный, передаёт его в Compositor с `onConsumed`-callback'ом, который
 * помечает bitmap свободным после завершения upload-а на GL-потоке. Если оба
 * заняты (GL не успевает) — текущий invalidate дропается; следующий vsync вызовет
 * новый.
 *
 * Дедупликация invalidate: множество вызовов от Compose внутри одного vsync
 * компрессируются в один snapshot через [pendingInvalidate]. Без этого
 * `onDescendantInvalidated` накидывает на main-handler по нескольку Runnable'ов
 * за тик, перегружая главный поток (`v.draw(cv)` — 2-5мс) и приводя к jank'у.
 */
internal class OverlayViewRenderer(
    private val width: Int,
    private val height: Int,
) : OverlayInvalidator {

    private val mainHandler = Handler(Looper.getMainLooper())
    private var view: View? = null
    private var compositor: Compositor? = null

    private val bitmaps = arrayOfNulls<Bitmap>(BUFFER_COUNT)
    private val canvases = arrayOfNulls<Canvas>(BUFFER_COUNT)
    private val bitmapBusy = BooleanArray(BUFFER_COUNT)
    private val poolLock = Any()

    private val pendingInvalidate = AtomicBoolean(false)

    private var attached: Boolean = false
    private var hostDecor: ViewGroup? = null

    fun setView(view: View) {
        this.view = view
    }

    /**
     * Прячет view невидимо в `decorView` активити: `alpha = 0` + сдвиг за экран.
     * `view.draw(canvas)` всё равно рисует реальный контент в наш bitmap. Если
     * overlay уже подключён к Compositor — сразу делает свежий снимок.
     */
    fun hostIn(activity: Activity) {
        runOnMain {
            val v = view ?: return@runOnMain
            val decor = activity.window.decorView as? ViewGroup ?: return@runOnMain
            if (v.parent === decor) return@runOnMain
            unhostNow(v)
            v.alpha = 0f
            v.translationX = -(width.toFloat() * 4f)
            decor.addView(v, ViewGroup.LayoutParams(width, height))
            hostDecor = decor
            if (attached) {
                try {
                    measureAndLayout(v)
                    refreshLocked()
                } catch (t: Throwable) {
                    Log.e(TAG, "OverlayViewRenderer rehost refresh failed", t)
                }
            }
        }
    }

    fun unhost() {
        runOnMain { view?.let { unhostNow(it) } }
    }

    fun attach(compositor: Compositor) {
        this.compositor = compositor
        runOnMain {
            if (attached) return@runOnMain
            val v = view ?: run {
                Log.w(TAG, "attach without view")
                return@runOnMain
            }
            attached = true
            try {
                v.setBackgroundColor(Color.TRANSPARENT)
                measureAndLayout(v)
                for (i in 0 until BUFFER_COUNT) {
                    val bm = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
                    bitmaps[i] = bm
                    canvases[i] = Canvas(bm)
                    bitmapBusy[i] = false
                }
                refreshLocked()
            } catch (t: Throwable) {
                Log.e(TAG, "OverlayViewRenderer attach failed", t)
            }
        }
    }

    fun detach() {
        runOnMain {
            if (attached) {
                attached = false
                compositor?.clearOverlay()
                compositor = null
                synchronized(poolLock) {
                    for (i in 0 until BUFFER_COUNT) {
                        bitmaps[i]?.recycle()
                        bitmaps[i] = null
                        canvases[i] = null
                        bitmapBusy[i] = false
                    }
                }
            }
            view?.let {
                unhostNow(it)
                (it as? OverlayComposeContainer)?.dispose()
            }
        }
    }

    private fun unhostNow(v: View) {
        val decor = hostDecor ?: return
        hostDecor = null
        if (v.parent === decor) decor.removeView(v)
    }

    private fun measureAndLayout(v: View) {
        val widthSpec = View.MeasureSpec.makeMeasureSpec(width, View.MeasureSpec.EXACTLY)
        val heightSpec = View.MeasureSpec.makeMeasureSpec(height, View.MeasureSpec.EXACTLY)
        v.measure(widthSpec, heightSpec)
        v.layout(0, 0, width, height)
    }

    override fun invalidate() {
        // Дедуп: если уже есть pending Runnable — игнорируем. Compose может
        // вызвать onDescendantInvalidated несколько раз за vsync.
        //
        // Постим всегда через handler, даже если уже на main: Compose дёргает
        // `View.invalidate()` прямо изнутри своего `dispatchDraw` (например,
        // GraphicsLayerOwnerLayer.resize при изменении layer-bounds), а мы в этот
        // момент находимся внутри `v.draw(cv)`. Реентрантный `refreshLocked`
        // запустит второй `v.draw` поверх первого → "performMeasureAndLayout
        // called during measure layout" + tearing. Откладываем на следующий tick
        // main looper'а, где предыдущий draw уже завершён.
        if (!pendingInvalidate.compareAndSet(false, true)) return
        mainHandler.post {
            pendingInvalidate.set(false)
            if (!attached) return@post
            try {
                refreshLocked()
            } catch (t: Throwable) {
                Log.e(TAG, "OverlayViewRenderer refresh failed", t)
            }
        }
    }

    private fun refreshLocked() {
        val v = view ?: return
        val compositor = compositor ?: return
        val index = acquireFreeBitmapIndex() ?: return
        val bm = bitmaps[index] ?: run {
            releaseBitmap(index)
            return
        }
        val cv = canvases[index] ?: run {
            releaseBitmap(index)
            return
        }
        cv.drawColor(Color.TRANSPARENT, PorterDuff.Mode.CLEAR)
        v.draw(cv)
        compositor.setOverlayBitmap(bm) { releaseBitmap(index) }
    }

    private fun acquireFreeBitmapIndex(): Int? {
        synchronized(poolLock) {
            for (i in 0 until BUFFER_COUNT) {
                if (!bitmapBusy[i] && bitmaps[i] != null) {
                    bitmapBusy[i] = true
                    return i
                }
            }
        }
        return null
    }

    private fun releaseBitmap(index: Int) {
        synchronized(poolLock) {
            bitmapBusy[index] = false
        }
    }

    private fun runOnMain(block: () -> Unit) {
        if (Looper.myLooper() == Looper.getMainLooper()) block() else mainHandler.post(block)
    }

    companion object {
        private const val TAG = "OverlayViewRenderer"
        private const val BUFFER_COUNT = 2
    }
}
