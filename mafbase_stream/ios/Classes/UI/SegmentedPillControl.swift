import UIKit

/// Сегментированная pill-капсула в стиле кнопок экрана трансляции: полупрозрачный
/// чёрный фон, активный сегмент — белая подложка с тёмным текстом. Используется
/// переключателем объектива и панелью качества.
final class SegmentedPillControl: UIView {

    var onChange: ((Int) -> Void)?

    private(set) var selectedIndex: Int
    private let segmentButtons: [UIButton]
    private let thumb = UIView()
    private let segmentHeight: CGFloat

    init(titles: [String], selectedIndex: Int = 0, segmentHeight: CGFloat = 36) {
        self.selectedIndex = selectedIndex
        self.segmentHeight = segmentHeight
        segmentButtons = titles.map { title in
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
            return button
        }
        super.init(frame: .zero)

        backgroundColor = UIColor.black.withAlphaComponent(0.45)
        layer.cornerRadius = segmentHeight / 2
        clipsToBounds = true

        thumb.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        thumb.layer.cornerRadius = (segmentHeight - 8) / 2
        addSubview(thumb)

        for (index, button) in segmentButtons.enumerated() {
            button.tag = index
            button.addTarget(self, action: #selector(segmentTapped(_:)), for: .touchUpInside)
            addSubview(button)
        }
        applySelectionColors()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) is not supported") }

    override var intrinsicContentSize: CGSize {
        let widest = segmentButtons
            .map { $0.titleLabel?.intrinsicContentSize.width ?? 0 }
            .max() ?? 0
        let segmentWidth = max(48, widest + 24)
        return CGSize(width: segmentWidth * CGFloat(segmentButtons.count) + 8, height: segmentHeight)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let count = CGFloat(segmentButtons.count)
        let segmentWidth = (bounds.width - 8) / count
        for (index, button) in segmentButtons.enumerated() {
            button.frame = CGRect(
                x: 4 + segmentWidth * CGFloat(index),
                y: 0,
                width: segmentWidth,
                height: bounds.height
            )
        }
        thumb.frame = thumbFrame(for: selectedIndex)
    }

    func setSelectedIndex(_ index: Int, animated: Bool) {
        guard index != selectedIndex, segmentButtons.indices.contains(index) else { return }
        selectedIndex = index
        let updates = {
            self.thumb.frame = self.thumbFrame(for: index)
            self.applySelectionColors()
        }
        if animated {
            UIView.animate(withDuration: 0.18, delay: 0, options: [.curveEaseOut], animations: updates)
        } else {
            updates()
        }
    }

    /// Приглушает капсулу и блокирует тапы — на время реконфигурации камеры.
    func setInteractionEnabled(_ enabled: Bool) {
        isUserInteractionEnabled = enabled
        alpha = enabled ? 1 : 0.6
    }

    private func thumbFrame(for index: Int) -> CGRect {
        let count = CGFloat(segmentButtons.count)
        let segmentWidth = (bounds.width - 8) / count
        return CGRect(
            x: 4 + segmentWidth * CGFloat(index),
            y: 4,
            width: segmentWidth,
            height: bounds.height - 8
        )
    }

    private func applySelectionColors() {
        for (index, button) in segmentButtons.enumerated() {
            let isSelected = index == selectedIndex
            button.setTitleColor(
                isSelected ? UIColor.black.withAlphaComponent(0.85) : UIColor.white.withAlphaComponent(0.6),
                for: .normal
            )
        }
    }

    @objc private func segmentTapped(_ sender: UIButton) {
        guard sender.tag != selectedIndex else { return }
        setSelectedIndex(sender.tag, animated: true)
        onChange?(sender.tag)
    }
}
