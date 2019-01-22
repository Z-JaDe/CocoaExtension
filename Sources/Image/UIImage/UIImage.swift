import Foundation
import UIKit
extension UIImage {
    public var automaticImage: UIImage {
        return self.withRenderingMode(.automatic)
    }
    public var templateImage: UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
    public var originalImage: UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
}

extension UIImage {
    public func hasAlpha() -> Bool {
        guard let alphaInfo = self.cgImage?.alphaInfo else { return false }
        switch alphaInfo {
        case .first, .last, .premultipliedFirst, .premultipliedLast, .alphaOnly:
            return true
        case .none, .noneSkipFirst, .noneSkipLast:
            return false
        }
    }

    public func data(compressionQuality: Float = 1.0) -> Data? {
        let hasAlpha = self.hasAlpha()
        let data = hasAlpha ? self.pngData() : self.jpegData(compressionQuality: CGFloat(compressionQuality))
        return data
    }
    /// ZJaDe: Returns compressed image to rate from 0 to 1
    public func compressImage(rate: CGFloat) -> Data? {
        return self.jpegData(compressionQuality: rate)
    }
    /// ZJaDe: Returns Image size in Bytes
    public func getSizeAsBytes() -> Int {
        return self.jpegData(compressionQuality: 1)?.count ?? 0
    }
    /// ZJaDe: Returns Image size in Kylobites
    public func getSizeAsKilobytes() -> Int {
        let sizeAsBytes = getSizeAsBytes()
        return sizeAsBytes != 0 ? sizeAsBytes / 1024 : 0
    }
    // MARK: -
    /// ZJaDe: Returns the image associated with the URL
    public convenience init?(urlString: String) {
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
    public var sizeScale: CGFloat {
        return self.size.height / self.size.width
    }
}
extension UIImage {
    public static func dataWithImage(_ image: UIImage) -> Data? {
        var scale: CGFloat = 1.0
        var data: Data? = {
            var data: Data?
            repeat {
                if let tempData = image.scaleData(scale) {
                    data = tempData
                } else {
                    return data
                }
                scale -= 0.3
            } while (data?.count ?? 0) > 1024 * 1024  && scale >= 0
            return data
        }()
        if data == nil {
            data = image.pngData()
        }
        return data
    }
    public func scaleData(_ scale: CGFloat) -> Data? {
        //        if let tempData = UIImageHEICRepresentation(self, scale) {
        //            return tempData
        //        } else
        if let tempData = self.jpegData(compressionQuality: scale) {
            return tempData
        } else {
            return nil
        }
    }
}

import AVFoundation
public func UIImageHEICRepresentation(_ image: UIImage, _ compressionQuality: CGFloat) -> Data? {
    var imageData: Data?
    if #available(iOS 11, *) {
        let destinationData = NSMutableData()
        let destination: CGImageDestination? = CGImageDestinationCreateWithData(destinationData, AVFileType.jpg as CFString, 1, nil)
        if let destination = destination {
            let options: [String: Any] = [kCGImageDestinationLossyCompressionQuality as String: compressionQuality]
            CGImageDestinationAddImage(destination, image.cgImage!, options as CFDictionary)
            CGImageDestinationFinalize(destination)
            imageData = destinationData as Data
        }
    }
    return imageData
}
