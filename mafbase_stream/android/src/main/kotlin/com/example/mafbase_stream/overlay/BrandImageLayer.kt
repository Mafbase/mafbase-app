package com.example.mafbase_stream.overlay

import android.util.Log
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import coil3.compose.AsyncImage
import coil3.request.ImageRequest
import coil3.request.allowHardware

/**
 * Полноэкранный слой брендированной PNG-картинки (логотипы спонсоров и т.п.).
 * Лежит под overlay-вёрсткой и под break-заглушкой, чтобы прозрачные участки
 * PNG пропускали кадр камеры, а break-плашка при необходимости полностью
 * перекрывала его.
 *
 * Если [imageUrl] null/blank — слой не рисуется.
 */
@Composable
internal fun BrandImageLayer(imageUrl: String?) {
    if (imageUrl.isNullOrBlank()) return
    val context = LocalContext.current
    AsyncImage(
        model = ImageRequest.Builder(context)
            .data(imageUrl)
            .allowHardware(false)
            .listener(
                onStart = { Log.d("BrandImage", "brand image load start: $imageUrl") },
                onSuccess = { _, result ->
                    Log.d(
                        "BrandImage",
                        "brand image load success (${result.image.width}x${result.image.height})",
                    )
                },
                onError = { _, result ->
                    Log.w("BrandImage", "brand image load error: ${result.throwable}")
                },
            )
            .build(),
        contentDescription = null,
        modifier = Modifier.fillMaxSize(),
        contentScale = ContentScale.Fit,
    )
}
