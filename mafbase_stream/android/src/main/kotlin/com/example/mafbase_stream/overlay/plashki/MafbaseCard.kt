package com.example.mafbase_stream.overlay.plashki

import androidx.compose.animation.Crossfade
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.ColorFilter
import androidx.compose.ui.graphics.ColorMatrix
import androidx.compose.ui.graphics.Shadow
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil3.compose.AsyncImage
import coil3.request.ImageRequest
import coil3.request.allowHardware
import com.example.mafbase_stream.R
import generated.Mafia

@Composable
internal fun MafbaseCard(
    role: Mafia.PlayerRole,
    status: Mafia.PlayerStatus,
    nickname: String,
    number: Int,
    image: String?,
    modifier: Modifier = Modifier,
) {
    Column(
        modifier = modifier,
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Box(
            modifier = Modifier
                .padding(bottom = 4.dp)
                .clip(RoundedCornerShape(8.dp))
                .background(Color(0xFF3A3A3A))
                .padding(horizontal = 10.dp, vertical = 4.dp),
            contentAlignment = Alignment.Center,
        ) {
            Text(
                text = number.toString(),
                color = Color.White,
                fontSize = 14.sp,
                fontWeight = FontWeight.SemiBold,
                textAlign = TextAlign.Center,
            )
        }
        Box(
            modifier = Modifier.fillMaxWidth().padding(bottom = 12.dp, start = 20.dp, end = 20.dp),
            contentAlignment = Alignment.BottomCenter,
        ) {
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .aspectRatio(ratio = 5 / 6f),
            ) {
                val saturation by animateFloatAsState(
                    targetValue = if (status == Mafia.PlayerStatus.alive) 1f else 0f,
                    animationSpec = tween(durationMillis = 400),
                    label = "saturation",
                )
                val context = LocalContext.current
                AsyncImage(
                    // Hardware-bitmaps нельзя рисовать в software-canvas, который использует
                    // OverlayViewRenderer (view.draw(canvas)). Поэтому форсируем software-decode.
                    model = ImageRequest.Builder(context)
                        .data(image)
                        .allowHardware(false)
                        .build(),
                    modifier = Modifier
                        .fillMaxSize()
                        .clip(RoundedCornerShape(12.dp)),
                    contentDescription = null,
                    placeholder = painterResource(R.drawable.player_photo),
                    fallback = painterResource(R.drawable.player_photo),
                    error = painterResource(R.drawable.player_photo),
                    contentScale = ContentScale.Crop,
                    alignment = Alignment.TopCenter,
                    colorFilter = ColorFilter.colorMatrix(ColorMatrix().apply { setToSaturation(saturation) }),
                )
                Crossfade(
                    targetState = roleIconRes(role),
                    animationSpec = tween(durationMillis = 300),
                    modifier = Modifier
                        .align(Alignment.TopStart)
                        .offset(x = (-20).dp, y = (-20).dp)
                        .size(40.dp),
                    label = "roleIcon",
                ) { iconRes ->
                    if (iconRes != null) {
                        Image(
                            painter = painterResource(iconRes),
                            contentDescription = null,
                            modifier = Modifier.fillMaxSize(),
                        )
                    }
                }
                Crossfade(
                    targetState = statusIconRes(status),
                    animationSpec = tween(durationMillis = 300),
                    modifier = Modifier
                        .align(Alignment.TopEnd)
                        .offset(x = 20.dp, y = (-20).dp)
                        .size(40.dp),
                    label = "statusIcon",
                ) { iconRes ->
                    if (iconRes != null) {
                        Image(
                            painter = painterResource(iconRes),
                            contentDescription = null,
                            modifier = Modifier.fillMaxSize(),
                        )
                    }
                }
                Crossfade(
                    targetState = statusLabel(status),
                    animationSpec = tween(durationMillis = 300),
                    modifier = Modifier.align(Alignment.Center),
                    label = "statusLabel",
                ) { label ->
                    if (label != null) {
                        Text(
                            text = label,
                            color = Color.White,
                            fontSize = 22.sp,
                            fontWeight = FontWeight.Black,
                            textAlign = TextAlign.Center,
                            maxLines = 1,
                            softWrap = false,
                            overflow = TextOverflow.Visible,
                            modifier = Modifier
                                .wrapContentSize(unbounded = true)
                                .rotate(40f),
                            style = TextStyle(
                                shadow = Shadow(
                                    color = Color.Black,
                                    offset = Offset(2f, 2f),
                                    blurRadius = 8f,
                                ),
                            ),
                        )
                    }
                }
            }
            Box(
                modifier = Modifier
                    .fillMaxWidth(fraction = 0.85f)
                    .offset(y = 12.dp)
                    .clip(RoundedCornerShape(8.dp))
                    .background(Color(0xFF3A3A3A))
                    .padding(horizontal = 8.dp, vertical = 4.dp),
                contentAlignment = Alignment.Center,
            ) {
                Text(
                    text = nickname,
                    color = Color.White,
                    fontSize = 14.sp,
                    fontWeight = FontWeight.SemiBold,
                    textAlign = TextAlign.Center,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis,
                )
            }
        }
    }
}

private fun roleIconRes(role: Mafia.PlayerRole): Int? = when (role) {
    Mafia.PlayerRole.don -> R.drawable.role_don
    Mafia.PlayerRole.maf -> R.drawable.role_mafia
    Mafia.PlayerRole.sheriff -> R.drawable.role_sheriff
    else -> null
}

private fun statusIconRes(status: Mafia.PlayerStatus): Int? = when (status) {
    Mafia.PlayerStatus.killed -> R.drawable.status_killed
    Mafia.PlayerStatus.voted -> R.drawable.status_voted
    Mafia.PlayerStatus.deleted -> R.drawable.status_deleted
    else -> null
}

private fun statusLabel(status: Mafia.PlayerStatus): String? = when (status) {
    Mafia.PlayerStatus.killed -> "Убит"
    Mafia.PlayerStatus.voted -> "Заголосован"
    Mafia.PlayerStatus.deleted -> "Дисквалифицирован"
    else -> null
}

@Preview(name = "Citizen / alive")
@Composable
private fun MafbaseCardCitizenPreview() {
    Box(modifier = Modifier.width(200.dp)) {
        MafbaseCard(
            role = Mafia.PlayerRole.citizen,
            status = Mafia.PlayerStatus.alive,
            nickname = "Гражданин",
            number = 1,
            image = "https://mafbase.ru/images/805Strelas.png",
        )
    }
}

@Preview(name = "Mafia / voted")
@Composable
private fun MafbaseCardMafiaPreview() {
    Box(modifier = Modifier.width(200.dp)) {
        MafbaseCard(
            role = Mafia.PlayerRole.maf,
            status = Mafia.PlayerStatus.voted,
            nickname = "Мафия",
            number = 2,
            image = "https://mafbase.ru/images/805Strelas.png",
        )
    }
}

@Preview(name = "Don / killed")
@Composable
private fun MafbaseCardDonPreview() {
    Box(modifier = Modifier.width(200.dp)) {
        MafbaseCard(
            role = Mafia.PlayerRole.don,
            status = Mafia.PlayerStatus.killed,
            nickname = "Дон",
            number = 3,
            image = "https://mafbase.ru/images/805Strelas.png",
        )
    }
}

@Preview(name = "Sheriff / deleted")
@Composable
private fun MafbaseCardSheriffPreview() {
    Box(modifier = Modifier.width(200.dp)) {
        MafbaseCard(
            role = Mafia.PlayerRole.sheriff,
            status = Mafia.PlayerStatus.deleted,
            nickname = "Дикая Пума",
            number = 10,
            image = "https://mafbase.ru/images/805Strelas.png",
        )
    }
}