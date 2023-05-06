//
//  UIImage+GraphicsImageContext.swift
//  Alamofire
//
//  Created by ZJaDe on 2019/1/24.
//

import UIKit

// MARK: color
public extension UIImage {
    /// ZJaDe: 根据透明度返回图片
    func alpha(_ alpha: CGFloat) -> UIImage {
        return imageRenderer().image(actions: { _ in
            self.draw(at: CGPoint.zero, blendMode: .copy, alpha: alpha)
        })
    }
    /// ZJaDe: 根据颜色返回图片
    func change(color: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage {
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
// MARK: size
public extension UIImage {
    /// ZJaDe: 根据宽度等比例缩放图片
    @objc func scaleResize(withWidth width: CGFloat) -> UIImage {
        let aspectSize = CGSize(width: width, height: scaleAspectHeight(forWidth: width))
        return imageRenderer(size: aspectSize).image(actions: { _ in
            self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        })
    }
    /// ZJaDe: 根据高度等比例缩放图片
    @objc func scaleResize(withHeight height: CGFloat) -> UIImage {
        let aspectSize = CGSize(width: scaleAspectWidth(forHeight: height), height: height)
        return imageRenderer(size: aspectSize).image(actions: { _ in
            self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        })
    }
    /// ZJaDe: aspectHeightForWidth
    func scaleAspectHeight(forWidth width: CGFloat) -> CGFloat {
        (width * self.size.height) / self.size.width
    }
    /// ZJaDe: aspectWidthForHeight
    func scaleAspectWidth(forHeight height: CGFloat) -> CGFloat {
        (height * self.size.width) / self.size.height
    }
}

public extension UIImage {
    /// ZJaDe: 按照frame裁剪图片
    func cropped(at frame: CGRect) -> UIImage {
        imageRenderer(size: frame.size).image(actions: { _ in
            var frame = frame
            frame.origin.x = -frame.origin.x
            frame.origin.y = -frame.origin.y
            self.draw(at: frame.origin, blendMode: .copy, alpha: 1)
        })
    }
    /// ZJaDe: 视同 UIImageView的scaleAspectFill
    func scaleAspectFill(at destinationSize: CGSize) -> UIImage {
        imageRenderer(size: destinationSize).image(actions: { _ in
            self.draw(in: self.size.scaleAspectFill(to: destinationSize))
        })
    }
    /// ZJaDe: 视同 UIImageView的scaleAspectFit
    func scaleAspectFit(at destinationSize: CGSize) -> UIImage {
        imageRenderer(size: destinationSize).image(actions: { _ in
            self.draw(in: self.size.scaleAspectFit(to: destinationSize))
        })
    }
    /// ZJaDe: 扩大image大小，多余空间无色
    func addBlank(insets: UIEdgeInsets) -> UIImage {
        imageRenderer(size: self.size + insets).image(actions: { _ in
            let origin = CGPoint(x: insets.left, y: insets.top)
            self.draw(in: CGRect(origin: origin, size: self.size))
        })
    }
    /// ZJaDe: 图片缩放
    func scaleTo(_ scale: CGFloat) -> UIImage {
        if scale == 1 { return self }
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        return imageRenderer(size: size).image(actions: { _ in
            self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        })
    }
    /// ZJaDe: 图片圆角
    func round(_ cornerRadius: CGFloat? = nil) -> UIImage {
        imageRenderer().image(actions: { _ in
            let rect = CGRect(origin: CGPoint.zero, size: self.size)
            let cornerRadius = cornerRadius ?? min(size.width, size.height) / 2
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            path.addClip()
            self.draw(in: rect)
        })
    }
}
