//
//  GraphicsImageContext+EditImage.swift
//  Alamofire
//
//  Created by 郑军铎 on 2019/1/24.
//

import Foundation
// MARK: - color
extension UIImage {
    /// ZJaDe: 根据透明度返回图片
    public func alpha(_ alpha: CGFloat) -> UIImage {
        return imageContext.draw {
            self.draw(at: CGPoint.zero, blendMode: .copy, alpha: alpha)
            }.createImage()
    }
    /// ZJaDe: 根据颜色返回图片
    public func change(color: UIColor) -> UIImage {
        return imageContext.draw { (context) in
            color.setFill()
            let drawRect = CGRect(origin: .zero, size: size)
            context.fill(drawRect)
            self.draw(at: CGPoint.zero, blendMode: .destinationIn, alpha: 1)
        }.createImage()
    }
    /// ZJaDe: 根据颜色返回图片2
    private func changeColor(_ color: UIColor) -> UIImage {
        return imageContext.draw { (context) in
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1, y: -1)
            context.setBlendMode(.normal)
            let rect = CGRect(origin: .zero, size: self.size)
            context.clip(to: rect, mask: self.cgImage!)
            color.setFill()
            context.fill(rect)
        }.createImage()
    }
}
// MARK: - size
extension UIImage {
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
    /// ZJaDe: 按照frame裁剪图片
    public func cropped(at frame: CGRect) -> UIImage {
        var frame = frame
        frame.origin.x = -frame.origin.x
        frame.origin.y = -frame.origin.y
        return GraphicsImageContext(frame.size).draw {
            self.draw(at: frame.origin, blendMode: .copy, alpha: 1)
        }.createImage()
    }
    /// ZJaDe: 扩大image大小，多余空间无色
    public func addBlank(insets: UIEdgeInsets) -> UIImage {
        let size = self.size + insets
        let origin = CGPoint(x: insets.left, y: insets.top)
        return GraphicsImageContext(size).draw {
            self.draw(in: CGRect(origin: origin, size: self.size))
        }.createImage()
    }
    /// ZJaDe: 图片缩放
    public func scaleTo(_ scale: CGFloat) -> UIImage {
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        return GraphicsImageContext(size).draw {
            self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        }.createImage()
    }
    /// ZJaDe: 图片圆角
    public func round(_ cornerRadius: CGFloat? = nil) -> UIImage {
        let size = self.size
        let rect = CGRect(origin: CGPoint.zero, size: size)
        return GraphicsImageContext(size).draw {
            let cornerRadius = cornerRadius ?? min(size.width, size.height) / 2
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            path.addClip()
            self.draw(in: rect)
        }.createImage()
    }
}
