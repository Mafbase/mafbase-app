package com.example.mafbase_stream

import android.content.Context
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.view.Gravity
import android.widget.LinearLayout
import android.widget.SeekBar
import android.widget.TextView

/**
 * Боковая панель выбора качества трансляции: пресеты или ручные разрешение+битрейт.
 * Изменения применяются сразу через [onQualityChanged]; показ/скрытие и scrim
 * держит [StreamActivity].
 */
internal class QualitySettingsPanel(
    context: Context,
    initial: StreamQuality,
) : LinearLayout(context) {

    var onQualityChanged: ((StreamQuality) -> Unit)? = null
    var onCloseRequested: (() -> Unit)? = null

    private var quality = initial

    private val modePill = SegmentedPillView(
        context,
        listOf("Пресеты", "Вручную"),
        initialIndex = if (initial.isManual) 1 else 0,
    )
    private val presetsContainer = LinearLayout(context)
    private val manualContainer = LinearLayout(context)
    private val presetRows = mutableListOf<LinearLayout>()
    private val resolutionPill = SegmentedPillView(
        context,
        StreamResolution.values().map { it.label },
        initialIndex = StreamResolution.values().indexOf(initial.manualResolution).coerceAtLeast(0),
    )
    private lateinit var bitrateValue: TextView
    private lateinit var bitrateSeekBar: SeekBar

    init {
        orientation = VERTICAL
        val cornerRadius = dp(20).toFloat()
        background = GradientDrawable().apply {
            setColor(Color.argb(209, 0, 0, 0))
            cornerRadii = floatArrayOf(0f, 0f, cornerRadius, cornerRadius, cornerRadius, cornerRadius, 0f, 0f)
        }
        setPadding(dp(20), dp(20), dp(20), dp(16))
        isClickable = true

        buildHeader()
        addView(modePill, LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT).apply {
            topMargin = dp(16)
        })
        modePill.onSegmentSelected = { index ->
            quality = quality.copy(isManual = index == 1)
            updateModeVisibility()
            notifyChanged()
        }

        buildPresets()
        buildManual()
        buildHint()
        updateModeVisibility()
        updatePresetSelection()
    }

    private fun buildHeader() {
        val title = TextView(context).apply {
            text = "Качество трансляции"
            setTextColor(Color.WHITE)
            textSize = 18f
            setTypeface(typeface, Typeface.BOLD)
        }
        val close = TextView(context).apply {
            text = "✕"
            setTextColor(Color.argb(204, 255, 255, 255))
            textSize = 18f
            setPadding(dp(8), 0, dp(4), 0)
            setOnClickListener { onCloseRequested?.invoke() }
        }
        val header = LinearLayout(context).apply {
            orientation = HORIZONTAL
            addView(title, LayoutParams(0, LayoutParams.WRAP_CONTENT, 1f))
            addView(close, LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT))
        }
        addView(header, LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT))
    }

    private fun buildPresets() {
        presetsContainer.orientation = VERTICAL
        StreamQuality.PRESETS.forEachIndexed { index, preset ->
            val title = TextView(context).apply {
                text = preset.title
                setTextColor(Color.WHITE)
                textSize = 15f
                setTypeface(typeface, Typeface.BOLD)
            }
            val subtitle = TextView(context).apply {
                text = preset.subtitle
                setTextColor(Color.argb(153, 255, 255, 255))
                textSize = 12f
            }
            val row = LinearLayout(context).apply {
                orientation = VERTICAL
                setPadding(dp(14), dp(10), dp(14), dp(10))
                minimumHeight = dp(52)
                addView(title)
                addView(subtitle)
                setOnClickListener {
                    quality = quality.copy(isManual = false, presetId = preset.id)
                    modePill.select(0)
                    updateModeVisibility()
                    notifyChanged()
                }
            }
            presetRows += row
            presetsContainer.addView(
                row,
                LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT).apply {
                    topMargin = if (index == 0) 0 else dp(8)
                },
            )
        }
        addView(
            presetsContainer,
            LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT).apply {
                topMargin = dp(16)
            },
        )
    }

    private fun buildManual() {
        manualContainer.orientation = VERTICAL

        manualContainer.addView(makeCaption("Разрешение"))
        manualContainer.addView(
            resolutionPill,
            LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT).apply {
                topMargin = dp(8)
            },
        )
        resolutionPill.onSegmentSelected = { index ->
            quality = quality.copy(manualResolution = StreamResolution.values()[index])
            notifyChanged()
        }

        manualContainer.addView(
            makeCaption("Битрейт"),
            LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT).apply {
                topMargin = dp(18)
            },
        )

        bitrateValue = TextView(context).apply {
            setTextColor(Color.WHITE)
            textSize = 22f
            setTypeface(Typeface.MONOSPACE, Typeface.BOLD)
            gravity = Gravity.CENTER
        }
        val minus = makeStepButton("−") { changeBitrate(-StreamQuality.BITRATE_STEP_KBPS) }
        val plus = makeStepButton("+") { changeBitrate(StreamQuality.BITRATE_STEP_KBPS) }
        val valueRow = LinearLayout(context).apply {
            orientation = HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
            addView(minus, LayoutParams(dp(32), dp(32)))
            addView(bitrateValue, LayoutParams(0, LayoutParams.WRAP_CONTENT, 1f))
            addView(plus, LayoutParams(dp(32), dp(32)))
        }
        manualContainer.addView(
            valueRow,
            LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT).apply {
                topMargin = dp(8)
            },
        )

        bitrateSeekBar = SeekBar(context).apply {
            max = (StreamQuality.MAX_BITRATE_KBPS - StreamQuality.MIN_BITRATE_KBPS) /
                StreamQuality.BITRATE_STEP_KBPS
            setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
                override fun onProgressChanged(seekBar: SeekBar, progress: Int, fromUser: Boolean) {
                    if (!fromUser) return
                    setBitrate(
                        StreamQuality.MIN_BITRATE_KBPS + progress * StreamQuality.BITRATE_STEP_KBPS,
                    )
                }

                override fun onStartTrackingTouch(seekBar: SeekBar) {}

                override fun onStopTrackingTouch(seekBar: SeekBar) {}
            })
        }
        manualContainer.addView(
            bitrateSeekBar,
            LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT).apply {
                topMargin = dp(8)
            },
        )

        val minLabel = TextView(context).apply {
            text = "${StreamQuality.MIN_BITRATE_KBPS}"
            setTextColor(Color.argb(153, 255, 255, 255))
            textSize = 11f
        }
        val maxLabel = TextView(context).apply {
            text = "${StreamQuality.MAX_BITRATE_KBPS}"
            setTextColor(Color.argb(153, 255, 255, 255))
            textSize = 11f
            gravity = Gravity.END
        }
        val rangeRow = LinearLayout(context).apply {
            orientation = HORIZONTAL
            addView(minLabel, LayoutParams(0, LayoutParams.WRAP_CONTENT, 1f))
            addView(maxLabel, LayoutParams(0, LayoutParams.WRAP_CONTENT, 1f))
        }
        manualContainer.addView(rangeRow, LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT))

        addView(
            manualContainer,
            LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT).apply {
                topMargin = dp(16)
            },
        )
        updateBitrateDisplay()
    }

    private fun buildHint() {
        val hint = TextView(context).apply {
            text = "Качество можно изменить только до начала записи или трансляции"
            setTextColor(Color.argb(153, 255, 255, 255))
            textSize = 12f
        }
        addView(
            hint,
            LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT).apply {
                topMargin = dp(20)
            },
        )
    }

    private fun makeCaption(text: String): TextView = TextView(context).apply {
        this.text = text
        setTextColor(Color.argb(153, 255, 255, 255))
        textSize = 13f
    }

    private fun makeStepButton(label: String, onClick: () -> Unit): TextView =
        TextView(context).apply {
            text = label
            setTextColor(Color.WHITE)
            textSize = 18f
            gravity = Gravity.CENTER
            background = GradientDrawable().apply {
                shape = GradientDrawable.OVAL
                setColor(Color.argb(38, 255, 255, 255))
            }
            setOnClickListener { onClick() }
        }

    private fun updateModeVisibility() {
        presetsContainer.visibility = if (quality.isManual) GONE else VISIBLE
        manualContainer.visibility = if (quality.isManual) VISIBLE else GONE
    }

    private fun updatePresetSelection() {
        presetRows.forEachIndexed { index, row ->
            val selected = !quality.isManual && StreamQuality.PRESETS[index].id == quality.presetId
            row.background = GradientDrawable().apply {
                cornerRadius = dp(12).toFloat()
                setColor(
                    if (selected) Color.argb(38, 255, 255, 255) else Color.argb(10, 255, 255, 255),
                )
                setStroke(
                    dp(if (selected) 2 else 1),
                    if (selected) Color.argb(230, 255, 255, 255) else Color.argb(38, 255, 255, 255),
                )
            }
        }
    }

    private fun updateBitrateDisplay() {
        bitrateValue.text = "${quality.manualBitrateKbps} kbps"
        bitrateSeekBar.progress =
            (quality.manualBitrateKbps - StreamQuality.MIN_BITRATE_KBPS) / StreamQuality.BITRATE_STEP_KBPS
    }

    private fun changeBitrate(deltaKbps: Int) {
        setBitrate(quality.manualBitrateKbps + deltaKbps)
    }

    private fun setBitrate(kbps: Int) {
        val step = StreamQuality.BITRATE_STEP_KBPS
        val snapped = ((kbps + step / 2) / step * step)
            .coerceIn(StreamQuality.MIN_BITRATE_KBPS, StreamQuality.MAX_BITRATE_KBPS)
        if (snapped == quality.manualBitrateKbps) {
            updateBitrateDisplay()
            return
        }
        quality = quality.copy(manualBitrateKbps = snapped)
        updateBitrateDisplay()
        notifyChanged()
    }

    private fun notifyChanged() {
        updatePresetSelection()
        onQualityChanged?.invoke(quality)
    }

    private fun dp(value: Int): Int = (resources.displayMetrics.density * value).toInt()
}
