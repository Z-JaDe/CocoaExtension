//
//  GraphicsImageContext.swift
//  Any
//
//  Created by ZJaDe on 2018/6/20.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import UIKit

public struct GraphicsImageContext {
    let inverting: Bool
    let size: CGSize
    let scale: CGFloat
    public init(_ size: CGSize, scale: CGFloat, inverting: Bool = false) {
        self.inverting = inverting
        self.size = size
        self.scale = scale
    }

    func draw(_ closure: () -> Void) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        closure()
        return createImage()
    }
    func draw(_ closure: (CGContext) -> Void) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        if let context = UIGraphicsGetCurrentContext() {
            if inverting {
                context.scaleBy(x: 1.0, y: -1.0)
                context.translateBy(x: 0, y: -size.height)
            }
            closure(context)
        }
        return createImage()
    }

    public func createImage() -> UIImage? {
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        endImageContext()
        if let image = image {
            return image
        } else {
            assertionFailure("生成图片失败")
            return nil
        }
    }
    public func endImageContext() {
        UIGraphicsEndImageContext()
    }
}
public extension UIImage {
    // If drawing a CGImage, we need to make context flipped.
    func imageContext(inverting: Bool = false) -> GraphicsImageContext {
        return GraphicsImageContext(size, scale: scale, inverting: inverting)
    }
    func imageRenderer(size: CGSize? = nil, format: UIGraphicsImageRendererFormat? = nil) -> UIGraphicsImageRenderer {
        let size = size ?? self.size
        if let format = format {
            return UIGraphicsImageRenderer(size: size, format: format)
        } else {
            return UIGraphicsImageRenderer(size: size)
        }
    }
}
