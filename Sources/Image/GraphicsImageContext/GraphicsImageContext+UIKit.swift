//
//  GraphicsImageContext+UIKit.swift
//  Alamofire
//
//  Created by 郑军铎 on 2019/1/24.
//

import Foundation

extension CALayer {
    public func toImage(_ size: CGSize? = nil) -> UIImage {
        var size = size ?? self.frame.size
        if size.width <= 0 {size.width = 1}
        if size.height <= 0 {size.height = 1}
        return GraphicsImageContext(size).draw { (context) in
            render(in: context)
        }.createImage()
    }
}

extension UIView {
    public func toImage() -> UIImage {
        var size = bounds.size
        if size.width <= 0 {size.width = 1}
        if size.height <= 0 {size.height = 1}
        return GraphicsImageContext(size, isOpaque).draw {
            drawHierarchy(in: bounds, afterScreenUpdates: false)
        }.createImage()
    }
}
