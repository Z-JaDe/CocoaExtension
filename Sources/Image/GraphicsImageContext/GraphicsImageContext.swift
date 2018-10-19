//
//  GraphicsImageContext.swift
//  Any
//
//  Created by 郑军铎 on 2018/6/20.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import UIKit

public class GraphicsImageContext {
    public init(_ size: CGSize, _ opaque: Bool = false, _ scale: CGFloat = 0) {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
    }

    func draw(_ closure: () -> Void) -> GraphicsImageContext {
        closure()
        return self
    }
    func draw(_ closure: (CGContext) -> Void) -> GraphicsImageContext {
        if let context = UIGraphicsGetCurrentContext() {
            closure(context)
        }
        return self
    }

    public func createImage() -> UIImage {
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        endImageContext()
        return image
    }
    public func endImageContext() {
        UIGraphicsEndImageContext()
    }
}
// MARK: - UIImage
// MARK: 图片裁剪或拉伸
extension UIImage {
    /// ZJaDe: 根据透明度返回图片
    public func alpha(_ alpha: CGFloat) -> UIImage {
        return GraphicsImageContext(self.size).draw {
            self.draw(at: CGPoint.zero, blendMode: .copy, alpha: alpha)
            }.createImage()
    }
    /// ZJaDe: 根据颜色返回图片
    public func color(_ color: UIColor) -> UIImage {
        return GraphicsImageContext(self.size).draw {
            color.setFill()
            self.templateImage.draw(at: CGPoint.zero, blendMode: .copy, alpha: 1)
        }.createImage()
    }
    /// ZJaDe: 根据宽度等比例缩放图片
    public func resizeWithWidth(_ width: CGFloat) -> UIImage {
        let aspectSize = CGSize(width: width, height: aspectHeightForWidth(width))
        return GraphicsImageContext(aspectSize).draw {
            self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
            }.createImage()
    }
    /// ZJaDe: 根据高度等比例缩放图片
    public func resizeWithHeight(_ height: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: aspectWidthForHeight(height), height: height)

        return GraphicsImageContext(aspectSize).draw {
            self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
            }.createImage()
    }
    /// ZJaDe: aspectHeightForWidth
    public func aspectHeightForWidth(_ width: CGFloat) -> CGFloat {
        return (width * self.size.height) / self.size.width
    }

    /// ZJaDe: aspectWidthForHeight
    public func aspectWidthForHeight(_ height: CGFloat) -> CGFloat {
        return (height * self.size.width) / self.size.height
    }
}

extension UIImage {
    /// ZJaDe: 图片圆角
    public func round(_ cornerRadius: CGFloat? = nil) -> UIImage {
        return self.scaleTo(size: self.size, cornerRadius: cornerRadius)
    }
    /// ZJaDe: 图片缩放
    public func scaleTo(_ scale: CGFloat) -> UIImage {
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        return self.scaleTo(size: size)
    }
    /// ZJaDe: 重新设置尺寸，设置圆角
    public func scaleTo(size: CGSize, cornerRadius: CGFloat? = 0) -> UIImage {
        let layer = CALayer()
        layer.frame.size = size
        layer.contents = self.cgImage
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius ?? min(size.width, size.height) / 2
        return layer.toImage()
    }
    /// ZJaDe: 按照frame裁剪图片
    public func cropped(at frame: CGRect) -> UIImage {
        var frame = frame
        frame.origin.x = -frame.origin.x
        frame.origin.y = -frame.origin.y
        return GraphicsImageContext(frame.size).draw {
            self.draw(at: frame.origin, blendMode: .copy, alpha: 1)
        }.createImage()
    }
}
// MARK: 生成图片
extension UIImage {
    /// ZJaDe: 动态生成一个图片
    public class func imageWithColor(_ color: UIColor?, size: CGSize = CGSize(width: 1, height: 1), cornerRadius: CGFloat? = 0) -> UIImage? {
        guard let color = color else {
            return nil
        }
        let layer = CALayer()
        layer.frame.size = size
        layer.backgroundColor = color.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius ?? min(size.width, size.height) / 2
        return layer.toImage()
    }
    /// ZJaDe: 返回一个空图片
    public class func blankImage(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return GraphicsImageContext(size).createImage()
    }
}
// MARK: 图片混合
extension UIImage {
    public func blend(_ overlayImage: UIImage, cropRect: CGRect, _ blendMode: CGBlendMode = .normal, _ alpha: CGFloat = 1) -> UIImage {
        return GraphicsImageContext(self.size).draw {
            self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
            overlayImage.draw(in: cropRect, blendMode: blendMode, alpha: alpha)
        }.createImage()
    }
    public func blend(_ overlayImage: UIImage, cropPoint: CGPoint, _ blendMode: CGBlendMode = .normal, _ alpha: CGFloat = 1) -> UIImage {
        return GraphicsImageContext(self.size).draw {
            self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
            overlayImage.draw(at: cropPoint, blendMode: blendMode, alpha: alpha)
            }.createImage()
    }
}
// MARK: - UIView
extension CALayer {
    public func toImage(_ size: CGSize? = nil) -> UIImage {
        return GraphicsImageContext(size ?? self.frame.size).draw { (context) in
            self.render(in: context)
        }.createImage()
    }
}
// MARK: - UIView
extension UIView {
    public func toImage() -> UIImage {
        return GraphicsImageContext(bounds.size, isOpaque).draw {
            drawHierarchy(in: bounds, afterScreenUpdates: false)
        }.createImage()
    }
}
