//
//  GraphicsImageContext+EditImage.swift
//  Alamofire
//
//  Created by ZJaDe on 2019/1/24.
//

import UIKit
// MARK: - color
extension UIImage {
    /// ZJaDe: 根据透明度返回图片
    public func alpha(_ alpha: CGFloat) -> UIImage {
        return imageRenderer().image(actions: { (_) in
            self.draw(at: CGPoint.zero, blendMode: .copy, alpha: alpha)
        })
    }
    /// ZJaDe: 根据颜色返回图片
    public func change(color: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage {
        return imageRenderer().image(actions: { (context) in
            color.setFill()
            let drawRect = CGRect(origin: .zero, size: size)
            context.fill(drawRect)
            self.draw(at: CGPoint.zero, blendMode: blendMode, alpha: 1)
        })
    }
    /// ZJaDe: 根据颜色返回图片2
    private func changeColor(_ color: UIColor) -> UIImage {
        return imageRenderer().image(actions: { (context) in
            let context = context.cgContext
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(.normal)
            let rect = CGRect(origin: .zero, size: self.size)
            context.clip(to: rect, mask: self.cgImage!)
            color.setFill()
            context.fill(rect)
        })
    }
}
// MARK: - size
extension UIImage {
    /// ZJaDe: 根据宽度等比例缩放图片
    public func resizeWithWidth(_ width: CGFloat) -> UIImage {
        let aspectSize = CGSize(width: width, height: aspectHeightForWidth(width))
        return UIGraphicsImageRenderer(size: aspectSize).image(actions: { (_) in
            self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        })
    }
    /// ZJaDe: 根据高度等比例缩放图片
    public func resizeWithHeight(_ height: CGFloat) -> UIImage {
        let aspectSize = CGSize(width: aspectWidthForHeight(height), height: height)
        return UIGraphicsImageRenderer(size: aspectSize).image(actions: { (_) in
            self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        })
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
        return UIGraphicsImageRenderer(size: frame.size).image(actions: { (_) in
            self.draw(at: frame.origin, blendMode: .copy, alpha: 1)
        })
    }
    /// ZJaDe: 扩大image大小，多余空间无色
    public func addBlank(insets: UIEdgeInsets) -> UIImage {
        let size = self.size + insets
        let origin = CGPoint(x: insets.left, y: insets.top)
        return UIGraphicsImageRenderer(size: size).image(actions: { (_) in
            self.draw(in: CGRect(origin: origin, size: self.size))
        })
    }
    /// ZJaDe: 图片缩放
    public func scaleTo(_ scale: CGFloat) -> UIImage {
        if scale == 1 { return self }
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        return UIGraphicsImageRenderer(size: size).image(actions: { (_) in
            self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        })
    }
    /// ZJaDe: 图片圆角
    public func round(_ cornerRadius: CGFloat? = nil) -> UIImage {
        let size = self.size
        let rect = CGRect(origin: CGPoint.zero, size: size)
        return UIGraphicsImageRenderer(size: size).image(actions: { (_) in
            let cornerRadius = cornerRadius ?? min(size.width, size.height) / 2
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            path.addClip()
            self.draw(in: rect)
        })
    }
}
