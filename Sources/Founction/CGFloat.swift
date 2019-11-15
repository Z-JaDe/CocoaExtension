import UIKit
import Darwin

extension CGFloat {
    /// ZJaDe: 根据Self返回一个弧度
    public func toRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }

    /// ZJaDe: 根据Self返回一个弧度
    public func degreesToRadians() -> CGFloat {
        return toRadians()
    }

    /// ZJaDe: 把本身，从角度转换成弧度
    public mutating func toRadiansInPlace() {
        self = (.pi * self) / 180.0
    }

    /// ZJaDe: 根据angle返回一个弧度
    public func degreesToRadians (_ angle: CGFloat) -> CGFloat {
        return (.pi * angle) / 180.0
    }

    public static func scaleValue(beginValue: CGFloat, endValue: CGFloat, percentComplete: CGFloat) -> CGFloat {
        var percent: CGFloat = percentComplete
        if percent < 0 {percent = 0}
        if percent > 1 {percent = 1}
        return (endValue - beginValue) * percent + beginValue
    }
}
extension CGFloat {
    /**
     *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
     *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
     */
    public func flat(scale: CGFloat = 0) -> Self {
        let scale: CGFloat = scale > 0 ? scale : UIScreen.main.scale
        return Darwin.ceil(self * scale) / scale
    }
    /**
     *  类似ceilSpecific()，只不过 ceilSpecific 是向上取整，而 floorInPixel 是向下取整
     */
    public func floorInPixel(scale: CGFloat = 0) -> Self {
        let scale: CGFloat = scale > 0 ? scale : UIScreen.main.scale
        return Darwin.floor(self * scale) / scale
    }
}
