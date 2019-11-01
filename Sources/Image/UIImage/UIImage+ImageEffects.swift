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
    func grayScale() -> UIImage? {
        let width: Int = Int(self.size.width)
        let height: Int = Int(self.size.height)

        let colorSpace = CGColorSpaceCreateDeviceGray()
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue) else {
            return nil
        }

        context.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        let grayImage = context.makeImage()!
        return UIImage(cgImage: grayImage)
    }
}

extension UIImage {
    /// ZJaDe: 精度无损 略微耗时
    public func mainColor() -> UIColor? {
        guard let cgImage = self.cgImage else {
            return nil
        }
        let imgWidth = cgImage.width
        let imgHeight = cgImage.height
        guard let colorSpace = cgImage.colorSpace else {
            return nil
        }
        //位图的大小＝图片宽＊图片高＊图片中每点包含的信息量
        let bitmapByteCount = imgWidth * imgHeight * 4
        guard let context = CGContext(data: nil, width: imgWidth, height: imgHeight, bitsPerComponent: 8, bytesPerRow: imgWidth * 4, space: colorSpace, bitmapInfo: cgImage.bitmapInfo.rawValue) else {
            return nil
        }
        //将图片画到位图中
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: CGFloat(imgWidth), height: CGFloat(imgHeight)))
        guard let contextData = context.data else {
            return nil
        }
        //获取位图数据
        let data = contextData.bindMemory(to: CUnsignedChar.self, capacity: bitmapByteCount)
        let mapFunc = dataFliterMap(data, imgWidth: imgWidth, imgHeight: imgHeight)
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
                    guard a > 0 else {
                        continue
                    }
                    ///不是纯色时或者允许解析纯色时
                    guard !(r == g && g == b) || parsePureColor else {
                        continue
                    }
                    let values = [r, g, b, a].map({CGFloat($0)})
                    colors.add(values)
                }
            }
            let orderFunc: (Any, Any) -> Bool = {colors.count(for: $0) < colors.count(for: $1)}
            guard let maxCountColor = colors.max(by: orderFunc) as? [CGFloat] else {
                return nil
            }
            //        logDebug("count-->\(colors.count(for: maxCountColor))")
            //        logDebug(colors.map({($0, colors.count(for: $0))}).sorted(by: {$0.1 < $1.1}))
            return self.mapColor(maxCountColor)
        }
    }
    private func mapColor(_ array: [CGFloat]) -> UIColor {
        return UIColor(r: array[0], g: array[1], b: array[2], a: array[3])
    }
}
