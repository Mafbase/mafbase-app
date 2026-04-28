package com.example.mafbase_stream.overlay

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Color
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.Recomposer
import androidx.compose.ui.platform.AndroidUiDispatcher
import androidx.compose.ui.platform.ComposeView
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.LifecycleRegistry
import androidx.lifecycle.setViewTreeLifecycleOwner
import androidx.savedstate.SavedStateRegistry
import androidx.savedstate.SavedStateRegistryController
import androidx.savedstate.SavedStateRegistryOwner
import androidx.savedstate.setViewTreeSavedStateRegistryOwner
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

/**
 * Хост для Compose-overlay'ев. Принимает любой `@Composable () -> Unit` и
 * заворачивает его в [ComposeView] вместе со всем окружением, нужным для работы
 * Compose off-screen — оверлей никогда не приклеивается к window, его рисует
 * [OverlayViewRenderer] напрямую через `view.draw(canvas)`.
 *
 * Что приходится поднимать вручную, потому что `ComposeView` обычно делает это в
 * `onAttachedToWindow`:
 *  - [LifecycleOwner] и [SavedStateRegistryOwner] для view-trees;
 *  - [Recomposer] на main-потоке через [AndroidUiDispatcher.CurrentThread] —
 *    он же даёт `MonotonicFrameClock` для `withFrameNanos`.
 *
 * Compose сам вызывает `View.invalidate()`, когда нужна перерисовка. Мы ловим
 * это в [onDescendantInvalidated] и дёргаем [OverlayInvalidator.invalidate],
 * чтобы [OverlayViewRenderer] снял свежий bitmap и залил в `Compositor`.
 */
@SuppressLint("ViewConstructor")
internal class OverlayComposeContainer(
    context: Context,
    private val invalidator: OverlayInvalidator,
    params: OverlayParams,
    content: @Composable (OverlayParams) -> Unit,
) : FrameLayout(context) {

    private val lifecycleOwner = OffscreenLifecycleOwner()
    private val recomposer = Recomposer(AndroidUiDispatcher.Main)
    private val composeScope = CoroutineScope(AndroidUiDispatcher.Main)

    private val composeView = ComposeView(context).apply {
        setViewTreeLifecycleOwner(lifecycleOwner)
        setViewTreeSavedStateRegistryOwner(lifecycleOwner)
        setParentCompositionContext(recomposer)
        setContent {
            MaterialTheme { content(params) }
        }
    }

    init {
        // Recomposer стартуем РАНЬШЕ addView, чтобы он был активен к моменту, когда
        // ComposeView в onMeasure / onAttachedToWindow триггерит initial composition.
        composeScope.launch { recomposer.runRecomposeAndApplyChanges() }
        setBackgroundColor(Color.TRANSPARENT)
        addView(composeView, LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT))
        Log.d(TAG, "container created, recomposer launched")
    }

    override fun onDescendantInvalidated(child: View, target: View) {
        super.onDescendantInvalidated(child, target)
        invalidator.invalidate()
    }

    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        Log.d(TAG, "onAttachedToWindow")
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        Log.d(TAG, "onDetachedFromWindow")
        composeView.disposeComposition()
        recomposer.cancel()
        lifecycleOwner.destroy()
    }

    companion object {
        private const val TAG = "OverlayCompose"
    }
}

private class OffscreenLifecycleOwner : LifecycleOwner, SavedStateRegistryOwner {
    private val lifecycleRegistry = LifecycleRegistry(this)
    private val savedStateController = SavedStateRegistryController.create(this).apply {
        performAttach()
        performRestore(null)
    }

    init {
        lifecycleRegistry.currentState = Lifecycle.State.RESUMED
    }

    override val lifecycle: Lifecycle get() = lifecycleRegistry
    override val savedStateRegistry: SavedStateRegistry get() = savedStateController.savedStateRegistry

    fun destroy() {
        lifecycleRegistry.currentState = Lifecycle.State.DESTROYED
    }
}
