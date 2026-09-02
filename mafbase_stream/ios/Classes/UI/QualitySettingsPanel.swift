import UIKit

/// Боковая панель выбора качества трансляции: пресеты или ручные разрешение+битрейт.
/// Изменения применяются сразу — панель только сообщает о них через `onSettingsChanged`,
/// показ/скрытие и scrim держит `StreamViewController`.
final class QualitySettingsPanel: UIView {

    var onSettingsChanged: ((StreamQualitySettings) -> Void)?
    var onCloseTapped: (() -> Void)?

    private var settings: StreamQualitySettings

    private let modeControl: SegmentedPillControl
    private let presetsContainer = UIStackView()
    private let manualContainer = UIStackView()
    private var presetRows: [UIView] = []
    private let resolutionControl: SegmentedPillControl
    private let bitrateValueLabel = UILabel()
    private let bitrateSlider = UISlider()

    init(settings: StreamQualitySettings) {
        self.settings = settings
        modeControl = SegmentedPillControl(
            titles: ["Пресеты", "Вручную"],
            selectedIndex: settings.isManual ? 1 : 0
        )
        resolutionControl = SegmentedPillControl(
            titles: StreamResolution.allCases.map { $0.label },
            selectedIndex: StreamResolution.allCases.firstIndex(of: settings.manualResolution) ?? 0
        )
        super.init(frame: .zero)
        backgroundColor = UIColor.black.withAlphaComponent(0.82)
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        buildContent()
        updateModeVisibility()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) is not supported") }

    // MARK: - Layout

    private func buildContent() {
        let header = UILabel()
        header.text = "Качество трансляции"
        header.textColor = .white
        header.font = .systemFont(ofSize: 18, weight: .bold)

        let close = UIButton(type: .system)
        close.setImage(UIImage(systemName: "xmark"), for: .normal)
        close.tintColor = UIColor.white.withAlphaComponent(0.8)
        close.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        close.setContentHuggingPriority(.required, for: .horizontal)

        let headerRow = UIStackView(arrangedSubviews: [header, close])
        headerRow.axis = .horizontal
        headerRow.alignment = .center

        modeControl.onChange = { [weak self] index in
            guard let self = self else { return }
            self.settings.isManual = index == 1
            self.updateModeVisibility()
            self.notifyChanged()
        }

        presetsContainer.axis = .vertical
        presetsContainer.spacing = 8
        for (index, preset) in StreamQualitySettings.presets.enumerated() {
            let row = makePresetRow(preset: preset, index: index)
            presetRows.append(row)
            presetsContainer.addArrangedSubview(row)
        }
        updatePresetSelection()

        buildManualContainer()

        let hint = UILabel()
        hint.text = "Качество можно изменить только до начала записи или трансляции"
        hint.textColor = UIColor.white.withAlphaComponent(0.6)
        hint.font = .systemFont(ofSize: 12)
        hint.numberOfLines = 0

        let content = UIStackView(arrangedSubviews: [headerRow, modeControl, presetsContainer, manualContainer, hint])
        content.axis = .vertical
        content.spacing = 16
        content.setCustomSpacing(24, after: presetsContainer)
        content.translatesAutoresizingMaskIntoConstraints = false
        addSubview(content)

        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            content.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            content.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            modeControl.heightAnchor.constraint(equalToConstant: 36),
        ])
    }

    private func makePresetRow(preset: StreamQualityPreset, index: Int) -> UIView {
        let row = UIControl()
        row.tag = index
        row.layer.cornerRadius = 12
        row.layer.borderWidth = 1.5
        row.addTarget(self, action: #selector(presetRowTapped(_:)), for: .touchUpInside)

        let title = UILabel()
        title.text = preset.title
        title.textColor = .white
        title.font = .systemFont(ofSize: 15, weight: .semibold)

        let subtitle = UILabel()
        subtitle.text = preset.subtitle
        subtitle.textColor = UIColor.white.withAlphaComponent(0.6)
        subtitle.font = .systemFont(ofSize: 12)

        let texts = UIStackView(arrangedSubviews: [title, subtitle])
        texts.axis = .vertical
        texts.spacing = 2
        texts.isUserInteractionEnabled = false
        texts.translatesAutoresizingMaskIntoConstraints = false
        row.addSubview(texts)

        NSLayoutConstraint.activate([
            row.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),
            texts.leadingAnchor.constraint(equalTo: row.leadingAnchor, constant: 14),
            texts.trailingAnchor.constraint(lessThanOrEqualTo: row.trailingAnchor, constant: -14),
            texts.centerYAnchor.constraint(equalTo: row.centerYAnchor),
        ])
        return row
    }

    private func buildManualContainer() {
        let resolutionTitle = UILabel()
        resolutionTitle.text = "Разрешение"
        resolutionTitle.textColor = UIColor.white.withAlphaComponent(0.6)
        resolutionTitle.font = .systemFont(ofSize: 13)

        resolutionControl.onChange = { [weak self] index in
            guard let self = self else { return }
            self.settings.manualResolution = StreamResolution.allCases[index]
            self.notifyChanged()
        }

        let bitrateTitle = UILabel()
        bitrateTitle.text = "Битрейт"
        bitrateTitle.textColor = UIColor.white.withAlphaComponent(0.6)
        bitrateTitle.font = .systemFont(ofSize: 13)

        bitrateValueLabel.textColor = .white
        bitrateValueLabel.font = .monospacedDigitSystemFont(ofSize: 22, weight: .bold)
        bitrateValueLabel.textAlignment = .center

        let minus = makeStepButton(symbol: "minus", action: #selector(bitrateMinusTapped))
        let plus = makeStepButton(symbol: "plus", action: #selector(bitratePlusTapped))
        let valueRow = UIStackView(arrangedSubviews: [minus, bitrateValueLabel, plus])
        valueRow.axis = .horizontal
        valueRow.spacing = 12
        valueRow.alignment = .center

        bitrateSlider.minimumValue = Float(StreamQualitySettings.minBitrateKbps)
        bitrateSlider.maximumValue = Float(StreamQualitySettings.maxBitrateKbps)
        bitrateSlider.minimumTrackTintColor = .white
        bitrateSlider.maximumTrackTintColor = UIColor.white.withAlphaComponent(0.2)
        bitrateSlider.addTarget(self, action: #selector(bitrateSliderChanged), for: .valueChanged)

        let minLabel = UILabel()
        minLabel.text = "\(StreamQualitySettings.minBitrateKbps)"
        let maxLabel = UILabel()
        maxLabel.text = "\(StreamQualitySettings.maxBitrateKbps)"
        for label in [minLabel, maxLabel] {
            label.textColor = UIColor.white.withAlphaComponent(0.6)
            label.font = .systemFont(ofSize: 11)
        }
        maxLabel.textAlignment = .right
        let rangeRow = UIStackView(arrangedSubviews: [minLabel, UIView(), maxLabel])
        rangeRow.axis = .horizontal

        manualContainer.axis = .vertical
        manualContainer.spacing = 10
        [resolutionTitle, resolutionControl, bitrateTitle, valueRow, bitrateSlider, rangeRow].forEach {
            manualContainer.addArrangedSubview($0)
        }
        manualContainer.setCustomSpacing(18, after: resolutionControl)
        resolutionControl.heightAnchor.constraint(equalToConstant: 36).isActive = true

        updateBitrateDisplay()
    }

    private func makeStepButton(symbol: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: symbol), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: action, for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 32),
            button.heightAnchor.constraint(equalToConstant: 32),
        ])
        return button
    }

    // MARK: - State

    private func updateModeVisibility() {
        presetsContainer.isHidden = settings.isManual
        manualContainer.isHidden = !settings.isManual
    }

    private func updatePresetSelection() {
        for (index, row) in presetRows.enumerated() {
            let isSelected = !settings.isManual
                && StreamQualitySettings.presets[index].id == settings.presetId
            row.backgroundColor = isSelected
                ? UIColor.white.withAlphaComponent(0.15)
                : UIColor.white.withAlphaComponent(0.04)
            row.layer.borderColor = isSelected
                ? UIColor.white.withAlphaComponent(0.9).cgColor
                : UIColor.white.withAlphaComponent(0.15).cgColor
        }
    }

    private func updateBitrateDisplay() {
        bitrateValueLabel.text = "\(settings.manualBitrateKbps) kbps"
        bitrateSlider.value = Float(settings.manualBitrateKbps)
    }

    private func setManualBitrate(_ kbps: Int) {
        let step = StreamQualitySettings.bitrateStepKbps
        let snapped = (kbps + step / 2) / step * step
        let clamped = min(max(snapped, StreamQualitySettings.minBitrateKbps), StreamQualitySettings.maxBitrateKbps)
        guard clamped != settings.manualBitrateKbps else {
            updateBitrateDisplay()
            return
        }
        settings.manualBitrateKbps = clamped
        updateBitrateDisplay()
        notifyChanged()
    }

    private func notifyChanged() {
        updatePresetSelection()
        onSettingsChanged?(settings)
    }

    // MARK: - Actions

    @objc private func closeTapped() {
        onCloseTapped?()
    }

    @objc private func presetRowTapped(_ sender: UIControl) {
        settings.isManual = false
        settings.presetId = StreamQualitySettings.presets[sender.tag].id
        modeControl.setSelectedIndex(0, animated: true)
        updateModeVisibility()
        notifyChanged()
    }

    @objc private func bitrateSliderChanged() {
        setManualBitrate(Int(bitrateSlider.value))
    }

    @objc private func bitrateMinusTapped() {
        setManualBitrate(settings.manualBitrateKbps - StreamQualitySettings.bitrateStepKbps)
    }

    @objc private func bitratePlusTapped() {
        setManualBitrate(settings.manualBitrateKbps + StreamQualitySettings.bitrateStepKbps)
    }
}
