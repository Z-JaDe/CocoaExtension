import Foundation
import UIKit
public extension UIImage {
    var automaticImage: UIImage {
        return self.withRenderingMode(.automatic)
    }
    var templateImage: UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
    var originalImage: UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
}

public extension UIImage {
    func data(compressionQuality: Float = 1.0) -> Data? {
        let hasAlpha = self.hasAlpha()
        let data = hasAlpha ? self.pngData() : self.jpegData(compressionQuality: CGFloat(compressionQuality))
        return data
    }
    /// ZJaDe: Returns compressed image to rate from 0 to 1
    func compressImage(rate: CGFloat) -> Data? {
        return self.jpegData(compressionQuality: rate)
    }
    /// ZJaDe: Returns Image size in Bytes
    func getSizeAsBytes() -> Int {
        return self.jpegData(compressionQuality: 1)?.count ?? 0
    }
    /// ZJaDe: Returns Image size in Kylobites
    func getSizeAsKilobytes() -> Int {
        let sizeAsBytes = getSizeAsBytes()
        return sizeAsBytes != 0 ? sizeAsBytes / 1024 : 0
    }
    // MARK: -
    /// ZJaDe: Returns the image associated with the URL
    convenience init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.init(data: Data())
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            print("EZSE: No image in URL \(urlString)")
            self.init(data: Data())
            return
        }
        self.init(data: data)
    }
    /// ZJaDe: 高除以宽
    var sizeScale: CGFloat {
        return self.size.height / self.size.width
    }
}
public extension UIImage {
    static func dataWithImage(_ image: UIImage, expectedSize: Int = 1024 * 1024) -> Data? {
        var scale: CGFloat = 1.0
        var data: Data?
        repeat {
            guard let tempData = image.scaleData(scale) else {
                break
            }
            data = tempData
            scale -= 0.3
        } while (data?.count ?? 0) > expectedSize && scale >= 0
        return data ?? image.pngData()
    }
    func scaleData(_ scale: CGFloat) -> Data? {
        //        if let tempData = UIImageHEICRepresentation(self, scale) {
        //            return tempData
        //        } else
        jpegData(compressionQuality: scale)
    }
}

import AVFoundation
public func UIImageHEICRepresentation(_ image: UIImage, _ compressionQuality: CGFloat) -> Data? {
    var imageData: Data?
    let destinationData = NSMutableData()
    let destination: CGImageDestination? = CGImageDestinationCreateWithData(destinationData, AVFileType.jpg as CFString, 1, nil)
    if let destination = destination {
        let options: [String: Any] = [kCGImageDestinationLossyCompressionQuality as String: compressionQuality]
        CGImageDestinationAddImage(destination, image.cgImage!, options as CFDictionary)
        CGImageDestinationFinalize(destination)
        imageData = destinationData as Data
    }
    return imageData
}
// MARK: -
extension UIImage {
    public func hasAlpha() -> Bool {
        guard let alphaInfo = self.cgImage?.alphaInfo else { return false }
        switch alphaInfo {
        case .first, .last, .premultipliedFirst, .premultipliedLast, .alphaOnly:
            return true
        case .none, .noneSkipFirst, .noneSkipLast:
            return false
        @unknown default:
            fatalError()
        }
    }
    /**
     * bitsPerComponent: 像素的每个颜色分量使用的 bit 数，在 RGB 颜色空间下指定 8 即可；
     * bytesPerRow: 位图的每一行要使用的内存字节数。 如果data参数为NULL，则传递0值将导致自动计算该值，大小至少为 width * bytes per pixel 字节。有意思的是，当我们指定 0 时，系统不仅会为我们自动计算，而且还会进行 cache line alignment 的优化
     */
    func drawToContext(size: CGSize? = nil, colorSpace: CGColorSpace, bitmapInfo: UInt32) -> CGContext? {
        guard let cgImage = self.cgImage else { return nil }
        let size = size ?? CGSize(width: cgImage.width, height: cgImage.height)
        let width: size_t = size_t(size.width)
        let height: size_t = size_t(size.height)
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo) else { return nil }
        // 将图片画到位图中
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        return context
    }
    func drawToContext() -> CGContext? {
        guard let cgImage = self.cgImage else { return nil }
        return drawToContext(size: nil, colorSpace: cgImage.colorSpace ?? CGColorSpaceCreateDeviceRGB(), bitmapInfo: cgImage.bitmapInfo.rawValue)
    }
    func drawToContextGray(size: CGSize? = nil) -> CGContext? {
        drawToContext(
            size: size,
            colorSpace: CGColorSpaceCreateDeviceGray(),
            bitmapInfo: CGBitmapInfo().rawValue | CGImageAlphaInfo.alphaOnly.rawValue
        )
    }
    func drawToContextRGB(size: CGSize? = nil, bitmapInfo: UInt32) -> CGContext? {
        drawToContext(
            size: size,
            colorSpace: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: bitmapInfo
        )
    }
    /**
     顺序 + argb = argb
     kCGImageByteOrder32Big | kCGImageAlphaPremultipliedFirst
     */
    func drawToContextARGB(size: CGSize? = nil) -> CGContext? {
        drawToContextRGB(
            size: size,
            bitmapInfo: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue
        )
    }
    /**
     顺序 + rgba = rgba
     kCGImageByteOrder32Big | kCGImageAlphaPremultipliedLast
     */
    func drawToContextRGBA(size: CGSize? = nil) -> CGContext? {
        drawToContextRGB(
            size: size,
            bitmapInfo: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
        )
    }
    /**
     倒序 + argb = bgra;
     kCGImageByteOrder32Little | kCGImageAlphaPremultipliedFirst
     */
    func drawToContextBGRA(size: CGSize? = nil) -> CGContext? {
        drawToContextRGB(
            size: size,
            bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue
        )
    }
    /**
     倒序 + rgba = abgr
     kCGImageByteOrder32Little | kCGImageAlphaPremultipliedLast
     */
    func drawToContextABGR(size: CGSize? = nil) -> CGContext? {
        drawToContextRGB(
            size: size,
            bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
        )
    }
}

extension UIImage {
    func compress(with lengthLimit: UInt) -> Data? {
        guard let data = compressMidQuality(with: lengthLimit) else {
            return nil
        }
        if data.count <= lengthLimit {
            return data
        }
        return UIImage(data: data)?.compressBySize(with: lengthLimit)
    }
    func compressBySize(with lengthLimit: UInt) -> Data? {
        var resultImage = self
        guard var data = resultImage.jpegData(compressionQuality: 1) else {
            return nil
        }
        var lastDataLength = 0
        while data.count > lengthLimit && data.count != lastDataLength {
            lastDataLength = data.count
            let ratio = CGFloat(lengthLimit) / CGFloat(data.count)
            let size = CGSize(width: Int(resultImage.size.width * Darwin.sqrt(ratio)),
                              height: Int(resultImage.size.height * Darwin.sqrt(ratio)))
            resultImage = UIGraphicsImageRenderer(size: size).image { _ in
                resultImage.draw(in: CGRect(origin: .zero, size: size))
            }
            if let _data = resultImage.jpegData(compressionQuality: 1) {
                data = _data
            } else {
                break
            }
        }
        return data
    }
    func compressMidQuality(with lengthLimit: UInt) -> Data? {
        var compression: CGFloat = 1
        guard var data = self.jpegData(compressionQuality: compression) else {
            return nil
        }
        if data.count <= lengthLimit {
            return data
        }
        var max: CGFloat = compression
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            if let _data = self.jpegData(compressionQuality: compression) {
                data = _data
                if CGFloat(data.count) < CGFloat(lengthLimit) * 0.9 {
                    min = compression
                } else if data.count > lengthLimit {
                    max = compression
                }
            } else {
                break
            }
        }
        return data
    }
}
