//
//  GraphicsImageContext+UIKit.swift
//  Alamofire
//
//  Created by ZJaDe on 2019/1/24.
//

import Foundation

extension CALayer {
    public func toImage(_ size: CGSize? = nil) -> UIImage {
        var size = size ?? self.frame.size
        if size.width <= 0 {size.width = 1}
        if size.height <= 0 {size.height = 1}
        return UIGraphicsImageRenderer(size: size).image(actions: { (context) in
            render(in: context.cgContext)
        })
    }
}

extension UIView {
    public func toImage() -> UIImage {
        var size = bounds.size
        if size.width <= 0 {size.width = 1}
        if size.height <= 0 {size.height = 1}
        let format = UIGraphicsImageRendererFormat()
        format.opaque = self.isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image(actions: { (_) in
            drawHierarchy(in: bounds, afterScreenUpdates: false)
        })
    }
}
