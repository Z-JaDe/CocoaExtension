//
//  GraphicsImageContext+Blend.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2019/1/24.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
/** ZJaDe:
 R = D*Sa ：目标色 = 原色*目标色的透明度
 R--result
 S--原色
 D--目标色
 Ra、Sa、Da分别为三种颜色的透明度
 */
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
    public static func + (lhs: UIImage, rhs: UIImage) -> UIImage {
        let lhsRect = CGRect(origin: CGPoint.zero, size: lhs.size)
        var rhsRect = CGRect(origin: CGPoint.zero, size: rhs.size)
        if lhsRect.contains(rhsRect) {
            rhsRect.origin.x = (lhsRect.size.width - rhsRect.size.width) / 2
            rhsRect.origin.y = (lhsRect.size.height - rhsRect.size.height) / 2
        }
        return GraphicsImageContext(lhsRect.size).draw {
            lhs.draw(in: lhsRect)
            rhs.draw(in: rhsRect)
        }.createImage()
    }
}
