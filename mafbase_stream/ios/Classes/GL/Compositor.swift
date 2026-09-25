import CoreMedia
import CoreVideo
import Foundation
import OpenGLES
import OpenGLES.ES3

/// GL ES 3.0 passthrough-композитор кадров камеры.
///
/// Принимает `CVPixelBuffer` (BGRA от `AVCaptureVideoDataOutput`), заворачивает его
/// в GL-текстуру через `CVOpenGLESTextureCache`, рисует full-screen quad в offscreen
/// FBO, привязанный к output `CVPixelBuffer` из `CVPixelBufferPool`. На выходе —
/// готовый `CVPixelBuffer` для VideoToolbox/AVAssetWriter.
///
/// Сейчас shader — passthrough; точка расширения для оверлея в задаче 10
/// (рисуем плашки тем же FBO поверх кадра).
///
/// Режим заглушки: пока камеры нет (фон, звонок, чужое приложение), кадр «последний кадр
/// камеры + overlay + карточка паузы» рендерится один раз, пока GL ещё разрешён, и дальше
/// повторяется таймером 2 fps без единого GL-вызова — в фоне iOS убивает процесс за любой из них.
///
/// Жизненный цикл:
///  1. `prepare()` (sync) — создаёт EAGL context, текстурные кэши, pool, шейдер.
///  2. `processFrame(pixelBuffer:pts:)` (async на собственном serial queue).
///  3. `release()` (sync) — освобождает GL-ресурсы.
final class Compositor {

    enum CompositorError: Error {
        case eaglContext
        case textureCache(CVReturn)
        case bufferPool(CVReturn)
        case shaderCompile(String)
        case programLink(String)
        case framebufferIncomplete(GLenum)
    }

    private static let placeholderInterval: DispatchTimeInterval = .milliseconds(500)

    private let width: Int
    private let height: Int

    private var context: EAGLContext?
    private var inputTextureCache: CVOpenGLESTextureCache?
    private var outputTextureCache: CVOpenGLESTextureCache?
    private var bufferPool: CVPixelBufferPool?

    private var program: GLuint = 0
    private var fbo: GLuint = 0
    private var vertexVbo: GLuint = 0
    private var positionAttr: GLint = -1
    private var texCoordAttr: GLint = -1
    private var textureUniform: GLint = -1

    private let renderQueue = DispatchQueue(label: "com.example.mafbase_stream.compositor")
    private var prepared = false

    // Overlay-текстура (CVOpenGLESTexture, обёрнутая поверх входящего CVPixelBuffer).
    // Кеш: пересоздаётся только при смене pixel buffer, в drawFrame только bind.
    private var overlayTextureCache: CVOpenGLESTextureCache?
    private var overlayTexture: CVOpenGLESTexture?
    private var overlayPixelBuffer: CVPixelBuffer?
    private var overlayEnabled = false
    /// Overlay, пришедший при приостановленном рендере — заливается в GL при возобновлении.
    private var pendingOverlayPixelBuffer: CVPixelBuffer?

    // Карточка паузы: своя текстура, создаётся лениво при первом рендере заглушки.
    private var cardTextureCache: CVOpenGLESTextureCache?
    private var cardTexture: CVOpenGLESTexture?
    private var cardPixelBuffer: CVPixelBuffer?

    private var lastInputBuffer: CVPixelBuffer?
    private var lastOutputBuffer: CVPixelBuffer?
    private var placeholderBuffer: CVPixelBuffer?
    private var placeholderMode = false
    private var placeholderTimer: DispatchSourceTimer?
    private var renderingSuspended = false

    /// Колбэк выполняется на `renderQueue`. Pixel buffer допустимо удерживать
    /// сколь угодно долго — он взят из CVPixelBufferPool и автоматически
    /// возвращается в pool при release'е CVPixelBuffer.
    var onFrame: ((CVPixelBuffer, CMTime) -> Void)?
    var onError: ((Error) -> Void)?
    /// Часы для PTS кадров заглушки — те же, которыми capture session штампует кадры камеры.
    var clock: () -> CMTime = { CMClockGetTime(CMClockGetHostTimeClock()) }

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    func prepare() throws {
        var prepareError: Error?
        renderQueue.sync {
            do {
                try self.prepareOnQueue()
            } catch {
                prepareError = error
            }
        }
        if let err = prepareError { throw err }
    }

    private func prepareOnQueue() throws {
        guard let ctx = EAGLContext(api: .openGLES3) ?? EAGLContext(api: .openGLES2) else {
            throw CompositorError.eaglContext
        }
        EAGLContext.setCurrent(ctx)
        context = ctx

        inputTextureCache = try makeTextureCache(ctx)
        outputTextureCache = try makeTextureCache(ctx)
        overlayTextureCache = try makeTextureCache(ctx)
        cardTextureCache = try makeTextureCache(ctx)

        let poolAttrs: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA,
            kCVPixelBufferWidthKey as String: width,
            kCVPixelBufferHeightKey as String: height,
            kCVPixelBufferIOSurfacePropertiesKey as String: [:],
            kCVPixelBufferOpenGLESCompatibilityKey as String: true,
        ]
        var pool: CVPixelBufferPool?
        let poolRet = CVPixelBufferPoolCreate(kCFAllocatorDefault, nil, poolAttrs as CFDictionary, &pool)
        guard poolRet == kCVReturnSuccess, let p = pool else {
            throw CompositorError.bufferPool(poolRet)
        }
        bufferPool = p

        try buildProgram()

        glGenFramebuffers(1, &fbo)
        prepared = true
    }

    private func makeTextureCache(_ ctx: EAGLContext) throws -> CVOpenGLESTextureCache {
        var cache: CVOpenGLESTextureCache?
        let ret = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, nil, ctx, nil, &cache)
        guard ret == kCVReturnSuccess, let created = cache else {
            throw CompositorError.textureCache(ret)
        }
        return created
    }

    private func buildProgram() throws {
        let vsSrc = """
        attribute vec4 a_position;
        attribute vec2 a_texCoord;
        varying vec2 v_texCoord;
        void main() {
            gl_Position = a_position;
            v_texCoord = a_texCoord;
        }
        """
        let fsSrc = """
        precision mediump float;
        varying vec2 v_texCoord;
        uniform sampler2D u_texture;
        void main() {
            gl_FragColor = texture2D(u_texture, v_texCoord);
        }
        """
        let vs = try compileShader(GLenum(GL_VERTEX_SHADER), source: vsSrc)
        let fs = try compileShader(GLenum(GL_FRAGMENT_SHADER), source: fsSrc)
        let prog = glCreateProgram()
        glAttachShader(prog, vs)
        glAttachShader(prog, fs)
        glLinkProgram(prog)

        var status: GLint = 0
        glGetProgramiv(prog, GLenum(GL_LINK_STATUS), &status)
        if status == 0 {
            var len: GLint = 0
            glGetProgramiv(prog, GLenum(GL_INFO_LOG_LENGTH), &len)
            var buf = [GLchar](repeating: 0, count: max(1, Int(len)))
            glGetProgramInfoLog(prog, len, nil, &buf)
            glDeleteProgram(prog)
            throw CompositorError.programLink(String(cString: buf))
        }
        glDeleteShader(vs)
        glDeleteShader(fs)
        program = prog

        positionAttr = glGetAttribLocation(prog, "a_position")
        texCoordAttr = glGetAttribLocation(prog, "a_texCoord")
        textureUniform = glGetUniformLocation(prog, "u_texture")

        // Full-screen quad TRIANGLE_STRIP. И вход (camera CVPixelBuffer), и выход
        // (CVPixelBufferPool) обёрнуты через CVOpenGLESTextureCache — Apple сам
        // согласует CV/GL origin'ы для обеих сторон. Поэтому UV-координаты —
        // прямые, без vertical flip; иначе output получится перевёрнутым по
        // вертикали (Mp4Recorder этого не видит, т.к. кодирует сырой кадр без
        // композитора, а на RTMP идёт именно output композитора).
        let vertices: [GLfloat] = [
            -1, -1, 0, 0,
             1, -1, 1, 0,
            -1,  1, 0, 1,
             1,  1, 1, 1,
        ]
        glGenBuffers(1, &vertexVbo)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexVbo)
        vertices.withUnsafeBytes { raw in
            glBufferData(
                GLenum(GL_ARRAY_BUFFER),
                vertices.count * MemoryLayout<GLfloat>.size,
                raw.baseAddress,
                GLenum(GL_STATIC_DRAW)
            )
        }
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
    }

    private func compileShader(_ type: GLenum, source: String) throws -> GLuint {
        let shader = glCreateShader(type)
        var status: GLint = 0
        try source.withCString { (cstr: UnsafePointer<CChar>) in
            var ptr: UnsafePointer<GLchar>? = cstr
            glShaderSource(shader, 1, &ptr, nil)
            glCompileShader(shader)
            glGetShaderiv(shader, GLenum(GL_COMPILE_STATUS), &status)
            if status == 0 {
                var len: GLint = 0
                glGetShaderiv(shader, GLenum(GL_INFO_LOG_LENGTH), &len)
                var buf = [GLchar](repeating: 0, count: max(1, Int(len)))
                glGetShaderInfoLog(shader, len, nil, &buf)
                glDeleteShader(shader)
                throw CompositorError.shaderCompile(String(cString: buf))
            }
        }
        return shader
    }

    // MARK: - Frames

    /// Async: рендер выполняется на собственной очереди, output отдаётся через `onFrame`.
    /// При приостановленном рендере и в режиме заглушки кадр только запоминается.
    func processFrame(pixelBuffer: CVPixelBuffer, pts: CMTime) {
        renderQueue.async { [weak self] in
            guard let self = self else { return }
            self.lastInputBuffer = pixelBuffer
            guard !self.renderingSuspended, !self.placeholderMode else { return }
            self.renderOnQueue(pixelBuffer: pixelBuffer, pts: pts)
        }
    }

    /// Заливает указанный [pixelBuffer] (BGRA premultiplied) в overlay-текстуру.
    /// Можно вызывать с любого потока — работа постится на render queue. Вызывается
    /// только при invalidate содержимого view (см. F3.8 BRD); в простое compositor
    /// переиспользует прошлую обёрнутую CVOpenGLESTexture.
    func setOverlayBitmap(_ pixelBuffer: CVPixelBuffer) {
        renderQueue.async { [weak self] in
            self?.uploadOverlayPixelBuffer(pixelBuffer)
        }
    }

    /// Отключает overlay и освобождает обёрнутую GL-текстуру.
    func clearOverlay() {
        renderQueue.async { [weak self] in
            guard let self = self else { return }
            self.overlayEnabled = false
            self.overlayTexture = nil
            self.overlayPixelBuffer = nil
            self.pendingOverlayPixelBuffer = nil
            if !self.renderingSuspended, let cache = self.overlayTextureCache {
                CVOpenGLESTextureCacheFlush(cache, 0)
            }
        }
    }

    /// Карточка «Трансляция на паузе» (BGRA premultiplied размера кадра) — рисуется поверх
    /// overlay только в кадре заглушки. `nil` убирает карточку.
    func setPlaceholderCard(_ pixelBuffer: CVPixelBuffer?) {
        renderQueue.async { [weak self] in
            guard let self = self else { return }
            self.cardPixelBuffer = pixelBuffer
            self.cardTexture = nil
        }
    }

    // MARK: - Placeholder mode

    /// Sync: пока GL ещё разрешён, рендерит и кеширует кадр заглушки
    /// (последний кадр камеры + overlay + карточка) для `enterPlaceholderMode()`.
    func prepareForBackground() {
        renderQueue.sync {
            guard !renderingSuspended, let input = lastInputBuffer else { return }
            placeholderBuffer = drawFrame(input: input, withCard: true)
            glFinish()
        }
    }

    /// Пока режим включён, таймер 2 fps отдаёт в `onFrame` кадр заглушки (или последний
    /// выходной кадр, если заглушку отрендерить было нельзя) с PTS от `clock`, без GL.
    /// Кадры камеры в это время только обновляют последний входной кадр. Идемпотентно.
    func enterPlaceholderMode() {
        renderQueue.async { [weak self] in
            guard let self = self, !self.placeholderMode else { return }
            self.placeholderMode = true
            if !self.renderingSuspended, let input = self.lastInputBuffer {
                self.placeholderBuffer = self.drawFrame(input: input, withCard: true)
            }
            NSLog(
                "[mafbase_stream] placeholder mode on (card=\(self.placeholderBuffer != nil) fallback=\(self.lastOutputBuffer != nil))"
            )
            let timer = DispatchSource.makeTimerSource(queue: self.renderQueue)
            timer.schedule(deadline: .now(), repeating: Self.placeholderInterval)
            timer.setEventHandler { [weak self] in self?.emitPlaceholderFrame() }
            timer.resume()
            self.placeholderTimer = timer
        }
    }

    func exitPlaceholderMode() {
        renderQueue.async { [weak self] in
            guard let self = self else { return }
            self.placeholderBuffer = nil
            guard self.placeholderMode else { return }
            self.placeholderMode = false
            self.placeholderTimer?.cancel()
            self.placeholderTimer = nil
            NSLog("[mafbase_stream] placeholder mode off")
        }
    }

    /// Sync: дожидается GPU и запрещает GL до `resumeRendering()` — в фоне iOS убивает
    /// процесс за любой GL-вызов.
    func suspendRendering() {
        renderQueue.sync {
            guard !renderingSuspended else { return }
            renderingSuspended = true
            if let ctx = context {
                EAGLContext.setCurrent(ctx)
                glFinish()
            }
        }
    }

    func resumeRendering() {
        renderQueue.async { [weak self] in
            guard let self = self, self.renderingSuspended else { return }
            self.renderingSuspended = false
            if let pending = self.pendingOverlayPixelBuffer {
                self.pendingOverlayPixelBuffer = nil
                self.uploadOverlayPixelBuffer(pending)
            }
        }
    }

    private func emitPlaceholderFrame() {
        guard placeholderMode, let buffer = placeholderBuffer ?? lastOutputBuffer else { return }
        onFrame?(buffer, clock())
    }

    // MARK: - Rendering (render queue, GL allowed)

    private func uploadOverlayPixelBuffer(_ pixelBuffer: CVPixelBuffer) {
        guard prepared, let ctx = context, let cache = overlayTextureCache else { return }
        if renderingSuspended {
            pendingOverlayPixelBuffer = pixelBuffer
            return
        }
        EAGLContext.setCurrent(ctx)
        do {
            overlayTexture = try makeTexture(from: pixelBuffer, cache: cache)
        } catch {
            onError?(error)
            return
        }
        overlayPixelBuffer = pixelBuffer
        overlayEnabled = true
    }

    private func cardTextureIfAvailable() -> CVOpenGLESTexture? {
        if let texture = cardTexture { return texture }
        guard let pixelBuffer = cardPixelBuffer, let cache = cardTextureCache else { return nil }
        CVOpenGLESTextureCacheFlush(cache, 0)
        do {
            let texture = try makeTexture(from: pixelBuffer, cache: cache)
            cardTexture = texture
            return texture
        } catch {
            onError?(error)
            return nil
        }
    }

    /// Оборачивает BGRA pixel buffer в GL-текстуру через кэш. Параметры сэмплирования —
    /// состояние текстуры, поэтому выставляются один раз здесь.
    private func makeTexture(from pixelBuffer: CVPixelBuffer, cache: CVOpenGLESTextureCache) throws -> CVOpenGLESTexture {
        var texture: CVOpenGLESTexture?
        let ret = CVOpenGLESTextureCacheCreateTextureFromImage(
            kCFAllocatorDefault,
            cache,
            pixelBuffer,
            nil,
            GLenum(GL_TEXTURE_2D),
            GLint(GL_RGBA),
            GLsizei(CVPixelBufferGetWidth(pixelBuffer)),
            GLsizei(CVPixelBufferGetHeight(pixelBuffer)),
            GLenum(GL_BGRA),
            GLenum(GL_UNSIGNED_BYTE),
            0,
            &texture
        )
        guard ret == kCVReturnSuccess, let tex = texture else {
            throw CompositorError.textureCache(ret)
        }
        glBindTexture(CVOpenGLESTextureGetTarget(tex), CVOpenGLESTextureGetName(tex))
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GL_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_S), GL_CLAMP_TO_EDGE)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_T), GL_CLAMP_TO_EDGE)
        glBindTexture(CVOpenGLESTextureGetTarget(tex), 0)
        return tex
    }

    private func renderOnQueue(pixelBuffer: CVPixelBuffer, pts: CMTime) {
        guard let outBuf = drawFrame(input: pixelBuffer, withCard: false) else { return }
        lastOutputBuffer = outBuf
        onFrame?(outBuf, pts)
    }

    /// Рисует кадр в новый буфер из пула: камера, поверх — overlay и (для заглушки) карточка.
    private func drawFrame(input pixelBuffer: CVPixelBuffer, withCard: Bool) -> CVPixelBuffer? {
        guard prepared,
              let ctx = context,
              let ic = inputTextureCache,
              let oc = outputTextureCache,
              let pool = bufferPool else { return nil }

        EAGLContext.setCurrent(ctx)

        let inTex: CVOpenGLESTexture
        do {
            inTex = try makeTexture(from: pixelBuffer, cache: ic)
        } catch {
            onError?(error)
            return nil
        }

        var outputBuffer: CVPixelBuffer?
        let poolRet = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, pool, &outputBuffer)
        guard poolRet == kCVReturnSuccess, let outBuf = outputBuffer else {
            onError?(CompositorError.bufferPool(poolRet))
            return nil
        }

        var outputTexture: CVOpenGLESTexture?
        let outRet = CVOpenGLESTextureCacheCreateTextureFromImage(
            kCFAllocatorDefault,
            oc,
            outBuf,
            nil,
            GLenum(GL_TEXTURE_2D),
            GLint(GL_RGBA),
            GLsizei(width),
            GLsizei(height),
            GLenum(GL_BGRA),
            GLenum(GL_UNSIGNED_BYTE),
            0,
            &outputTexture
        )
        guard outRet == kCVReturnSuccess, let outTex = outputTexture else {
            onError?(CompositorError.textureCache(outRet))
            return nil
        }

        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), fbo)
        glFramebufferTexture2D(
            GLenum(GL_FRAMEBUFFER),
            GLenum(GL_COLOR_ATTACHMENT0),
            CVOpenGLESTextureGetTarget(outTex),
            CVOpenGLESTextureGetName(outTex),
            0
        )
        let status = glCheckFramebufferStatus(GLenum(GL_FRAMEBUFFER))
        if status != GLenum(GL_FRAMEBUFFER_COMPLETE) {
            onError?(CompositorError.framebufferIncomplete(status))
            glBindFramebuffer(GLenum(GL_FRAMEBUFFER), 0)
            return nil
        }

        glViewport(0, 0, GLsizei(width), GLsizei(height))
        glClearColor(0, 0, 0, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))

        glUseProgram(program)
        drawTexturedQuad(inTex)

        // Overlay и карточка: alpha-blend поверх FBO (FBO всё ещё привязан к output buffer'у).
        // Bitmap, который приходит из UIView через CGContext premultipliedFirst —
        // premultiplied alpha. Поэтому blend = (ONE, ONE_MINUS_SRC_ALPHA).
        let overlay = overlayEnabled ? overlayTexture : nil
        let card = withCard ? cardTextureIfAvailable() : nil
        if overlay != nil || card != nil {
            glEnable(GLenum(GL_BLEND))
            glBlendFunc(GLenum(GL_ONE), GLenum(GL_ONE_MINUS_SRC_ALPHA))
            if let overlay = overlay { drawTexturedQuad(overlay) }
            if let card = card { drawTexturedQuad(card) }
            glDisable(GLenum(GL_BLEND))
        }

        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), 0)

        glFlush()

        // CV держит ссылки на текущий output buffer через CVOpenGLESTexture —
        // освобождаем прежние слоты в кэше, чтобы pool мог переиспользовать буферы.
        CVOpenGLESTextureCacheFlush(ic, 0)
        CVOpenGLESTextureCacheFlush(oc, 0)

        return outBuf
    }

    private func drawTexturedQuad(_ texture: CVOpenGLESTexture) {
        glActiveTexture(GLenum(GL_TEXTURE0))
        glBindTexture(CVOpenGLESTextureGetTarget(texture), CVOpenGLESTextureGetName(texture))
        if textureUniform >= 0 {
            glUniform1i(textureUniform, 0)
        }

        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexVbo)
        let stride = GLsizei(MemoryLayout<GLfloat>.size * 4)
        if positionAttr >= 0 {
            glEnableVertexAttribArray(GLuint(positionAttr))
            glVertexAttribPointer(
                GLuint(positionAttr), 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE),
                stride, UnsafeRawPointer(bitPattern: 0)
            )
        }
        if texCoordAttr >= 0 {
            glEnableVertexAttribArray(GLuint(texCoordAttr))
            glVertexAttribPointer(
                GLuint(texCoordAttr), 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE),
                stride, UnsafeRawPointer(bitPattern: MemoryLayout<GLfloat>.size * 2)
            )
        }

        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)

        if positionAttr >= 0 { glDisableVertexAttribArray(GLuint(positionAttr)) }
        if texCoordAttr >= 0 { glDisableVertexAttribArray(GLuint(texCoordAttr)) }
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
        glBindTexture(CVOpenGLESTextureGetTarget(texture), 0)
    }

    func release() {
        renderQueue.sync {
            placeholderTimer?.cancel()
            placeholderTimer = nil
            placeholderMode = false
            placeholderBuffer = nil
            lastInputBuffer = nil
            lastOutputBuffer = nil
            pendingOverlayPixelBuffer = nil
            // При приостановленном рендере (фон) GL-вызовы запрещены — ресурсы уходят вместе
            // с контекстом.
            if !renderingSuspended {
                if let ctx = context {
                    EAGLContext.setCurrent(ctx)
                }
                if program != 0 { glDeleteProgram(program) }
                if fbo != 0 {
                    var fboCopy = fbo
                    glDeleteFramebuffers(1, &fboCopy)
                }
                if vertexVbo != 0 {
                    var vboCopy = vertexVbo
                    glDeleteBuffers(1, &vboCopy)
                }
                if let ic = inputTextureCache { CVOpenGLESTextureCacheFlush(ic, 0) }
                if let oc = outputTextureCache { CVOpenGLESTextureCacheFlush(oc, 0) }
                if let ovc = overlayTextureCache { CVOpenGLESTextureCacheFlush(ovc, 0) }
                if let cc = cardTextureCache { CVOpenGLESTextureCacheFlush(cc, 0) }
            }
            program = 0
            fbo = 0
            vertexVbo = 0
            inputTextureCache = nil
            outputTextureCache = nil
            overlayTextureCache = nil
            cardTextureCache = nil
            overlayTexture = nil
            overlayPixelBuffer = nil
            overlayEnabled = false
            cardTexture = nil
            cardPixelBuffer = nil
            bufferPool = nil
            EAGLContext.setCurrent(nil)
            context = nil
            prepared = false
        }
    }
}
