import SwiftUI

/// Карточка одного игрока. Эквивалент Compose-функции `MafbaseCard`
/// (см. android/.../overlay/plashki/MafbaseCard.kt). Дизайн 1:1: номер сверху,
/// фото с saturation-фильтром по статусу, role/status-иконки в углах,
/// крупный лейбл «Убит/Заголосован/Дисквалифицирован» поверх фото с поворотом 40°,
/// плашка с никнеймом снизу 85% ширины фото, выезжающая снаружи на 12 пунктов.
struct MafbaseCard: View {
    let role: Generated_PlayerRole
    let status: Generated_PlayerStatus
    let nickname: String
    let number: Int
    let image: String?

    var body: some View {
        VStack(spacing: 0) {
            numberPlate
                .padding(.bottom, 4)
            photoSection
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
        }
    }

    // MARK: - Number plate

    private var numberPlate: some View {
        Text("\(number)")
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Color(red: 58 / 255, green: 58 / 255, blue: 58 / 255))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    // MARK: - Photo + nickname

    private var photoSection: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = width * 6.0 / 5.0
            ZStack(alignment: .bottom) {
                ZStack {
                    AsyncImageView(urlString: image)
                        .frame(width: width, height: height)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        // compositingGroup() форсирует создание стабильного backing
                        // layer'а под `.saturation()`. Без него SwiftUI оптимизирует
                        // saturation==1 (без filter-layer'а), а при переходе на 0
                        // создаёт filter-layer заново — backing-структура меняется,
                        // и фото на 1 кадр прыгает вниз/вправо при первой смене
                        // статуса с `.alive`. С compositingGroup() filter-layer
                        // присутствует всегда, layout стабилен.
                        .compositingGroup()
                        .saturation(status == .alive ? 1 : 0)
                    roleIcon.frame(width: 40, height: 40).position(x: 0, y: 0)
                    statusIcon.frame(width: 40, height: 40).position(x: width, y: 0)
                    statusLabel.position(x: width / 2, y: height / 2)
                }
                .frame(width: width, height: height)
                // .animation(_:value:) на родительском ZStack включает implicit
                // animation для всех изменений внутри, привязанных к этому value.
                // Без этого `.transition(.opacity)` на иконках/label'е работает
                // моментально (SwiftUI просто add/remove view без интерполяции).
                .animation(.easeInOut(duration: 0.4), value: role)
                .animation(.easeInOut(duration: 0.4), value: status)

                nicknamePlate
                    .frame(width: width * 0.85)
                    .offset(y: 12)
            }
            .frame(width: width, height: height)
        }
        .aspectRatio(5.0 / 6.0, contentMode: .fit)
    }

    // MARK: - Role / status icons / label
    //
    // Все варианты иконок и текстов всегда живут в дереве; виден только тот,
    // у кого `opacity = 1`. Без `.transition(.opacity) + .id(asset)`, потому что
    // SwiftUI на время transition теряет правильный z-order для удаляемого layer'а
    // (исчезающая иконка прячется за фото/соседнюю карточку и обрезается).
    // С постоянными views и плавным opacity-crossfade позиционирование стабильно.

    private var roleIcon: some View {
        ZStack {
            roleImage("role_don", visible: role == .don)
            roleImage("role_mafia", visible: role == .maf)
            roleImage("role_sheriff", visible: role == .sheriff)
        }
    }

    private var statusIcon: some View {
        ZStack {
            statusImage("status_killed", visible: status == .killed)
            statusImage("status_voted", visible: status == .voted)
            statusImage("status_deleted", visible: status == .deleted)
        }
    }

    private var statusLabel: some View {
        ZStack {
            statusLabelText("Убит", visible: status == .killed)
            statusLabelText("Заголосован", visible: status == .voted)
            statusLabelText("Дисквалифицирован", visible: status == .deleted)
        }
    }

    private func roleImage(_ name: String, visible: Bool) -> some View {
        Image(name, bundle: PluginBundle.resources)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .opacity(visible ? 1 : 0)
    }

    private func statusImage(_ name: String, visible: Bool) -> some View {
        Image(name, bundle: PluginBundle.resources)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .opacity(visible ? 1 : 0)
    }

    private func statusLabelText(_ text: String, visible: Bool) -> some View {
        Text(text)
            .font(.system(size: 22, weight: .black))
            .foregroundColor(.white)
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: true)
            .shadow(color: .black, radius: 4, x: 2, y: 2)
            .rotationEffect(.degrees(40))
            .opacity(visible ? 1 : 0)
    }

    // MARK: - Nickname plate

    private var nicknamePlate: some View {
        Text(nickname)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.white)
            .lineLimit(1)
            .truncationMode(.tail)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity)
            .background(Color(red: 58 / 255, green: 58 / 255, blue: 58 / 255))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

}

/// Загрузка картинки игрока с фоллбеком на placeholder. SwiftUI-нативный
/// `AsyncImage` доступен только с iOS 15, а плагин таргетится в iOS 14.
/// Используем `URLSession` + `@State` + locally bundled placeholder.
///
/// При успешной загрузке вызывает `onImageLoaded` через environment — оверлей
/// использует это, чтобы продлить CADisplayLink-pump invalidate'ов и снять
/// свежий кадр с подгруженным фото в стрим (фиксированный 2.5-сек pump после
/// content-update мог не дождаться медленных картинок).
private struct AsyncImageView: View {
    let urlString: String?

    @State private var loaded: UIImage?
    @Environment(\.overlayImageLoaded) private var onImageLoaded

    var body: some View {
        Group {
            if let image = loaded {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image("player_photo", bundle: PluginBundle.resources)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .onAppear { load() }
        .onChange(of: urlString) { _ in
            loaded = nil
            load()
        }
    }

    private func load() {
        guard let s = urlString, let url = URL(string: s) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = decodeImage(data) else { return }
            DispatchQueue.main.async {
                self.loaded = image
                self.onImageLoaded?()
            }
        }.resume()
    }
}

/// Environment-канал для уведомления оверлея о завершении загрузки фото.
/// Передаётся из `PlashkiContainerView`, дёргается из `AsyncImageView`.
struct OverlayImageLoadedKey: EnvironmentKey {
    static let defaultValue: (() -> Void)? = nil
}

extension EnvironmentValues {
    var overlayImageLoaded: (() -> Void)? {
        get { self[OverlayImageLoadedKey.self] }
        set { self[OverlayImageLoadedKey.self] = newValue }
    }
}

/// Форсированное декодирование UIImage в RGBA. JPEG/HEIC, загруженные через
/// `UIImage(data:)`, держат данные «лениво» в YUV (`kCVPixelFormatType_420YpCbCr8BiPlanar`).
/// Когда такой UIImage рисуется через `view.layer.render(in: rgbContext)` (наш overlay
/// pipeline в стриме), iOS пытается на лету конвертировать YUV→RGB и часть compositor'а
/// логирует «[Utilities] unsupported surface format: 420f», а в кадре оказывается
/// чёрный квадрат вместо фото. Принудительная отрисовка в RGB CGContext пере-кодирует
/// картинку в premultiplied BGRA, после чего `render(in:)` работает корректно.
private func decodeImage(_ data: Data) -> UIImage? {
    guard let src = UIImage(data: data), let cg = src.cgImage else { return nil }
    let w = cg.width
    let h = cg.height
    guard w > 0, h > 0 else { return src }
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGImageAlphaInfo.premultipliedFirst.rawValue
        | CGBitmapInfo.byteOrder32Little.rawValue
    guard let ctx = CGContext(
        data: nil,
        width: w,
        height: h,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: bitmapInfo
    ) else { return src }
    ctx.draw(cg, in: CGRect(x: 0, y: 0, width: w, height: h))
    guard let decoded = ctx.makeImage() else { return src }
    return UIImage(cgImage: decoded, scale: src.scale, orientation: src.imageOrientation)
}
