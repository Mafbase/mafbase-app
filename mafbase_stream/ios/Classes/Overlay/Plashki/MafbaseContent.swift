import SwiftUI

private let designWidth: CGFloat = 1920

/// 10 карточек игроков, прижатых к низу. Эквивалент Compose-функции `MafbaseContent`
/// (см. android/.../overlay/plashki/MafbaseContent.kt). Внутри — `ScaledCanvas`,
/// который меряет content под design-шириной 1920 и одинаково скейлит обе оси,
/// так чтобы вся плашка занимала всю ширину родителя без letterbox.
struct MafbaseContent: View {
    let content: Generated_SeatingContent

    var body: some View {
        ScaledCanvas(designWidth: designWidth) {
            CardsRow(content: content)
        }
    }
}

private struct CardsRow: View {
    let content: Generated_SeatingContent

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(0..<10, id: \.self) { i in
                    cardAt(i)
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 4)
        }
    }

    private func cardAt(_ i: Int) -> some View {
        MafbaseCard(
            role: content.roles[safe: i] ?? .citizen,
            status: content.status[safe: i] ?? .alive,
            nickname: content.names[safe: i] ?? "",
            number: i + 1,
            image: content.images[safe: i]
        )
        .frame(maxWidth: .infinity)
    }
}

/// Меряет content под фиксированной [designWidth]; design-высоту берёт из aspect ratio
/// реального контейнера. Скейл одинаков по обеим осям — `scale = outWidth / designWidth`,
/// поэтому letterbox-полей не остаётся, контент всегда заполняет всю площадь родителя.
///
/// Аналог Compose `ScaledCanvas` (см. MafbaseContent.kt). Реализация через
/// `GeometryReader` + `frame(width:height:)` под design-размеры + `scaleEffect` с
/// якорем в верхнем левом углу.
private struct ScaledCanvas<Content: View>: View {
    let designWidth: CGFloat
    @ViewBuilder let content: () -> Content

    var body: some View {
        GeometryReader { geo in
            let outW = geo.size.width
            let outH = geo.size.height
            let scale = outW / designWidth
            let designHeight = outH / max(scale, 0.0001)
            content()
                .frame(width: designWidth, height: designHeight, alignment: .bottom)
                .scaleEffect(scale, anchor: .topLeading)
                .frame(width: outW, height: outH, alignment: .topLeading)
        }
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
