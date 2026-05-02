package com.example.mafbase_stream.gl

import android.graphics.Bitmap
import android.graphics.SurfaceTexture
import android.opengl.EGL14
import android.opengl.EGLConfig
import android.opengl.EGLContext
import android.opengl.EGLDisplay
import android.opengl.EGLExt
import android.opengl.EGLSurface
import android.opengl.GLES20
import android.opengl.GLES30
import android.opengl.GLUtils
import android.opengl.Matrix
import android.os.Handler
import android.os.HandlerThread
import android.util.Log
import android.view.Surface
import java.nio.ByteBuffer
import java.nio.ByteOrder
import java.nio.FloatBuffer

/**
 * GL-композитор для пайплайна камера → multi-output.
 *
 * Camera2 пишет кадры в [cameraSurface] (внутри — [SurfaceTexture] на текстуре
 * `GL_TEXTURE_EXTERNAL_OES`). На каждом `onFrameAvailable`:
 *  1) updateTexImage() — забираем кадр в OES-текстуру;
 *  2) рисуем passthrough-шейдером в offscreen FBO (с обычной 2D-текстурой), сразу
 *     с поворотом UV под нужный экранный угол;
 *  3) если есть overlay — alpha-blend поверх FBO;
 *  4) для каждого подключённого output-окна (preview SurfaceView / recorder encoder /
 *     stream encoder) — рисуем FBO в это окно и делаем eglSwapBuffers.
 *
 * Подключать/отключать output'ы можно в любой момент через [attachOutput] / [detachOutput].
 * Encoder'ы (запись и стрим) дополнительно требуют `eglPresentationTimeANDROID` — для
 * них передаётся `needsPresentationTime = true`.
 *
 * Все GL-операции выполняются на собственном [HandlerThread]. Внешние вызовы безопасны
 * с любого потока.
 */
internal class Compositor(
    private val width: Int,
    private val height: Int,
    rotationDegrees: Int = 0,
) {
    interface Listener {
        fun onError(t: Throwable)
    }

    /** Идентификаторы output-окон. */
    enum class OutputId { PREVIEW, RECORD_ENCODER, STREAM_ENCODER }

    private data class OutputWindow(
        val eglSurface: EGLSurface,
        val needsPresentationTime: Boolean,
    )

    private var listener: Listener? = null

    private val thread = HandlerThread("MafbaseCompositor").apply { start() }
    private val handler = Handler(thread.looper)

    private var eglDisplay: EGLDisplay = EGL14.EGL_NO_DISPLAY
    private var eglContext: EGLContext = EGL14.EGL_NO_CONTEXT
    private var eglConfig: EGLConfig? = null

    // Offscreen pbuffer — нужен, чтобы установить контекст ещё до появления output'ов.
    private var pbufferSurface: EGLSurface = EGL14.EGL_NO_SURFACE

    // Подключённые output-окна. Доступ только с GL-потока.
    private val outputs = mutableMapOf<OutputId, OutputWindow>()

    private var oesTextureId = 0
    private var fboTextureId = 0
    private var fboId = 0

    // Overlay-текстура (RGBA), переиспользуется между кадрами. Аллоцируется при
    // первом вызове setOverlayBitmap, обновляется через glTexSubImage2D только
    // когда приходит новый Bitmap (т.е. по invalidate). drawFrame только биндит.
    private var overlayTextureId: Int = 0
    private var overlayWidth: Int = 0
    private var overlayHeight: Int = 0
    @Volatile private var overlayEnabled: Boolean = false

    private var oesProgram = 0
    private var fboProgram = 0

    private var oesAPos = 0
    private var oesATex = 0
    private var oesUTexMatrix = 0
    private var oesUSampler = 0

    private var fboAPos = 0
    private var fboATex = 0
    private var fboUSampler = 0
    private var fboUTexMatrix = 0

    private var quadVbo = 0
    private val texMatrix = FloatArray(16)
    private val rotationMatrix = FloatArray(16)
    private val combinedTexMatrix = FloatArray(16)
    private val identityTexMatrix = FloatArray(16)
    private val overlayTexMatrix = FloatArray(16)
    // Поворот кадра камеры вокруг центра UV (0.5, 0.5). Нормализуем угол к [0, 360).
    private val rotationDegrees: Int = ((rotationDegrees % 360) + 360) % 360

    private var surfaceTexture: SurfaceTexture? = null
    private var cameraSurfaceInternal: Surface? = null

    @Volatile private var pendingFrame = false

    /**
     * Surface для добавления в Camera2 capture session как target. Будет null, пока
     * не вызван [start].
     */
    val cameraSurface: Surface?
        get() = cameraSurfaceInternal

    fun setListener(listener: Listener?) {
        this.listener = listener
    }

    /**
     * Инициализирует EGL, создаёт OES-текстуру и SurfaceTexture для камеры.
     * Блокирующий вызов — возвращается, когда GL готов.
     */
    fun start() = runOnGlThreadBlocking {
        try {
            initEgl()
            makeCurrentPbuffer()
            initGlResources()
            createCameraSurfaceTexture()
        } catch (t: Throwable) {
            Log.e(TAG, "Compositor start failed", t)
            listener?.onError(t)
        }
    }

    /**
     * Подключает output-окно (preview / recorder encoder / stream encoder).
     * Если под этим [id] уже есть окно — оно сначала отключается.
     *
     * [needsPresentationTime] — для encoder'ов (MediaCodec ожидает PTS на каждом
     * фрейме); для preview SurfaceView не нужно.
     */
    fun attachOutput(id: OutputId, surface: Surface, needsPresentationTime: Boolean) = runOnGlThread {
        try {
            removeOutput(id)
            val attribs = intArrayOf(EGL14.EGL_NONE)
            val eglSurface = EGL14.eglCreateWindowSurface(eglDisplay, eglConfig, surface, attribs, 0)
            if (eglSurface == EGL14.EGL_NO_SURFACE) {
                checkEglError("eglCreateWindowSurface for $id")
                return@runOnGlThread
            }
            outputs[id] = OutputWindow(eglSurface, needsPresentationTime)
            Log.d(TAG, "attachOutput $id ok (presentationTime=$needsPresentationTime)")
        } catch (t: Throwable) {
            Log.e(TAG, "attachOutput $id failed", t)
            listener?.onError(t)
        }
    }

    /**
     * Отключает output-окно. Блокирующий — после возврата гарантированно не будет
     * eglSwapBuffers на этот surface (защита от race с уже-разрушенным BufferQueue).
     */
    fun detachOutput(id: OutputId) {
        runOnGlThreadBlocking {
            removeOutput(id)
        }
    }

    /**
     * Заливает указанный [bitmap] в overlay-текстуру. Можно вызывать с любого
     * потока — работа постится на GL-thread. Bitmap читается синхронно внутри
     * GL-thread; [onConsumed] вызывается на GL-потоке после завершения upload-а
     * (успех или ошибка) — caller может пометить bitmap свободным для следующей
     * перерисовки. Это позволяет caller-у держать пул bitmap'ов и избегать
     * race read/write на одном bitmap'е.
     */
    fun setOverlayBitmap(bitmap: Bitmap, onConsumed: (() -> Unit)? = null) {
        runOnGlThread {
            try {
                uploadOverlayBitmap(bitmap)
            } catch (t: Throwable) {
                Log.e(TAG, "setOverlayBitmap failed", t)
                listener?.onError(t)
            } finally {
                onConsumed?.invoke()
            }
        }
    }

    /** Отключает overlay и освобождает GL-текстуру. Можно вызывать с любого потока. */
    fun clearOverlay() {
        runOnGlThread {
            overlayEnabled = false
            if (overlayTextureId != 0) {
                GLES20.glDeleteTextures(1, intArrayOf(overlayTextureId), 0)
                overlayTextureId = 0
                overlayWidth = 0
                overlayHeight = 0
            }
        }
    }

    /** Останавливает GL-thread и освобождает все ресурсы. Блокирующий. */
    fun release() {
        runOnGlThreadBlocking {
            try {
                for (id in outputs.keys.toList()) removeOutput(id)
                releaseGlResources()
                releaseEgl()
                surfaceTexture?.release()
                cameraSurfaceInternal?.release()
                surfaceTexture = null
                cameraSurfaceInternal = null
            } catch (t: Throwable) {
                Log.w(TAG, "Compositor release error", t)
            }
        }
        thread.quitSafely()
        try {
            thread.join(500)
        } catch (e: InterruptedException) {
            Thread.currentThread().interrupt()
        }
    }

    // ---- GL thread ----------------------------------------------------------

    private fun removeOutput(id: OutputId) {
        outputs.remove(id)?.let {
            EGL14.eglDestroySurface(eglDisplay, it.eglSurface)
        }
    }

    private fun initEgl() {
        eglDisplay = EGL14.eglGetDisplay(EGL14.EGL_DEFAULT_DISPLAY)
        if (eglDisplay == EGL14.EGL_NO_DISPLAY) error("eglGetDisplay failed")
        val versions = IntArray(2)
        if (!EGL14.eglInitialize(eglDisplay, versions, 0, versions, 1)) {
            error("eglInitialize failed")
        }

        val configAttribs = intArrayOf(
            EGL14.EGL_RED_SIZE, 8,
            EGL14.EGL_GREEN_SIZE, 8,
            EGL14.EGL_BLUE_SIZE, 8,
            EGL14.EGL_ALPHA_SIZE, 8,
            EGL14.EGL_RENDERABLE_TYPE, EGLExt.EGL_OPENGL_ES3_BIT_KHR,
            EGL14.EGL_SURFACE_TYPE, EGL14.EGL_WINDOW_BIT or EGL14.EGL_PBUFFER_BIT,
            EGL14.EGL_NONE,
        )
        val configs = arrayOfNulls<EGLConfig>(1)
        val numConfigs = IntArray(1)
        if (!EGL14.eglChooseConfig(eglDisplay, configAttribs, 0, configs, 0, 1, numConfigs, 0) ||
            numConfigs[0] == 0
        ) {
            error("eglChooseConfig failed")
        }
        eglConfig = configs[0]

        val ctxAttribs = intArrayOf(EGL14.EGL_CONTEXT_CLIENT_VERSION, 3, EGL14.EGL_NONE)
        eglContext = EGL14.eglCreateContext(
            eglDisplay,
            eglConfig,
            EGL14.EGL_NO_CONTEXT,
            ctxAttribs,
            0,
        )
        checkEglError("eglCreateContext")

        // Маленький pbuffer на 1×1 — нужен только для makeCurrent когда нет ни одного output.
        val pbAttribs = intArrayOf(
            EGL14.EGL_WIDTH, 1,
            EGL14.EGL_HEIGHT, 1,
            EGL14.EGL_NONE,
        )
        pbufferSurface = EGL14.eglCreatePbufferSurface(eglDisplay, eglConfig, pbAttribs, 0)
        checkEglError("eglCreatePbufferSurface")
    }

    private fun makeCurrentPbuffer() {
        if (!EGL14.eglMakeCurrent(eglDisplay, pbufferSurface, pbufferSurface, eglContext)) {
            error("eglMakeCurrent (pbuffer) failed")
        }
    }

    private fun initGlResources() {
        oesProgram = buildProgram(VERTEX_SHADER, FRAGMENT_SHADER_OES)
        oesAPos = GLES20.glGetAttribLocation(oesProgram, "aPosition")
        oesATex = GLES20.glGetAttribLocation(oesProgram, "aTexCoord")
        oesUTexMatrix = GLES20.glGetUniformLocation(oesProgram, "uTexMatrix")
        oesUSampler = GLES20.glGetUniformLocation(oesProgram, "uSampler")

        fboProgram = buildProgram(VERTEX_SHADER_2D, FRAGMENT_SHADER_2D)
        fboAPos = GLES20.glGetAttribLocation(fboProgram, "aPosition")
        fboATex = GLES20.glGetAttribLocation(fboProgram, "aTexCoord")
        fboUSampler = GLES20.glGetUniformLocation(fboProgram, "uSampler")
        fboUTexMatrix = GLES20.glGetUniformLocation(fboProgram, "uTexMatrix")

        // Полноэкранный quad (NDC + texcoord).
        val quad = floatArrayOf(
            -1f, -1f, 0f, 0f,
            1f, -1f, 1f, 0f,
            -1f, 1f, 0f, 1f,
            1f, 1f, 1f, 1f,
        )
        val buf: FloatBuffer = ByteBuffer
            .allocateDirect(quad.size * 4)
            .order(ByteOrder.nativeOrder())
            .asFloatBuffer()
            .put(quad)
        buf.position(0)

        val ids = IntArray(1)
        GLES20.glGenBuffers(1, ids, 0)
        quadVbo = ids[0]
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, quadVbo)
        GLES20.glBufferData(GLES20.GL_ARRAY_BUFFER, quad.size * 4, buf, GLES20.GL_STATIC_DRAW)
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0)

        // OES external — для камеры.
        val texIds = IntArray(1)
        GLES20.glGenTextures(1, texIds, 0)
        oesTextureId = texIds[0]
        GLES20.glBindTexture(GL_TEXTURE_EXTERNAL_OES, oesTextureId)
        GLES20.glTexParameterf(GL_TEXTURE_EXTERNAL_OES, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_LINEAR.toFloat())
        GLES20.glTexParameterf(GL_TEXTURE_EXTERNAL_OES, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_LINEAR.toFloat())
        GLES20.glTexParameteri(GL_TEXTURE_EXTERNAL_OES, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE)
        GLES20.glTexParameteri(GL_TEXTURE_EXTERNAL_OES, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE)
        GLES20.glBindTexture(GL_TEXTURE_EXTERNAL_OES, 0)

        // 2D-текстура и FBO для offscreen-рендера.
        GLES20.glGenTextures(1, texIds, 0)
        fboTextureId = texIds[0]
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, fboTextureId)
        GLES20.glTexImage2D(
            GLES20.GL_TEXTURE_2D, 0, GLES20.GL_RGBA, width, height, 0,
            GLES20.GL_RGBA, GLES20.GL_UNSIGNED_BYTE, null,
        )
        GLES20.glTexParameterf(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_LINEAR.toFloat())
        GLES20.glTexParameterf(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_LINEAR.toFloat())
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE)
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE)
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, 0)

        val fbo = IntArray(1)
        GLES20.glGenFramebuffers(1, fbo, 0)
        fboId = fbo[0]
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, fboId)
        GLES20.glFramebufferTexture2D(
            GLES20.GL_FRAMEBUFFER,
            GLES20.GL_COLOR_ATTACHMENT0,
            GLES20.GL_TEXTURE_2D,
            fboTextureId,
            0,
        )
        val status = GLES20.glCheckFramebufferStatus(GLES20.GL_FRAMEBUFFER)
        if (status != GLES20.GL_FRAMEBUFFER_COMPLETE) {
            error("Framebuffer incomplete: $status")
        }
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, 0)
    }

    private fun createCameraSurfaceTexture() {
        val st = SurfaceTexture(oesTextureId).apply {
            setDefaultBufferSize(width, height)
            setOnFrameAvailableListener({ onFrameAvailable() }, handler)
        }
        surfaceTexture = st
        cameraSurfaceInternal = Surface(st)
    }

    private fun onFrameAvailable() {
        if (pendingFrame) return
        pendingFrame = true
        handler.post {
            pendingFrame = false
            try {
                drawFrame()
            } catch (t: Throwable) {
                Log.e(TAG, "drawFrame error", t)
                listener?.onError(t)
            }
        }
    }

    private fun drawFrame() {
        val st = surfaceTexture ?: return

        // 1) Забрать кадр в OES.
        st.updateTexImage()
        st.getTransformMatrix(texMatrix)
        // texMatrix * rotationMatrix: сначала поворачиваем UV, затем применяем
        // SurfaceTexture transform (его flip/crop). Порядок важен — Camera2 отдаёт
        // кадр в sensor-ориентации, и поворачивать нужно ДО SurfaceTexture-transform.
        Matrix.multiplyMM(combinedTexMatrix, 0, texMatrix, 0, rotationMatrix, 0)

        // 2) Нарисовать OES → FBO (passthrough).
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, fboId)
        GLES20.glViewport(0, 0, width, height)
        GLES20.glClearColor(0f, 0f, 0f, 1f)
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT)
        GLES20.glUseProgram(oesProgram)
        GLES20.glUniformMatrix4fv(oesUTexMatrix, 1, false, combinedTexMatrix, 0)
        GLES20.glActiveTexture(GLES20.GL_TEXTURE0)
        GLES20.glBindTexture(GL_TEXTURE_EXTERNAL_OES, oesTextureId)
        GLES20.glUniform1i(oesUSampler, 0)
        bindQuad(oesAPos, oesATex)
        GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, 4)
        unbindQuad(oesAPos, oesATex)

        // 2b) Если есть overlay — alpha-blend поверх FBO. Используем тот же 2D
        // passthrough-шейдер; источник альфы — сама overlay-текстура (RGBA от
        // Bitmap.ARGB_8888). По F3.8 — текстура переиспользуется, новых upload'ов
        // здесь нет (выполнялись в setOverlayBitmap).
        if (overlayEnabled && overlayTextureId != 0) {
            GLES20.glEnable(GLES20.GL_BLEND)
            // Bitmap.ARGB_8888 даёт non-premultiplied RGBA; используем стандартный
            // SRC_ALPHA / ONE_MINUS_SRC_ALPHA over-blend.
            GLES20.glBlendFunc(GLES20.GL_SRC_ALPHA, GLES20.GL_ONE_MINUS_SRC_ALPHA)
            GLES20.glUseProgram(fboProgram)
            // Android Bitmap row 0 — это top-of-image, а GL после GLUtils.texImage2D
            // мапит первый row в bottom of texture → получается V-flip. Компенсируем
            // через uTexMatrix, иначе overlay выходит перевёрнутым относительно кадра.
            GLES20.glUniformMatrix4fv(fboUTexMatrix, 1, false, overlayTexMatrix, 0)
            GLES20.glActiveTexture(GLES20.GL_TEXTURE0)
            GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, overlayTextureId)
            GLES20.glUniform1i(fboUSampler, 0)
            bindQuad(fboAPos, fboATex)
            GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, 4)
            unbindQuad(fboAPos, fboATex)
            GLES20.glDisable(GLES20.GL_BLEND)
        }

        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, 0)

        if (outputs.isEmpty()) return

        // 3) FBO → каждое подключённое output-окно.
        for ((id, output) in outputs) {
            if (!EGL14.eglMakeCurrent(eglDisplay, output.eglSurface, output.eglSurface, eglContext)) {
                Log.w(TAG, "eglMakeCurrent failed for $id")
                continue
            }
            GLES20.glViewport(0, 0, width, height)
            GLES20.glClearColor(0f, 0f, 0f, 1f)
            GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT)
            GLES20.glUseProgram(fboProgram)
            GLES20.glUniformMatrix4fv(fboUTexMatrix, 1, false, identityTexMatrix, 0)
            GLES20.glActiveTexture(GLES20.GL_TEXTURE0)
            GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, fboTextureId)
            GLES20.glUniform1i(fboUSampler, 0)
            bindQuad(fboAPos, fboATex)
            GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, 4)
            unbindQuad(fboAPos, fboATex)

            if (output.needsPresentationTime) {
                EGLExt.eglPresentationTimeANDROID(eglDisplay, output.eglSurface, st.timestamp)
            }
            if (!EGL14.eglSwapBuffers(eglDisplay, output.eglSurface)) {
                Log.w(TAG, "eglSwapBuffers failed for $id")
            }
        }

        // Возвращаем pbuffer, чтобы FBO-операции на следующей итерации работали без window.
        makeCurrentPbuffer()
    }

    private fun bindQuad(aPos: Int, aTex: Int) {
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, quadVbo)
        GLES20.glEnableVertexAttribArray(aPos)
        GLES20.glVertexAttribPointer(aPos, 2, GLES20.GL_FLOAT, false, 16, 0)
        GLES20.glEnableVertexAttribArray(aTex)
        GLES20.glVertexAttribPointer(aTex, 2, GLES20.GL_FLOAT, false, 16, 8)
    }

    private fun unbindQuad(aPos: Int, aTex: Int) {
        GLES20.glDisableVertexAttribArray(aPos)
        GLES20.glDisableVertexAttribArray(aTex)
        GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER, 0)
    }

    private fun releaseGlResources() {
        if (oesProgram != 0) GLES20.glDeleteProgram(oesProgram)
        if (fboProgram != 0) GLES20.glDeleteProgram(fboProgram)
        if (oesTextureId != 0) GLES20.glDeleteTextures(1, intArrayOf(oesTextureId), 0)
        if (fboTextureId != 0) GLES20.glDeleteTextures(1, intArrayOf(fboTextureId), 0)
        if (overlayTextureId != 0) GLES20.glDeleteTextures(1, intArrayOf(overlayTextureId), 0)
        if (fboId != 0) GLES20.glDeleteFramebuffers(1, intArrayOf(fboId), 0)
        if (quadVbo != 0) GLES20.glDeleteBuffers(1, intArrayOf(quadVbo), 0)
        oesProgram = 0; fboProgram = 0
        oesTextureId = 0; fboTextureId = 0; fboId = 0; quadVbo = 0
        overlayTextureId = 0; overlayWidth = 0; overlayHeight = 0
        overlayEnabled = false
    }

    private fun uploadOverlayBitmap(bitmap: Bitmap) {
        // Аллоцируем GL-текстуру при первом upload или при смене размера. На
        // последующих invalidate с тем же размером — glTexSubImage2D, без
        // переаллокации, чтобы драйверу было дешевле.
        val w = bitmap.width
        val h = bitmap.height
        if (overlayTextureId == 0 || overlayWidth != w || overlayHeight != h) {
            if (overlayTextureId == 0) {
                val ids = IntArray(1)
                GLES20.glGenTextures(1, ids, 0)
                overlayTextureId = ids[0]
            }
            GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, overlayTextureId)
            GLES20.glTexParameterf(
                GLES20.GL_TEXTURE_2D,
                GLES20.GL_TEXTURE_MIN_FILTER,
                GLES20.GL_LINEAR.toFloat(),
            )
            GLES20.glTexParameterf(
                GLES20.GL_TEXTURE_2D,
                GLES20.GL_TEXTURE_MAG_FILTER,
                GLES20.GL_LINEAR.toFloat(),
            )
            GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE)
            GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE)
            GLUtils.texImage2D(GLES20.GL_TEXTURE_2D, 0, bitmap, 0)
            overlayWidth = w
            overlayHeight = h
        } else {
            GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, overlayTextureId)
            GLUtils.texSubImage2D(GLES20.GL_TEXTURE_2D, 0, 0, 0, bitmap)
        }
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, 0)
        overlayEnabled = true
    }

    private fun releaseEgl() {
        if (eglDisplay != EGL14.EGL_NO_DISPLAY) {
            EGL14.eglMakeCurrent(
                eglDisplay,
                EGL14.EGL_NO_SURFACE,
                EGL14.EGL_NO_SURFACE,
                EGL14.EGL_NO_CONTEXT,
            )
            if (pbufferSurface != EGL14.EGL_NO_SURFACE) {
                EGL14.eglDestroySurface(eglDisplay, pbufferSurface)
            }
            if (eglContext != EGL14.EGL_NO_CONTEXT) {
                EGL14.eglDestroyContext(eglDisplay, eglContext)
            }
            EGL14.eglReleaseThread()
            EGL14.eglTerminate(eglDisplay)
        }
        eglDisplay = EGL14.EGL_NO_DISPLAY
        eglContext = EGL14.EGL_NO_CONTEXT
        eglConfig = null
        pbufferSurface = EGL14.EGL_NO_SURFACE
    }

    private fun runOnGlThread(block: () -> Unit) {
        if (Thread.currentThread() === thread) block() else handler.post(block)
    }

    private fun runOnGlThreadBlocking(block: () -> Unit) {
        if (Thread.currentThread() === thread) {
            block()
            return
        }
        val lock = Object()
        var done = false
        handler.post {
            try {
                block()
            } finally {
                synchronized(lock) {
                    done = true
                    lock.notifyAll()
                }
            }
        }
        synchronized(lock) {
            while (!done) {
                try {
                    lock.wait()
                } catch (e: InterruptedException) {
                    Thread.currentThread().interrupt()
                    return
                }
            }
        }
    }

    private fun checkEglError(op: String) {
        val err = EGL14.eglGetError()
        if (err != EGL14.EGL_SUCCESS) error("$op: EGL error 0x${Integer.toHexString(err)}")
    }

    private fun buildProgram(vertex: String, fragment: String): Int {
        val vs = compileShader(GLES20.GL_VERTEX_SHADER, vertex)
        val fs = compileShader(GLES20.GL_FRAGMENT_SHADER, fragment)
        val program = GLES20.glCreateProgram()
        GLES20.glAttachShader(program, vs)
        GLES20.glAttachShader(program, fs)
        GLES20.glLinkProgram(program)
        val link = IntArray(1)
        GLES20.glGetProgramiv(program, GLES20.GL_LINK_STATUS, link, 0)
        if (link[0] != GLES20.GL_TRUE) {
            val log = GLES20.glGetProgramInfoLog(program)
            GLES20.glDeleteProgram(program)
            error("Shader link failed: $log")
        }
        GLES20.glDeleteShader(vs)
        GLES20.glDeleteShader(fs)
        return program
    }

    private fun compileShader(type: Int, source: String): Int {
        val id = GLES20.glCreateShader(type)
        GLES20.glShaderSource(id, source)
        GLES20.glCompileShader(id)
        val status = IntArray(1)
        GLES20.glGetShaderiv(id, GLES20.GL_COMPILE_STATUS, status, 0)
        if (status[0] != GLES20.GL_TRUE) {
            val log = GLES20.glGetShaderInfoLog(id)
            GLES20.glDeleteShader(id)
            error("Shader compile failed: $log")
        }
        return id
    }

    init {
        Matrix.setIdentityM(texMatrix, 0)
        Matrix.setIdentityM(combinedTexMatrix, 0)
        Matrix.setIdentityM(identityTexMatrix, 0)
        // V-flip overlay UV вокруг центра (0.5, 0.5) — компенсирует row-order от
        // GLUtils.texImage2D(Bitmap).
        Matrix.setIdentityM(overlayTexMatrix, 0)
        Matrix.translateM(overlayTexMatrix, 0, 0.5f, 0.5f, 0f)
        Matrix.scaleM(overlayTexMatrix, 0, 1f, -1f, 1f)
        Matrix.translateM(overlayTexMatrix, 0, -0.5f, -0.5f, 0f)
        // Поворот вокруг центра UV (0.5, 0.5): translate → rotate → translate back.
        // Sensor Camera2 отдаёт кадр в "родной" sensor-ориентации; получившуюся UV-координату
        // мы вращаем перед сэмплированием, чтобы кадр в энкодере был в ожидаемой ориентации.
        Matrix.setIdentityM(rotationMatrix, 0)
        Matrix.translateM(rotationMatrix, 0, 0.5f, 0.5f, 0f)
        Matrix.rotateM(rotationMatrix, 0, this.rotationDegrees.toFloat(), 0f, 0f, 1f)
        Matrix.translateM(rotationMatrix, 0, -0.5f, -0.5f, 0f)
        // Гарантируем, что GLES30 классы тоже подгружены (используются константы).
        @Suppress("UNUSED_VARIABLE")
        val unused = GLES30.GL_TEXTURE_2D
    }

    companion object {
        private const val TAG = "Compositor"
        private const val GL_TEXTURE_EXTERNAL_OES = 0x8D65

        // OES external → 2D FBO.
        private val VERTEX_SHADER = """
            #version 300 es
            in vec2 aPosition;
            in vec2 aTexCoord;
            uniform mat4 uTexMatrix;
            out vec2 vTexCoord;
            void main() {
                gl_Position = vec4(aPosition, 0.0, 1.0);
                vTexCoord = (uTexMatrix * vec4(aTexCoord, 0.0, 1.0)).xy;
            }
        """.trimIndent()

        private val FRAGMENT_SHADER_OES = """
            #version 300 es
            #extension GL_OES_EGL_image_external_essl3 : require
            precision mediump float;
            uniform samplerExternalOES uSampler;
            in vec2 vTexCoord;
            out vec4 fragColor;
            void main() {
                fragColor = texture(uSampler, vTexCoord);
            }
        """.trimIndent()

        // FBO 2D-текстура → output window. uTexMatrix позволяет переиспользовать
        // программу и для overlay (V-flip для компенсации Bitmap-row-order), и для
        // FBO→output draw'а (identity).
        private val VERTEX_SHADER_2D = """
            #version 300 es
            in vec2 aPosition;
            in vec2 aTexCoord;
            uniform mat4 uTexMatrix;
            out vec2 vTexCoord;
            void main() {
                gl_Position = vec4(aPosition, 0.0, 1.0);
                vTexCoord = (uTexMatrix * vec4(aTexCoord, 0.0, 1.0)).xy;
            }
        """.trimIndent()

        private val FRAGMENT_SHADER_2D = """
            #version 300 es
            precision mediump float;
            uniform sampler2D uSampler;
            in vec2 vTexCoord;
            out vec4 fragColor;
            void main() {
                fragColor = texture(uSampler, vTexCoord);
            }
        """.trimIndent()
    }
}
