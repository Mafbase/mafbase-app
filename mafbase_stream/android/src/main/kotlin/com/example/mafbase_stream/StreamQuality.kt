package com.example.mafbase_stream

import android.content.Context

/** Разрешение видео-пайплайна. */
enum class StreamResolution(val width: Int, val height: Int, val label: String) {
    HD_720(1280, 720, "720p"),
    FULL_HD_1080(1920, 1080, "1080p"),
}

data class StreamQualityPreset(
    val id: String,
    val title: String,
    val resolution: StreamResolution,
    val bitrateKbps: Int,
) {
    val subtitle: String get() = "${resolution.label} · $bitrateKbps kbps"
}

/**
 * Выбор качества трансляции: именованный пресет или ручные разрешение+битрейт.
 * Битрейт применяется при старте стрима (и становится потолком ABR-лестницы ядра),
 * разрешение задаёт размер всего пайплайна экрана.
 */
data class StreamQuality(
    val isManual: Boolean,
    val presetId: String,
    val manualResolution: StreamResolution,
    val manualBitrateKbps: Int,
) {
    private val preset: StreamQualityPreset
        get() = PRESETS.firstOrNull { it.id == presetId } ?: PRESETS[1]

    val resolution: StreamResolution get() = if (isManual) manualResolution else preset.resolution
    val bitrateKbps: Int get() = if (isManual) manualBitrateKbps else preset.bitrateKbps
    val bitrateBps: Int get() = bitrateKbps * 1000

    companion object {
        val PRESETS = listOf(
            StreamQualityPreset("eco", "Экономный", StreamResolution.HD_720, 2000),
            StreamQualityPreset("standard", "Стандартный", StreamResolution.HD_720, 4000),
            StreamQualityPreset("high", "Высокий", StreamResolution.FULL_HD_1080, 6000),
        )

        const val MIN_BITRATE_KBPS = 1000
        const val MAX_BITRATE_KBPS = 8000
        const val BITRATE_STEP_KBPS = 500

        /** Дефолт совпадает с прежним пресетом «Стандартный»: 720p / 4000 kbps. */
        val STANDARD = StreamQuality(
            isManual = false,
            presetId = "standard",
            manualResolution = StreamResolution.HD_720,
            manualBitrateKbps = 4000,
        )
    }
}

/** Персистентность выбора качества между открытиями экрана трансляции. */
object StreamQualityStore {
    private const val PREFS_NAME = "mafbase_stream"
    private const val KEY_MANUAL = "quality.manual"
    private const val KEY_PRESET = "quality.preset"
    private const val KEY_RESOLUTION = "quality.resolution"
    private const val KEY_BITRATE = "quality.bitrateKbps"

    fun load(context: Context): StreamQuality {
        val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        val presetId = prefs.getString(KEY_PRESET, null)
            ?.takeIf { id -> StreamQuality.PRESETS.any { it.id == id } }
            ?: StreamQuality.STANDARD.presetId
        val resolution = prefs.getString(KEY_RESOLUTION, null)
            ?.let { raw -> StreamResolution.values().firstOrNull { it.name == raw } }
            ?: StreamQuality.STANDARD.manualResolution
        val bitrate = prefs.getInt(KEY_BITRATE, StreamQuality.STANDARD.manualBitrateKbps)
            .coerceIn(StreamQuality.MIN_BITRATE_KBPS, StreamQuality.MAX_BITRATE_KBPS)
        return StreamQuality(
            isManual = prefs.getBoolean(KEY_MANUAL, false),
            presetId = presetId,
            manualResolution = resolution,
            manualBitrateKbps = bitrate,
        )
    }

    fun save(context: Context, quality: StreamQuality) {
        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            .edit()
            .putBoolean(KEY_MANUAL, quality.isManual)
            .putString(KEY_PRESET, quality.presetId)
            .putString(KEY_RESOLUTION, quality.manualResolution.name)
            .putInt(KEY_BITRATE, quality.manualBitrateKbps)
            .apply()
    }
}
