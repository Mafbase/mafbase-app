package com.example.mafbase_stream.overlay

import android.content.Context
import android.view.View
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import com.example.mafbase_stream.overlay.plashki.PlashkiMafbaseOverlay

/**
 * Внутренний каталог overlay-вёрстки, известной плагину. Каждый overlay — это
 * `@Composable`, принимающий [OverlayParams], а [OverlayComposeContainer]
 * оборачивает его в `ComposeView` со всем нужным окружением.
 *
 * Чтобы добавить новый overlay — пиши `@Composable` функцию, принимающую
 * [OverlayParams], и добавляй строчку в [overlays] под уникальным `viewType`.
 * Тот же `viewType` приложение указывает из Dart через `MafbaseOverlay`.
 *
 * Помимо overlay-вёрстки каталог рисует [BrandImageLayer] под ней — постоянная
 * брендированная картинка, заданная через [OverlayParams.brandImageUrl]. Она
 * работает независимо от того, выбран overlay или нет.
 */
internal object OverlayCatalog {
    private val overlays: Map<String, @Composable (OverlayParams) -> Unit> = mapOf(
        "plashki-mafbase" to { params -> PlashkiMafbaseOverlay(params) },
    )

    fun has(viewType: String): Boolean = viewType in overlays

    /**
     * Создаёт wrapper-view с brand-слоем и (опционально) overlay-вёрсткой.
     * Возвращает null, если ни overlay, ни brand не заданы — тогда смысла
     * подключать overlay-renderer нет.
     */
    fun create(
        viewType: String?,
        context: Context,
        invalidator: OverlayInvalidator,
        params: OverlayParams = OverlayParams(),
    ): View? {
        val overlayContent: (@Composable (OverlayParams) -> Unit)? = viewType?.let { overlays[it] }
        if (overlayContent == null && params.brandImageUrl.isNullOrBlank()) return null
        val wrappedContent: @Composable (OverlayParams) -> Unit = { p ->
            Box(Modifier.fillMaxSize()) {
                BrandImageLayer(p.brandImageUrl)
                overlayContent?.invoke(p)
            }
        }
        return OverlayComposeContainer(context, invalidator, params, wrappedContent)
    }
}
