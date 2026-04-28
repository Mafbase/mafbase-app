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

    /// Колбэк выполняется на `renderQueue`. Pixel buffer допустимо удерживать
    /// сколь угодно долго — он взят из CVPixelBufferPool и автоматически
    /// возвращается в pool при release'е CVPixelBuffer.
    var onFrame: ((CVPixelBuffer, CMTime) -> Void)?
    var onError: ((Error) -> Void)?

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

        var inputCache: CVOpenGLESTextureCache?
        let inRet = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, nil, ctx, nil, &inputCache)
        guard inRet == kCVReturnSuccess, let ic = inputCache else {
            throw CompositorError.textureCache(inRet)
        }
        var outputCache: CVOpenGLESTextureCache?
        let outRet = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, nil, ctx, nil, &outputCache)
        guard outRet == kCVReturnSuccess, let oc = outputCache else {
            throw CompositorError.textureCache(outRet)
        }
        inputTextureCache = ic
        outputTextureCache = oc

        var overlayCache: CVOpenGLESTextureCache?
        let ovRet = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, nil, ctx, nil, &overlayCache)
        guard ovRet == kCVReturnSuccess, let ovc = overlayCache else {
            throw CompositorError.textureCache(ovRet)
        }
        overlayTextureCache = ovc

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

    /// Async: рендер выполняется на собственной очереди, output отдаётся через `onFrame`.
    func processFrame(pixelBuffer: CVPixelBuffer, pts: CMTime) {
        renderQueue.async { [weak self] in
            self?.renderOnQueue(pixelBuffer: pixelBuffer, pts: pts)
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
            if let cache = self.overlayTextureCache {
                CVOpenGLESTextureCacheFlush(cache, 0)
            }
        }
    }

    private func uploadOverlayPixelBuffer(_ pixelBuffer: CVPixelBuffer) {
        guard prepared, let ctx = context, let cache = overlayTextureCache else { return }
        EAGLContext.setCurrent(ctx)
        let w = CVPixelBufferGetWidth(pixelBuffer)
        let h = CVPixelBufferGetHeight(pixelBuffer)
        var texture: CVOpenGLESTexture?
        let ret = CVOpenGLESTextureCacheCreateTextureFromImage(
            kCFAllocatorDefault,
            cache,
            pixelBuffer,
            nil,
            GLenum(GL_TEXTURE_2D),
            GLint(GL_RGBA),
            GLsizei(w),
            GLsizei(h),
            GLenum(GL_BGRA),
            GLenum(GL_UNSIGNED_BYTE),
            0,
            &texture
        )
        guard ret == kCVReturnSuccess, let tex = texture else {
            onError?(CompositorError.textureCache(ret))
            return
        }
        glBindTexture(CVOpenGLESTextureGetTarget(tex), CVOpenGLESTextureGetName(tex))
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GL_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_S), GL_CLAMP_TO_EDGE)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_T), GL_CLAMP_TO_EDGE)
        glBindTexture(CVOpenGLESTextureGetTarget(tex), 0)
        overlayTexture = tex
        overlayPixelBuffer = pixelBuffer
        overlayEnabled = true
    }

    private func renderOnQueue(pixelBuffer: CVPixelBuffer, pts: CMTime) {
        guard prepared,
              let ctx = context,
              let ic = inputTextureCache,
              let oc = outputTextureCache,
              let pool = bufferPool else { return }

        EAGLContext.setCurrent(ctx)

        let inputW = CVPixelBufferGetWidth(pixelBuffer)
        let inputH = CVPixelBufferGetHeight(pixelBuffer)

        var inputTexture: CVOpenGLESTexture?
        let inRet = CVOpenGLESTextureCacheCreateTextureFromImage(
            kCFAllocatorDefault,
            ic,
            pixelBuffer,
            nil,
            GLenum(GL_TEXTURE_2D),
            GLint(GL_RGBA),
            GLsizei(inputW),
            GLsizei(inputH),
            GLenum(GL_BGRA),
            GLenum(GL_UNSIGNED_BYTE),
            0,
            &inputTexture
        )
        guard inRet == kCVReturnSuccess, let inTex = inputTexture else {
            onError?(CompositorError.textureCache(inRet))
            return
        }

        var outputBuffer: CVPixelBuffer?
        let poolRet = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, pool, &outputBuffer)
        guard poolRet == kCVReturnSuccess, let outBuf = outputBuffer else {
            onError?(CompositorError.bufferPool(poolRet))
            return
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
            return
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
            return
        }

        glViewport(0, 0, GLsizei(width), GLsizei(height))
        glClearColor(0, 0, 0, 1)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))

        glUseProgram(program)

        glActiveTexture(GLenum(GL_TEXTURE0))
        glBindTexture(CVOpenGLESTextureGetTarget(inTex), CVOpenGLESTextureGetName(inTex))
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GL_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_S), GL_CLAMP_TO_EDGE)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_T), GL_CLAMP_TO_EDGE)
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
        glBindTexture(CVOpenGLESTextureGetTarget(inTex), 0)

        // Overlay: alpha-blend поверх FBO (FBO всё ещё привязан к output buffer'у).
        // Bitmap, который приходит из UIView через CGContext premultipliedFirst —
        // premultiplied alpha. Поэтому blend = (ONE, ONE_MINUS_SRC_ALPHA).
        if overlayEnabled, let overlay = overlayTexture {
            glEnable(GLenum(GL_BLEND))
            glBlendFunc(GLenum(GL_ONE), GLenum(GL_ONE_MINUS_SRC_ALPHA))

            glActiveTexture(GLenum(GL_TEXTURE0))
            glBindTexture(CVOpenGLESTextureGetTarget(overlay), CVOpenGLESTextureGetName(overlay))
            if textureUniform >= 0 {
                glUniform1i(textureUniform, 0)
            }

            glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexVbo)
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
            glBindTexture(CVOpenGLESTextureGetTarget(overlay), 0)
            glDisable(GLenum(GL_BLEND))
        }

        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), 0)

        glFlush()

        // CV держит ссылки на текущий output buffer через CVOpenGLESTexture —
        // освобождаем прежние слоты в кэше, чтобы pool мог переиспользовать буферы.
        CVOpenGLESTextureCacheFlush(ic, 0)
        CVOpenGLESTextureCacheFlush(oc, 0)

        onFrame?(outBuf, pts)
    }

    func release() {
        renderQueue.sync {
            if let ctx = context {
                EAGLContext.setCurrent(ctx)
            }
            if program != 0 { glDeleteProgram(program); program = 0 }
            if fbo != 0 {
                var fboCopy = fbo
                glDeleteFramebuffers(1, &fboCopy)
                fbo = 0
            }
            if vertexVbo != 0 {
                var vboCopy = vertexVbo
                glDeleteBuffers(1, &vboCopy)
                vertexVbo = 0
            }
            if let ic = inputTextureCache { CVOpenGLESTextureCacheFlush(ic, 0) }
            if let oc = outputTextureCache { CVOpenGLESTextureCacheFlush(oc, 0) }
            if let ovc = overlayTextureCache { CVOpenGLESTextureCacheFlush(ovc, 0) }
            inputTextureCache = nil
            outputTextureCache = nil
            overlayTextureCache = nil
            overlayTexture = nil
            overlayPixelBuffer = nil
            overlayEnabled = false
            bufferPool = nil
            EAGLContext.setCurrent(nil)
            context = nil
            prepared = false
        }
    }
}
