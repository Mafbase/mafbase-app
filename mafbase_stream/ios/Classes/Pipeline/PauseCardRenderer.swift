import CoreGraphics
import CoreVideo
import UIKit

/// Карточка «Трансляция на паузе» для кадра заглушки: прозрачный BGRA premultiplied буфер
/// размера кадра с тёмной скруглённой плашкой и белым текстом по центру. Рисуется через
/// CGContext на main; компоситор накладывает её отдельной текстурой поверх overlay.
enum PauseCardRenderer {

    static let text = "Трансляция на паузе"

    static func render(width: Int, height: Int) -> CVPixelBuffer? {
        let attrs: [CFString: Any] = [
            kCVPixelBufferIOSurfacePropertiesKey: [:],
            kCVPixelBufferOpenGLESCompatibilityKey: true,
        ]
        var buffer: CVPixelBuffer?
        let ret = CVPixelBufferCreate(
            kCFAllocatorDefault,
            width,
            height,
            kCVPixelFormatType_32BGRA,
            attrs as CFDictionary,
            &buffer
        )
        guard ret == kCVReturnSuccess, let pb = buffer else {
            NSLog("[mafbase_stream] PauseCardRenderer pixel buffer create failed: \(ret)")
            return nil
        }
        CVPixelBufferLockBaseAddress(pb, [])
        defer { CVPixelBufferUnlockBaseAddress(pb, []) }
        guard let baseAddress = CVPixelBufferGetBaseAddress(pb),
              let ctx = CGContext(
                data: baseAddress,
                width: width,
                height: height,
                bitsPerComponent: 8,
                bytesPerRow: CVPixelBufferGetBytesPerRow(pb),
                space: CGColorSpaceCreateDeviceRGB(),
                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
              )
        else { return nil }

        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        ctx.clear(bounds)
        // UIKit-рисование ждёт y-down, у CGContext ось y направлена вверх.
        ctx.translateBy(x: 0, y: CGFloat(height))
        ctx.scaleBy(x: 1, y: -1)
        UIGraphicsPushContext(ctx)
        drawCard(in: bounds)
        UIGraphicsPopContext()
        return pb
    }

    private static func drawCard(in bounds: CGRect) {
        let fontSize = bounds.height * 0.05
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: fontSize),
            .foregroundColor: UIColor.white,
        ]
        let textSize = (text as NSString).size(withAttributes: attributes)
        let paddingX = fontSize * 1.2
        let paddingY = fontSize * 0.7
        let textOrigin = CGPoint(x: bounds.midX - textSize.width / 2, y: bounds.midY - textSize.height / 2)
        let card = CGRect(
            x: textOrigin.x - paddingX,
            y: textOrigin.y - paddingY,
            width: textSize.width + paddingX * 2,
            height: textSize.height + paddingY * 2
        )
        UIColor(white: 0, alpha: 0.72).setFill()
        UIBezierPath(roundedRect: card, cornerRadius: fontSize * 0.5).fill()
        (text as NSString).draw(at: textOrigin, withAttributes: attributes)
    }
}
