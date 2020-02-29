//
//  UIImage+ImageEffects.swift
//  Any
//
//  Created by ZJaDe on 2018/6/20.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import UIKit

extension UIImage {
    func applyBlur(withRadius blurRadius: CGFloat,
                   tintColor: UIColor,
                   saturationDeltaFactor: CGFloat,
                   maskImage: UIImage?,
                   atFrame frame: CGRect) -> UIImage {
        if let blurredFrame = self.cropped(at: frame).applyBlur(withRadius: blurRadius, tintColor: tintColor, saturationDeltaFactor: saturationDeltaFactor, maskImage: maskImage) {
            return self.blend(blurredFrame, cropRect: frame)
        } else {
            return self
        }
    }
}

public enum ImageEffect {
    case light
    case extraLight
    case dark
    case tintEffect(UIColor)
}
extension UIImage {
    public func applyEffect(_ effect: ImageEffect) -> UIImage? {
        let tintColor: UIColor
        switch effect {
        case .light:
            tintColor = UIColor(white: 1, alpha: 0.3)
            return self.applyBlur(withRadius: 7, tintColor: tintColor, saturationDeltaFactor: 1.8, maskImage: nil)
        case .extraLight:
            tintColor = UIColor(white: 0.97, alpha: 0.82)
            return self.applyBlur(withRadius: 5, tintColor: tintColor, saturationDeltaFactor: 1.8, maskImage: nil)
        case .dark:
            tintColor = UIColor(white: 0.11, alpha: 0.73)
            return self.applyBlur(withRadius: 5, tintColor: tintColor, saturationDeltaFactor: 1.8, maskImage: nil)
        case .tintEffect(let effectColor):
            tintColor = effectColor.alpha(0.6)
            return self.applyBlur(withRadius: 5, tintColor: tintColor, saturationDeltaFactor: 1.4, maskImage: nil)
        }
    }
}
extension UIImage {
    public func blurImage(radius: CGFloat = 5, tintColor: UIColor = UIColor.clear, maskImage: UIImage? = nil) -> UIImage? {
        return self.applyBlur(withRadius: radius, tintColor: tintColor, saturationDeltaFactor: 1.4, maskImage: maskImage)
    }
    public func blurImage(at frame: CGRect) -> UIImage {
        return self.applyBlur(withRadius: 5, tintColor: UIColor.clear, saturationDeltaFactor: 1.4, maskImage: nil, atFrame: frame)
    }
}
extension UIImage {
    /// ZJaDe: 灰度图
    public var grayImage: UIImage? {
        guard let context = drawToContextGray() else { return nil }
        guard let grayImage = context.makeImage() else { return nil }
        return UIImage(cgImage: grayImage, scale: scale, orientation: imageOrientation)
    }
}
extension UIImage {
    public func averageColor() -> UIColor? {
        guard let bitData = getBitData(1, 1) else { return nil }
        let rgba = (0...3).map({(bitData + $0).pointee})
        if rgba[3] > 0 {
            let rgba: [CGFloat] = rgba.map(CGFloat.init)
            let a = rgba[3] / 255.0
            return UIColor(r: rgba[0] * a, g: rgba[1] * a, b: rgba[2] * a, alpha: a)
        } else {
            return mapColor(rgba)
        }
    }
}
extension UIImage {
    /// ZJaDe: 精度无损 略微耗时
    public func mainColor() -> UIColor? {
        guard let cgImage = self.cgImage else { return nil }
        guard let bitData = getBitData(cgImage.width, cgImage.height) else { return nil }
        let mapFunc = dataFliterMap(bitData, imgWidth: cgImage.width, imgHeight: cgImage.height)
        return mapFunc(false) ?? mapFunc(true)
    }
    private func dataFliterMap(_ data: UnsafeMutablePointer<CUnsignedChar>, imgWidth: Int, imgHeight: Int) -> (Bool) -> UIColor? {
        return { (parsePureColor) in
            let colors = NSCountedSet()
            for x in 0..<imgWidth {
                for y in 0..<imgHeight {
                    let offSet = 4 * ( x * y)
                    let r = (data + offSet).pointee
                    let g = (data + offSet + 1).pointee
                    let b = (data + offSet + 2).pointee
                    let a = (data + offSet + 3).pointee
                    guard a > 0 else { continue }
//                    if r >= 240 && g >= 240 && b >= 240 { continue }
                    ///不是纯色时或者允许解析纯色时
                    guard parsePureColor || !(r == g && g == b) else { continue }
                    colors.add([r, g, b, a])
                }
            }
            let orderFunc: (Any, Any) -> Bool = {colors.count(for: $0) < colors.count(for: $1)}
            guard let maxCountColor = colors.max(by: orderFunc) as? [CUnsignedChar] else {
                return nil
            }
            //        logDebug("count-->\(colors.count(for: maxCountColor))")
            //        logDebug(colors.map({($0, colors.count(for: $0))}).sorted(by: {$0.1 < $1.1}))
            return self.mapColor(maxCountColor)
        }
    }
    private func mapColor(_ rgba: [CUnsignedChar]) -> UIColor {
        let rgba: [CGFloat] = rgba.map(CGFloat.init)
        return UIColor(r: rgba[0], g: rgba[1], b: rgba[2], a: rgba[3])
    }
}
extension UIImage {
    ///会根据传入尺寸 缩放
    private func getBitData(_ imgWidth: Int, _ imgHeight: Int) -> UnsafeMutablePointer<CUnsignedChar>? {
        guard let context = drawToContextRGBA(size: CGSize(width: imgWidth, height: imgHeight)) else { return nil }
        guard let contextData = context.data else { return nil }
        //获取位图数据 位图的大小＝位图的每一行要使用的内存字节数＊图片高
        return contextData.bindMemory(to: CUnsignedChar.self, capacity: context.bytesPerRow * imgHeight)
    }
}
