//
//  GraphicsImageContext+Blend.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2019/1/24.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
/** ZJaDe:
 kCGBlendModeNormal //正常；也是默认的模式。前景图会覆盖背景图

 kCGBlendModeMultiply // 正片叠底；混合了前景和背景的颜色，最终颜色比原先的都暗

 kCGBlendModeScreen //滤色；把前景和背景图的颜色先反过来，然后混合

 kCGBlendModeOverlay // 覆盖；能保留灰度信息，结合

 //覆盖；能保留灰度信息，结合kCGBlendModeSaturation能保留透明度信息，
 //在imageWithBlendMode方法中两次执行drawInRect方法实现我们基本需求"
 kCGBlendModeOverlay:

 kCGBlendModeDarken// 变暗
 kCGBlendModeLighten// 变亮
 kCGBlendModeColorDodge// 颜色变淡
 kCGBlendModeColorBurn//颜色加深
 kCGBlendModeSoftLight// 柔光
 kCGBlendModeHardLight// 强光
 kCGBlendModeDifference//插值
 kCGBlendModeExclusion//排除
 kCGBlendModeHue// 色调
 kCGBlendModeSaturation//饱和度
 kCGBlendModeColor// 颜色
 kCGBlendModeLuminosity// 亮度

 //Apple额外定义的枚举
 //R: premultiplied result, 表示混合结果
 //S: Source, 表示源颜色(Sa对应透明度值: 0.0-1.0)
 //D: destination colors with alpha, 表示带透明度的目标颜色(Da对应透明度值: 0.0-1.0)
 R表示结果，S表示包含alpha的原色，D表示包含alpha的目标色，Ra，Sa和Da分别是三个的alpha。明白了这些以后，就可以开始寻找我们所需要的blend模式了。相信你可以和我一样，很快找到这个模式

 kCGBlendModeClear: R = 0
 kCGBlendModeCopy: R = S
 kCGBlendModeSourceIn: R = S*Da //R = 原色*目标色的透明度
 kCGBlendModeSourceOut: R = S*(1 - Da)
 kCGBlendModeSourceAtop: R = S*Da + D*(1 - Sa)
 kCGBlendModeDestinationIn: R = S*Da //R = 目标色*原色的透明度
 kCGBlendModeDestinationOver: R = S*(1 - Da) + D
 kCGBlendModeXOR: R = S*(1 - Da) + D*(1 - Sa)
 kCGBlendModePlusDarker: R = MAX(0, (1 - D) + (1 - S)
 kCGBlendModePlusLighter: R = MIN(1, S + D)（最后一种混合模式）
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
