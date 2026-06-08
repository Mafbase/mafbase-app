import UIKit

/// UIView-wrapper над overlay-вёрсткой и брендированной PNG-картинкой. Картинка
/// рисуется под overlay'ем во всех выходах compositor'а (preview, запись,
/// стрим), а прозрачные участки PNG пропускают кадр камеры. На фазе перерыва
/// break-заглушка из overlay'я перекрывает её.
///
/// Если задан только `brandImageUrl`, а overlay-view отсутствует — каталог всё
/// равно создаёт этот wrapper, чтобы brand-слой работал независимо от
/// overlay'я. Если оба отсутствуют — каталог возвращает nil и OverlayRenderer
/// не подключается.
final class BrandOverlayContainerView: UIView {
    private let brandImageView: UIImageView
    private let overlayView: UIView?
    private let invalidator: OverlayInvalidator
    private var dataTask: URLSessionDataTask?

    init(brandImageUrl: String?, overlayView: UIView?, invalidator: OverlayInvalidator) {
        self.brandImageView = UIImageView()
        self.overlayView = overlayView
        self.invalidator = invalidator
        super.init(frame: .zero)

        backgroundColor = .clear
        isOpaque = false

        brandImageView.contentMode = .scaleAspectFit
        brandImageView.backgroundColor = .clear
        brandImageView.isOpaque = false
        brandImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(brandImageView)
        NSLayoutConstraint.activate([
            brandImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            brandImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            brandImageView.topAnchor.constraint(equalTo: topAnchor),
            brandImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        if let overlayView = overlayView {
            overlayView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(overlayView)
            NSLayoutConstraint.activate([
                overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
                overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
                overlayView.topAnchor.constraint(equalTo: topAnchor),
                overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        }

        if let urlString = brandImageUrl, !urlString.isEmpty {
            loadBrandImage(urlString: urlString)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Грузим PNG через URLSession, как BreakAsyncImage в plashki-overlay. После
    /// успешной загрузки дёргаем invalidator, чтобы Compositor снял свежий snapshot
    /// с уже отрисованной картинкой.
    private func loadBrandImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            NSLog("[BrandImage] invalid url: \(urlString)")
            return
        }
        NSLog("[BrandImage] brand image load start: \(urlString)")
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                NSLog("[BrandImage] brand image load error: \(error)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                NSLog("[BrandImage] brand image data invalid")
                return
            }
            NSLog("[BrandImage] brand image load success (\(image.size.width)x\(image.size.height))")
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.brandImageView.image = image
                self.invalidator.invalidate()
            }
        }
        dataTask = task
        task.resume()
    }

    deinit {
        dataTask?.cancel()
    }
}
