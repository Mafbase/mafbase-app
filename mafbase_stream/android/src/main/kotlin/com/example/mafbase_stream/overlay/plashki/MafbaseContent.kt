package com.example.mafbase_stream.overlay.plashki

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.TransformOrigin
import androidx.compose.ui.layout.Layout
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Constraints
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import generated.Mafia
import kotlin.math.roundToInt

private val DESIGN_WIDTH = 1920.dp

@Composable
fun MafbaseContent(content: Mafia.SeatingContent, modifier: Modifier = Modifier) {
    ScaledCanvas(
        designWidth = DESIGN_WIDTH,
        modifier = modifier.fillMaxSize(),
    ) {
        Box(modifier = Modifier.fillMaxSize().padding(bottom = 4.dp)) {
            Row(
                modifier = Modifier
                    .align(Alignment.BottomCenter)
                    .fillMaxWidth(),
                verticalAlignment = Alignment.Bottom,
            ) {
                for (i in 0..9) {
                    MafbaseCard(
                        role = content.rolesList.getOrNull(i) ?: Mafia.PlayerRole.citizen,
                        status = content.statusList.getOrNull(i) ?: Mafia.PlayerStatus.alive,
                        number = i + 1,
                        nickname = content.namesList.getOrNull(i).orEmpty(),
                        image = content.imagesList.getOrNull(i),
                        modifier = Modifier
                            .padding(horizontal = 4.dp)
                            .weight(1f),
                    )
                }
            }
        }
    }
}

/**
 * Меряет [content] под фиксированной design-шириной [designWidth], а design-высоту берёт
 * из aspect ratio реального контейнера. Скейл одинаков по обеим осям —
 * `scale = outWidth / designWidth` — поэтому letterbox-полей не остаётся, контент всегда
 * заполняет всю площадь родителя.
 *
 * Это позволяет верстать всю плашку «как для 1920-широкого экрана» — все dp-отступы и
 * шрифты остаются пропорциональными независимо от того, в какой ширине кадра (1280, 720
 * etc.) overlay в итоге сжимается. Если AR кадра отличается, design-canvas получится
 * выше/ниже, но плашка по-прежнему прижата к низу через `Alignment.BottomCenter`.
 */
@Composable
private fun ScaledCanvas(
    designWidth: Dp,
    modifier: Modifier = Modifier,
    content: @Composable () -> Unit,
) {
    Layout(modifier = modifier, content = content) { measurables, constraints ->
        val designWidthPx = designWidth.roundToPx()
        val outW = if (constraints.hasBoundedWidth) constraints.maxWidth else designWidthPx
        val outH = if (constraints.hasBoundedHeight) constraints.maxHeight else designWidthPx
        val scale = outW.toFloat() / designWidthPx
        // Design-высота вычисляется из реального aspect ratio: outH = designH * scale.
        val designHeightPx = (outH / scale).roundToInt()
        val designConstraints = Constraints.fixed(designWidthPx, designHeightPx)
        val placeables = measurables.map { it.measure(designConstraints) }

        layout(outW, outH) {
            placeables.forEach { placeable ->
                placeable.placeWithLayer(0, 0) {
                    transformOrigin = TransformOrigin(0f, 0f)
                    scaleX = scale
                    scaleY = scale
                }
            }
        }
    }
}

@Preview(widthDp = 1920, heightDp = 1080)
@Composable
fun MafbaseContentPreview() {
    val state = Mafia.SeatingContent.newBuilder()
        .addAllNames(List(10) { "Nickname $it" })
        .addAllRoles(
            listOf(
                Mafia.PlayerRole.don,
                Mafia.PlayerRole.sheriff,
                Mafia.PlayerRole.maf,
            ) + List(7) { Mafia.PlayerRole.citizen },
        )
        .addAllStatus(
            listOf(
                Mafia.PlayerStatus.killed,
                Mafia.PlayerStatus.voted,
                Mafia.PlayerStatus.deleted,
            ) + List(7) { Mafia.PlayerStatus.alive },
        )

    Box(modifier = Modifier.fillMaxSize()) {
        MafbaseContent(state.build())
    }
}
