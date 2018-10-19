import UIKit

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
