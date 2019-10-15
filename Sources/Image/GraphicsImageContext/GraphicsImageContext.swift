//
//  GraphicsImageContext.swift
//  Any
//
//  Created by ZJaDe on 2018/6/20.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import UIKit
@available(iOS, deprecated: 10.0, message: "可以使用 UIGraphicsImageRenderer")
public struct GraphicsImageContext {
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
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        endImageContext()
        if let image = image {
            return image
        } else {
            assertionFailure("生成图片失败")
            return UIImage()
        }
    }
    public func endImageContext() {
        UIGraphicsEndImageContext()
    }
}
extension UIImage {
    @available(iOS, deprecated: 10.0, message: "可以使用 UIGraphicsImageRenderer")
    public var imageContext: GraphicsImageContext {
        return GraphicsImageContext(self.size, false, self.scale)
    }
    public func imageRenderer(format: UIGraphicsImageRendererFormat? = nil) -> UIGraphicsImageRenderer {
        if let format = format {
            return UIGraphicsImageRenderer(size: self.size, format: format)
        } else {
            return UIGraphicsImageRenderer(size: self.size)
        }
    }
}
