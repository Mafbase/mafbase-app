package com.example.mafbase_stream.overlay

import android.content.Context
import android.view.View
import androidx.compose.runtime.Composable
import com.example.mafbase_stream.overlay.plashki.PlashkiMafbaseOverlay

/**
 * Внутренний каталог overlay-вёрстки, известной плагину. Каждый overlay — это
 * `@Composable`, принимающий [OverlayParams], а [OverlayComposeContainer]
 * оборачивает его в `ComposeView` со всем нужным окружением.
 *
 * Чтобы добавить новый overlay — пиши `@Composable` функцию, принимающую
 * [OverlayParams], и добавляй строчку в [overlays] под уникальным `viewType`.
 * Тот же `viewType` приложение указывает из Dart через `MafbaseOverlay`.
 */
internal object OverlayCatalog {
    private val overlays: Map<String, @Composable (OverlayParams) -> Unit> = mapOf(
        "plashki-mafbase" to { params -> PlashkiMafbaseOverlay(params) },
    )

    fun has(viewType: String): Boolean = viewType in overlays

    fun create(
        viewType: String,
        context: Context,
        invalidator: OverlayInvalidator,
        params: OverlayParams = OverlayParams(),
    ): View? {
        val content = overlays[viewType] ?: return null
        return OverlayComposeContainer(context, invalidator, params, content)
    }
}
